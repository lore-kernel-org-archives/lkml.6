Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D051C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8F421A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8F421A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbeHFP0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729660AbeHFP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76DEALo111137
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 09:17:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kpnxxu1kf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:17:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 14:17:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 14:17:43 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76DHgo833423488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 13:17:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D16152059;
        Mon,  6 Aug 2018 16:17:51 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B8A5D52050;
        Mon,  6 Aug 2018 16:17:50 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:17:41 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/4] ftrace build improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 18080613-0008-0000-0000-0000025DAFD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080613-0009-0000-0000-000021C45FF8
Message-Id: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=521 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for -fentry -mrecord-mcount and -mnop-mcount has been added for
s390 in gcc master branch. An attempt to build 4.18 for s390 with that
gcc would produce a kernel with no __mcount_loc though because of the
new condition in scripts/Makefile.build:210 which disables recordmcount
tool if compiler supports -mrecord-mcount (s390 relies on combination
of -mhotpatch=0,3 gcc flag and recordmcount.pl).

This patch series adds s390 ftrace support based on combination of -pg
-fentry -mrecord-mcount and -mnop-mcount gcc flags (that fixes issue
mentioned above). At the same time this patch series fixes couple of
minor issues and adds -mnop-mcount gcc flag support (utilized by s390).

Vasily Gorbik (4):
  trace: handle CC_FLAGS_FTRACE more accurately
  trace: avoid calling cc-option -mrecord-mcount for every Makefile
  trace: add -mcount-nop option support
  s390/ftrace: add -mfentry and -mnop-mcount support

 Makefile                       | 24 ++++++++++++++++++++----
 arch/s390/Kconfig              |  2 ++
 arch/s390/Makefile             | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h |  6 +++---
 arch/s390/kernel/ftrace.c      |  2 +-
 arch/s390/kernel/mcount.S      |  2 +-
 kernel/trace/Kconfig           |  5 +++++
 kernel/trace/ftrace.c          |  2 ++
 scripts/Makefile.build         |  9 +++------
 9 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.18.0.13.gd42ae10

