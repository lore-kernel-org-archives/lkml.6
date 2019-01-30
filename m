Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C866BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C121473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548863335;
	bh=POC2mkr9IictvzejYiZGfp3B95vtAo3X4yJqzA3L5ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0P5zUjo0yhP+p06nM+EqrJVChWxVwcEEgTk91GuCEbgwpip3h0dyJla7lytdT3a6B
	 oZloYDlBRr0GFYKT5Dc+qqZpoTrB9f245CxA5wgh2AbmIOGKP6sPYdML1gXSqhfDn0
	 aicRLvzLRP5gO7OKpS1ldJiGKgSBMWOOHBAxj8zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfA3Psy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:48:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45367 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfA3Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:48:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so19528257oie.12;
        Wed, 30 Jan 2019 07:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIvFbso9rnJrc5OUL5DT5uU7me/DauI6rCgSdMwHq74=;
        b=mOGK27X0VWugcRx3q2s2W/llfrqosI1RwWJA7rmSn1kKmJR1mRLhjzLMCNZcK52RLS
         58jQBKEqXp8I4CQdYO3fanFLiLXV1VkNd83oNUYMIIiJPv7EOITLOF3nmi/Fr6591TTW
         SPF9Ia+z91tI8JX+mQ3feEeGuyXlG0zU/2fUHMtxgZWIcHc6r6TkaUrI/IOG+xEyKOge
         X2wMOVbV209WL62JUjh9/FqhLJ3HdzG+FXpmeMhREzrrsD4Scek/4yjlUQQcsshKAS8t
         j6ldrIf7suLzTQqMK75Y55/LumOVpDN39kcvS/qGzN7EXmiJaXoZceSPpQsgx7QdZ5u2
         eD0w==
X-Gm-Message-State: AJcUukecYBpG7yGK1NM7j5nmOkKyM/V4XnNcZipRhCqcNhx93KQN9Zs4
        jPDIMiExLqSPYatrwE3e4w==
X-Google-Smtp-Source: ALg8bN6BdpW1svsWz+hMd4KSbH83B5V9J2pCHmbjB3JwtmmpCQKlFv75L8YHhL0y+4eyWKqfb3sSUg==
X-Received: by 2002:aca:2ecf:: with SMTP id u198mr13048124oiu.338.1548863333031;
        Wed, 30 Jan 2019 07:48:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g138sm831598oib.26.2019.01.30.07.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:48:52 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:48:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add vendor prefix for "GlobalTop
 Technology, Inc."
Message-ID: <20190130154851.GA25794@bogus>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548693481-1162-2-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 17:37:58 +0100, Loys Ollivier wrote:
> Add globaltop vendor definition.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v3: No changes
> 
> v2: Alphabetical order
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
