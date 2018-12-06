Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82220661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6zpBhjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeLFLpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:45:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41127 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFLpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:45:47 -0500
Received: by mail-yb1-f193.google.com with SMTP id n134so96601ybf.8;
        Thu, 06 Dec 2018 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V0jh6ZDzmh12Ee5TlMg7+a9CJ6zs/faP1jc19qokHtI=;
        b=W6zpBhjjgiMkdQN6xyXIIrIOG4l4lP9oJLDCPFt54ar4GVvoaCLAetflIydcqQ/wkJ
         YyrtwEAnFASRm26pUjnLhfGT5uHKkdUcFvGiVkLJZVvJTHnyd0N7G4wYBkwFpIHRsmPQ
         r0GBn5cwj/F73KO3LJykQWMpzzVHk/Ugg2N652tj8c88ySGJxeyhaCBHZU/EBQO8TgYA
         4yw788glxUEEcaAZDbemRlD2KKtOFeCu7vyJGZRW3yBQ5TL3VYJpBodI91ZAL/wndMwb
         yweaq02nshb2OTN2yBbiQ8H9NdfLUzC4rvq9eWcWUSdE0yB1Hrx5c5kYQilSuJ8U5psp
         xuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V0jh6ZDzmh12Ee5TlMg7+a9CJ6zs/faP1jc19qokHtI=;
        b=iS5TWg4U5hlTqfH8eWcImdULKj2JHL8VLBuMhug3dYbmWEXRdud+/sDXLM/6BGovbk
         5EDMb+uJSU2rF/Iy5v/VgdxzMA4k4ujNipsNdDN2/OYtN/ojnI4vcbJFHjSrQJfovVqz
         MxOOP/1lUOJK6yNEG8HlkmXeE4Y5WcLQowUrluMgWCz+6MVxXHAOzDPn2dUY8y8qTwDa
         gBab0xakQUNtYeIZrbMJiGaORYv1Ful2SMThPyD6gF+BwiyoSQ08qnM/WsPU7PWM4+N/
         Yu8JSjcsIlV8a1sTGzNvDwTakqreQ1gG7tzxCB4tUOgfC7JEMlRN0ebyDHFwbbr/7Ogk
         nz4A==
X-Gm-Message-State: AA+aEWa2ayl0ueGc03xEnbNeG/T6lhasDWAAHrGhzNq+j51RS+FKj7Qm
        ikEAAc4k2O+7v7aoqI9a4T4Akaeq+vOeHEPz66U=
X-Google-Smtp-Source: AFSGD/UfJZGu/1u0RijiCpdoN8lFH7hl8n4OymxSMTF2+s8VCOmDMsp9v/rzVhqUKW5a3ejREIY8pzQP80DLgXaH/64=
X-Received: by 2002:a81:7c04:: with SMTP id x4mr18932366ywc.264.1544096746043;
 Thu, 06 Dec 2018 03:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20181117121452.6101-1-peron.clem@gmail.com>
In-Reply-To: <20181117121452.6101-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 6 Dec 2018 12:45:34 +0100
Message-ID: <CAJiuCceKdd4P_Bih138cUZWLRrXkmvysgmrneQ+2w4oduhbuOA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add ASoC maintainers for sound dt-bindings
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle up,

Thanks
On Sat, 17 Nov 2018 at 13:15, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Sound dt-bindings are applied by ASoC maintainers and should be
> submit to ASoC list in addition to the devicetree list.
>
> Hence, add this information into the MAINTAINERS file.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0abecc528dac..62701e0135af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13930,6 +13930,7 @@ S:      Supported
>  F:     Documentation/devicetree/bindings/sound/
>  F:     Documentation/sound/soc/
>  F:     sound/soc/
> +F:     include/dt-bindings/sound/
>  F:     include/sound/soc*
>
>  SOUNDWIRE SUBSYSTEM
> --
> 2.19.1
>
