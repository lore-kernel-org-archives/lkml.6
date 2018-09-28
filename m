Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B48C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7492173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBi43fHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7492173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeI1Mw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:52:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53476 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1Mw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:52:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8S6TEI9135526;
        Fri, 28 Sep 2018 06:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cectg9FtSg1IQqudEUGPs+uRGBaavB6jA5Rv8Xv9W2M=;
 b=hBi43fHvFxxfIANqZYT3/foNF7O0N0wWyWJ7VPuaLVnxsjkpry7T6SoBu4egvgJYjwDS
 YNXoNoZ2xLNLoQnyl7vlNx80WoyaPuZAYRPnDGfVhbin9bm9/5gWhnkkCiu+Xvkfqu07
 VcQykdA/4TG2nqqdV2xWfeIIr/JLge+rw3b5WM87gDujMOmoahDMKS63MRLsPhfTepAC
 ebypMdJBQvj2ZYUMCFlGIZUCvWUsU5TJIHWP4BfV9I9buQLY0i0KU7caRDZ/BSBHlljG
 N+z31iCJOPvJn8JYvKPLnDkRKtZ95avj4hXvaa4Mm5G0u6iJtik7FoxlCr//cMTsgZQj 9g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mnd5tx32v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 06:29:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8S6TI8f031577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 06:29:18 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8S6TGmS007971;
        Fri, 28 Sep 2018 06:29:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 23:29:16 -0700
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] NCR5380: Various improvements
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1538011031.git.fthain@telegraphics.com.au>
Date:   Fri, 28 Sep 2018 02:29:13 -0400
In-Reply-To: <cover.1538011031.git.fthain@telegraphics.com.au> (Finn Thain's
        message of "Thu, 27 Sep 2018 11:17:11 +1000")
Message-ID: <yq1h8iab0ee.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=523
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> This series addresses issues which became apparent when Michael
> Schmitz tried to use an AztecMonster II SATA/SCSI adapter with a 5380
> host.
>
> That target seems to have some bugs which thoroughly exercise driver
> error paths and EH.
>
> The patch by Hannes Reinecke was cherry-picked from his 'eh-reset.v5'
> branch.

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
