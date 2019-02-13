Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A714C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19B222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOBXau6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbfBMIHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:07:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33173 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfBMIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:07:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id q12so1082152lfm.0;
        Wed, 13 Feb 2019 00:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHcGxz3V88oGQhykUNeVVZN70O0EhRcnJWcib7mocSQ=;
        b=UOBXau6BHAsTofr53bBkRVeGAvV1PEfVNhteIEGtw+aslAiL+Jf9oxf2HHlT/OEU2q
         NACA9f4jjzyFACtO0GRcnMgSH3/QzQtivCAN4zcYuNCFD5IY7DYfIS+FcMYuA/6bUERy
         Gyfqn+vRGIPJISsXCPKtNi7hR/6/T5D4hrA/xBwDd3810fGzFlxM4TpyLh771uMx+47G
         A2MBaeTU7SKAiZHuFt8zw2dBElWQMp3PEBA3mDL74dIZ9n4H/SnpjyKvPmCCw+oC7+hX
         E6zY94HLyWD+xXQVSo6EMTVKCzdlo7C2buQbS56+YxE84/UAS6+COxst8znFGJUY33XW
         NSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHcGxz3V88oGQhykUNeVVZN70O0EhRcnJWcib7mocSQ=;
        b=SAMV+i0m2yWM2+CyPz+BuDFXdKxUtFKoSuYv3gAy09Hjdm7mrKNr75dWEtAyQFPgXG
         CJizUJjM86SCtH5rccAfmwMQ3zzzktYjmjXxhKJ4zqDqHG3Hp+tXplhQ7tsrak/JLftp
         lu25fdo1JyXHyd6Zf2O7SNrqsq9L4bVTF90qIJXJuri6FrU3Q4qTklRKZffDOhILS5kV
         fObZGYDX110iXbaD3zieT2rlThx2TMxm1LHitryvJl4AoEHcZ+QYIlZUCOPfIfdOq2ES
         +RAQhoa4p34OymWCLGxeRLcAVbHDLhwj045fjmUS0dFUXIdn2m7SoH1ZJC4+cjzmCWdY
         yczA==
X-Gm-Message-State: AHQUAuZk7KRnbGjx+VpKI5XK+qn4xPLcr88WX6vJPdZLENPf6JKpQp4v
        kzRkxw9RDs/bMfuccnOgUdG144cKy3s=
X-Google-Smtp-Source: AHgI3IboGuxbtt9iiv1hzDd81tncWimgZmURt+jqYk3xvLsEz6vypmyIEokNA4W9pziLbtUOepP2yQ==
X-Received: by 2002:a19:914c:: with SMTP id y12mr870894lfj.55.1550045251623;
        Wed, 13 Feb 2019 00:07:31 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id z17sm3902977lfh.9.2019.02.13.00.07.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:07:30 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management
 port
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190213042600.27729-1-f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
Date:   Wed, 13 Feb 2019 09:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213042600.27729-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2019 05:25, Florian Fainelli wrote:
> BCM5301X has 3 Ethernet controllers: GMAC0, 1, 2 which map to ports 5, 7
> and 8 respectively of the internal switch. Future changes will turn on
> management mode in the Ethernet switch driver (b53) which will require
> us to use port 8.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 3fced3b7f1a8..affa9cc7422d 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -150,10 +150,15 @@
>   			label = "wan";
>   		};
>   
> -		port@5 {
> -			reg = <5>;
> +		port@8 {
> +			reg = <8>;
>   			label = "cpu";
> -			ethernet = <&gmac0>;
> +			ethernet = <&gmac2>;
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
>   		};
>   	};
>   };

I'm not exactly sure how Linux switch driver works, but from DT
perspective I think we should rather have *hardware* described instead
of a common Linux case.

If I'm right, we should rather have all 3 switch ports described (5, 7,
8) and have Linux just use the one it needs.
