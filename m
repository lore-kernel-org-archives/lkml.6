Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B28C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3CF2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3CF2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeKLWWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:22:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:46339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbeKLWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:22:33 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Mon, 12 Nov 2018 13:29:07 +0100
MIME-Version: 1.0
Message-ID: <trinity-8a113065-6ab9-43cb-b48b-d55f8aee1751-1542025747660@msvc-mesg-gmx021>
From:   "Qian Cai" <cai@gmx.us>
To:     "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc:     linux-mm@kvack.org, "Catalin Marinas" <catalin.marinas@arm.com>,
        "linux kernel" <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: crashkernel=512M is no longer working on this aarch64 server
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Nov 2018 13:29:07 +0100
In-Reply-To: <20181112070151.51ea5caf@mschwideX1>
References: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
 <20181111123553.3a35a15c@mschwideX1>
 <77E3BE32-F509-43B3-8C5F-252416C04B7C@gmx.us>
 <20181112070151.51ea5caf@mschwideX1>
X-Provags-ID: V03:K1:5nEyHRY7vAmmiAvbR2rI2uNlq3Qirbqd01ONwt6ClXUOx2mbE/BKe1BpOxxHQyCDdqduv
 uETOvSv3ZQNdYHwL056pSWQKP5imFu9UpNXxRW7/7rFth41vSf8cRmZvOpF5SJv9sCfhmEoj1RSy
 Mbyp9VpD6i1kXedEX7MZANJHaeGvElaxRIMQ1SNYkvA33MJLdZ3UPp4V0e0d4gsAgogIFLDNYgII
 FIrdcW+DcVW0//8MUBPEGCbEGcDAJjv0/VXSQj9LH8/4oT/hsE9Tg4NZMKv7BZHuIPCsY7LIy5PS
 OYaaeV4+Api0zGMybMRohdx
X-UI-Out-Filterresults: notjunk:1;V01:K0:YVaoaq/pv8I=:OClDvjwsKDRIxP/aqswBYH
 Rq/Mm0/QZFiULqMjKrN5KrKR+/QkMMNAd9msqXdKZ9Er2o/H/SF3dKa6Qx6Ub5EJxs0bKj615
 QXats7DGSEg4ME0ZGAaMt2MRC2RvnZwdjlyvf/UJ/HQaE5f+Dqyl1jliDvpQXyzy+V76o1G6Z
 7zISANWuBASab5EuRH4lUnugHFrYfImSRh/n3PX53WtRKYEVW146PNO8z4ROHi20OMEkl7hD/
 avi1c/omZtbOeTn9oZxPm8f/dxaXRfyTT654z59GMeBikpL6m1M2yOK9moJCSDLUVWpq02FBm
 hBQZ87Aud/BTZ1NCcSqPVrKyJueofHyWGHSsUkTUPF2taMmVNXTFotYM3z87JeDU6MJIXJGtr
 K/yUI0i4KojFgiw4LOQiozjrjWipracWEndxAdTSp3CnRDGPHogPcf8JWQ7lynxIsJvj3LCeM
 NczCE+x3kkYxdICzEP4dkqr0ez2YBK59JR5cp5PstH88HNjEfcOHyGN5v/s9IetZOD/djMsRW
 IQpN8RNbXWALA9U0f2WQos/5Lieupcmy4gVyWwfCL0p/ZVxa6fTBN3PbNfTQyRdPFXyaOmY3v
 ZVLKoPtD6NIrsfg6JsNbzPDyKKbXT94RT3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 at 1:01 AM, Martin Schwidefsky wrote:

> On Sun, 11 Nov 2018 08:36:09 -0500
> Qian Cai <cai@gmx.us> wrote:
> 
> > > On Nov 11, 2018, at 6:35 AM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > > 
> > > On Sat, 10 Nov 2018 23:41:34 -0500
> > > Qian Cai <cai@gmx.us> wrote:
> > >   
> > >> It was broken somewhere between b00d209241ff and 3541833fd1f2.
> > >> 
> > >> [    0.000000] cannot allocate crashkernel (size:0x20000000)
> > >> 
> > >> Where a good one looks like this,
> > >> 
> > >> [    0.000000] crashkernel reserved: 0x0000000008600000 - 0x0000000028600000 (512 MB)
> > >> 
> > >> Some commits look more suspicious than others.
> > >> 
> > >>      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
> > >>      mm: introduce mm_[p4d|pud|pmd]_folded
> > >>      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty  
> > > 
> > > The intent of these three patches is to add extra checks to the
> > > pgtable_bytes accounting function. If applied incorrectly the expected
> > > result would be warnings like this:
> > >  BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > 
> > > The change Linus worried about affects the __PAGETABLE_PxD_FOLDED defines.
> > > These defines are used with #ifdef, #ifndef, and __is_defined() for the
> > > new mm_p?d_folded() macros. I can not see how this would make a difference
> > > for your iomem setup.
> > >   
> > >> # diff -u ../iomem.good.txt ../iomem.bad.txt 
> > >> --- ../iomem.good.txt	2018-11-10 22:28:20.092614398 -0500
> > >> +++ ../iomem.bad.txt	2018-11-10 20:39:54.930294479 -0500
> > >> @@ -1,9 +1,8 @@
> > >> 00000000-3965ffff : System RAM
> > >>   00080000-018cffff : Kernel code
> > >> -  018d0000-020affff : reserved
> > >> -  020b0000-045affff : Kernel data
> > >> -  08600000-285fffff : Crash kernel
> > >> -  28730000-2d5affff : reserved
> > >> +  018d0000-0762ffff : reserved
> > >> +  07630000-09b2ffff : Kernel data
> > >> +  231b0000-2802ffff : reserved
> > >>   30ec0000-30ecffff : reserved
> > >>   35660000-3965ffff : reserved
> > >> 39660000-396fffff : reserved
> > >> @@ -127,7 +126,7 @@
> > >>   7c5200000-7c520ffff : 0004:48:00.0
> > >> 1040000000-17fbffffff : System RAM
> > >>   13fbfd0000-13fdfdffff : reserved
> > >> -  16fba80000-17fbfdffff : reserved
> > >> +  16fafd0000-17fbfdffff : reserved
> > >>   17fbfe0000-17fbffffff : reserved
> > >> 1800000000-1ffbffffff : System RAM
> > >>   1bfbff0000-1bfdfeffff : reserved  
> > > 
> > > The easiest way to verify if the three commits have something to do with your
> > > problem is to revert them and run your test. Can you do that please ?  
> > Yes, you are right. Those commits have nothing to do with the problem. I should
> > realized it earlier as those are virtual memory vs physical memory. Sorry for the
> > nosie.
> > 
> > It turned out I made a wrong assumption that if kmemleak is disabled by default,
> > there should be no memory reserved for kmemleak at all which is not the case.
> > 
> > CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=600000
> > CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> > 
> > Even without kmemleak=on in the kernel cmdline, it still reserve early log memory
> > which causes not enough memory for crashkernel.
> > 
> > Since there seems no way to turn kmemleak on later after boot, is there any
> > reasons for the current behavior? 
> 
> Well seems like you do have CONFIG_DEBUG_KMEMLEAK=y in your config. The code
> contains data structures for the case that you want to use the kmemleak checker.
> The presence of these structures will change the sizes. The last commit in regard
> to the 'early_log' buffer has been from 2009 with this change:
> 
> @@ -232,8 +232,9 @@ struct early_log {
>  };
>  
>  /* early logging buffer and current position */
> -static struct early_log early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE];
> -static int crt_early_log;
> +static struct early_log
> +       early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE] __initdata;
> +static int crt_early_log __initdata;
>  
>  static void kmemleak_disable(void);
>  
> The current behavior is imho nothing new.
> 
> Would it be possible to disable CONFIG_DEBUG_KMEMLEAK for your kdump kernel?
> That seems like the simplest solution.
Ah, okay. Those are static memory allocations 
regardless of the kmemleak runtime setting.

The problem is that it has to disable kmemleak entirely 
and re-compile the kernel for the first-kernel as well, 
as crashkernel reservation happens in the first-kernel.

Hence, it loses flexibility to enable kmemleak during
boot time as well. I can live with it, although it does
not seem ideal.
