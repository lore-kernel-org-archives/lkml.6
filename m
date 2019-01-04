Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB72C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C592070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HI5hkMD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfADGCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:02:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:02:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045sw2t157847;
        Fri, 4 Jan 2019 06:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=voBQmesZdOUKLP9Fz5cxScsO/iyTXASRfosoyjWFxNQ=;
 b=HI5hkMD4eD69Z4EEbsB6V5X5lJjjcQydz01XLyGJuHXGS5HDhAWb20fiGyJUBRRiShgC
 3I4r6TXTrNCKDI62T2Iyoatpn2tAl0gBxlmyvB0w4+PpV6/n4YruIu915zmRvVexpfyD
 diQVkmMaV348cc7s2W6b2qrgqJz0o1tTA/sS6xTuRv05QzcmoDUY1R1NmVBwTAyDTD8n
 l4EMaOf9oMy8PG7cZNjpOVy2K2TAmWDwBmg/eU1WgwzLsq7Y05sox7WWf3nnEgk/7/bF
 2gXpAExzUTjefSJvx2Dgu/F07/gW6mgc1EgbU51+/ts+TJvsPdmykqhJmkDXTQZqWeqx PQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pp0bu2jb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:02:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0462Ycf026010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:02:34 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0462XoN028915;
        Fri, 4 Jan 2019 06:02:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:02:33 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: smartpqi_init: fix boolean expression in pqi_device_remove_start
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190103164744.GA16360@embeddedor>
Date:   Fri, 04 Jan 2019 01:02:31 -0500
In-Reply-To: <20190103164744.GA16360@embeddedor> (Gustavo A. R. Silva's
        message of "Thu, 3 Jan 2019 10:47:44 -0600")
Message-ID: <yq1imz56juw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=637
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Fix boolean expression by using logical AND operator '&&' instead of
> bitwise operator '&'.

Applied to 4.21/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
