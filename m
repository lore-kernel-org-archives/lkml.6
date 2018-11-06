Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82225C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0C220685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vg6SR8dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0C220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbeKGA0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:26:05 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45087 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKGA0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:26:05 -0500
Received: by mail-vk1-f193.google.com with SMTP id n126so2722991vke.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufLleiMJsLLBP6Nyrgucr+3ko3K4kubEC73ZKopBepo=;
        b=vg6SR8dWpJZ/bgan0OMWyGKRYOOsSnfiUOV56o0ltR2igGL589+7Ar/q789y5ZefXI
         G33GviOEQU64SYeDbmCEm6g02DmGVM4Id2JR53K57XQ5GmdCuLwerAHCm9hzUER416Zu
         hm2fnN2z/hKI4pNC0pZ60JoE8gYcEIdcRYV7C5LS1qJLny3HvQkZ5S6S79/5l2kE+nt9
         qU5nb3DKjsOJmPFgUwO9bMSRyi2pLlgYRR9UeD5cHbO0kdyXku9yvgnetz01OeksCgJB
         c+1D9I2gQSCegMPVF/2Ua/+Yp5K0aUtxqmSVI3iTRcDrZTY7cjikUg8jT8d7DbnWxzYh
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufLleiMJsLLBP6Nyrgucr+3ko3K4kubEC73ZKopBepo=;
        b=ZHbgtn57i3o1ppnxSiWxkfpKnjmjQEicZ3xcz2+tNWiY/P2XGW+A6j4f1qssO/+SkM
         Tzw7zfVRsaewvAqj0/FPPGpaIpGoCAuAEpvaZUfb4mk4TiUevlSE469GcdJ5NhUSj21M
         M2rJ4qK9lwpWzWnDnL9fbop+2uHpNlHOCRlAz5E0RMhm9aJXNl0P/j7K8hr6lJ4uKZO8
         /ps91VOrcLUFz9L9dqVvvBFjMghBWFLjQ9OanGEvP+rBn41Fh3+haQjDGwGMnEcyl+S4
         mIli5+Kn5IZOU5RlK4kn8Y0+e8Dehu09KW7XAYFXG21gsxLG0lJ4Tkuh1PVgKj7xboky
         ugcA==
X-Gm-Message-State: AGRZ1gK6RWzXyJ1D3D9DR1DyIj5MiamPB5WqgbhT9d0rdd9S6hOgApoc
        lxGVR3n8F4y9d87Kf00QljyUVdwT49PpKovXLxyGyw==
X-Google-Smtp-Source: AJdET5d52InEfDNFH7JS2AABF53+v48uYWGgGvAL0PdS75e1RuF9Q8y9z2SJooecPzJ8HvXU/WI1HP/tiNSCh3qyfIo=
X-Received: by 2002:a1f:f0d:: with SMTP id 13mr619940vkp.21.1541516426042;
 Tue, 06 Nov 2018 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
 <c7356e5d-71e2-1562-1a0b-2ca0d985d4cb@linux.intel.com> <CABPqkBRT678TYMbPMwsUjmazQij_qFDgu2nS7dm619ukni5EGQ@mail.gmail.com>
 <abe1cbab-d010-0899-acb1-32b1f9bf17df@linux.intel.com>
In-Reply-To: <abe1cbab-d010-0899-acb1-32b1f9bf17df@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 6 Nov 2018 07:00:13 -0800
Message-ID: <CABPqkBQAJXeUmNZLyT_ihShPucO2OpqKBKmKaUMeZt02jHb3OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:43 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 11/5/2018 5:59 AM, Stephane Eranian wrote:
> > Hi Kan,
> >
> > I built a small test case for you to demonstrate the issue for code and data.
> > Compile the test program and then do:
> > For text:
> > $ perf record  ./mmap
> > $ perf report -D | fgrep MMAP2
> >
> > The test program mmaps 2 pages, unmaps the second, and remap 1 page
> > over the freed space.
> > If you look at the MMAP2 record, you will not be able to reconstruct
> > what happened and perf will
> > get confused should it try to symbolize from the address range
> >
> > With Text:
> > PERF_RECORD_MMAP2 5937/5937: [0x400000(0x1000) @ 0 08:01 400938
> > 824817672]: r-xp /home/eranian/mmap
> > PERF_RECORD_MMAP2 5937/5937: [0x7f7c01019000(0x2000) @ 0x7f7c01019000
> > 00:00 0 0]: rwxp //anon
> > PERF_RECORD_MMAP2 5937/5937: [0x7f7c01019000(0x2000) @ 0x7f7c01019000
> > 00:00 0 0]: rwxp //anon
> >
> > ^^^^^^^^^^^^^^^^^^^^^^^^ captures the whole VMA but not the mapping
> > change in user space
> >
> > For data:
> > $ perf record -d  ./mmap
> > $ perf report -D | fgrep MMAP2
> > With data:
> > PERF_RECORD_MMAP2 6430/6430: [0x400000(0x1000) @ 0 08:01 400938
> > 3278843184]: r-xp /home/eranian/mmap
> > PERF_RECORD_MMAP2 6430/6430: [0x7f4aa704b000(0x2000) @ 0x7f4aa704b000
> > 00:00 0 0]: rw-p //anon
> > PERF_RECORD_MMAP2 6430/6430: [0x7f4aa704b000(0x2000) @ 0x7f4aa704b000
> > 00:00 0 0]: rw-p //anon
> >
> > Same test case with data.
> > Perf will think the entire 2 pages have been replaced when in fact
> > only the second has.
> > I believe the problem is likely to impact data and jitted code cache
> >
> > #include <sys/types.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <sys/mman.h>
> > #include <err.h>
> > #include <getopt.h>
> >
> > int main(int argc, char **argv)
> > {
> > void *addr1, *addr2;
> > size_t pgsz = sysconf(_SC_PAGESIZE);
> > int n = 2;
> > int ret;
> > int c, mode = 0;
> >
> > while ((c = getopt(argc, argv, "hd")) != -1) {
> > switch (c) {
> > case 'h':
> > printf("[-h]\tget this help\n");
> > printf("[-d]\tuse data mmaps (no PROT_EXEC)\n");
> > return 0;
> > case 'd':
> > mode = PROT_EXEC;
> > break;
> > default:
> > errx(1, "unknown option");
> > }
> > }
> > /* default to data */
> > if (mode == 0)
> > mode = PROT_WRITE;
> >
> > /*
> > * mmap 2 contiugous pages
> > */
> > addr1 = mmap(NULL, n * pgsz, PROT_READ| mode, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> > if (addr1 == (void *)MAP_FAILED)
> > err(1, "mmap 1 failed");
> >
> > printf("addr1=[%p : %p]\n", addr1, addr1 + n * pgsz);
> >
> > /*
> > * unmap only the second page
> > */
> > ret = munmap(addr1 + pgsz, pgsz);
> > if (ret == -1)
> > err(1, "munmp failed");
> >
> > /*
> > * mmap 1 page at the location of the unmap page (should reuse virtual space)
> > * This creates a continuous region built from two mmaps and
> > potentially two different sources
> > * especially with jitted runtimes
> > */
>
> The two mmaps are both anon. As my understanding, we cannot symbolize
> from the anonymous address, can we?
Can't we build the same test case using an actual file mapping (both
mmap from the same file)?

> If we cannot, why we have to distinguish with them? I think we do not
> need to know their sources for symbolization.
>
> As my understanding, only --jit can inject MMAP event, which tag an
> anon. Perf can symbolize the address after that. Then the unmap is needed.
>
Yes,  perf inject --jit injects timestamped MMAP2 records to cover the
jitted regions
which helps symbolize anons.

> Thanks,
> Kan
> > addr2 = mmap(addr1 + pgsz, 1 * pgsz, PROT_READ|PROT_WRITE | mode,
> > MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> >
> > printf("addr2=%p\n", addr2);
> >
> > if (addr2 == (void *)MAP_FAILED)
> > err(1, "mmap 2 failed");
> > if (addr2 != (addr1 + pgsz))
> > errx(1, "wrong mmap2 address");
> >
> > sleep(1);
> >
> > return 0;
> > }
> >
> > On Thu, Nov 1, 2018 at 7:10 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 10/24/2018 3:30 PM, Stephane Eranian wrote:
> >>> The need for this new record type extends beyond physical address conversions
> >>> and PEBS. A long while ago, someone reported issues with symbolization related
> >>> to perf lacking munmap tracking. It had to do with vma merging. I think the
> >>> sequence of mmaps was as follows in the problematic case:
> >>> 1.   addr1 = mmap(8192);
> >>> 2.   munmap(addr1 + 4096, 4096)
> >>> 3.   addr2 = mmap(addr1+4096, 4096)
> >>>
> >>> If successful, that yields addr2 = addr1 + 4096 (could also get the
> >>> same without forcing the address).
> >>>
> >>> In that case, if I recall correctly, the vma for 1st mapping (now at
> >>> 4k) and that of the 2nd mapping (4k)
> >>> get merged into a single 8k vma and this is what perf_events will
> >>> record for PERF_RECORD_MMAP.
> >>> On the perf tool side, it is assumed that if two timestamped mappings
> >>> overlap then, the latter overrides
> >>> the former. In this case, perf would loose the mapping of the first
> >>> 4kb and assume all symbols comes from
> >>> 2nd mapping. Hopefully I got the scenario right. If so, then you'd
> >>> need PERF_RECORD_UNMAP to
> >>> disambiguate assuming the perf tool is modified accordingly.
> >>>
> >>
> >> Hi Stephane and Peter,
> >>
> >> I went through the link(https://lkml.org/lkml/2017/1/27/452). I'm trying
> >> to understand the problematic case.
> >>
> >> It looks like the issue can only be triggered by perf inject --jit.
> >> Because it can inject extra MMAP events.
> >> As my understanding,  Linux kernel only try to merge VMAs if they are
> >> both from anon or they are both from the same file. --jit breaks the
> >> rule, and makes the merged VMA partly from anon, partly from file.
> >> Now, there is a new MMAP event which range covers the modified VMA.
> >> Without the help of MUNMAP event, perf tool have no idea if the new one
> >> is a newly merged VMA (modified VMA + a new VMA) or a brand new VMA.
> >> Current code just simply overwrite the modified VMAs. The VMA
> >> information which --jit injected may be lost. The symbolization may be
> >> lost as well.
> >>
> >> Except --jit, the VMAs information should be consistent between kernel
> >> and perf tools. We shouldn't observe the problem. MUNMAP event is not
> >> needed.
> >>
> >> Is my understanding correct?
> >>
> >> Do you have a test case for the problem?
> >>
> >> Thanks,
> >> Kan
