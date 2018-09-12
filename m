Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F6DC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D785920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSTlnGST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D785920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeILGF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILGF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:05:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8C0xKQC082915;
        Wed, 12 Sep 2018 01:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wmFgzW+enPU199HDPv4MpjNv8tEtjHZDfJHxGDFZpNk=;
 b=HSTlnGSTUukG48VnNtHgjusNvAFf2mvFC0rGTxke0fnXGSqFdIHb5JP1x4w1zxifFMZh
 5n0iXXzOEGzrGtRjR66PTX2t5mf2jUr+useS+deFkUUYAmSrZET2MY3qlfaCkvV6yYXK
 Yzqf55hbxYkIC6aw+M3lEgvGTP8j/zDrOlbNdnYjhOoIDjbeRVjdL9syKgDaTgQomCxz
 XYMAf6ezPnA0+HFGdUP+efTYpMNCdUyCF3Hx1sqsaRA21pmAELNP+/9vaIhmtJ39HB7i
 SSPCNLmUARDfRQJ7kBRPBzccJXZqlQMRLbz4yOP593b2+BpQbiAdjKNd9rK2kTymSKE+ cA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mc6cpq9wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 01:03:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8C13n6f027849
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 01:03:49 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8C13mpO018197;
        Wed, 12 Sep 2018 01:03:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 18:03:48 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aic7xxx: remove unused redundant variable num_chip_names
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180904143656.3504-1-colin.king@canonical.com>
Date:   Tue, 11 Sep 2018 21:03:45 -0400
In-Reply-To: <20180904143656.3504-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 4 Sep 2018 15:36:56 +0100")
Message-ID: <yq1bm93y1am.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=466
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable num_chip_names is defined but not used, hence it is
> redundant and can be removed.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
