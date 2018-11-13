Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED0C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05AC2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5C/l0D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05AC2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbeKNEgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbeKNEgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:36:44 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7F122520
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542134244;
        bh=BajjHn6cEQ7SoqjIQfb5d1ujATvkHkGfcLsnEJ+eoxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D5C/l0D/dDbV4R9jfpCgQglzBkFBLTtB4v+ltkbSItLc6HqQyXen12ZwNhEAPrmrc
         bZzqp9Q3QOKTNHcBxm6dTjuioZ7IZmLxNDF7INGnIzHFeGEmYgc1ftLrGl5u1ZeQf0
         B53TVu8eMPZhXR+CJnpa1uLDWySNl1KB+rEku/XI=
Received: by mail-wr1-f43.google.com with SMTP id e3-v6so14497298wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:37:24 -0800 (PST)
X-Gm-Message-State: AGRZ1gIGo38Yt739t4y1SIeYhFD8C4r5qPSx4EbB6mJ0jiOKijrb6GV0
        LOk6pV8SSDlKD60NKXX3+Ky2mgDoPJ4j//MF4ZZcyA==
X-Google-Smtp-Source: AJdET5dSLTau2dEWkhRXAQsNP8JIIsqsITd4SDC6cslvHjjsjrtRQ0PD+oieu3oCWHAxIJYwmOdVpspdT0ruL6HQpBY=
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr6212862wre.94.1542134217353;
 Tue, 13 Nov 2018 10:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com> <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com> <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
In-Reply-To: <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 13 Nov 2018 10:36:45 -0800
X-Gmail-Original-Message-ID: <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
Message-ID: <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
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

On Tue, Nov 13, 2018 at 10:33 AM Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> I forgot one sentence :-(
>
> On 13/11/2018 20:31, Igor Stoppa wrote:
> > On 13/11/2018 19:47, Andy Lutomirski wrote:
> >
> >> For general rare-writish stuff, I don't think we want IRQs running
> >> with them mapped anywhere for write.  For AVC and IMA, I'm less sure.
> >
> > Why would these be less sensitive?
> >
> > But I see a big difference between my initial implementation and this one.
> >
> > In my case, by using a shared mapping, visible to all cores, freezing
> > the core that is performing the write would have exposed the writable
> > mapping to a potential attack run from another core.
> >
> > If the mapping is private to the core performing the write, even if it
> > is frozen, it's much harder to figure out what it had mapped and where,
> > from another core.
> >
> > To access that mapping, the attack should be performed from the ISR, I
> > think.
>
> Unless the secondary mapping is also available to other cores, through
> the shared mm_struct ?
>

I don't think this matters much.  The other cores will only be able to
use that mapping when they're doing a rare write.
