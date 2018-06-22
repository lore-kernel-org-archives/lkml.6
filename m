Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B42C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33AB23C78
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQgz2NFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33AB23C78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeFVC65 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:58:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934071AbeFVC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:58:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5M2sNx9092533;
        Fri, 22 Jun 2018 02:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=cYEa9uv7lMq/uoYV9Ul5EItBteRTTFO0jNg7zGW83LY=;
 b=IQgz2NFxKF5qyYczpCir8dFlkE9qLGx+c4aT2XCsttA/zb1NJi3jwCK1dPTIePJb/g29
 KSMSEFl/Vh5AZqfU/L9lF2nFhtOTH4Jd4YyGU5SKsjyOc2cbxAz/qbahbK4FJ/mzV1O1
 C4ypVVLjYMsYEVG5jW1Owp5vcbfE3FFfC5TPH3Ed4FeUXyX5ezlxOadKLrtupq4kuNfk
 jtSDaeTIz1V2Lfe94ET3x26PyPwEHPP3vr8FQhgZ52OPrqjZ9KRazgaDnYKAFC/SOQcN
 hY4uHpjSPeSSj65CPar53jNDJ4ixJBC5r7t86vVsN9BftzDlO2slCzLbNHM/UGbg2g/E Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jrp8hr7sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 02:58:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5M2wWJx031726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 02:58:32 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5M2wVY7008271;
        Fri, 22 Jun 2018 02:58:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 19:58:31 -0700
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, manoj@linux.vnet.ibm.com,
        mrochs@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: cxlflash: Change return type for fault handler
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180620182507.GA21775@jordon-HP-15-Notebook-PC>
Date:   Thu, 21 Jun 2018 22:58:28 -0400
In-Reply-To: <20180620182507.GA21775@jordon-HP-15-Notebook-PC> (Souptick
        Joarder's message of "Wed, 20 Jun 2018 23:55:07 +0530")
Message-ID: <yq1o9g3a5nv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=647
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Souptick,

> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.

Applied to 4.19/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
