Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4108C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2DD218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545228206;
	bh=MouVdjqF6SXMZ31DkHvU4oZphQuofTbks6nl6zi5mS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4JpS/SyrPXfOBQy9pbWWeAWGJ7ES0+sOiSwI7673JQcDIILkJudyOFmtx4aNVKPP
	 3ez83QoH6RFQK/qG/99Rsa+jREASx52RAWswxNduAs6qG89D2WT3aJw31gABIYNGXz
	 xa8BK7SkoDN/1Xx9/a0YdVQbCElztOz3yjZkmyrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeLSODZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:03:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40146 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:03:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so19162968oth.7;
        Wed, 19 Dec 2018 06:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87Q7t3au6AiYONenqf5bXOf5YLbZmUmIIK0zrYw8Hcw=;
        b=NIdz+q+UrYWDJzGdjmStjd2m8wjxAnNevSQXhR5p2gLg/EUx0OZBcwZE+BjIQwwQ0u
         1WxkpkjJVxz7TBwQCJ8kzBI7zWZ65rq8Smu5H5s5pnLDR11ElKCIcC/bwb0re24KVyj5
         mE/7M5OZK2VflpiEsoxzs2pH4KmNDRERsxJeo8Oveww+8dDOWpSsDZn79pUqR7SW/iQY
         e+v//ATij4Bk1eSFfFBbjBvsPVANV7j1YJd4oY7sfAiYxdKCcn5k11eqTiRCR9HBHLAr
         1GYiMYF/p4iaaptm4KhG+ka1PcTu5yZJpomwVAT2pVgMYLi4qPdNp9EfYmdmkiK2HEr8
         yHDw==
X-Gm-Message-State: AA+aEWb3st0gm59/DHmQB7BT3/aI6vBQHoigy24IIXKjc+4jBbH16Jzm
        BfVsSGPM+uTyni2XBFa29A==
X-Google-Smtp-Source: AFSGD/XzNGl2JnxcMIsUYgcd3IY+N80IVcHEYNvfAS8bHRjJBgUlUj1/b2jaHmLT2xiGS1vLmAdwXg==
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr14651848otr.251.1545228203951;
        Wed, 19 Dec 2018 06:03:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 4sm9109358otw.39.2018.12.19.06.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:03:23 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:03:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
Message-ID: <20181219140322.GA6620@bogus>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Dec 2018 00:23:10 +0300, Mesih Kilinc wrote:
> Add compatible string for Allwinner suniv F1C100s DMA.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/sun4i-dma.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
