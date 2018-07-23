Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7AFECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B885120858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="srBCHW7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B885120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbeGWEmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:42:09 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:42733 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeGWEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:42:09 -0400
Received: by mail-vk0-f48.google.com with SMTP id t4-v6so8575583vke.9;
        Sun, 22 Jul 2018 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F5tKwLJbVw4k9HBKCMgKOe6xi5iREMSqWWUu7DRRRMI=;
        b=srBCHW7mfigfkbAuFrbFWZ/33F9IrkLrJoxQ/eseVYSQ7DsT0SHd+1rr9JQ3wytjf6
         ND4hnTkXOhTVhh1Y7PltpZFnEVZfDBmxfZgDNOzDmj/BzLHxK0CMhN/RYU9NxjmAObit
         LlPs228jT1kNU/JUrYFIfRQ8OPG2F2RyQqwSRE2s9JMxDjWq25UEC/WptKrFpg3UwTxU
         lATG5HTGVZdU0nFUBsJ5xcjbWTTw3x0mhdYi0BcA8QRH9sSkDSYyP3lyK/1lIGObSDMU
         ib996/mmWxWUExIH034M+jjB0p8FHJf2c5WR7MtXPQCcPSyiStUmkBwfksVu8yrGWzkp
         92eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F5tKwLJbVw4k9HBKCMgKOe6xi5iREMSqWWUu7DRRRMI=;
        b=LVa5X5ajcJuxp8ecvBhnTMPycR8pLv0+6tiNHsKH5zA+iecvjI2IuITN2Vx4FnI5+K
         2V/MKoIDrKmKmCsFHsjMPwOLznUUOk4IpPsIQrf97l3lWwGvkQ7TRmi4pd8eJfVxQYgv
         kWzgIpJZqLYDbS0XmgMZYCvhRMl38U1xmzmK9LaB6+ZaJS7XEdxPM6m4G30INNHTL8ny
         WVJ6/wGfZtjyaKSGOCAw1Y28/iEPBp5MqbQBx5oawmzu0pPTTP5aTbAsPTouTq9HTRPt
         FXLGXboAdzfgX0kf+sX+QQizlfwG5Spgskd6FVICjNwCi6UZaCyc621G6MwCdxNI6kA4
         LHAg==
X-Gm-Message-State: AOUpUlGfUM8wQOS6zlXASQi3cV1Jt63/cySOMOMkrBPrC/umuRy+qfW+
        xqBpIFKOqikg92mzXi/6/sYtEWyu6ywgcCmrQq+Zsw==
X-Google-Smtp-Source: AAOMgpcumwltIXB/TGJ6pof/znGCsPD3Fzv/nA5lUwWvBTe6xiDLqx/8LzZ1mNjKbhglI7ZVWTlP9w9hOybUZ3n+GIM=
X-Received: by 2002:a1f:e0d:: with SMTP id 13-v6mr6988079vko.107.1532317381904;
 Sun, 22 Jul 2018 20:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:d012:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 20:43:01
 -0700 (PDT)
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Mon, 23 Jul 2018 04:43:01 +0100
Message-ID: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
Subject: Does /dev/urandom now block until initialised ?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

last week you proposed an rfc patch to gather entropy from the CPU's
hwrng, and I was pleased - until I discovered one of my stalling
desktop machines does not have a hwrng.  At that point I thought that
the problem was only from reading /dev/random, so I went away to look
at persuading the immediate consumer (unbound) to use /dev/urandom.

Did that, no change.  Ran strace from the bootscript, confirmed that
only /dev/urandom was being used, and that it seemed to be blocking.
Thought maybe this was the olnl problematic bootscript, tried moving
it to later, but hit the same problem on chronyd (again, seems to use
urandom). And yes, I probably should have started chronyd first
anyway, but that's irrelevant to this problem.

BUT: I'm not sure if I've correctly understood what is happening.
It seems to me that the fix for CVE-2018-1108 (4.17-rc1, 4.16.4)
means /dev/urandom will now block until fully initialised.

Is that correct and intentional ?

If so, to get the affected desktop machines to boot I seem to have
some choices:

1. Wait for two and a half minutes (timed on the kaveri, the haswell
seemed to take a similar time).

2. Sit at the keyboard and start thumping it once userspace has
started.

3. For the haswell, apply your patch and trust that the CPU has not
been backdored

4. Run haveged.

The latter certainly lets it boot in a reasonable time, but people
who understand this seem to regard it as untrustworthy.  For users
of /dev/urandom that is no big deal, but does it not mean that the
values from /dev/random will be similarly untrustworthy and
therefore I should not use this machine for generating long-lived
secure keys ?

TIA.

=C4=B8en
