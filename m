Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D254BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47F020700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390844AbfBRRB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:01:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731758AbfBRRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:01:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IGuvFt024598
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:01:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qqy19dsg5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:01:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 18 Feb 2019 17:01:51 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 17:01:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IH1lwA57278702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 17:01:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A77D04C050;
        Mon, 18 Feb 2019 17:01:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CB404C044;
        Mon, 18 Feb 2019 17:01:47 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 17:01:47 +0000 (GMT)
Date:   Mon, 18 Feb 2019 18:01:46 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/setup: fix early warning messages
In-Reply-To: <20190218154640.GA27699@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19021817-0028-0000-0000-00000349FB15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021817-0029-0000-0000-000024083407
Message-Id: <20190218180146.79930fe6@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=692 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 07:46:40 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
> > The setup_lowcore() function creates a new prefix page for the boot CPU.
> > The PSW mask for the system_call, external interrupt, i/o interrupt and
> > the program check handler have the DAT bit set in this new prefix page.
> > 
> > At the time setup_lowcore is called the system still runs without virtual
> > address translation, the paging_init() function creates the kernel page
> > table and loads the CR13 with the kernel ASCE.
> > 
> > Any code between setup_lowcore() and the end of paging_init() that has
> > a BUG or WARN statement will create a program check that can not be
> > handled correctly as there is no kernel page table yet.
> > 
> > To allow early WARN statements initially setup the lowcore with DAT off
> > and set the DAT bit only after paging_init() has completed.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>  
> 
> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> Reverting the patch fixes the problem. Crash log and bisect results below.

Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
with 4K mapping where the prefix page is mapped to absolute zero.

Just using S390_lowcore instead of lowcore_ptr[0] does not work either
because low-address protection is already active. I'll think of something.

Thanks for bug report!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

