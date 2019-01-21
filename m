Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC845C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11AE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s132RB/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfAUSPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:15:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34621 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfAUSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:15:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so24636042qtp.1;
        Mon, 21 Jan 2019 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZAuiNZOcMyYu4Sr6tDNzcip58OVo6bIWWJZixreFaw=;
        b=s132RB/FSU4PBSxxGhzRXYz+ytpgZ69csEnMyTanTUASC52t4n9CtLFI1y1VEG7AHv
         X+/aWAG3yu0pYVpszYqDR025ArstkJxhMdezmuCrdcJwVaD/P8YOa5/H1SKWYd1mkZCI
         RfJRA6jeuf4ZSz4+oN84QqU78CejxuJBxusS1BtyahXto0yHivehQkCipPA4EbqmM9GV
         PEfTOeluAnlqihZnNX9F4jVq1Rz0+gJsdQcdpsW2Ht+A5MjkdkxrqU6b7lgnXC4bFOF1
         Q3YcXc7e/+HsWlplBjN/Rd3sxYTIJ8PoYfqMBx6APs1ey0sKvkgqSSdrwUfC6xplVc/J
         Yobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZAuiNZOcMyYu4Sr6tDNzcip58OVo6bIWWJZixreFaw=;
        b=nCrtUN0rqkGg7Y6PHt/8lRvkRYlOEjblMc69vea2d0oBcj2UbFiITbqWG5rIgZVie0
         UD6/Ee01debYXCkAlxSz5V0fhAMYGUtkPRM4OwO7ZYeumyVssTI60QRcRwGNSUANb5ly
         dyScytDcYfBePLpbKIzE3Wb0rH1tOjhU9PZINqLHxbBwilwudTaQxAqp752ctPSnx0MT
         H28YI0PUK84gECHd6h5Z0KXf+OtOZFunK7eRMBBbdyPfyoJRI8kCyuLOhmOoUSitPP4c
         J+cSDz7ooL+23MIyedF+0IgA/6EABwxUxinzFGe2qdIf3qLF9jV6eMXu5hOlSF2ZIPei
         qoBw==
X-Gm-Message-State: AJcUukcYNCeQ7rGITPA/3khWICQaP3ZEkV4UJHJViHAB6Kr48lL7Ao4O
        lkVb8kO/pHA2u9fsAL090Ns1IhBLK1bWdXXa07w=
X-Google-Smtp-Source: ALg8bN7hhaC0sB0UZUyo+O1HCXNv7sbRv+S79lTDx049xWpyJfsmnNckToTeL/Ls6G+bkRIMzitL8vud/mY3UipKDU4=
X-Received: by 2002:ac8:2585:: with SMTP id e5mr28015263qte.233.1548094503563;
 Mon, 21 Jan 2019 10:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20190119113332.249720-1-cychiang@chromium.org>
In-Reply-To: <20190119113332.249720-1-cychiang@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 21 Jan 2019 19:14:52 +0100
Message-ID: <CAFqH_50BKXftn_4p4dK59g3Zv5LvZYVF92weN4OW87muqE_iUQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: Documentation: Add google, cros-ec-codec
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org> and
Mark Rutland <mark.rutland@arm.com>

Missatge de Cheng-Yi Chiang <cychiang@chromium.org> del dia ds., 19 de
gen. 2019 a les 12:34:
>
> Add documentation for Chrome EC codec driver.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Change in v4:
>  - Add a property max-dmic-gain so we can configure maximum gain on dmic.
>  - Add Guenter to the reviewer list.
>
>  .../bindings/sound/google,cros-ec-codec.txt   | 26 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> new file mode 100644
> index 000000000000..1084f7f22eea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> @@ -0,0 +1,26 @@
> +* Audio codec controlled by ChromeOS EC
> +
> +Google's ChromeOS EC codec is a digital mic codec provided by the
> +Embedded Controller (EC) and is controlled via a host-command interface.
> +
> +An EC codec node should only be found as a sub-node of the EC node (see
> +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> +
> +Required properties:
> +- compatible: Must contain "google,cros-ec-codec"
> +- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
> +- max-dmic-gain: A number for maximum gain in dB on digital microphone.
> +
> +Example:
> +
> +cros-ec@0 {
> +       compatible = "google,cros-ec-spi";
> +
> +       ...
> +
> +       cros_ec_codec: ec-codec {
> +               compatible = "google,cros-ec-codec";
> +               #sound-dai-cells = <1>;
> +               max-dmic-gain = <43>;
> +       };
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..a5678e4041e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3688,6 +3688,13 @@ N:       cros_ec
>  N:     cros-ec
>  F:     drivers/power/supply/cros_usbpd-charger.c
>
> +CHROMEOS EC CODEC DRIVER
> +M:     Cheng-Yi Chiang <cychiang@chromium.org>
> +S:     Maintained
> +R:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:     Guenter Roeck <groeck@chromium.org>
> +F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.20.1.321.g9e740568ce-goog
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
