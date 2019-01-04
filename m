Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1277C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686E2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UfuA9nEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfADGHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:07:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55288 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:07:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045rkZ4110281;
        Fri, 4 Jan 2019 06:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RHL3SWzsVi5F6Z+jNmySTFECKp6sngfIWLKylbSnEd8=;
 b=UfuA9nEbXjkQUp7SMNz0mNKaP3y0Uw8zsJ86lDwfxocx5SCMsPAiZoTvtRRxwLkVOQJz
 Hc0zQXl6auPKWRVe6UiI7k3VTdy9Cgak52NwCyBaXPHCaxUCPD6Zm2ATtMr/FAZTms/0
 BSjh6Z8ZFOCyHCXJKLS4tfiefSW6qZ0qWFVX0szCb3YTp1dRiNViQoIlAqlHjbLRcESf
 0r74vdMvx+NjzHpsoD3xfiw8Rq3smPy9ililZXTUlqTAECn4D9OMzLape3OT3wmkuTIk
 AlEii+12fl+86/Y01Dj+dAZqfPG28zLrypWvXpYIhzSWhcfqDVCVl9k+oV790OHgfbyq ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pnxeeanut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:07:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0466vJF008191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:06:57 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0466vOh021774;
        Fri, 4 Jan 2019 06:06:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:06:57 -0800
To:     Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        James Smart <james.smart@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 28/41] scsi: lpfc: lpfc_sli: Mark expected switch fall-throughs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <cb80d182329a02971ff365446b0e04771fc77da8.1543374820.git.gustavo@embeddedor.com>
        <1a29b249-e248-d4ea-525e-e5f3efece00f@embeddedor.com>
        <CAGx+d6e+rCLjFEFCThgQwewod9Ni_wroV0cE_bceTXTFcsbe9A@mail.gmail.com>
Date:   Fri, 04 Jan 2019 01:06:54 -0500
In-Reply-To: <CAGx+d6e+rCLjFEFCThgQwewod9Ni_wroV0cE_bceTXTFcsbe9A@mail.gmail.com>
        (Dick Kennedy's message of "Wed, 2 Jan 2019 10:05:30 -0500")
Message-ID: <yq1a7kh6jnl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=603
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dick,

> Looks good.
> Ack

Applied to 4.21/scsi-fixes. Thanks, Gustavo.

-- 
Martin K. Petersen	Oracle Linux Engineering
