Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E1C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58C120841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMTHkA0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58C120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG1VVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:21:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46011 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeG1VVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:21:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so14831355oic.12;
        Sat, 28 Jul 2018 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to;
        bh=waP0LzJdgmULv4dKKQMtqJuh2vqF5tTdy6gamqj/Aq8=;
        b=mMTHkA0f5VkRyXlNQ6M9NCdweoVvulrVe0XN+kEZhGahr2dVrDzA4V9JrBbEIJZNXc
         bYiECUJ9v933nSgX0dfzRAfzi9b71zhtsZWcXlGha04ED02LU5zn+LxeHv+I6hduCHC+
         dHpg93cNYmDThV5EjMx4AyJmT6f5+DA+sAB7jkatrQrwSOdgdf7FbDtkbrgU1PugFaCw
         r+zap1d5TKbrjFjz7A2f/Ba6A5crP5Jp/myTSHdB7TmwMd4vIMPWnwZqIsJaL7/Qo1ri
         VI0P3l6CYTFXeAqc3LFQnACluVrlUY9+5ZsDpKiWiqoFlwS6UOA5K2vo/eRoxswmPrKX
         WK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to;
        bh=waP0LzJdgmULv4dKKQMtqJuh2vqF5tTdy6gamqj/Aq8=;
        b=ZIg0sf4rC9ILXCDRbPAq7DxA2JmdSCh7e8nZAMQph+qk4w4X3eY/SAMPD6kaPoinlm
         cdI8JO8iOinsDeXe1fDpj+L9VY50vkIroXQj0o3rBhU8uQKipD8rhGSTQBtY3PhbZj1N
         YlAxxRq+5W4Dlvx4NdBk6tTIkgW5L9N78aBOoXDQ45lEsw8Mg70Oe0ue3V7pclfje4uM
         ab2gZb91eiq0enTymiyDuYd4P8cydJ5/o9imzndXOybfD65YbVIVrBbkqlCflGUyxHv5
         UHHU59Jurp0uuIrsH6qYCF6i3mz/0M1L7F/BSVFgvAtWJ0KrqDm2wKluNfz1yC4Ub55w
         93wQ==
X-Gm-Message-State: AOUpUlHTKmZz15kRYdlLtg9DUFQjFbQIViJ/qEu6hsi1zu/XCG7YYeND
        8D+aeGQRSOKTTTMJ8lHJq8YsKGIPp9VsuO8y+tU=
X-Google-Smtp-Source: AAOMgpey8ygr/WY4Fcj5dV40DaCqESiP1g5GP13uD2Xq1WW41cGHanNJ0HFPn5tXIpDKTM/hoePkTaqCeqHbqFmqMl0=
MIME-Version: 1.0
X-Received: by 2002:aca:6141:: with SMTP id v62-v6mr12387074oib.240.1532807626052;
 Sat, 28 Jul 2018 12:53:46 -0700 (PDT)
Received: from 329980741037 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 28 Jul 2018 15:53:45 -0400
From:   John S Gruber <JohnSGruber@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
Date:   Sat, 28 Jul 2018 15:53:45 -0400
Message-ID: <CAPotdmS6dv0YkqX4QBt-DaYsO77Hza2bgMLJuzHi+cjNn27fYw@mail.gmail.com>
Subject: [PATCH 0/2] "HID: redragon: Fix modifier keys for Redragon Asura
 Keyboard" causes regression for Acer keyboard
To:     Jiri Kosina <jikos@kernel.org>,
        Robert Munteanu <rombert@apache.org>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        JohnSGruber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me in any replies.

The Acer branded keyboard that came with my Acer ATC-605-UB11 computer system
fails completely due to:

85455dd906d5 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard.")

That commit was merged to 4.18 on June 8.

The redragon vendor_id device_id combination 0c45:760b is shared by that
keyboard, as well as many others, it appears.
See https://linux-hardware.org/index.php?id=usb:0c45-760b
for other SONiX keyboards that don't appear to be Redragon devices.

First patch:

While the Redragon keyboard uses the second device created and not the first,
the Acer, and perhaps many others, use that first device
(the one with dev->maxapplication==1).

The hid-redragon.c driver should not cause this device to be ignored and
should not interfere with its being cleared up when disconnected.
It appears to me that this problematic change was made late in the
patch's revisions as a clean up.

I recently tried to connect another usb keyboard after the redragon driver
was activated by my Acer keyboard. It is blocked from working too
until the kernel is rebooted without my keyboard being plugged in. I
also understand that the interference with the first device stops
the keyboard LEDs from working correctly.



I'm resending this set as I haven't heard from the hid people in the two
weeks since I first sent this. Before 3.18 is released I believe either
this patch should be quickly finalized and applied, Robert's patch in the
linux-next tree should be applied instead, dc9b8e85ed9, or, as a last option,
the problematic commit should be reverted. I've tested all three
possibilities.

Second Patch:

As there are potentially many different devices being intercepted by the new
hid-redragon driver, and as the bytes x81 x00 are not rare in this context,
I also think it's advisable to improve the verification condition before
performing the report-description patch only meant for the Redragon Asura
Keyboard.



These two patches will follow. The first restores the function of my keyboard
sucessfully.

I don't have the Redragon Asura Keyboard necessary to test the second patch.
Its rdesc data come from Robert as posted to pastebin.

John S Gruber (2):
  HID: redragon: Fix regression in non-Redragon keyboard due to this new
    driver
  HID: redragon Add additional verification to rdesc modification quirk

 drivers/hid/hid-redragon.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
1.9.1
