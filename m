Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B202086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B202086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeIJNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:24:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34123 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbeIJNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:24:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so15859068eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8puvfjOaR4VfFkTlN1+aLWAQuNPIiysE1hNFutLktY=;
        b=Z7/JkpbdmjfV0+mZMxFMFIIfSJA3fsBQqbvt4pv6BVWgl08sE3QVkdn6qOMi/Oy8xf
         qKk6qaoK/vCZpw20MN3QlSrtdhcX5dkGDzYLPHfAIBYCCbvqcOhMkYdAXcsHMGH2hBmH
         PwTkgm2pTMOM2moH1Nrl64zje+n5FcQ8q0slbGLBsufCUJbRAvkN0C6cxy18Yh8RPeYc
         ZYZNIo9RKQ6ApSe+TXBMZyjZK2WlUBsYnZcfqKY8phsU7GbrWmw0+rizCFhgTnQokWHX
         H+XYsIxUvlHWx6XYjxnEws2X9Pad1iZHgM649793k0eK74a23kAlyZNdm9ajq5TWQIHI
         iXyw==
X-Gm-Message-State: APzg51D6j9STUJj+IH046hnAEGt3MDlNZ6k5IWdIH6yRevSMmjgkp6YU
        O8uEWcSksZ6GDyQ2d0WLNPWBmUGDZ0M=
X-Google-Smtp-Source: ANB0VdYhivH7hwi/sLQLYoSBI7rFPW2A8maegsnqaUVECuNTWWiQljzI4rZvw897Nr0VdkKHXZ/ppg==
X-Received: by 2002:aa7:d391:: with SMTP id x17-v6mr21838943edq.144.1536568267227;
        Mon, 10 Sep 2018 01:31:07 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com. [74.125.82.54])
        by smtp.gmail.com with ESMTPSA id r35-v6sm14155956edr.59.2018.09.10.01.31.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:31:06 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id 207-v6so20334310wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:31:06 -0700 (PDT)
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr12590486wmp.58.1536568266554;
 Mon, 10 Sep 2018 01:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180909190439.20425-1-contact@paulk.fr>
In-Reply-To: <20180909190439.20425-1-contact@paulk.fr>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 10 Sep 2018 16:30:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v66=O6E43xKRkSDHm_Un_CEd2NQnNtyAH+C98i7Zyj7zdA@mail.gmail.com>
Message-ID: <CAGb2v66=O6E43xKRkSDHm_Un_CEd2NQnNtyAH+C98i7Zyj7zdA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <contact@paulk.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Sep 10, 2018 at 3:04 AM Paul Kocialkowski <contact@paulk.fr> wrote:
>
> This makes it possible to build the sunxi SRAM driver without building
> for the sunxi architecture. This allows selecting the driver when
> building the kernel in testing environments.
>
> In particular, this is necessary for testing of the Cedrus driver, that
> selects the sunxi SRAM driver.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 113e884697fd..446166ba0bec 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -18,7 +18,7 @@ obj-y                         += qcom/
>  obj-y                          += renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)    += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
> -obj-$(CONFIG_ARCH_SUNXI)       += sunxi/
> +obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-$(CONFIG_SOC_TI)           += ti/
>  obj-$(CONFIG_ARCH_U8500)       += ux500/
> --
> 2.18.0
>

Do you want us to merge this on an immutable tag for you to pull?

ChenYu
