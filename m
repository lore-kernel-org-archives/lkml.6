Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ECB2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ECB2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeKLPxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:53:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731226AbeKLPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:53:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAC5wZar089466
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:02:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npx353r4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:01:59 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 12 Nov 2018 06:01:56 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 06:01:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAC61rdY58916932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 06:01:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA1F311C058;
        Mon, 12 Nov 2018 06:01:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EC3E11C052;
        Mon, 12 Nov 2018 06:01:53 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.78.106])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 06:01:53 +0000 (GMT)
Date:   Mon, 12 Nov 2018 07:01:51 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: crashkernel=512M is no longer working on this aarch64 server
In-Reply-To: <77E3BE32-F509-43B3-8C5F-252416C04B7C@gmx.us>
References: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
        <20181111123553.3a35a15c@mschwideX1>
        <77E3BE32-F509-43B3-8C5F-252416C04B7C@gmx.us>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18111206-0012-0000-0000-000002C8FD64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111206-0013-0000-0000-000020FE0457
Message-Id: <20181112070151.51ea5caf@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 08:36:09 -0500
Qian Cai <cai@gmx.us> wrote:

> > On Nov 11, 2018, at 6:35 AM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > 
> > On Sat, 10 Nov 2018 23:41:34 -0500
> > Qian Cai <cai@gmx.us> wrote:
> >   
> >> It was broken somewhere between b00d209241ff and 3541833fd1f2.
> >> 
> >> [    0.000000] cannot allocate crashkernel (size:0x20000000)
> >> 
> >> Where a good one looks like this,
> >> 
> >> [    0.000000] crashkernel reserved: 0x0000000008600000 - 0x0000000028600000 (512 MB)
> >> 
> >> Some commits look more suspicious than others.
> >> 
> >>      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
> >>      mm: introduce mm_[p4d|pud|pmd]_folded
> >>      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty  
> > 
> > The intent of these three patches is to add extra checks to the
> > pgtable_bytes accounting function. If applied incorrectly the expected
> > result would be warnings like this:
> >  BUG: non-zero pgtables_bytes on freeing mm: 16384
> > 
> > The change Linus worried about affects the __PAGETABLE_PxD_FOLDED defines.
> > These defines are used with #ifdef, #ifndef, and __is_defined() for the
> > new mm_p?d_folded() macros. I can not see how this would make a difference
> > for your iomem setup.
> >   
> >> # diff -u ../iomem.good.txt ../iomem.bad.txt 
> >> --- ../iomem.good.txt	2018-11-10 22:28:20.092614398 -0500
> >> +++ ../iomem.bad.txt	2018-11-10 20:39:54.930294479 -0500
> >> @@ -1,9 +1,8 @@
> >> 00000000-3965ffff : System RAM
> >>   00080000-018cffff : Kernel code
> >> -  018d0000-020affff : reserved
> >> -  020b0000-045affff : Kernel data
> >> -  08600000-285fffff : Crash kernel
> >> -  28730000-2d5affff : reserved
> >> +  018d0000-0762ffff : reserved
> >> +  07630000-09b2ffff : Kernel data
> >> +  231b0000-2802ffff : reserved
> >>   30ec0000-30ecffff : reserved
> >>   35660000-3965ffff : reserved
> >> 39660000-396fffff : reserved
> >> @@ -127,7 +126,7 @@
> >>   7c5200000-7c520ffff : 0004:48:00.0
> >> 1040000000-17fbffffff : System RAM
> >>   13fbfd0000-13fdfdffff : reserved
> >> -  16fba80000-17fbfdffff : reserved
> >> +  16fafd0000-17fbfdffff : reserved
> >>   17fbfe0000-17fbffffff : reserved
> >> 1800000000-1ffbffffff : System RAM
> >>   1bfbff0000-1bfdfeffff : reserved  
> > 
> > The easiest way to verify if the three commits have something to do with your
> > problem is to revert them and run your test. Can you do that please ?  
> Yes, you are right. Those commits have nothing to do with the problem. I should
> realized it earlier as those are virtual memory vs physical memory. Sorry for the
> nosie.
> 
> It turned out I made a wrong assumption that if kmemleak is disabled by default,
> there should be no memory reserved for kmemleak at all which is not the case.
> 
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=600000
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> 
> Even without kmemleak=on in the kernel cmdline, it still reserve early log memory
> which causes not enough memory for crashkernel.
> 
> Since there seems no way to turn kmemleak on later after boot, is there any
> reasons for the current behavior? 

Well seems like you do have CONFIG_DEBUG_KMEMLEAK=y in your config. The code
contains data structures for the case that you want to use the kmemleak checker.
The presence of these structures will change the sizes. The last commit in regard
to the 'early_log' buffer has been from 2009 with this change:

@@ -232,8 +232,9 @@ struct early_log {
 };
 
 /* early logging buffer and current position */
-static struct early_log early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE];
-static int crt_early_log;
+static struct early_log
+       early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE] __initdata;
+static int crt_early_log __initdata;
 
 static void kmemleak_disable(void);
 
The current behavior is imho nothing new.

Would it be possible to disable CONFIG_DEBUG_KMEMLEAK for your kdump kernel?
That seems like the simplest solution.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

