Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3278C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FEF20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8S+tLRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfAIHkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:40:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42521 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIHkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:40:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2934702pga.9;
        Tue, 08 Jan 2019 23:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dBoozhFKd3MYntr6ZGABvIVyu6z379S0J2tfM5/OraE=;
        b=H8S+tLRxTXr/k/zlLybZRDspkIC6QjcJZBP7e4emZ/eUB0058utF5167+WGg3V8P98
         SKtpPcwP+wWzpts5vX3vY7g4IZGmfh3y/C7qoq+TzjmZPG6ljnRWm5HjOpCi2Htl92KR
         Laa1RdkDOGqp1O+H0G7JaQiS4sLnMP8ZiRF/qwuBGxE1UHQW77y/jTg/BAswC3sNpqwM
         hnmN4e0WN+9jf8N9PVRHn4mLMvNHPXzTYjm1RMPsCiCMOklxcs0TkCr5nG7uLfe+kiUG
         pQFM4/I7MLEWgkaKBrhCJcNCI6yGg5rbpEMimPayf/OeYPMSe8fwFAUTyIlmaomcCXw0
         0BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBoozhFKd3MYntr6ZGABvIVyu6z379S0J2tfM5/OraE=;
        b=tky/n4tPLVVr28nmafgNq618WYIgnZTiP7lY0z8VOXjfp2mSysbiNMJ0hflrgT89s0
         wOXzcX+msiSWFf4sKByHuIfoDN/nuuA3WC1DbYu9Gz/HSiUpUF+Sf200S4vICHmlRRkP
         URAbJSAr3zcbpKlUfsSShCcpNYFylnQNToKhb5ir5lsOz4p2JofJCwWJngBZgGqWGGb3
         D7E7PlzkWI62qRN0HblqOuNnvpb53ZLIiqXCJpTTg7mFq0Ov9Skn+FcIE8hqSc5+OsqT
         zIpUIcdu6STD54eMvBacBxvGjIu5w8mt1x0Cx90LQ7BLxbAWzZ3/p78DZGkigfKKtKRK
         pMfQ==
X-Gm-Message-State: AJcUukfHoEIdq8RV9oYxS/P1tCeWQCN8hXAuuZNMP7I5AYv1WqxP53XT
        EQ313G0BILtdyptg76TgFJE=
X-Google-Smtp-Source: ALg8bN69KNEB5FIHvbQlEeTSbXe9+1flN3tzPOOJa++MoE984rU6xDTSWaapICxPFQEuvfrrvE6YUg==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr2219603pgc.11.1547019606788;
        Tue, 08 Jan 2019 23:40:06 -0800 (PST)
Received: from localhost (c-73-158-250-148.hsd1.ca.comcast.net. [73.158.250.148])
        by smtp.gmail.com with ESMTPSA id p24sm118031060pfk.155.2019.01.08.23.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:40:05 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:58:10 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>, robh@kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Message-ID: <20190107225810.ggmkkbrnkoy2ykx5@penguin>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215151802.18592-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> Most of the Goodix CTP controllers are supply with AVDD28 pin.
> which need to supply for controllers like GT5663 on some boards
> to trigger the power.
> 
> So, document the supply property so-that the require boards
> that used on GT5663 can enable it via device tree.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..c4622c983e08 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,7 @@ Optional properties:
>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>                               (swapping is done after inverting the axis)
> + - AVDD28-supply	: Analog power supply regulator on AVDD28 pin

I think we normally use lower case in DT bindings and rarely encode
voltage in the supply name unless we are dealing with several supplies
of the same kind, but I'll let Ron comment on this.

Thanks.

-- 
Dmitry
