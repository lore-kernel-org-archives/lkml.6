Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DCDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD45720851
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y4WilMOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfALCjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:39:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:39:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C2YeVw144447;
        Sat, 12 Jan 2019 02:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MER7wJ9kJYukArBOvRGOG//8rMoMZftyhEg2uPRiogM=;
 b=y4WilMOgoz/WCSuG7c0ZmTqn0I2qHQ/PIPIZUrvxWspiBIThfMDgy3G3qiFvSDujozmU
 M3NuQ5UHlUjpCvN7/rm/Kq59/+qHvj40uhRke9j1w4ti4Htd1K3xmcD/qlno1NXO6U/F
 cg/KV8mUcRFvzV3oytxW7vAoz80dbX4OKRopgUgKExNr2R55jPU53d0duAJg4PJeXa4m
 RHnLDvXJfb0xaAKtcytBfEgPRkwauK/XzUCvP45DoLOO5+yS21kiRQ3fZqYxIPvCfW6p
 S04qyPgTnAzqYA5fWtL3ljuig586UHB/b1K8hUGjbOFElMLqEdxaIolRtR+j3VtDELit 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ptm0uqsw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:39:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0C2dGnx028181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:39:17 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0C2dGIq032415;
        Sat, 12 Jan 2019 02:39:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 18:39:16 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: hisi_sas: Set protection parameters prior to adding SCSI host
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1547127161-213124-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 11 Jan 2019 21:39:13 -0500
In-Reply-To: <1547127161-213124-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 10 Jan 2019 21:32:41 +0800")
Message-ID: <yq1h8eey4z2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Currently we set the protection parameters after calling scsi_add_host()
> for v3 hw.
>
> They should be set beforehand, so make this change.

Applied to 5.0/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
