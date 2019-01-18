Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1544C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC5D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfARJWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:22:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfARJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:22:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I9JhmB079408
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 04:22:42 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q3c18g6vk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 04:22:42 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 18 Jan 2019 09:22:40 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 09:22:37 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I9Maio63504616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 09:22:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B431AA4060;
        Fri, 18 Jan 2019 09:22:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8040EA4054;
        Fri, 18 Jan 2019 09:22:36 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Jan 2019 09:22:36 +0000 (GMT)
Date:   Fri, 18 Jan 2019 10:22:35 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] s390: make thin archives not directly depend on
 *.o.chkbss files
References: <1547719364-18849-1-git-send-email-yamada.masahiro@socionext.com>
 <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1547719364-18849-2-git-send-email-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19011809-0008-0000-0000-000002B2B5C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011809-0009-0000-0000-0000221ED60B
Message-Id: <20190118092235.GB4160@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=795 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 07:02:42PM +0900, Masahiro Yamada wrote:
> When I was refactoring cmd_ar_builtin in scripts/Makefile.build,
> I noticed the build breakage of s390.
> 
> Some Makefiles of s390 add extra dependencies to built-in.a;
> built-in.a depends on timestamp files *.o.chkbss, but $(AR) does
> not want to include them into built-in.a.
> 
> Insert a phony target 'chkbss' in between so that $(AR) can take
> $(filter-out $(PHONY), $^) as input.
> 
> While I was here, I refactored Makefile.chkbss a little bit.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> I want Acked-by from a s390 maintainer so this series can go
> into kbuild tree.
> 
> Changes in v2:
>  - New patch
> 
>  arch/s390/boot/Makefile            |  4 ++--
>  arch/s390/boot/compressed/Makefile |  4 ++--
>  arch/s390/scripts/Makefile.chkbss  | 25 +++++++++++--------------
>  3 files changed, 15 insertions(+), 18 deletions(-)

Tested and still seems to work like before.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

