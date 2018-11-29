Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D6EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632A020832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qecfrilS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632A020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeK2N4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:56:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2N4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:56:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2ifq8091539;
        Thu, 29 Nov 2018 02:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=99GSPiKsT1ePaQaJ18PEwVQ2A01zh/1VLhsmFRyeSc8=;
 b=qecfrilSPKhPb7SzxmO42yErIb5FyJp58xIultj4h/sRPWqJF7wBjo43xx4Y+QUJ2nMs
 W5ndq+2QCAK05wwJ9NO9jO5pyNDVnDmkTPGT7NyxK7eyOeSi0gEFsMYSM3Go2oXIwnpV
 P2cMKAd/rzhlZliV9rH9kDlEsl0pVjpGZPsCFQq6/35A6e3dcXscg0f48x1B5RESE2po
 vYlDE77ujW2rCli378r4v6Kpyrpx8n26gPE7OQpI2CLAYN2KZi0BksUd14KEOguwrcSK
 T5ne5WjX9bDpmBdUTM67ww9XTrTNotHWR9kbWejN+uLSuO0FEbbHNAYWH8iismQoNbtC OA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkqnpg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:52:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2q1eZ026094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:52:01 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAT2q03d023815;
        Thu, 29 Nov 2018 02:52:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:52:00 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/41] scsi: megaraid_sas_fusion: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <5fceeac101cc3dfe4a129764a139c1b616cba292.1543374820.git.gustavo@embeddedor.com>
Date:   Wed, 28 Nov 2018 21:51:58 -0500
In-Reply-To: <5fceeac101cc3dfe4a129764a139c1b616cba292.1543374820.git.gustavo@embeddedor.com>
        (Gustavo A. R. Silva's message of "Tue, 27 Nov 2018 22:32:34 -0600")
Message-ID: <yq1y39cy4s1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=683
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo A.,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that, in this particular case, I replaced "Fall thru" with a
> "Fall through" annotation and added a dash as a token in order to
> separate the "Fall through" annotation from the rest of the comment
> on the same line, which is what GCC is expecting to find.

Applied to 4.21/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
