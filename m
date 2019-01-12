Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F992183F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSnaD9DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfALCw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:52:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALCw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:52:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0C2oZIZ103797;
        Sat, 12 Jan 2019 02:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nwDxYbDKFthJKsf1luKB32q+8lYYFHXylIEY76sXfjk=;
 b=YSnaD9DHySAPdv7a8z+rSLtYHC2UDAFSLhTvfBXyV4Oi1pkTregQB0gEDfnPXYPZiBma
 PJLIAhutKiDlqoKj1AkKacu4iFfTgVOdfqqxlH+ff7soytvbGScJEurrwwrJF2wDhJGy
 EyBEC6rn++BFN0NIWs6aP83bCSc7ntdKkdz8FYZEKzY2YFwYAsIRKvAOgF/t1c0m0YVl
 tk+FGuOgzG29X8x9QXlIllpuydBjDOen4A4YVc7/O4T1ApcCBr8IyrDJNuF8/RKCGTEQ
 qAlAwlYdssHtD5jfgEcoXd2K27LVyKwrJfRRgIKgVPXkrrKQIQmH0Vy07/r4h+vx6HAb Xw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2py5rdr579-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:52:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0C2qXka013789
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Jan 2019 02:52:34 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0C2qXpa023129;
        Sat, 12 Jan 2019 02:52:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jan 2019 18:52:33 -0800
To:     Hannes Reinecke <hare@suse.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/41] scsi: aic7xxx: aic79xx: mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <ff0ea78271abe136badebfbeba1d4373fb836bce.1543374820.git.gustavo@embeddedor.com>
        <1d73dbbd-7e8e-e5ba-6a0f-97fdd799d4c4@embeddedor.com>
        <a676a977-c55b-a0ce-1be3-b4d53ec68411@embeddedor.com>
        <a1c70e7c-5936-a094-7487-8b18318e6257@suse.com>
Date:   Fri, 11 Jan 2019 21:52:30 -0500
In-Reply-To: <a1c70e7c-5936-a094-7487-8b18318e6257@suse.com> (Hannes
        Reinecke's message of "Fri, 11 Jan 2019 08:42:23 +0100")
Message-ID: <yq1wonawpsh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9133 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=498
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901120021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hannes,

>> Friendly ping (second one):
>>
>> Who can ack/review/take this patch, please?

Applied to 5.1/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
