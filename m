Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A954A21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uy7bcXt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfADFyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:54:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50714 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:54:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045rXsQ157267;
        Fri, 4 Jan 2019 05:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=o2lK/OvwVBOtTVbc2KTWkUsVg2IXA079LsYp/iSwQoo=;
 b=Uy7bcXt6eEC7dwTcRM/x1JVOP695ouy3UJv7f0HcAI1CJ8/F1nDO0EllYR8HAxd+5H5T
 0nl5NmHj27Fc77O2LCueuFwwoECia9evH/MeSYdH6eJd17OrhcLB1lUN6PXRQrRP3D2Z
 e7Q9ZQoNV4KJ/q78AwiX8hoelTt404CUoae4cICdC0CWUgE3DXdj/+2d3oiNULzvxTO/
 Z5vXGyveTKWp7pFLTgfJXcqg1l+VJG6z6vwRfTdgHZ1V2tEfv9l652122qLj8E+2Sm8h
 qXbq+8nW8UuZDNfzyeM3sN7zVbJqDDiulTj9wNN4CqGe8b4hrje+bMkfx4FdnjlTMeer 4A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pp0bu2hew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 05:54:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x045sekA023983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 05:54:40 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x045sdoI024989;
        Fri, 4 Jan 2019 05:54:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 21:54:39 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/8] hisi_sas: debugfs support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 04 Jan 2019 00:54:37 -0500
In-Reply-To: <1545235006-151716-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 19 Dec 2018 23:56:38 +0800")
Message-ID: <yq1wonl6k82.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=499
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset adds debugfs support for capturing driver state for
> particular times when the HW has malfunctioned (and we must reset the HW).
>
> Every controller HW version has had bugs. These bugs have been very
> painful to debug. One useful tool to debug these is being able to capture
> and export HW registers and driver control structures at point of failure.
>
> This feature has been maintained out-of-tree for some time, so add it now.

Applied to 4.22/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
