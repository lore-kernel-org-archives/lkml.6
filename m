Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE00C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434B62184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfAYIsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:48:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbfAYIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:48:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0P8cvFL078973
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:48:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q7w9nngba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:48:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 25 Jan 2019 08:48:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Jan 2019 08:48:00 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0P8lxuh3539282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 08:47:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDC1142047;
        Fri, 25 Jan 2019 08:47:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B56942045;
        Fri, 25 Jan 2019 08:47:59 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Jan 2019 08:47:59 +0000 (GMT)
Date:   Fri, 25 Jan 2019 09:47:58 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: hypfs: no need to check return value of
 debugfs_create functions
References: <20190122152151.16139-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-1-gregkh@linuxfoundation.org>
X-TM-AS-GCONF: 00
x-cbid: 19012508-0020-0000-0000-0000030B436F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012508-0021-0000-0000-0000215C86F2
Message-Id: <20190125084758.GB3561@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=765 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:00PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/hypfs/hypfs.h        |  6 +++---
>  arch/s390/hypfs/hypfs_dbfs.c   |  8 ++------
>  arch/s390/hypfs/hypfs_diag.c   |  9 ++++-----
>  arch/s390/hypfs/hypfs_diag0c.c |  3 ++-
>  arch/s390/hypfs/hypfs_sprp.c   |  6 +++---
>  arch/s390/hypfs/hypfs_vm.c     |  3 ++-
>  arch/s390/hypfs/inode.c        | 11 +++--------
>  7 files changed, 19 insertions(+), 27 deletions(-)

Applied, thanks!

