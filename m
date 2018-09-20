Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC1BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F0E21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTrxoxdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F0E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbeITRek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:34:40 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33570 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:34:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id m125-v6so1825485vka.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwpdATpvxWQMxRdtNtDgfrk1I10H2ji0HEqs0CTYLOY=;
        b=vTrxoxduBydy2hQhAD/bSvhbUJPdPLcrcQ6WXc3HPgFnS70wfnaR3R3lcziMNPeeKO
         IwhZ7Y9EvcEZUVsoWI66Oy7n6NwC0GRWLD5104wPSErfwObNFgaXoyorvt26nDKyYoZy
         Q/vPRkNaMBQTUlpC5qbO2rlJWOT/vHjVy15dWUz/GQSyFmvGP/JCLRji636HsFWxchZd
         a9RqCGueFA/IqZVtGmxpsSQhYuLpWhqqCjd22D40ITEQh3gFmFq5D4dI+XdTqTegXHSi
         Qf/O1TrvtCeDsk4Ps7/JZzRWk6cI8FgTSULSVQ2CC8oa+wiyAcSzz4RUQ1/bZ6O2Jexr
         UePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwpdATpvxWQMxRdtNtDgfrk1I10H2ji0HEqs0CTYLOY=;
        b=IkLNfKYAK4Wq2Qwsyk4viZuqAFrF3UQrNOxQcu/SVnzqnzjt/DmRnIDR0yrsyImH0+
         d7sLdEFNB37QZVBXoS4S5wqikIPPLo4E/lLORgn0yeZKRm5YIAJbhyrZAaRZZrHxzPz4
         Imh8/kwofp1UvCI7WMJuNbxDwqR54XHwHD2/JH+06oHWrHZmkcXmsSFMyBLNfo8AUwMi
         3hKkWWj/VYLbp5OwpC8f/eDz2H+D0sKgpf+QtlVe/Su2xTk7VaapDjPqKa5fdrP4Br3M
         Gk2R9BPAs/Chx5F8V+I/CpnJeKJ3QkWZIhat/IkRxl48i1iE5LifnOzFX6T+d8TTVy3w
         M3VA==
X-Gm-Message-State: APzg51Asjm37XAaSiLoZf6xz56elVJvmGWSRT8qLvABKpfXxVrFcmflA
        B+KOxIxWraMk/u6nZmRSIhOLPAbxtkahTANVVOU=
X-Google-Smtp-Source: ANB0VdYMzFEH/avoHMXBgd49wqxEhQwgRxTEXap5ZRoQqIhOjDjPMHjUehnIRZvaaqlDlPIOdtWaPzNw5k5RHGsP2I4=
X-Received: by 2002:a1f:b989:: with SMTP id j131-v6mr10303458vkf.69.1537444291925;
 Thu, 20 Sep 2018 04:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx> <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx> <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
 <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com> <20180917145936.GA20945@rapoport-lnx>
In-Reply-To: <20180917145936.GA20945@rapoport-lnx>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Thu, 20 Sep 2018 17:21:20 +0530
Message-ID: <CAOuPNLiqntJspBgAyP4OSEiajbg1mWmeFBb6j4akPp-OULQpUw@mail.gmail.com>
Subject: Re: KSM not working in 4.9 Kernel
To:     rppt@linux.vnet.ibm.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you so much for all your reply so far.
I have few more doubts to understand the output from ksm sysfs.
Device: Hikey620 - ARM64 - Linux 4.9.20
With HUGE page enabled:
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set

Currently, I get this output, when I run below program with ksm:

~ # grep -H '' /sys/kernel/mm/ksm/*
/sys/kernel/mm/ksm/full_scans:29
/sys/kernel/mm/ksm/page_comparisons:39584
/sys/kernel/mm/ksm/pages_hashed:11672
/sys/kernel/mm/ksm/pages_scanned:21766
/sys/kernel/mm/ksm/pages_shared:3
/sys/kernel/mm/ksm/pages_sharing:10097
/sys/kernel/mm/ksm/pages_to_scan:200
/sys/kernel/mm/ksm/pages_unshared:53
/sys/kernel/mm/ksm/pages_volatile:1
/sys/kernel/mm/ksm/run:0
/sys/kernel/mm/ksm/sleep_millisecs:1000
---------------------------

int main(int argc, char *argv[])
{
        int i, n, size, ret;
        char *buffer;
        void *addr;

        n = 100;
        size = 100 * getpagesize();
        for (i = 0; i < n; i++) {
                buffer = (char *)malloc(size);
                memset(buffer, 0xff, size);
                madvise(buffer, size, MADV_MERGEABLE);
                if (ret < 0) {
                        fprintf(stderr, "malloc madvise failed: ret:
%d, reason: %s\n", ret, strerror(errno));
                }
                usleep(500);
        }
        printf("Done....press ^C\n");
        pause();
        return 0;
}
Note: madvise() system call is not failing here, as mentioned earlier.
I guess the page is aligned with getpagesize().
Then I do this to invoke ksm:
# echo 1 > /sys/kernel/mm/ksm/run
# ./malloc-test.out &
# sleep 5
# echo 0 > /sys/kernel/mm/ksm/run
#

Also, the anon pages in the system shows like this:
BEFORE:
-------------
~ # cat /proc/meminfo | grep -i anon
Active(anon):      40740 kB
Inactive(anon):        0 kB
AnonPages:         40760 kB
AnonHugePages:         0 kB

AFTER MERGING:
--------------------------
~ # cat /proc/meminfo | grep -i anon
Active(anon):        440 kB
Inactive(anon):        0 kB
AnonPages:           188 kB
AnonHugePages:         0 kB

I want to understand the KSM output w.r.t to the above program, and
cross-check if the output is correct.
Can someone help me to understand it?

As of now, what I understood is that:
- I am allocating around 400KB of memory 100 times. That is: 100 * 100
* 4K = 10000 pages (which are all with similar content).
- Output says: 10097 page_sharing happened.
- Pages currently shared is: 3
- So total pages are: 10097 + 3 = 10100

I could not understand from where the additional 100 pages came from?
Also, why some pages are shown as: pages_unshared ?
What can I interpret from this?
And, what does it mean by: pages_volatile:1 ?

Basically, I wanted to understand, is there any problem with the above
output, or it is fine.
If it is fine, how to prove it?



Thanks,
Pintu

On Mon, Sep 17, 2018 at 8:29 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Mon, Sep 17, 2018 at 05:25:27PM +0530, Pintu Kumar wrote:
> > On Mon, Sep 17, 2018 at 11:46 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > > > But still no effect.
> > > > > And I checked LTP test cases. It almost doing the same thing.
> > > > >
> > > > > I observed that [ksmd] thread is not waking up at all.
> > > > > I gave some print inside it, but I could never saw that prints coming.
> > > > > I could not find it running either in top command during the operation.
> > > > > Is there anything needs to be done, to wakw up ksmd?
> > > > > I already set: echo 1 > /sys/kernel/mm/ksm.
> > > >
> > > > It should be echo 1 > /sys/kernel/mm/ksm/run
> > > >
> > >
> > > Oh yes, sorry for the typo.
> > > I tried the same, but still ksm is not getting invoked.
> > > Could someone confirm if KSM was working in 4.9 kernel?
> > >
> >
> > Ok, it's working now. I have to explicitly stop the ksm thread to see
> > the statistics.
> > Also there was some internal patch that was setting vm_flags to
> > VM_MERGABLE thus causing ksm_advise call to return.
> >
> > # echo 1 > /sys/kernel/mm/ksm/run
> > # ./malloc-test.out &
> > # echo 0 > /sys/kernel/mm/ksm/run
> >
> > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > /sys/kernel/mm/ksm/full_scans:105
> > /sys/kernel/mm/ksm/pages_shared:1
> > /sys/kernel/mm/ksm/pages_sharing:999
> > /sys/kernel/mm/ksm/pages_to_scan:100
> > /sys/kernel/mm/ksm/pages_unshared:0
> > /sys/kernel/mm/ksm/pages_volatile:0
> > /sys/kernel/mm/ksm/run:0
> > /sys/kernel/mm/ksm/sleep_millisecs:20
> >
> >
> > However, I have one doubt.
> > Is the above data correct, for the below program?
>
> You have 1 shared page and 999 additional references to that page
>
> > int main(int argc, char *argv[])
> > {
> >         int i, n, size, ret;
> >         char *buffer;
> >         void *addr;
> >
> >         n = 10;
> >         size = 100 * getpagesize();
> >         for (i = 0; i < n; i++) {
> >                 buffer = (char *)malloc(size);
> >                 memset(buffer, 0xff, size);
> >                 madvise(buffer, size, MADV_MERGEABLE);o
>
> This madvise() call should fail because buffer won't be page aligned
>
> >                 addr =  mmap(NULL, size,
> >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > MAP_PRIVATE | MAP_ANONYMOUS,
> >                            -1, 0);
> >                 memset(addr, 0xff, size);
> >                 ret = madvise(addr, size, MADV_MERGEABLE);
> >                 if (ret < 0) {
> >                         fprintf(stderr, "madvise failed: ret: %d,
> > reason: %s\n", ret, strerror(errno));
> >                 }
> >                 usleep(500);
> >         }
> >         printf("Done....press ^C\n");
> >
> >         pause();
> >
> >         return 0;
> > }
> >
> >
> > Thanks,
> > Pintu
> >
>
> --
> Sincerely yours,
> Mike.
>
