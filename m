Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03144208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03144208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeKKVYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:24:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbeKKVYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:24:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABBSods105059
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 06:36:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdv7awww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 06:36:02 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Sun, 11 Nov 2018 11:36:00 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 11:35:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABBZt5Q65601670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 11:35:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4E864C044;
        Sun, 11 Nov 2018 11:35:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F334C040;
        Sun, 11 Nov 2018 11:35:55 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.75.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 11:35:55 +0000 (GMT)
Date:   Sun, 11 Nov 2018 12:35:53 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: crashkernel=512M is no longer working on this aarch64 server
In-Reply-To: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
References: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18111111-0020-0000-0000-000002E63B2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111111-0021-0000-0000-000021353CB0
Message-Id: <20181111123553.3a35a15c@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=783 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2018 23:41:34 -0500
Qian Cai <cai@gmx.us> wrote:

> It was broken somewhere between b00d209241ff and 3541833fd1f2.
> 
> [    0.000000] cannot allocate crashkernel (size:0x20000000)
> 
> Where a good one looks like this,
> 
> [    0.000000] crashkernel reserved: 0x0000000008600000 - 0x0000000028600000 (512 MB)
> 
> Some commits look more suspicious than others.
> 
>       mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
>       mm: introduce mm_[p4d|pud|pmd]_folded
>       mm: make the __PAGETABLE_PxD_FOLDED defines non-empty

The intent of these three patches is to add extra checks to the
pgtable_bytes accounting function. If applied incorrectly the expected
result would be warnings like this:
  BUG: non-zero pgtables_bytes on freeing mm: 16384

The change Linus worried about affects the __PAGETABLE_PxD_FOLDED defines.
These defines are used with #ifdef, #ifndef, and __is_defined() for the
new mm_p?d_folded() macros. I can not see how this would make a difference
for your iomem setup.

> # diff -u ../iomem.good.txt ../iomem.bad.txt 
> --- ../iomem.good.txt	2018-11-10 22:28:20.092614398 -0500
> +++ ../iomem.bad.txt	2018-11-10 20:39:54.930294479 -0500
> @@ -1,9 +1,8 @@
>  00000000-3965ffff : System RAM
>    00080000-018cffff : Kernel code
> -  018d0000-020affff : reserved
> -  020b0000-045affff : Kernel data
> -  08600000-285fffff : Crash kernel
> -  28730000-2d5affff : reserved
> +  018d0000-0762ffff : reserved
> +  07630000-09b2ffff : Kernel data
> +  231b0000-2802ffff : reserved
>    30ec0000-30ecffff : reserved
>    35660000-3965ffff : reserved
>  39660000-396fffff : reserved
> @@ -127,7 +126,7 @@
>    7c5200000-7c520ffff : 0004:48:00.0
>  1040000000-17fbffffff : System RAM
>    13fbfd0000-13fdfdffff : reserved
> -  16fba80000-17fbfdffff : reserved
> +  16fafd0000-17fbfdffff : reserved
>    17fbfe0000-17fbffffff : reserved
>  1800000000-1ffbffffff : System RAM
>    1bfbff0000-1bfdfeffff : reserved

The easiest way to verify if the three commits have something to do with your
problem is to revert them and run your test. Can you do that please ?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

