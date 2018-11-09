Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD00C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CB62081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CB62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeKIXVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:21:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727784AbeKIXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:21:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA9DdbJ0043058
        for <linux-kernel@vger.kernel.org>; Fri, 9 Nov 2018 08:40:49 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nn991wu5c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:40:49 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 9 Nov 2018 13:40:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Nov 2018 13:40:44 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA9DehFU60358796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 13:40:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB0255204F;
        Fri,  9 Nov 2018 13:40:43 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A4C4152050;
        Fri,  9 Nov 2018 13:40:43 +0000 (GMT)
Date:   Fri, 9 Nov 2018 14:40:42 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: Re: [GIT PULL] s390 patches for 4.20 #2
In-Reply-To: <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
References: <20181109081402.777716d1@mschwideX1>
        <CAHk-=wj+HK7htwua62MnT9e_vsfgboiACR08MQDsXj9+4WQEBg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18110913-4275-0000-0000-000002DE5AD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110913-4276-0000-0000-000037EB5E0E
Message-Id: <20181109144042.4546b7ce@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 06:39:07 -0600
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Nov 9, 2018 at 1:14 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > s390 updates for 4.20-rc2  
> 
> Pulled.
> 
> >  - A fix for the pgtable_bytes misaccounting on s390. The patch changes
> >    common code part in regard to page table folding and adds extra
> >    checks to mm_[inc|dec]_nr_[pmds|puds].  
> 
> Ugh. This is somewhat invasive, I worry  that some header include or
> architecture doesn't pick up on the subtle __PAGETABLE_XYZ_FOLDED
> things (if you don't get the includes, the mm_xyz_folded() maros will
> be mis-defined.
> 
> Has this been in linux-next or any other wide testing? The changes
> aren't _new_, but...

Just checked linux-next, the first version that picked up the patches
is 2018-11-19. The one dated 2018-10-19 does not have them.

Bad timing, no wider testing has been done. The bug itself shows up
as a false warning, nothing really breaks. I would understand if you
prefer not to have them in the official tree at this time.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

