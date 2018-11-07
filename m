Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3DCC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2624A20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CPGUgWVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbeKGLNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:13:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388644AbeKGLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:13:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA71ibxw103624;
        Wed, 7 Nov 2018 01:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6CU4J/8jFoTHGH+WoKKVhv1g2NQtVMAZioHGEmTTKJU=;
 b=CPGUgWVRCyTAGKy79hemqjfSUkOcf733pHT1ZrECCxPYEhuEsS8ZbNSUzug/KE54c8y7
 7T6YV/AZAawp50yOpWiGEY8Mypm5GAPmTqBjhU8dmegomoPgFrCAXgN8xjSQPeFjw+1a
 znl/RqViATzwyCd11AiZ/LTm28OpfPo6zwPX21ncI8fPsvr6a5QwlnExGTuzblBWVPBF
 ewes5tD23SvLwBGLqe8X63Gt5pRdsgmvXT44oBNwTKz2KhuwQ6BkBSAhaWGhjz+QOJKf
 FYWeGmMFwwN6JDGGPZ7is9rsHNsWgE4sFb9Bww43wmoslAYAjfBgFOBl+eBchJ3gNqOc 2A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33u0u6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 01:45:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA71jY62025629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 01:45:35 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA71jYTW001683;
        Wed, 7 Nov 2018 01:45:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 17:45:33 -0800
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [v1 0/2] mpt3sas: Add support to Aero controllers.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1540881316-13577-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Date:   Tue, 06 Nov 2018 20:45:31 -0500
In-Reply-To: <1540881316-13577-1-git-send-email-suganath-prabu.subramani@broadcom.com>
        (Suganath Prabu's message of "Tue, 30 Oct 2018 12:05:14 +0530")
Message-ID: <yq1sh0d3bk4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suganath,

> 1) Updated MPI headers to the latest version 2.6.7.
> 2) Added support for Aero/Sea controllers.

Applied to 4.21/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
