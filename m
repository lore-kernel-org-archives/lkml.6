Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789D5206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oSNmumvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbeLNRUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:20:23 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:35606 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbeLNRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:20:23 -0500
Received: by mail-io1-f54.google.com with SMTP id o13so5032137ioh.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NjNfkqRpnmYYnhi+Y2J7TAilhtMmDLwPt5PY8RwTtNY=;
        b=oSNmumvkx4+nd0V/VIllBfLkveIhy5kTd2A4N/stzTlddKEfCc+QfpWXSOz+yCwI1A
         LT6ExbW/8FkfE1X3Repvh1o036FJ9LrcZ057nbNU7UkON6NndPsAF015ICZTRyeIHyec
         KoQxxir2j4VvnSvO7o2ux7yMju1gMiuEWb1BLPZE+muxh1qTtcJ1hSLS1CcIeCd9ozkb
         VfeWTyW0+FsAlCJc6r1iuEIQGqLr6HqhR8MN6T0/rLsUZHa4iYh5VAfHu/narPDCyDfz
         X8bi2bWVI0krEHCiReWmZHBoc6JJi4mmVE/HZGQXgiA//o7egm/0gyYqsykFf+hqr2ol
         /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NjNfkqRpnmYYnhi+Y2J7TAilhtMmDLwPt5PY8RwTtNY=;
        b=B9tCLl6t/oztZQ2n1t7f7LBDN+Vcsu+7UilVivcwbJwYAMrCPRhGZLivwAQYBnyLAJ
         KxB0qjR4PyjOPm+ZYz4Li8A1TbGy50t3vG4jNZAHxq9DBgqtkk1NLbyc1m7ieXh75awL
         U284cUhtU9A/R4XoH+aiEJtxHSgkPXAH3Ae6ZzZY49gt+NMDuFEn1G9Vpw8tGMFL8z2W
         lexghFi+/lr5APuZ5ZbErZJaa+MCw/LlhFidRQ0z0SYubGYnbEyAQg8dR9skf+Anvup6
         wXMiF/AKYdUtrWW76U0pUxR0+v5mVL6CCT0CeqbF/CQ5TpRRo6D4olH7IkZpTe7bkQCJ
         2pug==
X-Gm-Message-State: AA+aEWbCGmSfwi2KeeoOyI6rfcYjQHhRzjT205s4DDsR8h0q6JgJb9d6
        MO0zZ8SKNy2nIqIWim9AY1PkfNrQp2CS5h1hFWRQCg==
X-Google-Smtp-Source: AFSGD/WOWl9W4bycgCQDFafmZdnFXKcp0IdCnRfZ58igOp0qyYBGhCICvdskheT2T/84eZmYUbVQXDh7sTGUI0EWDlQ=
X-Received: by 2002:a6b:6d0e:: with SMTP id a14mr3203078iod.258.1544808022168;
 Fri, 14 Dec 2018 09:20:22 -0800 (PST)
MIME-Version: 1.0
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Dec 2018 18:20:10 +0100
Message-ID: <CAMRc=MdGYG55s2=Z6pCA90TbUVLgfhE3hohsCnm5QDGy1NEg=A@mail.gmail.com>
Subject: [regression] Mute button LED stopped working on Lenovo X1 Extreme
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>,
        Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure what the connection is exactly but commit dcd51305cd41
("ALSA: hda/realtek - fix the pop noise on headphone for lenovo
laptops") broke the mute button LED on my Lenovo X1 Extreme laptop.

I don't have any more info frankly and don't even know where to start
debugging. Other LEDs work fine. This mute button LED never had any
entry in /sys/class/leds, I'm not sure how it's handled.

Let me know if you need more debugging on my part.

Best regards,
Bartosz Golaszewski
