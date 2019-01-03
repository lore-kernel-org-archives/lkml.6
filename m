Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB95A2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfACHhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:37:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbfACHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:37:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x037Xvas038387
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 02:37:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2psdtngp2p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 02:36:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 3 Jan 2019 07:36:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 07:36:55 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x037asvY37683312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 07:36:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E96D4C04A;
        Thu,  3 Jan 2019 07:36:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43EC24C046;
        Thu,  3 Jan 2019 07:36:54 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Jan 2019 07:36:54 +0000 (GMT)
Date:   Thu, 3 Jan 2019 08:36:52 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] kbuild: use assignment instead of define ... endef for
 filechk_* rules
References: <1546478214-20394-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1546478214-20394-1-git-send-email-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19010307-0016-0000-0000-0000023EDB57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010307-0017-0000-0000-00003297E2DF
Message-Id: <20190103073652.GA3957@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=636 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:16:54AM +0900, Masahiro Yamada wrote:
> You do not have to use define ... endef for filechk_* rules.
> 
> For simple cases, the use of assignment looks cleaner, IMHO.
> 
> I updated the usage for scripts/Kbuild.include in case somebody
> misunderstands the 'define ... endif' is the requirement.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Kbuild                             |  4 +---
>  Makefile                           |  3 +--
>  arch/s390/kernel/syscalls/Makefile | 12 +++---------
>  arch/s390/tools/Makefile           |  7 ++-----
>  scripts/Kbuild.include             |  8 ++++----
>  scripts/kconfig/Makefile           |  4 +---
>  6 files changed, 12 insertions(+), 26 deletions(-)

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

