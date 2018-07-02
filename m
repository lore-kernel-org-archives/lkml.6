Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD10C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077A425054
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DAqYNOSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077A425054
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeGBTbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:31:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50241 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeGBTbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:31:48 -0400
Received: by mail-it0-f66.google.com with SMTP id u4-v6so13696015itg.0;
        Mon, 02 Jul 2018 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PA6fbHKUMz0HyB7Bklan1B17cB1qjPP71a/deWVQ168=;
        b=DAqYNOSO/BC6yimakv/Uqhtly7Czgp+rrdeK/j9+Tekxgxdvg81fSMOVVOuOvCddCN
         YicAXiR8ufq4D++xeqy/XFOjsyObMaNtBjdHzN9dRuTR2WzHuFJtQzJ8xGMxNZIytd6W
         m7BOB6Jzcb0+FD7TEG1CGOqyDkkXE24ubDdvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PA6fbHKUMz0HyB7Bklan1B17cB1qjPP71a/deWVQ168=;
        b=qnulf1XP8VQa3256J8Szj/YlmXUvQIOQu7tRPDSx2j3CcL2NRYpprF3hw5gKqYLtyd
         MFSYH9wcPwhXzTVHs7i2+gBG01LpsDahp8JeqXUn3TabZqsiFIMFsfnnDP9ay3v7kNqY
         56oeIQ9g9D2zi1+9xyPyR+6jYkXyLV2BPWxSMJxql4kS43mDI3XC5OHJIZLzgpFh7UnT
         ImZca0VEMbNPG0rD/Axbq+dv2UiZGV6azJP760otM4/ooFgfKHLoJ987nJvOKn18vjyP
         +90egv4KrJMTT2Ya1TPig0D/zB18+qrC/y+UDPsS+XVxwhBCPOfTD4pijkIOcuxfMad7
         kwAg==
X-Gm-Message-State: APt69E1K3SXNqpuhmq13LfZLneA1E0/tcUBVFgpm6BZj4tD7w3Cp8RPL
        LTM/vMIPKOeO0lfcIfr5A3mOJXZ0OUQW+1pnD8g=
X-Google-Smtp-Source: AAOMgpcvdn3ea/muzC2Gi+HYK5e2TYa6GfjdGp4OPAVfugXPuXBuSt/Ic5gmDHVe+8wDGB35z6XowxV5vI3raCaR9yA=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr2262832itm.113.1530559907950;
 Mon, 02 Jul 2018 12:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
 <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
 <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
 <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
 <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com>
 <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com>
 <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com>
 <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com> <CALCETrVMhU8SrZBXOXxJerrZpQ71A_f_cRBCU=Lmj_KPV0+rRA@mail.gmail.com>
In-Reply-To: <CALCETrVMhU8SrZBXOXxJerrZpQ71A_f_cRBCU=Lmj_KPV0+rRA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 12:31:36 -0700
Message-ID: <CA+55aFy2rxnLhbqGtz0wxW_u=x_A1zHZBNP8ZC5P12_AHyb3PA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:02 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Works for me.  Linus, any objection?

I think the 4.19 stage may be overkill, but I don't hate it, so no
real objections.

If the main reason for this is that we silently clear the upper bits
when returning to compat mode, I actually think that a better fix
would be to just fix that. We shouldn't silently ignore bogus data in
the return path.

But I don't care enough, I think.

            Linus
