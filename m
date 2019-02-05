Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F4C282DC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC812080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfBEMpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:45:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728835AbfBEMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:45:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CjTY6093000
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 07:45:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qfa601s6k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:45:38 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 5 Feb 2019 12:43:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 12:43:52 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15ChpHe7209464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 12:43:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E0511C054;
        Tue,  5 Feb 2019 12:43:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B5C011C04C;
        Tue,  5 Feb 2019 12:43:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Feb 2019 12:43:50 +0000 (GMT)
Date:   Tue, 5 Feb 2019 13:43:49 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19020512-0028-0000-0000-000003446D48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020512-0029-0000-0000-0000240275FE
Message-Id: <20190205124349.GA10167@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
> On 1/23/19 5:24 AM, Heiko Carstens wrote:
> >On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> >>There's a build failure with gcc9:
> >>
> >>  ./arch/s390/include/asm/jump_label.h: Assembler messages:
> >>  ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
> >>  ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
> >>  make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
...
> I've had to turn off s390 in Fedora until this gets fixed :(

Laura, the patch below should fix this (temporarily). If possible,
could you give it a try? It seems to work for me.

rom 4067027c2ccc8d3f1dc3bb19fe2d00da0c65bcd8 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 5 Feb 2019 13:21:56 +0100
Subject: [PATCH] s390: disable section anchors

Disable section anchors to allow to compile with the current gcc 9
experimental version. The section anchors is a new feature for s390
with gcc 9, however it breaks our current usage of the 'X' constraint
within the asm goto construct within our jump label implementation.

Fixing this seems to be non-trivial, therefore (hopefully) temporarily
disable section anchors. We will hopefully have a better solution
before gcc 9 is released, so that this can be removed again.

Reported-by: Laura Abbott <labbott@redhat.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e21053e5e0da..1eac75bc3a29 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -62,6 +62,14 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 #
 cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
 
+#
+# Disable section anchors. This gcc 9 feature currently breaks the 'X'
+# constraint like it is used in the asm goto construct.
+#
+ifeq ($(call cc-option-yn,-fno-section-anchors),y)
+cflags-y += -fno-section-anchors
+endif
+
 ifeq ($(call cc-option-yn,-mpacked-stack),y)
 cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
-- 
2.16.4

