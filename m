Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D49CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB678217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB678217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeHMV7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:59:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41788 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbeHMV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:59:50 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so15869379iob.8;
        Mon, 13 Aug 2018 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ia60G+Rp4hsVa8jzvu02TOCdsquIequGf1S/oog1axw=;
        b=NzvKbcYMB3iURSIsHbOpoOwrUaqYXlF4+GVbiRhyqKmtLrvg9T+7aaxZ8nMNc4EYYu
         Px9ILNKeFoXYRgeBcIJnI4RN0Pq3bt8EbSyugwa9BQuMbGiBEHrCtj0ltrnSluEYH6gg
         MBDRnU8QxjRNHatc2gRdATVW3ka6OFV7M8G3A6r6ESxr5wWKsIxbaGWUiqTdfdCQQf6t
         VrWSF4douwL/5rczuyn9hdwC5jzX1EWf7Y+8EKNz5/EbGSt1DsZA5yNSYps2Zv+JcTxY
         IQGoU0DyQlMEMWcQOIFRuULSYaLkIhLl7GWmjbQnh/dBphrJceuCqA+FLmoD5qbFH9sm
         XinA==
X-Gm-Message-State: AOUpUlEnDrS49dMWb73QLAPEB6klvtdzG5+F+z3muZWHMmPJptAjDvVu
        4fr9in60A3WYNLRU7K2nY8lRGRw=
X-Google-Smtp-Source: AA+uWPwPlCIWSmhWF9gOYRi7QfGBbbYjYYT7aRQiyg6uFcZebo16gaSvKAAeirnNdkMFt9W0u3Zh4w==
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr15522665iou.218.1534187777642;
        Mon, 13 Aug 2018 12:16:17 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id h123-v6sm5317321itb.32.2018.08.13.12.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:16:17 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:16:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     mchehab@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH v2] dt-bindings: media: adv7604: Fix slave map
 documentation
Message-ID: <20180813191616.GA4086@rob-hp-laptop>
References: <20180808163351.28852-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808163351.28852-1-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 05:33:51PM +0100, Kieran Bingham wrote:
> The reg-names property in the documentation is missing an '='. Add it.
> 
> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
> bindings to allow specifying slave map addresses")
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> ---
> v2:
>  - Commit title changed to prefix as "dt-bindings: media:"
> 
> If this is collected through a DT tree, I assume therefore this will be
> fine, but if it is to go through the media-tree, please update as
> necessaary to prevent the redundant dual "media:" tagging.
> 
> (I'll leave it to the maintainers to decide whose tree thise should go
> through)
> 
> Thanks
> 
> Kieran
> 
>  Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> index dcf57e7c60eb..b3e688b77a38 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> @@ -66,7 +66,7 @@ Example:
>  		 * other maps will retain their default addresses.
>  		 */
>  		reg = <0x4c>, <0x66>;
> -		reg-names "main", "edid";
> +		reg-names = "main", "edid";
>  
>  		reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
>  		hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;
> -- 
> 2.17.1
> 
