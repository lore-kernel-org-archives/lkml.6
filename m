Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600EECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C220644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNX/QXFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJRJin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:38:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37496 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeJRJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:38:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I1YjKZ105948;
        Thu, 18 Oct 2018 01:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Y1YyJhp9wkXtUnhdUft637QGu8iGCQgIJIg3amWWgRo=;
 b=CNX/QXFDIKpwTEchQJEh6x9ShDpwq6bpgaXw7RJyGLUbEVftgwIax3Mh7c1p+VfYlq89
 VLs68FnGHx8iMhxsgqwU9p8/AjAF5t02g9XFOL6UnXXYmw/QqROMI+NiYzLz5G4013fa
 8XxOwKZ7YBYEGne1H5j2rk+ZNq8whd2c4YKm4+07Pbs30CL+Y8drYIkKEuzAwopFzDnS
 Drou1+Rn3sh89W1BIdif+k8KUzh4aOyCJ/KkaDfVFQ3TurGdKHdVuo+i/nITYM+lbE+z
 tYkrcmEot4BMcmokFxfN2BKNtOyqqyrhHYysagK0B5zkcCLXraO9+q7Sl2yM6fx2pglS KQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brj2t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:40:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9I1e6Qu018187
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:40:06 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9I1e5Zs021232;
        Thu, 18 Oct 2018 01:40:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 18:40:05 -0700
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mac_esp, zorro_esp, esp_scsi: Various improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1539497520.git.fthain@telegraphics.com.au>
Date:   Wed, 17 Oct 2018 21:40:02 -0400
In-Reply-To: <cover.1539497520.git.fthain@telegraphics.com.au> (Finn Thain's
        message of "Sun, 14 Oct 2018 17:12:00 +1100")
Message-ID: <yq1h8hkkp71.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> This series has fixes and cleanup for mac_esp, zorro_esp and the core
> esp_scsi driver.
>
> These improvements include elimination of duplicated code temporarily
> introduced for zorro_esp.

Had to hand-apply patch #5. Otherwise OK.

Applied to 4.20/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
