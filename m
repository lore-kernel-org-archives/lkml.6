Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8213DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D7217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfBRRVO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:21:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbfBRRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:21:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IHKAmo119458
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:21:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qqx03jn5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:21:11 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 18 Feb 2019 17:21:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 17:21:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IHL7RP10027116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 17:21:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41ECF42045;
        Mon, 18 Feb 2019 17:21:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111FC4203F;
        Mon, 18 Feb 2019 17:21:07 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 17:21:07 +0000 (GMT)
Date:   Mon, 18 Feb 2019 18:21:06 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/setup: fix early warning messages
In-Reply-To: <20190218180146.79930fe6@mschwideX1>
References: <20190218154640.GA27699@roeck-us.net>
        <20190218180146.79930fe6@mschwideX1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19021817-0016-0000-0000-00000257E0B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021817-0017-0000-0000-000032B2219E
Message-Id: <20190218182106.61b10ee4@mschwideX1>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 18:01:46 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 18 Feb 2019 07:46:40 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Hi,
> > 
> > On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:  
> > > The setup_lowcore() function creates a new prefix page for the boot CPU.
> > > The PSW mask for the system_call, external interrupt, i/o interrupt and
> > > the program check handler have the DAT bit set in this new prefix page.
> > > 
> > > At the time setup_lowcore is called the system still runs without virtual
> > > address translation, the paging_init() function creates the kernel page
> > > table and loads the CR13 with the kernel ASCE.
> > > 
> > > Any code between setup_lowcore() and the end of paging_init() that has
> > > a BUG or WARN statement will create a program check that can not be
> > > handled correctly as there is no kernel page table yet.
> > > 
> > > To allow early WARN statements initially setup the lowcore with DAT off
> > > and set the DAT bit only after paging_init() has completed.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>    
> > 
> > This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> > Reverting the patch fixes the problem. Crash log and bisect results below.  
> 
> Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> with 4K mapping where the prefix page is mapped to absolute zero.
> 
> Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> because low-address protection is already active. I'll think of something.
> 
> Thanks for bug report!
 
This patch should fix the problem:
--
From d4393e82c3ec9b2fe5dba4b0d1b6eef29f8d15c8 Mon Sep 17 00:00:00 2001
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 18 Feb 2019 18:10:08 +0100
Subject: [PATCH] s390/setup: fix boot crash for machine without EDAT-1

The fix to make WARN work in the early boot code created a problem
on older machines without EDAT-1. The setup_lowcore_dat_on function
uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
PSWs. That does not work if the kernel page table is set up with
4K pages as the prefix address maps to absolute zero.

To make this work the PSWs need to be changed with via address 0 in
form of the S390_lowcore definition.

Cc: stable@vger.kernel.org
Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/setup.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 65b22ef5141a..12934e8fbb91 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off(void)
 
 static void __init setup_lowcore_dat_on(void)
 {
-	struct lowcore *lc;
-
-	lc = lowcore_ptr[0];
-	lc->external_new_psw.mask |= PSW_MASK_DAT;
-	lc->svc_new_psw.mask |= PSW_MASK_DAT;
-	lc->program_new_psw.mask |= PSW_MASK_DAT;
-	lc->io_new_psw.mask |= PSW_MASK_DAT;
+	__ctl_clear_bit(0, 28);
+	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
+	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
+	__ctl_set_bit(0, 28);
 }
 
 static struct resource code_resource = {
-- 
2.16.4


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

