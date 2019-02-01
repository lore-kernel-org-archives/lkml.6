Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1C20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HhykiPcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfBARON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:14:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39283 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBARON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:14:13 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so6273316iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IsB4n7mKE/XOdrocSJSPhNR5SNx/kKR4kJ8kiC66QM=;
        b=HhykiPcpS6Uqq0FPjVQ8T6y9OaqrOk2SijfsLB1PkRWQC7PWcIUOWl/aaf8lilYOo0
         OE75O5newfSH3Sm+iQi+ucMWdCikq/+lF/HMd8U0UK7XWRCjikQhxUDdw7hsr3cyAb2E
         X6Gb9doVNEi6VdmKUNXx9HHD25il1wQne4fcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IsB4n7mKE/XOdrocSJSPhNR5SNx/kKR4kJ8kiC66QM=;
        b=Zjc8L5iKPEJ+sc2Rz5IbA687huKOfWNwc4eLsc3cZK3lC1mr3u5ytZ8tVtak9GjNrK
         SSa6tGkVdo1DTcRZCo4ve/49VuB9o9i6XIMTVumIAp7JetO6Q6/xpx94Werc2AYBM9aR
         TiAakSSqvCKLKTrRk1HsVBzYly2nj8zUVMy9DL0xycBG+UaVWdjH0ewqLBa5CoMKBI3X
         HVgoO+RdNCcnASy176wNs6/Avd0ujWjzi8/VFqYc0iQNtMp/MfFm04HKuV2CoAYb1MGw
         KujvcJQtLep9KeBwp3rGaloX2hJd9lIeBQpKWJA6YHZ1uzwY04AOOkNNJNSwU3BemMiw
         uiHA==
X-Gm-Message-State: AHQUAuYuNgm4c7TphmsKe78YbwwrT/0E18s0+0RAn6+OWRSq/PFc7EfP
        jfKPVQgBIrdkMCk/QXS9quQdQK/f2PA=
X-Google-Smtp-Source: AHgI3IbnbJGXA8y60Bbsmf2BPBOJHxavJn3ZUJaZ43CaGoRta0mtKNehO/8oY29gnfgMMnsIu2BfFw==
X-Received: by 2002:a5d:85c5:: with SMTP id e5mr21939546ios.125.1549041252108;
        Fri, 01 Feb 2019 09:14:12 -0800 (PST)
Received: from mail-it1-f173.google.com (mail-it1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id e68sm1493685ite.7.2019.02.01.09.14.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:14:11 -0800 (PST)
Received: by mail-it1-f173.google.com with SMTP id z20so10824246itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:14:10 -0800 (PST)
X-Received: by 2002:a24:d081:: with SMTP id m123mr2034035itg.119.1549041249599;
 Fri, 01 Feb 2019 09:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-15-thgarnie@chromium.org>
 <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
 <CAJcbSZGKR7dKVqNEDEO7Qzf7tnNqmL=p1uVKvsUefS=Hs-=iNA@mail.gmail.com> <01000168a6e5ab88-0deea73f-387f-4941-bd11-d1c161aac88a-000000@email.amazonses.com>
In-Reply-To: <01000168a6e5ab88-0deea73f-387f-4941-bd11-d1c161aac88a-000000@email.amazonses.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 1 Feb 2019 09:13:58 -0800
X-Gmail-Original-Message-ID: <CAJcbSZFvafvNX1pS96jaTBGNJad+NszLwSgKnRQgyT70gUGWqQ@mail.gmail.com>
Message-ID: <CAJcbSZFvafvNX1pS96jaTBGNJad+NszLwSgKnRQgyT70gUGWqQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/27] x86/percpu: Adapt percpu for PIE support
To:     Christopher Lameter <cl@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen@linux.intel.com, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 6:31 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Thu, 31 Jan 2019, Thomas Garnier wrote:
>
> > The per-cpu symbols are in a section that is zero based to create
> > offsets. The compiler doesn't see them as offsets but as relative
> > symbol and try to relocate them. Given the distance between zero and
> > the mapped kernel is much larger than the instruction offset range, it
> > fails to do it.
>
> We switch that off in the linker. If that does not work with your
> modifications then you need to figure out how to update the link
> configuration.
>

It didn't work originally but I will revisit to see if I missed something.
