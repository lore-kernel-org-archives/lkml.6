Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73939C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C12120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJKQBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:01:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43178 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJKQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:01:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so7423343ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaK2S6rgsJ+tp31COh6TC6KPHKbopjeXQQZsujY4dD8=;
        b=AvMFmM25JTLbi8mEUlBTOnWQqNBrRiyFNClyTAvN3p0URQY0rfxF4/qx+zjQv/syMu
         DxNIi+c3dln0porSj0b1mjCyiRbR/ueLix5ZCYYH77I1bAYcjoElDIJ84VjVrcnO+ZbD
         TCjpz6fPODHAVCKkB2cgiAnN4xD1QMXSGtqX5nkfcNEIZPKDz+eP4MkTlIT/BS6J2jjt
         3mhV6js0U1GD2ONJJ0jd7Q6v40EjqBGMd9x6HI1IsYHULGbg7QTVruKp4tIFTtwF4KyW
         eN0mnIXtBGiljmBuPvq9QTswF9NNb6ol/5uJxMI0zTiTcy1PcHkFaOMBxBswJeSSrk3Y
         AxDw==
X-Gm-Message-State: ABuFfojb/YaRYKkO9Hvm+ysTljHo4q4Lw9A6AW4xCNxK8SS119L5Tzb/
        e6Ni1jKCC6zK4jlHlQPRp1o/qKHskMGsoBbl+EKrsw==
X-Google-Smtp-Source: ACcGV61OVx2HB+9KhIYZagox4pkJEB6RwmXqh9ev00BM/GbD3miPfytc/aBvCpbrfbMGG8Mnnhkjrcm8Vq68cCkx63s=
X-Received: by 2002:a2e:8981:: with SMTP id c1-v6mr521925lji.124.1539246895991;
 Thu, 11 Oct 2018 01:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
In-Reply-To: <20181011075633.18868-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 11 Oct 2018 10:34:44 +0200
Message-ID: <CAO-hwJJkB=u44_kJNjOSL=8pgnXDkvda12_g8p39DeZ0JybqWQ@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

On Thu, Oct 11, 2018 at 9:56 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
> do not increment usages when a duplicate is found").
>
> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
> can solve the issue.

Before we take the hammer, could you share the report descriptors (or
I'll request those in the kernel BZ)?
In the kernel BZ, it's clear that the report descriptor is wrong at
assigning axes, but I'd like to double check if applying the quirk
will be OK and will not pollute other axes.

Cheers,
Benjamin

>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
> BugLink: https://bugs.launchpad.net/bugs/1793846
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-ids.h    | 1 +
>  drivers/hid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index bc49909aba8e..0e0aa7f0e6fc 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -342,6 +342,7 @@
>  #define USB_DEVICE_ID_DMI_ENC          0x5fab
>
>  #define USB_VENDOR_ID_DRAGONRISE               0x0079
> +#define USB_DEVICE_ID_REDRAGON_SEYMUR2         0x0006
>  #define USB_DEVICE_ID_DRAGONRISE_WIIU          0x1800
>  #define USB_DEVICE_ID_DRAGONRISE_PS3           0x1801
>  #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 249d49b6b16c..52c3b01917e7 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -70,6 +70,7 @@ static const struct hid_device_id hid_quirks[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
>         { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_REDRAGON_SEYMUR2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
>         { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
>         { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
> --
> 2.17.1
>
