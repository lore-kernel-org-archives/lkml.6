Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE944C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A0621450
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b7RFD2/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A0621450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936365AbeF2ASh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:18:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37128 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934190AbeF2ASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:18:33 -0400
Received: by mail-io0-f196.google.com with SMTP id s26-v6so6905612ioj.4;
        Thu, 28 Jun 2018 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=107XICFehgDCJLrRKVRUPK9jm84kP2RAAMakx69wqnQ=;
        b=b7RFD2/CTvzTjX6aeklvdl7eOz76beQONGkhNVR6x0ImELpW06/x4QOiwF/xdqPldQ
         hvOoE7busM/fqKh34luzWUUnkAMGCjyyhPtWvEZDMOZ54l7p+6nR8N1Fof9M7Mp66ndB
         HJYU4e4EFn0uH0oj7fpBp8D5+JVcTTsC0aqbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=107XICFehgDCJLrRKVRUPK9jm84kP2RAAMakx69wqnQ=;
        b=TlcDVUlACkVpaJCq/jlMGjTjF4wKEfepTyjTsiV6Y1Mkr1CHxcBEOhB5ERNKRSmLnU
         SLesLZowUbYnNQl3MMnusnd0urVx0aGyvhltbrVvYVNl1L6OBzC7vPe/QXuEV01JTBAv
         VJ74lkprEW8dab1XXWOgxZDkYAYMCWMhrOpGjPspOaXBrnjcjBw79O3nnFhV97187nPI
         2F7E5+JOItHqIdWCkBQDydSuiwKez2TH9cmtvMcoaSHtE6cO5E1RwV3NrGy9L1GNr6ZC
         EJ42Q7O9ABQD+/Xvgfr3vXXLLysf7aq7rT3UYNL6zc2iQAeRt1ckstaIta8sU8lCZYBV
         XTHw==
X-Gm-Message-State: APt69E227zFvru2LKcgKgZxh8y6PaRu3vNnVY0nhEqC4ZfUwjjanaXBf
        qZwE3iWcAWFvvralrMZUQSs/iM+Qh6mwrrXs15c=
X-Google-Smtp-Source: AAOMgpcU0U59DagYEigd+cctHj2mak3V/Q9quZeJyCE8R6aHLmJ3ukcbmzXW6sHaBFkEnrQwH2W0pSZvv6/JsVcl//k=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr10906893ion.259.1530231512936;
 Thu, 28 Jun 2018 17:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
 <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
In-Reply-To: <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jun 2018 17:18:22 -0700
Message-ID: <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, joelaf@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 4:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The idea is that, if someone screws up and sticks a number like
> 0xbaadf00d00045678 into their rseq abort_ip in a 32-bit x86 program
> (when they actually mean 0x00045678), we want to something consistent.

I think the "something consistent" is perfectly fine with just "it won't work".

Make it do

        if (rseq_cs->abort_ip != (unsigned long)rseq_cs->abort_ip)
                return -EINVAL;

at abort time.

Done.

If it's a 32-bit kernel, the above will reject the thing, and if it's
a 64-bit kernel, it will be a no-op, but the abort won't work in a
32-bit caller.

Problem solved.

             Linus
