Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C6AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FC02098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJxroeF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FC02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJCXur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:50:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44340 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:50:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so6250731oth.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TVOvcL/RPCfjgaxUTPR+EodiC4bCYYtfpfqcF+M5BGE=;
        b=CJxroeF5fENUeH1AKPncuaTVxtajHLFqBUFFrmezU5xEsSpZEUbJv0g0vbhBuTknmg
         QI9e3xOl9XYVPDnPWF5McBGxkAp3PAUigTud320uWn9xe2o210BFB072T666kFMEPemO
         y4YosWHq9+sy2WxGFufu2l9IALNadgvnEYRQ12vVZkA2sy5RpILQbumFBRnw/7ZgFOkk
         B9Gfl0hSPdcCg6cFobTL9D6xIN9jtdIqIjJsRuwK103DDAMaAVLJYxlGxwBRLzIJDBOu
         FBeGtnewLHS55YMZzjBMuSOea6Nb+f8fODjffTc4oHe7W03Ir3OnUX8dTHNp7p43gKYB
         GneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TVOvcL/RPCfjgaxUTPR+EodiC4bCYYtfpfqcF+M5BGE=;
        b=HWNmUM2MZz70FiGAwzE1fZh2ci6xgCZYvc3PQ9Xb4i3ILB/rcvMpwu6j+q/ObvxReJ
         AuQMOntQcfy/KrCbRYWoryQDGdqQu3yD///fB1LL41AyYRGgogeevZ1sci9bEQGl/v2Q
         rt5+yUtHIssgKFF7HgEs3Ig+ZPRDomf8tRLUVsfogOOTvaST0PfYnJyFIDuuaY9i5Ea9
         wvKPzXCujHT4qVfDn1bRz3hm4H0E7Don7064l7IAgbpzpkjaamhmlzVydQJ6U8CbXJBr
         EjZOVENrYNVKV6uiilgYhQAWDXv08BEQuTmRR123zg9OXG1F4eNFxLTce2ve5Z9Y0rac
         IiZQ==
X-Gm-Message-State: ABuFfogBk95NKUENLU3H90R7TDewdcOaWT7Z+9RmFrsEJojUnKXFtz+D
        TgYVuXV7D3zPxG9SPFDhBawa7ADYSc/yXUyHdkyOsA==
X-Google-Smtp-Source: ACcGV6179YIYwzfhCFEwupvTUVz6yg8Il6qiz9sbTU8pZhddrKWCAVkoeW51fCiORwN2Tejiu7MqUYQK1+O01+ARXsA=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr1282753oth.292.1538586092539;
 Wed, 03 Oct 2018 10:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com> <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com> <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com> <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
 <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de> <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
In-Reply-To: <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 3 Oct 2018 19:01:05 +0200
Message-ID: <CAG48ez3y7Q0DCkVH6PgGncwEKuD-OHLp7pTBNb=S1OXYhte-Nw@mail.gmail.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     alexey.budankov@linux.intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 10:53 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
> On 01.10.2018 19:11, Thomas Gleixner wrote:
> > Peter and I discussed that and we came up with the idea that the file
> > descriptor is not even required, i.e. you could make it backward
> > compatible.
> >
> > perf_event_open() knows which PMU is associated with the event the call=
er
> > tries to open. So perf_event_open() can try to access/open the special =
per
> > PMU file on behalf of the caller. That should get the same security
> > treatment like a regular open() from user space. If that succeeds, acce=
ss
> > is granted.
> >
> > The magic file could still be writeable for root to give general
> > restrictions aside of the file based ones similar to what you are
> > proposing.
>
> Let me wrap up all the requirements and ideas that have been captured so =
far.
>
> 1. A file [1] is added so that it can belong to a group of users allowed =
to use ${PMU},
>    something like this:
>
> ls -alh /sys/bus/event_source/devices/${PMU}/caps/
> total 0
> drwxr-xr-x 2 root root            0 Oct  1 20:36 .
> drwxr-xr-x 6 root root            0 Oct  1 20:36 ..
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 branches
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 max_precise
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 pmu_name
> -rw-r--r--   root ${PMU}_users                   paranoid        <=3D=3D=
=3D
>
>    Modifications of file content are allowed to those who can
>    modify /proc/sys/kernel/perf_event_paranoid setting.
>
> 2. Semantics and content of the introduced paranoid file is
>    similar to /proc/sys/kernel/perf_even_paranoid [2]:
>
>    The perf_event_paranoid file can be set to restrict access
>    to the performance counters.
>
>    2   allow only user-space measurements (default since Linux 4.6).
>    1   allow both kernel and user measurements (default before Linux 4.6)=
.
>    0   allow access to CPU-specific data but not raw trace=E2=80=90point =
samples.
>   -1  no restrictions.
>
>    The existence of the perf_event_paranoid file is the official method
>    for determining if a kernel supports perf_event_open().
>
> 3. Every time an event for ${PMU} is created over perf_event_open():
>    a) the calling thread's euid is checked to belong to ${PMU}_users grou=
p
>       and if it does then the event's fd is allocated;
>    b) then traditional checks against perf_event_pranoid content are appl=
ied;
>    c) if the file doesn't exist the access is governed by global setting
>       at /proc/sys/kernel/perf_even_paranoid;

You'll also have to make sure that this thing in kernel/events/core.c
doesn't have any bad effect:

    /*
    * Special case software events and allow them to be part of
    * any hardware group.
    */

As in, make sure that you can't smuggle in arbitrary software events
by attaching them to a whitelisted hardware event.

> 4. Documentation/admin-guide/perf-security.rst file is introduced that:
>    a) contains general explanation for fine grained access control;
>    b) contains a section with guidance about scope and risk for each PMU
>       which is enabled for fine grained access control;
>    c) file is extended when more PMUs are enabled for fine grain control;
>
> >
> > The analysis and documentation requirements still remain of course.
>
> Security analysis for uncore IMC, QPI/UPI, PCIe PMUs is still required
> to be enabled for fine grain control.

And you can't whitelist anything that permits using sampling events
with arbitrary sample_type.
