Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A34C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDDD2176F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeLWKyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:54:16 -0500
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:23978 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeLWKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 05:54:15 -0500
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        <christian.brauner@canonical.com>
CC:     <nix.or.die@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        <ellierevves@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <seth.forshee@canonical.com>, <stable@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
 <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
 <CAPP7u0UhPyC=eewx4dYu+AU5tK_URE8_5PW9cNkK6Ppp7vkqHg@mail.gmail.com>
 <CAHk-=wg8Qrh4nvFbWttz6zPMeRKO2Twv57vZfGaQ6odsjYFEnQ@mail.gmail.com>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <828415b6-9fee-96bd-b6b0-fd4450df97a8@mageia.org>
Date:   Sun, 23 Dec 2018 12:54:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg8Qrh4nvFbWttz6zPMeRKO2Twv57vZfGaQ6odsjYFEnQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0201.5C1F6956.0051,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 23-12-2018 kl. 01:28, skrev Linus Torvalds:
> On Sat, Dec 22, 2018 at 3:07 PM Christian Brauner
> <christian.brauner@canonical.com> wrote:
>>
>> However, for this case should I resend the revert?
> 
> Since I was pointed at the original email thread, I just picked it up
> from there directly. It still applied cleanly, nothing had changed in
> that area.
> 
>                  Linus
> 

This should also be picked up for 4.19 lts

Greg, it's now upstream as:

 From 94f82008ce30e2624537d240d64ce718255e0b80 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian@brauner.io>
Date: Thu, 5 Jul 2018 17:51:20 +0200
Subject: Revert "vfs: Allow userns root to call mknod on owned filesystems."

--
Thomas

