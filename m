Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1007980-1525279380-2-12951629749732105337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525279380; b=QvUKN5/YDfI9t2VKZVtCMIRLtnwfrdH6Gkf6y+zJF4YF3dy7Lj
    u0lgC+dwikiJLUqZzs1FnVGwhjks6RTGNuX6Bo391EDEen5B6dIbhY1HVMue7x6j
    Lb3LLybAleMUBacfvcYl14Bm/29NBtKiukUeJ4SIwZzejRqL1Rm6A4ibctfSUMdo
    +abEQwhJQFrQ4qMn6yFmddRVnCi+RyolpyMb3JVp7Qb2rpXyeiahVnGqk7CfnJxX
    G67zH1oaH4vjVzgn9nMT0PUthzG+7qdWDYgK91rBzQlAig7H1vLVzO+oPH3L0snD
    QNjhi26PMTF0jHdz0MW25Jlvz2vAF945dU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525279380;
    bh=DRV9CxjRn6IPB6qKDISJdxSGBHa3z/Gr02aEjgA9J+M=; b=JOQ9ryTj7k99
    OtXNTtMRR3XMGBMlAoKg1dORA/opp4yhW5SxPGPjzT5jtMChUYuQl7tfmZq6kFdR
    8PTFDpda5mZ/ubXxsOYmDkRTfmEV7oeX8oot/Uayt0r4XONrsDQoIShFfN8VSRbb
    8zM1K/vakFscoFHGkxwAuRdDRb6KMaq7shlGAK0lp6ZV2K8mzzj6qee8sbymiEoa
    K0hwRLEECeMbrn2gW6DH1TqdZqfIazdMIAORU4BsOqa+tGzWul6Ot/IKXJDZQngd
    VAa3o/31d8nc36QxeL1LPScYSu0ZjahaNRnC/ALxmZiQ2Lv9U3QztBLJhSGf23me
    FsmIjks0VQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDVj8m4JfxtoAMr0LHyM4egoL+p/Ksx3z4fNAHXKQf9JZuAWTkPJCzbkfxX4B7mvDJ9KwWllUslSyhqVXVK/xudZQiduL/UC/BNzo+NZIgV2GNt4ewho
    atHsSJMnMOYDR38qesjI8sRMJqq46piVO0N7+26vmw9IblfG2FZY2unowJZi4DmSprzrT6FPWCxakHNjHDmLkTWjfWAmXym3fkCKOtocEwXlcGOnHgaWk1M6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEBQm7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751484AbeEBQm6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 May 2018 12:42:58 -0400
Date: Wed, 2 May 2018 12:42:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Colascione <dancol@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, josh@joshtriplett.org,
        torvalds@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
Message-ID: <20180502124253.145253cb@gandalf.local.home>
In-Reply-To: <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
        <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
        <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
        <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 02 May 2018 16:07:48 +0000
Daniel Colascione <dancol@google.com> wrote:

> Why couldn't we take a page fault just before schedule? The reason we can't
> take a page fault in atomic context is that doing so might call schedule.
> Here, we're about to call schedule _anyway_, so what harm does it do to
> call something that might call schedule? If we schedule via that call, we
> can skip the manual schedule we were going to perform.

Another issue is slowing down something that is considered a fast path.

-- Steve
