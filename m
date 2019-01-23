Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5873FC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A33217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQr+Yg4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfAWCmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:42:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40098 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfAWCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:42:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N2cqPc104858;
        Wed, 23 Jan 2019 02:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=geVVHhEihPR/L/13pCGWXVs75306oM5YI8dQfCs7vKk=;
 b=OQr+Yg4aRLHoQjFerrM9wXIMUgZKm2EuwoiD9O/nnj9eCv/APea0eWQumjz5PUFP14D5
 z9HUB55FY4030vfkeJsW4RWzuxK6bcs2rQoB9ymCt1tyuJ5dBvzXl4z0dpdFUmeu5JBe
 mzmisHmWzl6wNJmj89dtgzQGlamr6HtmV22HHO4Mz2Z6/Tf58a+10wTrJUIGh2BNp2y3
 TnuFYiK393laNhbBhgsZQqTSz0vpagNWQmf+FeGy0Ouk4g9hhc4645S5RcHSiTtug7P8
 JQlPcPNLdY0sa0S0yNOShHcOCQuBiIYYjq1GRQJUJeJSUjxosYBmJZj/MUy9K6xY3lz/ AQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdefcqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 02:42:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0N2g2VQ026022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 02:42:02 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0N2fxRr017446;
        Wed, 23 Jan 2019 02:42:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 18:41:59 -0800
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Subject: Re: [PATCH v2 0/3] scsi: arcmsr: Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1547779645.4532.9.camel@Centos6.3-64>
Date:   Tue, 22 Jan 2019 21:41:56 -0500
In-Reply-To: <1547779645.4532.9.camel@Centos6.3-64> (Ching Huang's message of
        "Fri, 18 Jan 2019 10:47:25 +0800")
Message-ID: <yq136pkm6x7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=668
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ching,

> This patch series are against to mkp's 5.1/scsi-queue.

Applied to 5.1/scsi-queue. Thank you.

PS. Your file permissions are odd. I always have to change your diffs
from 755 to 644 before applying.

-- 
Martin K. Petersen	Oracle Linux Engineering
