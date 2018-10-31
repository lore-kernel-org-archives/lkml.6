Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF568ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718B920657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="V+EK8eXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718B920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeKAFgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:36:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43293 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbeKAFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:36:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so7912344pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zJjMs42Awvx3HRMZ9adrzWehSleS6VI9q0sXzY73Umc=;
        b=V+EK8eXzjGoQKdZdZx5/jE1BFkRI2UGuQXLa9qaAfJtC0icRkRcXPwmhlIwh9k7dbh
         fOiPFPqwkKeYA7UPFahu+1zH27ZQPTrhLFl+w6ZkvyTSCvMCqoAyeVZlc9YAgU1j4l6G
         y36ZzrydydSmzSQ34x/jBL3Rcb9735PUYaRa9FiGZBVr25zqtUe89lZ62A0Uy0LOLzii
         Vyf40yRh0824n6MuuUZOrFXgpbexYGVWmwYlpgz8U8VqsXW2uJkURh/xsGKwOBsz+zKR
         b0TlkL07wBs/+p5R4iuoLXDgzDYG6lA0K4kmtkn7jHn23WGKn8kYfTsoQgR9gXZDivhD
         JQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zJjMs42Awvx3HRMZ9adrzWehSleS6VI9q0sXzY73Umc=;
        b=ks9ORs44FxmUBv3wcJhYOgKmXl6Iej1ZkcWd/I3gFOA0wMulZZj22+xKyI9pFG5CzL
         8BBbVA8nN672uYRkNAT70ers5PgkvGJC4A4eDGDHEnXDdZk9C6MOncQK/7ZPjFqvHAP1
         mdup+ktgjb/wn7l+iAiS0OmDiYNz0KPXTArT/BVBaN9aceZIucCtqN6hH8x9MgfwwBbH
         am4PQ1ngIMZG8mdA+vraECq8UH7LwtVPVt1ddVLGMUw4HRa8JOQeEE3ZEc4uNIiJ4Qp1
         TqhqgSZQw9rMasfoaw/D7rLFf/y7ZwCZl6X4qGFT1nspmbKG540onehKaOJvrIUMH7c+
         uSLQ==
X-Gm-Message-State: AGRZ1gK+K3ty0RQf66igJftp3JgHX4U1CzqO4pEwM72GngPRMRy4leD7
        InPsUqv+GCKOkm6nxsp11XgGvQ==
X-Google-Smtp-Source: AJdET5e8F5ad6LZDXVhFNd7o54Z0DZmLU1ptAI2T6PStoovo4wZe0JdRt3IFkeewU3OcWsFyDd4HSg==
X-Received: by 2002:a65:610e:: with SMTP id z14-v6mr4574434pgu.138.1541018210983;
        Wed, 31 Oct 2018 13:36:50 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:fdea:9bef:2d79:82f? ([2601:646:c200:7429:fdea:9bef:2d79:82f])
        by smtp.gmail.com with ESMTPSA id z15-v6sm31457047pfn.170.2018.10.31.13.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:36:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181031100237.GN744@hirez.programming.kicks-ass.net>
Date:   Wed, 31 Oct 2018 13:36:48 -0700
Cc:     Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <659CFC78-22BF-492B-B2E4-B8E89AA08446@amacapital.net>
References: <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com> <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com> <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco> <20181030192021.GC10491@bombadil.infradead.org> <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com> <20181030213557.GE10491@bombadil.infradead.org> <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com> <20181031100237.GN744@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 31, 2018, at 3:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Tue, Oct 30, 2018 at 09:41:13PM -0700, Andy Lutomirski wrote:
>> To clarify some of this thread, I think that the fact that rare_write
>> uses an mm_struct and alias mappings under the hood should be
>> completely invisible to users of the API.  No one should ever be
>> handed a writable pointer to rare_write memory (except perhaps during
>> bootup or when initializing a large complex data structure that will
>> be rare_write but isn't yet, e.g. the policy db).
>=20
> Being able to use pointers would make it far easier to do atomics and
> other things though.

This stuff is called *rare* write for a reason. Do we really want to allow a=
tomics beyond just store-release?  Taking a big lock and then writing in the=
 right order should cover everything, no?

>=20
>> For example, there could easily be architectures where having a
>> writable alias is problematic.
>=20
> Mostly we'd just have to be careful of cache aliases, alignment should
> be able to sort that I think.
>=20
>> If you have multiple pools and one mm_struct per pool, you'll need a
>> way to find the mm_struct from a given allocation.
>=20
> Or keep track of it externally. For example by context. If you modify
> page-tables you pick the page-table pool, if you modify selinux state,
> you pick the selinux pool.
>=20
>> Regardless of how the mm_structs are set up, changing rare_write
>> memory to normal memory or vice versa will require a global TLB flush
>> (all ASIDs and global pages) on all CPUs, so having extra mm_structs
>> doesn't seem to buy much.
>=20
> The way I understand it, the point is that if you stick page-tables and
> selinux state in different pools, a stray write in one will never affect
> the other.
>=20

Hmm. That=E2=80=99s not totally crazy, but the API would need to be carefull=
y designed. And some argument would have to be made as to why it=E2=80=99s b=
etter to use a different address space as opposed to checking in software al=
ong the lines of the uaccess checking.=
