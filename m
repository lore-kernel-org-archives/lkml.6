Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEDECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C69F21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ssbQAqlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C69F21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJRJB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:01:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:01:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I0xR3f130069;
        Thu, 18 Oct 2018 01:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=0dg0tQKwnvt99m5OecLpdf56d/u+WEADm4oo3S1tyI8=;
 b=ssbQAqltorJfGJUaaujiyGWOLtQZXW56AUhfhqyD22a0BjnfvxbbJjhUUjAolRGaQnbk
 NghEmp1BxZgGwqxOkKCNo9twZej23Xki8QgnH7cXm4FnCVKSpJhMMTTYyjq7zg3GfNML
 rWog6CWGZqygL2Ee9aF8p6wP2qyIBPA5v38Tvjuk2AjZuhQTCTyYj123VE5FFWUsiazn
 M2tFnTZOPsnX61mCsdEGztkku06sMuy3TsMe4QeRKcD1ScoI+8NsD8iSKVDYGEbXiF/W
 ySl809Wxt6kRkHT+mb01xM+hCYGk+qC/X56f7hhPm+uQFfJAjw6+thWnVjhIgTW99yi8 ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n384uaag8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:02:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9I12T3u032093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:02:29 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9I12TAQ026407;
        Thu, 18 Oct 2018 01:02:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 18:02:29 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <willy@infradead.org>, <hare@suse.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] advansys: remove set but not used variable 'srb_tag' in adv_isr_callback
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181017123432.18304-1-yuehaibing@huawei.com>
Date:   Wed, 17 Oct 2018 21:02:26 -0400
In-Reply-To: <20181017123432.18304-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 17 Oct 2018 20:34:32 +0800")
Message-ID: <yq1pnw8kqxp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=576
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> drivers/scsi/advansys.c: In function 'adv_isr_callback':
> drivers/scsi/advansys.c:5952:6: warning:
>  variable 'srb_tag' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in
> commit 9c17c62aedb0 ("advansys: use shared host tag map for command lookup")

Applied to 4.20/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
