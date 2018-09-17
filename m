Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D88BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FA8214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wiCQgw3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FA8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeIQL7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:59:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42592 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeIQL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:59:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H6TM9t042226;
        Mon, 17 Sep 2018 06:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RL7JpkFnbbs1AWxXVmtYVptDZDV5d/CCoIdBmw97owY=;
 b=wiCQgw3Cm2Ig4UKRHyMTkKQZck6oGk2sNDb5OP9KyayH16DwahdEx7TJyG05w3oj0MGP
 gQBBzd5ae0oYStT+z5/ALs/EFRScwbBmDWb2noebTxoim/NuznMzENOiygdVK5pvYsdc
 mgV45VoZrPd1GR+xRr+pAt1Fnhxx6JOb6DKVRiVZsTa2McW4UOEPGCsXQzDx8/KqM411
 QePawH1IkGk1VnSDbkgaHY/NOBCa4XAN+0958+IfrCo8rV61g9BNVwPdbqbSwuIBhq+o
 hbXzCsZvJUUBPZe7MOlURED4CLCvwoxTHV8GdUyd9J61HDFGPsiujJnqMQjU+vcxBZMs Ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mgtqqm3mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:33:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6X6vI032552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:33:08 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6X5SN029757;
        Mon, 17 Sep 2018 06:33:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 23:33:05 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bvanassche@acm.org>,
        target-devel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: iscsi: target: fix spelling mistake "entires" -> "entries"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180914122808.5447-1-colin.king@canonical.com>
Date:   Mon, 17 Sep 2018 02:33:03 -0400
In-Reply-To: <20180914122808.5447-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 14 Sep 2018 13:28:08 +0100")
Message-ID: <yq1y3c0skf4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=570
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Trivial fix to spelling mistake in function name and comment

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
