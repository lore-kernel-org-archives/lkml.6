Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-405191-1526681015-2-1325730188816627561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526681013; b=hGJaErH/KqKUBMKwt9zP5tHLznBp/cwoBCqMwRyDfL51CPFoNP
    a4Wk5MW8XY0nHzGt46SUTwiwVmqJigbtuzOizqqHaz/NwvL6fGqrwaMz4UIRNmZE
    fX3Ja/s6U0UP+gosboR6qYZ3dlX5HgKZOqk8RiWkrYwsBniRpywhgikSoIKH4HFo
    oPxZJ7XzclzSTmp48X7b2ggH6XPE6ENHWr/bJaDKxaPyzCOjFeexOlV5iMokNBxi
    G2AseBjlc1MfjJlB0zKI6v+5mlbt7BX9zEOZk3ZlXRwzQwz5buPBy3gP5Q0SWPIe
    AcOWNTob7qLs4huc7h/q+XQ3ttSXtrIbRSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526681013; bh=78P6O5jDeRBgNBTjNTwQKVx6vt72omxIyF6lPqkuu0
    w=; b=F+WVf7Zv9bR2HFolUOT/Y6hz28Nxj0dbWG5imawCR7MdA+STSnZy8ylhjv
    5+FFrIY4+1N3grLh9etZ9StIrFkavL9rOXaIVdLnz2D9Gb722ptgUFWvD4Qmy/YA
    0RDh6bQqTeKxOtlxWVIrwdHiuylkN+KEuSfsSs0OPnjUksR4EaPvyRzyh2kEIUce
    9ymrGrBebfDNbxDd83S0spK4cIZsP4sZD46ZYrvtzdXFjp04Wj9g2SS8EOp25vAa
    i8/dz3z4sWQA+Hysu/QBfoCHVrEb5HbFhXgdzcJFEzu46JdTK+hLVbGkcG6xTxgc
    Qf2yNk/B2TPwzAS5j6wU9nrejDIQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=XrekUcdf x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=XrekUcdf x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC2TVirqA4Dr/rhocRyjVqooiGiqb7A1iERtz/5ffD8eaYrOI0BqIqxQtuSM3JoqzK9txkv34Emzv4lvU2aItnSgYoGzg1E5Qbx0Kw4pwWNB0mhz2NDv
    6zFIV9+GKVY+eJ8LcPatjqy31Fjg6EM8yz4jf1BsamGGDLGLIEt80P6ElPTQ9gtt6JkFj22XBMkGqsb5W+yrzhHGRBWbRcAGv9cpDa7igKxoNZjUrQEaDORP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=n2GhSfulAAAA:8 a=VwQbUJbxAAAA:8 a=cNtN4QPlB7a9OENpF7kA:9 a=QEXdDO2ut3YA:10
    a=9NqWk_7B-uqI6kdQTXIl:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeERWDa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 18:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeERWD3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 18:03:29 -0400
X-Google-Smtp-Source: AB8JxZrZfFbG0hh+K9mLVV6jw7Aoa2wq+Ceb+aubYYTJpKDV0zRQiFDMzXWb5KS95bi9nEmkyYp2Fqx1GDcTL1TZMds=
MIME-Version: 1.0
References: <20180517233510.24996-1-dima@arista.com> <1526600442.28243.39.camel@arista.com>
In-Reply-To: <1526600442.28243.39.camel@arista.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 May 2018 15:03:15 -0700
X-Gmail-Original-Message-ID: <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com>
Message-ID: <CALCETrUDX=4FHU0e8SZ9Rr_AnAes+5jjzKCrrVmS1mddHQyeVQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop TS_COMPAT on 64-bit exec() syscall
To: Dmitry Safonov <dima@arista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, izbyshev@ispras.ru,
        Alexander Monakov <amonakov@ispras.ru>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 4:40 PM Dmitry Safonov <dima@arista.com> wrote:
> Some selftests are failing, but the same way as before the patch
> (ITOW, it's not regression):
> [root@localhost self]# grep FAIL out
> [FAIL]  Reg 1 mismatch: requested 0x0; got 0x3
> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
> 0xffffff425aadc0de
> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
> 0xffffff425aadc0de
> [FAIL]  Reg 15 mismatch: requested 0x8badf00d5aadc0de; got
> 0xffffff425aadc0de

Are you on AMD?  Can you try this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=c88aa6d53840e48970c54f9ef70c79415033b32d

and give me a Tested-by if it fixes it for you?

> [FAIL]  f[u]comi[p] errors: 1
> [FAIL]  fisttp errors: 1'

I don't know about these.

> [FAIL]  R8 has changed:0000000000000000
> [FAIL]  R9 has changed:0000000000000000
> [FAIL]  R10 has changed:0000000000000000
> [FAIL]  R11 has changed:0000000000000000
> [FAIL]  R8 has changed:0000000000000000
> [FAIL]  R9 has changed:0000000000000000
> [FAIL]  R10 has changed:0000000000000000
> [FAIL]  R11 has changed:0000000000000000

The patch that added these test lines was the same patch that should have
made them pass.  Are you sure your tests match your running kernel?  You
need commit 8bb2610bc4967f19672444a7b0407367f1540028.

If you still have failures, can you send me the complete output from the
test_syscall_vdso test?

--Andy
