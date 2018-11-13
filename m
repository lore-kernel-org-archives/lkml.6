Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB60208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WNZPZ7no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB60208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeKNDqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:46:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:46:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so9033505wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f7n/XQvhSDnEsGaJKW58jdkk2D4ym9hJknP2qcsIFCE=;
        b=WNZPZ7noieoN3d0Wj73z1nQxycNboSxy+hdQGYFyESEX7p4GHseoecy5EPqHedLZ10
         f/cTFcmQSPB8WoHUTUQRxtKCyO5QgVUb6ME1d29PaoHwjd8Bwvt9g0XXQ/Ol0eN2IVz7
         bpKDPa4uaWoAWxq/qKiALKrzBloS2uZfIh0ymHWEKJMIybjy8q58kxd4Rd+UhpKJMXGO
         O5enADVsodN6UPRnvyRz0S6paG9fK0k+RK1cjFVnZQQnbybgwtjUsRMInqDxf98v5G5F
         qAnkucn/N49UTVtv20dMwOf4yfKrVyhXvP/+zAFKm+qrw6o7MjvOb1iJ4lWpR0cxY3wG
         f6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f7n/XQvhSDnEsGaJKW58jdkk2D4ym9hJknP2qcsIFCE=;
        b=gME7t93FFBOTc/5+8JIHotCjGkkbP1F38mzCmnmyq7DVl+P3nbM2PJCxxt6pNI6r+7
         eSGwtepebXwGzEgl26/xuKU6fvmFSJVfP1AAE3m0FoR+NfkURKLZNE1tQQai22vQGvhV
         HtbmLgNpt/UfJ1EklceKK/a7Sj0Vig8sgHC7AFzkNekYZ9M8EXtSR5RWUA0v22C8iV50
         YLNnYnImL36OYpJRmB77RKoj17O/kumOE4HEtls/baVtzDUR8Jb7Ot7EttFqa8Mz0ZTA
         LhZdNxlC6M+Krt8gXvr1GNxWmm3+vow7hAX0PNo9eJmWdushPrxCbwXPAfOjQwIxlX03
         Nd5A==
X-Gm-Message-State: AGRZ1gI25Orb5ykPR6wOxa6mym0qWmwgvd1mLBVQkvEAAAs03ikv2/dl
        Zgf0TweSif4sae93puGOiJxjVunZARornSG4k01tGQ==
X-Google-Smtp-Source: AJdET5f2oviiGlTMB+pnJfTo6zLPWF47S9VstHJBKEdQbczFq0MtyiRtfLrtc8w4xfPlzYDKUaYI5nRTdGwxfiR2id0=
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr6056301wre.94.1542131248499;
 Tue, 13 Nov 2018 09:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com> <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
In-Reply-To: <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 13 Nov 2018 09:47:16 -0800
Message-ID: <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
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
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:43 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> From: Andy Lutomirski
> Sent: November 13, 2018 at 5:16:09 PM GMT
> > To: Igor Stoppa <igor.stoppa@gmail.com>
> > Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead=
.org>, Nadav Amit <nadav.amit@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.=
com>, Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.c=
om>, James Morris <jmorris@namei.org>, Michal Hocko <mhocko@kernel.org>, Ke=
rnel Hardening <kernel-hardening@lists.openwall.com>, linux-integrity <linu=
x-integrity@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.o=
rg>, Igor Stoppa <igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.i=
ntel.com>, Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.c=
om>, Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport <rppt@linux.vnet.i=
bm.com>, open list:DOCUMENTATION <linux-doc@vger.kernel.org>, LKML <linux-k=
ernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
> > Subject: Re: [PATCH 10/17] prmem: documentation
> >
> >
> > On Tue, Nov 13, 2018 at 6:25 AM Igor Stoppa <igor.stoppa@gmail.com> wro=
te:
> >> Hello,
> >> I've been studying v4 of the patch-set [1] that Nadav has been working=
 on.
> >> Incidentally, I think it would be useful to cc also the
> >> security/hardening ml.
> >> The patch-set seems to be close to final, so I am resuming this discus=
sion.
> >>
> >> On 30/10/2018 19:06, Andy Lutomirski wrote:
> >>
> >>> I support the addition of a rare-write mechanism to the upstream kern=
el.  And I think that there is only one sane way to implement it: using an =
mm_struct. That mm_struct, just like any sane mm_struct, should only differ=
 from init_mm in that it has extra mappings in the *user* region.
> >>
> >> After reading the code, I see what you meant.
> >> I think I can work with it.
> >>
> >> But I have a couple of questions wrt the use of this mechanism, in the
> >> context of write rare.
> >>
> >>
> >> 1) mm_struct.
> >>
> >> Iiuc, the purpose of the patchset is mostly (only?) to patch kernel co=
de
> >> (live patch?), which seems to happen sequentially and in a relatively
> >> standardized way, like replacing the NOPs specifically placed in the
> >> functions that need patching.
> >>
> >> This is a bit different from the more generic write-rare case, applied
> >> to data.
> >>
> >> As example, I have in mind a system where both IMA and SELinux are in =
use.
> >>
> >> In this system, a file is accessed for the first time.
> >>
> >> That would trigger 2 things:
> >> - evaluation of the SELinux rules and probably update of the AVC cache
> >> - IMA measurement and update of the measurements
> >>
> >> Both of them could be write protected, meaning that they would both ha=
ve
> >> to be modified through the write rare mechanism.
> >>
> >> While the events, for 1 specific file, would be sequential, it's not
> >> difficult to imagine that multiple files could be accessed at the same=
 time.
> >>
> >> If the update of the data structures in both IMA and SELinux must use
> >> the same mm_struct, that would have to be somehow regulated and it wou=
ld
> >> introduce an unnecessary (imho) dependency.
> >>
> >> How about having one mm_struct for each writer (core or thread)?
> >
> > I don't think that helps anything.  I think the mm_struct used for
> > prmem (or rare_write or whatever you want to call it) should be
> > entirely abstracted away by an appropriate API, so neither SELinux nor
> > IMA need to be aware that there's an mm_struct involved.  It's also
> > entirely possible that some architectures won't even use an mm_struct
> > behind the scenes -- x86, for example, could have avoided it if there
> > were a kernel equivalent of PKRU.  Sadly, there isn't.
> >
> >> 2) Iiuc, the purpose of the 2 pages being remapped is that the target =
of
> >> the patch might spill across the page boundary, however if I deal with
> >> the modification of generic data, I shouldn't (shouldn't I?) assume th=
at
> >> the data will not span across multiple pages.
> >
> > The reason for the particular architecture of text_poke() is to avoid
> > memory allocation to get it working.  i think that prmem/rare_write
> > should have each rare-writable kernel address map to a unique user
> > address, possibly just by offsetting everything by a constant.  For
> > rare_write, you don't actually need it to work as such until fairly
> > late in boot, since the rare_writable data will just be writable early
> > on.
> >
> >> If the data spans across multiple pages, in unknown amount, I suppose
> >> that I should not keep interrupts disabled for an unknown time, as it
> >> would hurt preemption.
> >>
> >> What I thought, in my initial patch-set, was to iterate over each page
> >> that must be written to, in a loop, re-enabling interrupts in-between
> >> iterations, to give pending interrupts a chance to be served.
> >>
> >> This would mean that the data being written to would not be consistent=
,
> >> but it's a problem that would have to be addressed anyways, since it c=
an
> >> be still read by other cores, while the write is ongoing.
> >
> > This probably makes sense, except that enabling and disabling
> > interrupts means you also need to restore the original mm_struct (most
> > likely), which is slow.  I don't think there's a generic way to check
> > whether in interrupt is pending without turning interrupts on.
>
> I guess that enabling IRQs might break some hidden assumptions in the cod=
e,
> but is there a fundamental reason that IRQs need to be disabled? use_mm()
> got them enabled, although it is only suitable for kernel threads.
>

For general rare-writish stuff, I don't think we want IRQs running
with them mapped anywhere for write.  For AVC and IMA, I'm less sure.

--Andy
