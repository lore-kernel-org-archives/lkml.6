Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C359C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAD20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CAD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeK0GJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:09:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46611 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0GJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:09:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so17684705otm.13;
        Mon, 26 Nov 2018 11:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjmGH88+dZSYpD4yPFK9mShiiYrKdxylOKAAQ9hh4Lc=;
        b=n3DthoHMXQFsb6rbch71pI9jL0/71cWLZfQOfwszfsAIPE8j0Mrha9Y8hCJgV+3kMO
         I5WfcH5hHOrb/4BRJvpJ86qPOMwTymy3av5LV91BV6+Ou+zjo6P2jJBoDVIeqPuZlBxu
         a6ZdqBK7gcpRTU1zEfwcOURBI2lKJYBM4QdPuyvgiVsOh3afKMWY2t8CjVDiniYzFaeA
         3mEpxo4bJwIzODgsBZZDrZ/Omudd1MMVN7y6wlPMI18+CwBNSmmGD+j3GqHdCc460V14
         /cyiM5SNoAGPEkUnX8wGDvTtmTY5vZbNu+CGC1B/xUaKCBWwSRIEsizq003G2IXW4Dar
         pqyA==
X-Gm-Message-State: AA+aEWZMhw5vWwTWyJHcsqX+CEqATyrJ+hez7QyfOcM3if99Z9agYqdX
        jgozVbsK4eKCid80evLU3MwDO/I=
X-Google-Smtp-Source: AFSGD/UAaWPPhBhwNgUIzjJzcztOc1hr5RMixbLqpzK0zFWiiQSU2zfxz8HLuqQww946L6BYS5YKDg==
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr15860118oth.4.1543259674168;
        Mon, 26 Nov 2018 11:14:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y17sm963085oie.41.2018.11.26.11.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:14:33 -0800 (PST)
Date:   Mon, 26 Nov 2018 13:14:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v9 3/8] ASoC: dt-bindings: add regulator property to
 simple amplifier
Message-ID: <20181126191432.GA30762@bogus>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-4-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122102325.29495-4-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 18:23:20 +0800, Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Amplifier may have associated regulator, so add a property for it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
