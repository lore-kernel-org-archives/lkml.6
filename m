Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E0C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3562D223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLfOaNKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3562D223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeKNEse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNEse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:48:34 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686FA223DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542134950;
        bh=F7UuPtB4S0UIRSwu0uSGyCet6p0lDlDetyKisoUnNHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fLfOaNKgccbybbI6a05/gufph+vTwgbV+i8+4VFx29ggZJHCApin6+0yrlXR1Hpa9
         w+lby7nF9Jd/zd7aqe9BAmbdbKLeH8lyH6N5B7MmR1sA/nY/IxsR/sHRmhJLamcOvc
         V+r2T++LdMFrI7LWhWubC2AWVsrDwwyk0jDNEHT0=
Received: by mail-wr1-f51.google.com with SMTP id e3-v6so14534670wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:49:10 -0800 (PST)
X-Gm-Message-State: AGRZ1gKcjIuj1hLqBMr1FnjEJrs1+DGAFFD4x3HuzmIJrQYCKmU1byiU
        4w6E3lMy0fsD4k8Uq8f68TjwLImrXKNb5GLOWtXNcw==
X-Google-Smtp-Source: AJdET5fbZnAdPaZ+l9MY5KJPW20pyIA5nFeZMgM3viUQtPwckVoQQF9x48lNEx+WxwT9AUN9cVq3WT+SK7+FpoiiCXs=
X-Received: by 2002:adf:b181:: with SMTP id q1-v6mr5319302wra.95.1542134948894;
 Tue, 13 Nov 2018 10:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com> <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
In-Reply-To: <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 13 Nov 2018 10:48:57 -0800
X-Gmail-Original-Message-ID: <CALCETrXfBePNs_bs1OroLn9Kdi91FktZ0==N7JK7e=CX=uUisg@mail.gmail.com>
Message-ID: <CALCETrXfBePNs_bs1OroLn9Kdi91FktZ0==N7JK7e=CX=uUisg@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:31 AM Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> On 13/11/2018 19:47, Andy Lutomirski wrote:
>
> > For general rare-writish stuff, I don't think we want IRQs running
> > with them mapped anywhere for write.  For AVC and IMA, I'm less sure.
>
> Why would these be less sensitive?

I'm not really saying they're less sensitive so much as that the
considerations are different.  I think the original rare-write code is
based on ideas from grsecurity, and it was intended to protect static
data like structs full of function pointers.   Those targets have some
different properties:

 - Static targets are at addresses that are much more guessable, so
they're easier targets for most attacks.  (Not spraying attacks like
the ones you're interested in, though.)

 - Static targets are higher value.  No offense to IMA or AVC, but
outright execution of shellcode, hijacking of control flow, or compete
disablement of core security features is higher impact than bypassing
SELinux or IMA.  Why would you bother corrupting the AVC if you could
instead just set enforcing=0?  (I suppose that corrupting the AVC is
less likely to be noticed by monitoring tools.)

 - Static targets are small.  This means that the interrupt latency
would be negligible, especially in comparison to the latency of
replacing the entire SELinux policy object.

Anyway, I'm not all that familiar with SELinux under the hood, but I'm
wondering if a different approach to thinks like the policy database
might be appropriate.  When the policy is changed, rather than
allocating rare-write memory and writing to it, what if we instead
allocated normal memory, wrote to it, write-protected it, and then
used the rare-write infrastructure to do a much smaller write to
replace the pointer?

Admittedly, this creates a window where another core could corrupt the
data as it's being written.  That may not matter so much if an
attacker can't force a policy update.  Alternatively, the update code
could re-verify the policy after write-protecting it, or there could
be a fancy API to allocate some temporarily-writable memory (by
creating a whole new mm_struct, mapping the memory writable just in
that mm_struct, and activating it) so that only the actual policy
loader could touch the memory.  But I'm mostly speculating here, since
I'm not familiar with the code in question.

Anyway, I tend to think that the right way to approach mainlining all
this is to first get the basic rare write support for static data into
place and then to build on that.  I think it's great that you're
pushing this effort, but doing this for SELinux and IMA is a bigger
project than doing it for static data, and it might make sense to do
it in bite-sized pieces.

Does any of this make sense?
