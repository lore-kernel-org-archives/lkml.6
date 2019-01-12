Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BD920851
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qB7bjFpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfALDPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:15:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37258 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfALDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:15:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C34CnN111616;
        Sat, 12 Jan 2019 03:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=c4FGsLbWobkNJDDj3vXlXdEn3jsUbIzWyEcoSQVw3U4=;
 b=qB7bjFpakzAwbtHQnNOxsj7LHKmVWXLZPzPzyGHN7K1l+mFxGwoIZZxc+KPApYHNPHOL
 Z2MuJBBh62LCV18sCNCilTm7XyU7M/xWpJmsS2hmgjSNt3GoQcl6sfHBMSqgIpUON6iN
 ACuJpJakjUE+va7K1NDG+e/47po8ZWtIZbcAz8+DjqPnjrmyLjlzYccepK2X1KJXGj6B
 4BaxSiVfm3G9lLphV+oWLz/xEkO6gyO6Lmp3yLhE80kA/B+3SaXplHEqZgqVBj8cJR+7
 IHRhBuNt29TZYTiJP64I/Noz7o132H6KX869zeO3UwT/jUTODp6NJITXihdY6LrfV9EK XQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2py5rdr68g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:15:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0C3FRde013275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 03:15:27 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0C3FQiD031950;
        Sat, 12 Jan 2019 03:15:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 19:15:25 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] libsas: SATA PHY connection rate matching during disovery
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1546617688-240623-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 11 Jan 2019 22:15:23 -0500
In-Reply-To: <1546617688-240623-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Sat, 5 Jan 2019 00:01:25 +0800")
Message-ID: <yq1h8eewoqc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset looks to resolve an issue we see whereby a SATA end device
> negotiated linkrate may exceed the min linkrate to the initiator, and
> not be able to establish a connection.

Looks good to me. Applied to 5.1/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
