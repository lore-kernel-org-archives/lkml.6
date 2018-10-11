Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A158C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6EA2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6EA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJKWak convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:30:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39152 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:30:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id w21-v6so6929883lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PCNjYy8QEv3m/N6dVDGdOECUZprwcFxUN6/PK2USGh0=;
        b=jNZN3X9Bry7XJy1bL7geK/q/P14b+46pGXlIOgnG9OL0Nvn1IUJZHxh6nhl2pOtFiz
         W2OaRU9Cg9O8sRFiWhRcBDSW2pcmc6BrlZIA2lQGV17JbaGMRYt/v1KrJlvRHXimD4Oq
         DlorRKeh96xNtGDl03Zbac1jCn/Q9QSIS8STPTthEYLAK2Yo/GHofy1sjkg/F2ZYv6jp
         KJrwKok5lAcsBmI5r777vy/7arQZ4UNpvNqBeCzlSP28gk0qdwaB+JUcbxxbGOqUKiR6
         wnWwq++hDAPzh4W6jVqoGdO0DAIcOSvaca1TPhcM/MfbahEt+J+1rZK37TzN2AdoWfcm
         AvJg==
X-Gm-Message-State: ABuFfoheA2EACuRGqYzGuQuYY0d0tcZ1ShUGULp/XtfUS76NgRDUNHlo
        BR60j1Ej/2YQX6//ah4vrf+WW48kBKoBu1bZroDz+Q==
X-Google-Smtp-Source: ACcGV61bjD/1lY9JRvbRmXTy/Zy6HUpzJz1BG4IE/etQaAFGuw1kfmZwj8W6pOTr7WxaGSIlcv2XunXAnudTOJqeywI=
X-Received: by 2002:a19:d906:: with SMTP id q6-v6mr1361736lfg.62.1539270183544;
 Thu, 11 Oct 2018 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
 <CAO-hwJJkB=u44_kJNjOSL=8pgnXDkvda12_g8p39DeZ0JybqWQ@mail.gmail.com> <3941E373-A385-4080-ADCC-BAEBC862809A@canonical.com>
In-Reply-To: <3941E373-A385-4080-ADCC-BAEBC862809A@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 11 Oct 2018 17:02:51 +0200
Message-ID: <CAO-hwJKMkZx5mcXrYrbjYBeQdOqK0fThUc_amP0ofA6YtvWAEQ@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:16 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> > On Oct 11, 2018, at 16:34, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Kai-Heng,
> >
> > On Thu, Oct 11, 2018 at 9:56 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
> >> do not increment usages when a duplicate is found").
> >>
> >> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
> >> can solve the issue.
> >
> > Before we take the hammer, could you share the report descriptors (or
> > I'll request those in the kernel BZ)?
>
> Feel free to do so!
>
> I send the patch because seems like the user doesn’t know how to upstream patches.

Heh, no worries :)

So, after a review of the report descriptors:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(In this case, adding the quirk is the easiest solution and it has no
side effects)

Cheers,
Benjamin

>
> Kai-Heng
>
> > In the kernel BZ, it's clear that the report descriptor is wrong at
> > assigning axes, but I'd like to double check if applying the quirk
> > will be OK and will not pollute other axes.
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
> >> BugLink: https://bugs.launchpad.net/bugs/1793846
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/hid/hid-ids.h    | 1 +
> >> drivers/hid/hid-quirks.c | 1 +
> >> 2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >> index bc49909aba8e..0e0aa7f0e6fc 100644
> >> --- a/drivers/hid/hid-ids.h
> >> +++ b/drivers/hid/hid-ids.h
> >> @@ -342,6 +342,7 @@
> >> #define USB_DEVICE_ID_DMI_ENC          0x5fab
> >>
> >> #define USB_VENDOR_ID_DRAGONRISE               0x0079
> >> +#define USB_DEVICE_ID_REDRAGON_SEYMUR2         0x0006
> >> #define USB_DEVICE_ID_DRAGONRISE_WIIU          0x1800
> >> #define USB_DEVICE_ID_DRAGONRISE_PS3           0x1801
> >> #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
> >> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> >> index 249d49b6b16c..52c3b01917e7 100644
> >> --- a/drivers/hid/hid-quirks.c
> >> +++ b/drivers/hid/hid-quirks.c
> >> @@ -70,6 +70,7 @@ static const struct hid_device_id hid_quirks[] = {
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
> >> +       { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_REDRAGON_SEYMUR2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
> >> --
> >> 2.17.1
> >>
>
