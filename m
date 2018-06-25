Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3866BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0876254B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0876254B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeFYGZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:25:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38558 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeFYGZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:25:29 -0400
Received: from mail-wr0-f199.google.com ([209.85.128.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1fXKwK-0007Hz-LK
        for linux-kernel@vger.kernel.org; Mon, 25 Jun 2018 06:25:28 +0000
Received: by mail-wr0-f199.google.com with SMTP id r2-v6so8642186wro.21
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N1axxX4lPLr0u09hb8Ninl8+8sjJly0GoRegLL63hYw=;
        b=qsioPHHbjoVSsqnX7UH1HGTLiWWWjZJf6gdKcoHzSk6u2e4MfV27uNrtffxR2wEc7w
         UoxVT/ZDNtpD2p1Rq60+dEIoy0g/jeolvOeE4Ih9vAge2BRV79JkOSyXloVxHk2Sxnf+
         vfPPuWYWtmCVTRxwmMKLPyTIvaSG6vsQRLYMVgkzk8VH7ij0GszEmbAD7Kq0+NxfCZRy
         jaSWyzIXnlX2ODuy1ci6Q5jfNEYeQBSlMwUn6hTGleJC6XBMb+GVgPpB2gkhNmy4trUx
         Av/Kp7ZZObOIHAMXJ7MIciNT4UIcEDW6Nc2VW/7amk80PZAyf4Ah7vE9gA5P2IxUhE1p
         /Fxw==
X-Gm-Message-State: APt69E1zZdXsKRWyWleqs3EESiE1X6ktuAbZRVoc5rPa9gYIc4g9npIH
        HjnX2n5GtoB8NDCrfjZ8RKWku5LPp3Caf2rFmnQRXyDpA8spsxJwPHEq4jlW0X34ojwEK8objg3
        uEiHhswAWUccCkf5S6d1oA0Ck3JyZHMv3krdr7lc290T3Es5wambdiK7Vew==
X-Received: by 2002:a1c:6744:: with SMTP id b65-v6mr7921569wmc.9.1529907928276;
        Sun, 24 Jun 2018 23:25:28 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKIDY/Gipu0BNjA2BVNh0w4K7UKhZP0BxH4kuULPCeOCgJk13CLV1V5BESRY18sfy2pI3Hv/WVe3n5rFCuL+FM8=
X-Received: by 2002:a1c:6744:: with SMTP id b65-v6mr7921562wmc.9.1529907928062;
 Sun, 24 Jun 2018 23:25:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:bc55:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:25:27
 -0700 (PDT)
In-Reply-To: <20180625002940.117141-1-delco@chromium.org>
References: <20180625002940.117141-1-delco@chromium.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 25 Jun 2018 14:25:27 +0800
Message-ID: <CAFv23Qk_scxPrPMJ6aWhEMqijaS0dJ4LUB73bKfr_UAWqbx3aQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-vbtn: Add support for dock mode detection
To:     Matt Delco <delco@chromium.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me

Reviewed-By: AceLan Kao <acelan.kao@canonical.com>

2018-06-25 8:29 GMT+08:00 Matt Delco <delco@chromium.org>:
> The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
> tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD. Based on:
>
> http://www.traby.de/medion/DSDT/dsdt.dsl
> https://gist.github.com/jprvita/5737de3cbb670e80973b7d4e51c38ab6
> https://osdn.net/projects/android-x86/scm/git/kernel/commits/
> 7cbe5a330687b851f32dd9f1048a6ce182d0ff44
>
> It appears that 0xCA and 0xCB are about dock mode, which for my
> convertible laptop seems questionably tied to whether I've put
> the laptop in tablet or laptop mode.  I previously proposed no-oping
> 0xCA and 0xCB but this revised change attempts to add support for
> detecting dock mode--this detection will essentially be broken for
> my laptop (the main workaround would be for 0xCA and 0xCB to be used
> to provoke a query of the VGBS method that reports the current dock &
> tablet mode [which is accurately reported on my laptop but based on
> the prior workarounds in the driver it apparently can't be trusted
> for all systems]).
>
> Signed-off-by: Matt Delco <delco@chromium.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/platform/x86/intel-vbtn.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index c13780b8dabb..06cd7e818ed5 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -17,6 +17,7 @@
>
>  /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
>  #define TABLET_MODE_FLAG 0x40
> +#define DOCK_MODE_FLAG   0x80
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("AceLan Kao");
> @@ -38,6 +39,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
>         { KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },        /* volume-down key release */
>         { KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key press */
>         { KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key release */
> +       { KE_SW,     0xCA, { .sw = { SW_DOCK, 1 } } },          /* Docked */
> +       { KE_SW,     0xCB, { .sw = { SW_DOCK, 0 } } },          /* Undocked */
>         { KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },   /* Tablet */
>         { KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },   /* Laptop */
>         { KE_END },
> @@ -121,6 +124,8 @@ static void detect_tablet_mode(struct platform_device *device)
>
>         m = !(obj->integer.value & TABLET_MODE_FLAG);
>         input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
> +       m = (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
> +       input_report_switch(priv->input_dev, SW_DOCK, m);
>  out:
>         kfree(vgbs_output.pointer);
>  }
> --
> 2.18.0.rc2.346.g013aa6912e-goog
>
