Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49851C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB3206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392966AbeLVXHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:07:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44715 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731156AbeLVXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:07:29 -0500
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gaqMi-0001al-AJ
        for linux-kernel@vger.kernel.org; Sat, 22 Dec 2018 23:07:28 +0000
Received: by mail-vs1-f70.google.com with SMTP id m5so4407099vso.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFwnZ+H+cAM8uRguz7KMY3aHMaH/WglpMps2jbxCvrY=;
        b=dbEV7A5Q6gSTXKWKIPolWPBN6dz0VFBHRZUGjcAXXcD/0khNriJclfmDQF/FK3rY9T
         OXMdHUoX8XsmTa3IFip1H8G891H9Fv5U8XCReXdmHicC3qEJbVGcPf/zuVqRyLFDIFco
         9u6/of/kY8J5qD2auRFT1wyvAEtkMJ3x95BBSE81J0HLJZ3qVr4WbpXiVivVw/HHfGyb
         LeAZqnq6W6TZVPi88bHoi3G7PMSZBeUTY7Mdq6pCXYKrOUpEfJ6E3/ftT6RLOZB1T2Ot
         L8ZQDSeYwGLs/RCWUog6baTsQxUs5XXbyW0FJko/njy2I9AemQUuUBcd5Vh6mqZ8hS8R
         Niug==
X-Gm-Message-State: AJcUukfpk8Reoxn81nwb34OPey/xVeAr4A0hSWaY9/UlPl1NX7KvGL35
        6UJ5KSXwftDYOX5I5LB32vpNhWgSeHPCneS1wzvTk2Xdd82Su7J/IffoN6ifPHkTixnZpsmVIRZ
        kMYgbe6dETcHH7N3kf7Yg46BNy5K8EhrZuM2G4yRMBo1t/kRUGM7Vk+OaUg==
X-Received: by 2002:ab0:1425:: with SMTP id b34mr2897196uae.64.1545520047172;
        Sat, 22 Dec 2018 15:07:27 -0800 (PST)
X-Google-Smtp-Source: ALg8bN715t+tCd66LvQnBIPoit9R4tyzQFOSl+LumIjZMaK6VCFT2hoS+SiYZJsnBdqvkkofKftgvUEHsq4u5DnrwP0=
X-Received: by 2002:ab0:1425:: with SMTP id b34mr2897183uae.64.1545520046794;
 Sat, 22 Dec 2018 15:07:26 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com> <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
In-Reply-To: <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Sun, 23 Dec 2018 00:07:15 +0100
Message-ID: <CAPP7u0UhPyC=eewx4dYu+AU5tK_URE8_5PW9cNkK6Ppp7vkqHg@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     nix.or.die@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 12:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Dec 22, 2018 at 2:49 PM Christian Brauner
> <christian.brauner@canonical.com> wrote:
> >
> > To be fair, no one apart from me was pointing out that it actually
> > breaks people including systemd folks
> > even though I was bringing it up with them. I even tried to fix all of
> > userspace after this got NACKED
>
> Seriously, the "we don't break user space" is the #1 rule in the
> kernel, and people should _know_ it's the #1 rule.
>
> If somebody ignores that rule, it needs to be escalated to me.
> Immediately. Because I need to know.

Fair enough. I usually try to be very conservative when sending patches
directly your way and Eric is otherwise very much on top of not regressing
userspace and I trust him.

However, for this case should I resend the revert?

Christian

>
> I need to know so that I can override the bogus NAK, and so that we
> can fix the breakage ASAP. The absolute last thing we need is some
> other user space then starting to rely on the new behavior, which just
> compounds the problem and makes it a *much* bigger problem.
>
> But I also need to know so that I can then make sure I know not to
> trust the person who broke rule #1.
>
> This is not some odd corner case for the kernel. This is literally the
> rule we have lived with for *decades*.
>
> So please escalate to me whenever you feel a kernel developer doesn't
> follow the first rule. Because the code that broke things *will* be
> reverted (*).
>
>                     Linus
>
> (*) Yes, there are exceptions. We have had situations where some
> interface was simply just a huge security issue or had some other
> fundamental issue. And we've had cases where the breakage was just so
> old that it was no longer fixable. So even rule #1 can sometimes have
> things that hold it back. But it is *very* rare. Certainly nothing
> like this.
