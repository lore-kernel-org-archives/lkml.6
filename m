Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F692186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hB237u/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbeLTPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:37:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36258 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeLTPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:37:06 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so1142592ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr/eDeoHWOyHFwgeDn1KutEor14eLDS4Jnn5BhMdPVg=;
        b=hB237u/PvNBLUMxBlpjYNgdVALQZlLaxCSLYFYyRaLY8R0gqjFo5Z+NYNJKTZfRRJN
         eKKdIUPWEr5AqNZ16/Mk06+Tk2OLbH4OGUTmHYTWhx16mGgm3vz64tK5ITG8KXTh7Y5H
         Al2F1EucuUggh2RrO9LIz96smDUAFlfYL7OuMpHUvKJLBulmscPRV2DRpjRJnR0xNDLF
         /iK37YQfIlTWC1hs+SSIZn+g+UByHFXmb4DlYznkTMcqejEg3O/QlRv0ZFk+ZHlETIHV
         vL4gfOr7HQ68O4MX9ZRECWzKU4DaSGFrKdaeEMWWYSkbcQFtyHXNEPfLQFruaRSgDHFs
         velg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr/eDeoHWOyHFwgeDn1KutEor14eLDS4Jnn5BhMdPVg=;
        b=gwBqwfg9RFP4VQabtNzAIz8alF2H7/MGO8Nm0WJONbG3AshDSRIQv9yanEGoz1Pb4G
         gSL/oPOx7yRd+U0MeRKgwfbzW31N39bA1z1HvC6+EjOBj0y3rwYEhrmBXcHJWr+fIAGs
         XWMzwJmUTcbeEQyrmIBw3JY7bVF6d66rrdHkPB9wZnYoQ3/fDfNbs4QtEnZ/A0egHTg/
         gbWmlk2XC7zV4AHad30FQkNiensEQfshs+wH+sIKLS1xCDKg5bdYezo2Ey/kDAEcv4cy
         rWgB5DY8NhiSqanOrRM5PASRvQ8mUbvc4yojxaUYyVwguyNRWyvOAz9usNB4xTiJmGg2
         uXYQ==
X-Gm-Message-State: AA+aEWZ01OJa28bRkShbaBsJeulehuie6SAE3Zq/Xd5Kub447psmavFU
        HGUfMiffC2u/ROfLVn6JekV4qrmjc+AEZZUPyXXoZI8jQTr9xw==
X-Google-Smtp-Source: AFSGD/UODs7sRTmjaRC5hAS1KwVsRnPEOOsmuN6Qn14ggQQlKwF4UG+oszl30tTRCeO/QGhm31j/KatCnmb2Agc72Dc=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr19562063ioh.271.1545320225046;
 Thu, 20 Dec 2018 07:37:05 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
In-Reply-To: <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 20 Dec 2018 16:36:53 +0100
Message-ID: <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:04 AM Manfred Spraul
<manfred@colorfullife.com> wrote:
>
> Hello Dmitry,
>
> On 12/12/18 11:55 AM, Dmitry Vyukov wrote:
> > On Tue, Dec 11, 2018 at 9:23 PM syzbot
> > <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000
> > +Manfred, this looks similar to the other few crashes related to
> > semget$private(0x0, 0x4000, 0x3f) that you looked at.
>
> I found one unexpected (incorrect?) locking, see the attached patch.
>
> But I doubt that this is the root cause of the crashes.


But why? These one-off sporadic crashes reported by syzbot looks
exactly like a subtle race and your patch touches sem_exit_ns involved
in all reports.
So if you don't spot anything else, I would say close these 3 reports
with this patch (I see you already included Reported-by tags which is
great!) and then wait for syzbot reaction. Since we got 3 of them, if
it's still not fixed I would expect that syzbot will be able to
retrigger this later again.


> Any remarks on the patch?
>
> I would continue to search, and then send a series with all findings.
>
> --
>
>      Manfred
>
