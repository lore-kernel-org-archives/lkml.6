Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F034C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD39927F8D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="crWpzXfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD39927F8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936182AbeF2OSG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:18:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38040 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbeF2OSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:18:03 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so3084839itc.3;
        Fri, 29 Jun 2018 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM+B2QNNk/Ue6z/Eg6TujfaROvJUA1Ypfp1QqWCC0vY=;
        b=crWpzXfytXx93lFgzwAXlzq1sMzpdiC+u9w3OOvBm/J9QvMgpixyrQ3DfThmiFbTeu
         W++VulriWhcjIhk5K2GlLikT8TWbLgK1gG/28ZvA7xJEYPM/VzMKyQSSRWfieTk38UqK
         wmwZ65JZ40SaUXzjXIviAChyHVFvcVXmuqosg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM+B2QNNk/Ue6z/Eg6TujfaROvJUA1Ypfp1QqWCC0vY=;
        b=J11vlF3hoyTzCaGeJy+MnRJm0lGBzWaPr8fPSN6r5cLar7jvHDW7n+HTuCvX7bRSLJ
         XFuXCsFc2hfhRjBpZBjTYA5QBaVJr8irlUVm7ZxrSBbyPqmtJC/ho9nFEE5DC5MSL1YZ
         19iLVNd6nQ35QxDsGOVeT+CIxQj+M0ERfJdWFGEQE1dKz54tE5T+zowbYbvCPU48BiMT
         5fs2y3LqVtxpxwqQkbKk6S8b5jUo9zWrM8kOrelTfurdTMyw7zwbldnBX49bQ0mKUlIv
         k3dtK3RgsMp0rDIbT9SKG2NqxnWDmoa9vyWsQ9NTdWWwhy/O/geWAwJ/T03f+CGM/TOy
         xN/g==
X-Gm-Message-State: APt69E2z46C/EzdA7NTqTvQFIQpwZiZKYLZbBta8gmrHg3RfS8E8jwJC
        wRBxG9Y6xue2O+2fFKsZtgySaWyGVbPgfUYtxcA=
X-Google-Smtp-Source: AAOMgpd26vKsnidWRfIEHu2qGfCNC8hv2JWiE0KZuHAEOC7Cn7d825dnGlrox2Qp/AgWLD27IrAyVFxipBBRClvC7AA=
X-Received: by 2002:a24:e0a:: with SMTP id 10-v6mr1218648ite.1.1530281883154;
 Fri, 29 Jun 2018 07:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
 <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
 <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
 <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
 <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
 <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
In-Reply-To: <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 07:17:52 -0700
Message-ID: <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Fri, Jun 29, 2018 at 7:05 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> What I'm worried about is setting regs->ip of a compat 32-bit task to
> addresses in the range 0x100000000-0xFFFFFFFFFFFFFFFF.

Well, they won't have anything mapped in that range, so it really
shouldn't matter.

                 Linus
