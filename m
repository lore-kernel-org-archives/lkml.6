Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD83C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E35020863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E35020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeLAKYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:24:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39119 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:24:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so7791312qtl.6;
        Fri, 30 Nov 2018 15:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaLz8ODVLMxViUveo+rH1O7Au79GQa7TKiOUq/dhjT4=;
        b=Qqcr8cMunDU/uzmNOSPC0EcMVSul5OddCChvf+7x0sqOzXvoB+9EpnJOMhHiedm2vn
         ixg1JdNNlfuo1sIvx9zYOLIxnHo6e97CT99+CimQnfm38C1EkkBIRR8QeWzsNYJwC935
         HiRsV7o/F0BXe0rgrnUbAs4ljXq1zxoFS9lmm4dkNGZy1EJelRGx606j8OZmFrs5gRZ6
         vsdmsP4OhrV808ledX6nFnY3lvbyL0kNDma9reH9FU8ss8mBriWkZm36r8Bly5jXppWK
         TOEsgpNVgZ6P120JBcAtL5OIZqPO/4lHyjz8iVOXz1/5VaNnxLVLOi6uNzvpBGyZYXNC
         uMuQ==
X-Gm-Message-State: AA+aEWaJWCpA8lIKxVtHphjqydy2gBGDnd1zsSiWi2VBV8uOQBV3v+ZD
        DBe7bzj30hTuThGV03iFQAT1alC+g4cqURjC4W0=
X-Google-Smtp-Source: AFSGD/V68Gz9iIwbsjHxotmbDB0IF4a/fdBFUzfvxOUd1hDZZvwJ8LLzi2cEpQo38V/VU08zQN05Ydg8g5K8N5SpfS8=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7214474qtl.343.1543619590558;
 Fri, 30 Nov 2018 15:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io>
 <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
 <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
 <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com>
 <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io> <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com>
In-Reply-To: <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 1 Dec 2018 00:12:53 +0100
Message-ID: <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Daniel Colascione <dancol@google.com>
Cc:     christian@brauner.io, Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 12:05 AM Daniel Colascione <dancol@google.com> wrote:
> On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner <christian@brauner.io> wrote:
> > On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > One humble point I would like to make is that what I care about most is a sensible way forward without having to redo essential parts of how syscalls work.
> > I don't want to introduce a sane, small syscall that ends up breaking all over the place because we decided to fix past mistakes that technically have nothing to do with the patch itself.
> > However, I do sympathize and understand these concerns.
>
> IMHO, it's fine to just replicate all the splits we have for the
> existing signal system calls. It's ugly, but once it's done, it'll be
> done for a long time. I can't see a need to add even more signal
> system calls after this one.

We definitely need waitid_time64() and rt_sigtimedwait_time64()
in the very near future.

       Arnd
