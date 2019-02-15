Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E422C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4BE2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXOxe7CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436943AbfBOMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:21:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42238 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbfBOMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:21:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4745271pga.9;
        Fri, 15 Feb 2019 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3KjsjLe03/+hTrGOVMznt+9CZQAH/a8Fn5uycS3M28=;
        b=NXOxe7CDI+r04zfcDfttKFsAa/AXqmT9idfDfb4hqRrdLLY9TpQEx+yWCLBAh1fDh6
         92Q3WYJcSf+1Kx9tDxVYBsGXlYbc97nIYcJ6jFq5EHFAQgKXBoYxh1kcXH0VxYerT+n7
         49BvN49Pd/HzXpGazNkLbsP7ZREGKz4o37w7jwwxDtRTubWBvVWH+X4d3vKpqRSTuhNJ
         jS0O1Rz2lnBH2+mEj6gilEGW/6Sf33sXN3DQNBHidLyPB2EHK98SeZcuzXOb2mTckIfq
         v/bJwbymQpgrNaZscyLBLGnTQ+xfpvsN8oLcqcDKuMQjTqtzAcg7O1Hmax6HLhSK2MVO
         jLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3KjsjLe03/+hTrGOVMznt+9CZQAH/a8Fn5uycS3M28=;
        b=qotDycidf7+Ut2Kg00yEH1NpWknezBwq23Z7HGi9Hrpy++A6jWs4FFtN0lMhqk1dOs
         J9jwVyibJzGrYd8g5szPz+tC36jrTxQ2MYS5CQivJkUWAcQ/sxUjBBg451UuEYHKb8U0
         V4NajAOzbmW7+G3GtVNXHTMyTUsxi3i8mX+vceDyzu0bOE8N2Q8utLZFIEzYewSTnTWf
         B9MVFW/mUx090SKlW6g7EAigsd+V1rBjQuPE9J8vHjNcyOsiV7gBow8GMHaFHuvQHsHr
         uKbXVKn8km+OsWETKQZZ51F5jDzBdw1XKyxDSQnHwZbWMaePicqyBL3iAYV2TaraIGSJ
         UgxA==
X-Gm-Message-State: AHQUAuavOXsr0DxcUwHj1o3RlUdUwYs69AJ4BT6KcnE9iMiTsM/9fm2I
        tUj9+dp93cNrWngk13dXVjS8QqrmwLc6r12uvXyZwA==
X-Google-Smtp-Source: AHgI3Ib5WXasFkwpAJGxvriCDQxu+cDyipJiL90pIn3VS47xKNtHiIQzO5zWLy80wy6h2M8UlLf/9jK1/wIqcEpJAkI=
X-Received: by 2002:a65:6099:: with SMTP id t25mr8991097pgu.448.1550233316084;
 Fri, 15 Feb 2019 04:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20190213224859.GA7151@amd> <CAO1O6sdyJbo0LR9Lak+6yP0FKda4o66+8vwx4fE1fe36z2mDNQ@mail.gmail.com>
 <20190215114622.GA32198@amd>
In-Reply-To: <20190215114622.GA32198@amd>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 15 Feb 2019 13:21:45 +0100
Message-ID: <CAO1O6sfLuUtOJdxFkRxck_eLmwtSQ3aU6Rub_hrxaJ5dmWr_HA@mail.gmail.com>
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

Hi,
Den fre 15 feb. 2019 kl 12:46 skrev Pavel Machek <pavel@ucw.cz>:
>
> Hi!
>
> > > Currently, "no keyboard, no display" devices can be paired, but
> > > pairing is not secure against active attacker.
> > >
> > > Can we do better? Not for the first pairing; but for the next ones --
> > > yes, I believe we can.
> > >
> > > BLE device in this case has internal storage, and Linux running
> > > there. From factory, random 6-digit number is stored in the
> > > flash. Legitimate user knows the number, and system is manipulated so
> > > that pairing passkey will be this pre-shared passkey. After pairing,
> > > user is allowed to change it.
> > >
> > > [Or maybe passkey is 000000 from the factory; this is still win for
> > > the user, as long as he can change the key to something random in a
> > > secure cave.]
> > >
> > > Fortunately, kernel support for this is rather easy; patch is attached
> > > below.
> > >
> > > Does someone see a security issue with proposal above?
> >
> > Assuming "LE Secure Connections" is used, the protocol is only secure
> > if the passkey is not reused. A 6 digit passkey means 20 bits. The
> > protocol is performed in 20 steps, where one bit is compared and
> > revealed in every step. This means the attacker will know for every
> > attempt the first bit that is incorrect in the attempted passkey. If
> > the passkey is reused, the attacker can just try the same passkey with
> > the incorrect bit flipped. In average it takes 10 attempts to crack
> > the key and maximum 20 attempts. Hence, a static key doesn't really
> > add much security compared to Just Works and might give a false sense
> > of security.
>
> Thanks a lot for quick reply. And no, that is not good.
>
> Just Works basically means that there's no security at all, anyone
> within range can connect when owner is not around, and do whatever
> they want.
>
> Is there some common way this is solved?
>
> We do have pre-shared passkey, if only 20 bits. If we set
> passkey = sha( pre-shared passkey + pairing_attempt++ ), would we get
> some kind of meaningful security? Perhaps with limiting pairing
> attempt to say 10 a day?

I see two issues with that approach. First, the user needs to know the
correct counter of pairing_attempt (how?) and perform the sha
calculation and map that to a passkey. Second, if you eavesdrop a
pairing attempt that succeeds, you can just bruteforce sha over all
possible pre-shared passkeys (1 million if you have 6 digits) times
the number of different pairing_attempt counters you want to test, and
match that with the recorded pairing messages. That shouldn't take
more than a few seconds on a normal PC.

What people really do that wants proper security over BLE when they
need to use static passkeys, is using a PAKE algorithm in the
application layer to establish a session key, and then use some AEAD
cipher with that session key also in the application layer (or
potentially start BLE encryption using that session key as LTK, but I
haven't seen that). Unencrypted BLE is just used then as a transport
layer.

/Emil
