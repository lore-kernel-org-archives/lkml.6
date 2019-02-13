Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F386BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3D520643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y6h46vE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfBMM7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:59:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45950 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBMM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:59:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so3646793ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cjbHZjDXzQHFpoSUmBFSxpmR6yzoGP2sypxmSivxUZU=;
        b=Y6h46vE8GjsC6PKKglbQiMh1fsBgaFrHV/kyWuaRrjS+HA7EbBokcmTLQnPb0ZdFpI
         WR9dUfb/aLHuvEJe9KMEpkVoDUvWb5ldlXvGezMIlrJKE+jv4TFJ7B0xf9ATu2pAIx/x
         RnRwmLWq3aKkKErAv8y3GhC+bjPNIpCeLvK44NRjr9uapfmaycggmwGJnswIiZS1iAtE
         UWnHdF9eHh49y9OIFu9STrrxVLEPn9BgCmMvU2Nr6DSi34Hv71k91Zvu4RRnoY83gfh5
         h5Qp2uxseyoUe8POO+Wpq4GN/+5e2Gm99UbZRLKAldkhaMyBPpMLBulRjON6oBFYZjcE
         4FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjbHZjDXzQHFpoSUmBFSxpmR6yzoGP2sypxmSivxUZU=;
        b=ZI/Rwchwv3ewFW7JrfIaj9GRHlniyJL0SLoKMaU+fIEzrlIUk+FSm1UrO7qOSaQWc0
         01CKbYJNVAJfrxGSt+UpVWvxfR7wVfW2jbNB1mD3t4Zzs6PDNzNK4rnDJxUlD5teGPBU
         u2QiPlJgm7p+d5rvn4l6e5Mujw7MXkGq16IYd8zVVq+B/DNczCoHTt947tAP2fqmdRDx
         QERcltoX94/q2775noo+DT4hiStFrBcwMGxVZzwNAeBjdcYYwyCPvbkDaQCuEowZ0jWc
         NEKbd5XU7+/o+BFobQnQdqP2OexZd9sEgyIvLba1zobhqD8KAa8LSS6Oir+xL/h04F2y
         LwSQ==
X-Gm-Message-State: AHQUAubBS2Y2R2IATHQsW8JrgJxck0FdR1sxzODTSIvt2Q+5zNp+v60T
        K83gS6Vkr/Ypxcdh8gxhW+h0ZGfeyBXwhc7V/woQDg==
X-Google-Smtp-Source: AHgI3IYQg7s8BzfbNtquOZXJFhitpEDZzKNNvrfoPUuYtUyLQTEHJyffZBMpxpVMxbjA4jk8DGhc0K21KpsOARYZrmk=
X-Received: by 2002:aca:af53:: with SMTP id y80mr155896oie.170.1550062772306;
 Wed, 13 Feb 2019 04:59:32 -0800 (PST)
MIME-Version: 1.0
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
 <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
In-Reply-To: <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Feb 2019 13:59:21 +0100
Message-ID: <CAMpxmJWuMWBSPjoJWkfagAAopYjohA0rhxUacNPXhhiTFZJorA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 13 lut 2019 o 13:49 Baolin Wang <baolin.wang@linaro.org> napisa=
=C5=82(a):
>
> Change to use SoC compatible string instead of wildcard string.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-e=
ic-sprd.c
> index ac573da..24228cf 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_device=
 *pdev)
>  }
>
>  static const struct of_device_id sprd_pmic_eic_of_match[] =3D {
> -       { .compatible =3D "sprd,sc27xx-eic", },
> +       { .compatible =3D "sprd,sc2731-eic", },
>         { /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
> --
> 1.7.9.5
>

We guarantee to make older device-trees to work with new kernel so you
can add the new compatible, but you can't remove the old one.

Bart
