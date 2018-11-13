Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3EC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125FF224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YcqUVk6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125FF224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeKNDPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:15:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34652 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbeKNDPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:15:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so11625906wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oyAuWWcjSu0uytm90hhiKb/uLBTJ/lDlQh1huZKpzGU=;
        b=YcqUVk6yncC5WgpJXNOkfzf6KWHr4QK6lHdKNcPuSSzISlnoKYIyXf0IGcyuEgGmur
         ERMeceOw04hxMV9aY3w2nzWDax6PufNov4IkO5QvzaXmhbSZZJpsN1c2A7rZtwH+qfOC
         XfV0EYWXhjwAA9Aor6FcriZopLMcjj5upyv8rg7U9I0Go3i5TaQbL5Kgy8iw4VgBZy3s
         5s7uxVhJlQWdoaQ7GtSa4DzsvmOAqe+Xv8RY+rECBkufmFBcLIJRx/Qp9uzBy/NkauKn
         U2FO6rtG9XJY08EcBbBmkIjFcDFoD5VPfYauZ7lpUYy7FjpPK8XzaLyQIhZkFr3tJamU
         nJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oyAuWWcjSu0uytm90hhiKb/uLBTJ/lDlQh1huZKpzGU=;
        b=M8oiPN2QuJ8mAUkySisT4GL3aqJiIDTlVRTfIf+S7lBeQAT+1tu5elCsteIP/EU1py
         4fCfNrZQVdDtoLAurVM9OGTks6Ya6QNRR+3vyfWMKzjtKRz5vTxZKIowboDGhxznGx2W
         g+Mx0qi6lMxKuDgqpXEZQ1eeyvMTE0CduqLVfcHXBSbC5iwtoeW5f1TbtC/hzEYyUqya
         cW3RGvetsPRniOIxfIbauOwaQDUXI4PtD+3ZaNCmjn613iQ9UdRT/5F8AktajqXX7dwr
         I5lqKzgnw6EpvnIELtYTIltc+DupjsiiYoLnUFxFrssR6pUIAEqkQ8eXtcBjL2OAfrkv
         5TPw==
X-Gm-Message-State: AGRZ1gK0ruArHR8Tc4UHbcrpeU22nj7Sa2EStE5AExNkcAYDGfpEHWxV
        lqmk448DMIeZmOmQntOICButH24hwmyj8M5F0VKyyA==
X-Google-Smtp-Source: AJdET5empAVYVL6Xksq88M8WOMGr7U7+6Q/6nRvDISEbSjHY8iCBVRd+PWXPeX7Ejr29gdckFoY1F4xmLtURAm2/uXE=
X-Received: by 2002:a1c:4b1a:: with SMTP id y26-v6mr4117866wma.82.1542129381388;
 Tue, 13 Nov 2018 09:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
In-Reply-To: <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 13 Nov 2018 09:16:09 -0800
Message-ID: <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
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

On Tue, Nov 13, 2018 at 6:25 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> Hello,
> I've been studying v4 of the patch-set [1] that Nadav has been working on=
.
> Incidentally, I think it would be useful to cc also the
> security/hardening ml.
> The patch-set seems to be close to final, so I am resuming this discussio=
n.
>
> On 30/10/2018 19:06, Andy Lutomirski wrote:
>
> > I support the addition of a rare-write mechanism to the upstream kernel=
.  And I think that there is only one sane way to implement it: using an mm=
_struct. That mm_struct, just like any sane mm_struct, should only differ f=
rom init_mm in that it has extra mappings in the *user* region.
>
> After reading the code, I see what you meant.
> I think I can work with it.
>
> But I have a couple of questions wrt the use of this mechanism, in the
> context of write rare.
>
>
> 1) mm_struct.
>
> Iiuc, the purpose of the patchset is mostly (only?) to patch kernel code
> (live patch?), which seems to happen sequentially and in a relatively
> standardized way, like replacing the NOPs specifically placed in the
> functions that need patching.
>
> This is a bit different from the more generic write-rare case, applied
> to data.
>
> As example, I have in mind a system where both IMA and SELinux are in use=
.
>
> In this system, a file is accessed for the first time.
>
> That would trigger 2 things:
> - evaluation of the SELinux rules and probably update of the AVC cache
> - IMA measurement and update of the measurements
>
> Both of them could be write protected, meaning that they would both have
> to be modified through the write rare mechanism.
>
> While the events, for 1 specific file, would be sequential, it's not
> difficult to imagine that multiple files could be accessed at the same ti=
me.
>
> If the update of the data structures in both IMA and SELinux must use
> the same mm_struct, that would have to be somehow regulated and it would
> introduce an unnecessary (imho) dependency.
>
> How about having one mm_struct for each writer (core or thread)?
>

I don't think that helps anything.  I think the mm_struct used for
prmem (or rare_write or whatever you want to call it) should be
entirely abstracted away by an appropriate API, so neither SELinux nor
IMA need to be aware that there's an mm_struct involved.  It's also
entirely possible that some architectures won't even use an mm_struct
behind the scenes -- x86, for example, could have avoided it if there
were a kernel equivalent of PKRU.  Sadly, there isn't.

>
>
> 2) Iiuc, the purpose of the 2 pages being remapped is that the target of
> the patch might spill across the page boundary, however if I deal with
> the modification of generic data, I shouldn't (shouldn't I?) assume that
> the data will not span across multiple pages.

The reason for the particular architecture of text_poke() is to avoid
memory allocation to get it working.  i think that prmem/rare_write
should have each rare-writable kernel address map to a unique user
address, possibly just by offsetting everything by a constant.  For
rare_write, you don't actually need it to work as such until fairly
late in boot, since the rare_writable data will just be writable early
on.

>
> If the data spans across multiple pages, in unknown amount, I suppose
> that I should not keep interrupts disabled for an unknown time, as it
> would hurt preemption.
>
> What I thought, in my initial patch-set, was to iterate over each page
> that must be written to, in a loop, re-enabling interrupts in-between
> iterations, to give pending interrupts a chance to be served.
>
> This would mean that the data being written to would not be consistent,
> but it's a problem that would have to be addressed anyways, since it can
> be still read by other cores, while the write is ongoing.

This probably makes sense, except that enabling and disabling
interrupts means you also need to restore the original mm_struct (most
likely), which is slow.  I don't think there's a generic way to check
whether in interrupt is pending without turning interrupts on.
