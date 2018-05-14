Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526287078-2-18257763067796462853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526287078; b=asxoVl34Fbu626WMSREpNWZQkI0EozIIztFAQyrIl2YtTUXhV4
    MiDoaUAa+e4Hc93/Z7h8RP2OsPmtijff7BdwXe2oISa+3dgXsJC1eDCFg2o66dTH
    RzbLqUN3f2wlSJdJHK1SUBQd+tieRnuxXJ78IIkBmOK36R7sK97hzREl7gyoFuA3
    Z2jWjESnNPdF823QRnP5FEwGpP1Up1OUF+T5WdvUWBMijhCa79JWi1tKSWmnEsFl
    ChcoXxigNU1PACXsSq8ntXAblvSeceTFYhlcPPIpU2eJH+WPL1I/ApoGDOnAeEvC
    L+pAS7oItDy59Bl5EcJNyA9+zzYs33o7ktNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526287078; bh=SGmrZEw4ABLvlO00dLP4hG4hDRmLQF
    ba0EqJ5zBj0yo=; b=e/+zDIhgDBo7ucHnPMvXdkMi23M0aELjPJk/yznMSNxahG
    6cB6X87wiI41hlWF2Z6nMNXSpl5fkhPIzsXOgE8kD18BZgRcQKmr+u8+My1dPaq0
    9zzJwg2i0g9YahgDtQlqYM79bcx9qUwoOFF1Y1TgT6Ub21PCWsncfuOHky0NV57v
    DpMrGaJ83TuHmaF3oaD7Igki2uBmzwiqQxrPzu+124N/FLuOa07aHX5OSqBVqxxC
    Q/NhRt8oEnvk9r50Shy8TMAldzYqTUVI+9pXt2tCIDZomeRsrdmFpwtZpJA3SBNe
    bpYBT9RCBXY1AgwxRGA0sLPUZ5ii7dAKYCkV0BbQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEVK16tfTGxcDoPcpyNogXiDrqt5iyGw1OI6ewBmjP5W4ApSVMLxj8BLZTSorYIcV3UELacTcKbPw/y+JAOzY/yLOgRgc3TiZCp2ErP8B8HeA2tQkyYo
    9rCj88HleK0aPrKoTyl9DeS3cfJaXOpMTzzkfyEpjTfuEXRjn6A5DUwIUKczD+a9uN/dLjLcbE2tIpEOKnMSKqkjqUBPtsD8XwJR7p2eoJtj423M8hGbvrW4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=wLmoOJ-oirEA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=wWgf3xtT6e9JPWoq5nQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeENIh3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 04:37:29 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:37448 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbeENIhZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 May 2018 04:37:25 -0400
Date: Mon, 14 May 2018 10:29:08 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
 'limit_pids=1' mount option
Message-ID: <20180514082908.GA28179@comp-core-i7-2640m-0182e6>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
 <CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:45:33AM -0700, Linus Torvalds wrote:
> On Fri, May 11, 2018 at 2:46 AM Alexey Gladkov <gladkov.alexey@gmail.com>
> wrote:
> 
> > +       /* Limit procfs to only ptracable tasks */
> > +       if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
> > +               cond_resched();
> > +               if (!has_pid_permissions(fs_info, task,
> HIDEPID_NO_ACCESS))
> > +                       goto out_put_task;
> > +       }
> 
> Where did that "cond_resched()" come from? That doesn't seem to make a lot
> of sense.

This call came along with has_pid_permissions from proc_pid_readdir [1]. It
seems to me that proc_pid_readdir and proc_pid_lookup should act in a
similar way in this case.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ba4bceef23206349d4130ddf140819b365de7c8

-- 
Rgrds, legion

