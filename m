Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6uAohrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407564AbfBNP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:28:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34156 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBNP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:28:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id j18so3269905pfe.1;
        Thu, 14 Feb 2019 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HUSwDOyUGgWH5TjR1AcrgVsuq/Kz8O6lTekdx9IkEs=;
        b=s6uAohrKEZGtWspAGidZE3djwjOrGTzKLYPhgv7NWuzBBkUGpkDKUr3hWdTxNXnI5D
         IUEF+bqBZUouers+sie1qWjaVcTVryRo4X6AD8SRlBhOnoiYcy/6gkJtGirKREXe8cuZ
         cTTYMcpll8mKypf8dZbMr/21a7PCdId2VDjp8eqJFSXC/yhejkaY2KG7o30xiiA8iXOk
         20BK8dlbBBmuQw0mjybuXBERpSi25BLTph+zQpa2LpzN9XKixaQwhC3Ruv4OcH4dQc/L
         xK7BBf2tZCy35Lmc1qvtqGSSi5XKaRSWmhRitzdBiz6cw+MP+/nENqXLVE6TutKYJ2V/
         awMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HUSwDOyUGgWH5TjR1AcrgVsuq/Kz8O6lTekdx9IkEs=;
        b=lplMeKc8NIQMapFvp6aHYlbmSOyHS6ZovflnFKoJu+NBQ5DFOkgPdWC5x5N9D7l13s
         nl6t+bYwp3vKCkgzLwutZDHEneyaZh8z1LwbN69VBxzbuoz/jsFlUnDbAu/Ql1HGeqEn
         OfR2FznMo7tgqUBFYzZoiHfXlTD9INklrX7wrmjtEfmhh9WwkcQcOISaBRsYBZGsRZxB
         CXhvOWTUdOo7BnsOjpZapUaxOVYI7ixisL9w6d/gt4Af4zuGkTJ94La7/mKV9dh2E/Cs
         6qNogV9gy0r0l+Knj+/GrwFgVlm2r4h8ixkHYu4XZ1h4Bj2ggTxBU8YWdGvAyu8VeqIc
         jhmQ==
X-Gm-Message-State: AHQUAuadaUwLv7UhSq71gW2nn7xdYsBP4zNx3kj7wEDJWT71zqkVqVD1
        zzKfGCf1Co97FK0a+D5b4SXwKSWOw/AtGKXaYuw=
X-Google-Smtp-Source: AHgI3Ian54jBsal7WkGtp0I6pkrjtiNVPp4izBbGPaIYy9PMTqgzm/MfcPdyPAzMclJWCqJX61LjJIsJK6jAAhImhhU=
X-Received: by 2002:a62:6702:: with SMTP id b2mr4591900pfc.244.1550158091151;
 Thu, 14 Feb 2019 07:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20190213224859.GA7151@amd>
In-Reply-To: <20190213224859.GA7151@amd>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 14 Feb 2019 16:27:59 +0100
Message-ID: <CAO1O6sdyJbo0LR9Lak+6yP0FKda4o66+8vwx4fE1fe36z2mDNQ@mail.gmail.com>
Subject: Re: [PATCH] pre-shared passcode: secure pairing for "no keyboard, no
 display" devices
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Den tors 14 feb. 2019 kl 14:59 skrev Pavel Machek <pavel@ucw.cz>:
>
> Hi!
>
> Currently, "no keyboard, no display" devices can be paired, but
> pairing is not secure against active attacker.
>
> Can we do better? Not for the first pairing; but for the next ones --
> yes, I believe we can.
>
> BLE device in this case has internal storage, and Linux running
> there. From factory, random 6-digit number is stored in the
> flash. Legitimate user knows the number, and system is manipulated so
> that pairing passkey will be this pre-shared passkey. After pairing,
> user is allowed to change it.
>
> [Or maybe passkey is 000000 from the factory; this is still win for
> the user, as long as he can change the key to something random in a
> secure cave.]
>
> Fortunately, kernel support for this is rather easy; patch is attached
> below.
>
> Does someone see a security issue with proposal above?

Assuming "LE Secure Connections" is used, the protocol is only secure
if the passkey is not reused. A 6 digit passkey means 20 bits. The
protocol is performed in 20 steps, where one bit is compared and
revealed in every step. This means the attacker will know for every
attempt the first bit that is incorrect in the attempted passkey. If
the passkey is reused, the attacker can just try the same passkey with
the incorrect bit flipped. In average it takes 10 attempts to crack
the key and maximum 20 attempts. Hence, a static key doesn't really
add much security compared to Just Works and might give a false sense
of security.

A static key for Legacy Pairing has comparable security as using a
random key. The security is kind of the same as logging in to a
website over unencrypted HTTP, assuming the static key is stored on
the peripheral and the user enters the passkey on the central. In the
case where the passkey is entered by the user on the peripheral
instead of the central, the protocol is completely broken
(https://eprint.iacr.org/2013/309.pdf).

/Emil
