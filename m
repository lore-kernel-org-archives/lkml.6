Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1497517-1522349268-2-5531272209306126621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522349267; b=CIDHxXWSu5DeUH9uAjNWq6N7pF9zHtY/MjAqgN8fPnxaqWUF36
    p8we+GYZ3HqvlcxDhvCbixJPtQcLpUhko92h6uljXoWs2F4dtSqJvsVA/72u58QV
    LlYa8skh21icjnnjL8SEnd9Wv0q+8YpH0PO0NslKPUu/vNAmswhDlOOHgPfg8y6U
    FsotDYH3br5BuiHodkflMUguDmPDXWyeWtrd/LTnxZFRQbJB0gKgiF2kghn/QTfO
    cAeFXl3MDGPo/WYBEpG8bLV9SwpIKbeC7DaEEAGaSEOo1VJ8EVo0FlgqsLC1HBJA
    5IcGDFYIRejZE9M6WG2AVvSHW8CSldT9UC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522349267;
    bh=f/3B0oKbhB3K/q1h4YUrq5pHguj3pDD8Pmwmq5rOHB0=; b=IvfyC+vOOD5w
    6DZJtGw8i81hILTcwF1J5M7DDtAovPVIrLdNWXb9KkYmkLSXWgwUM73FBU4EPJdN
    KaBYBW4sQeGJa9NpzTE6cOfkHdWxRojSGzoKaWdiUiX4VDa4P6fdDv8HMtCfXibY
    kiM+kkHcL0zwfPjg2dk4uU4CPyegrLey9nv3Julkf7ilXzI4N243GPuY5xlKd1CI
    sedsLYRQf7qVbnYSo7TD2BQvJh3oVVTl2HQU7RmYl77i+W4jNi5kNXv27rDApOv/
    uoxisVcSt5ZXwfqIqkMpZdZEYdjkIg95K/RJO65O94Wk70wStssS7tTOOoA/QFj7
    ZqnmFWMUEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK4Xj2sQeNjuUqmXrVAwaSYpj6zWol0MYCxcErzmwiA9Pzjk+W/YMWCUD8GxNuy4dyWMDMgVTrHKone4FnjcxwE4fej397pHjMfk3KIFwMtfJO2lab8z
    +sT47hudxsOhr8C34mgpyKWlzXkFHAKRW/avuP8u1uA6xry5OHZZFSffpvrA5fNzp/CGZ/CwUVRsBI4wT/yHwBBhfbqPno8cs8etukmbkNuOWfSoiEVYqid8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=RU3nhEmULUJgMarh9fgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeC2SrT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeC2SrS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 14:47:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3340021777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 14:47:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
Message-ID: <20180329144714.09321ccf@gandalf.local.home>
In-Reply-To: <20180329144605.599a8f46@gandalf.local.home>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
        <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de>
        <87410797.545.1522331641598.JavaMail.zimbra@efficios.com>
        <20180329142338.GD4043@hirez.programming.kicks-ass.net>
        <544124089.623.1522337940950.JavaMail.zimbra@efficios.com>
        <20180329122439.4a909c72@gandalf.local.home>
        <21903915.856.1522346553810.JavaMail.zimbra@efficios.com>
        <20180329140752.12661138@gandalf.local.home>
        <1657598086.875.1522348516598.JavaMail.zimbra@efficios.com>
        <20180329144605.599a8f46@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:46:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This gives us more incentive to help Andy make it faster ;-)

And with Meltdown, I doubt this makes as big of a difference anymore :-/

-- Steve
