Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79776C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F00217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCmHEH2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfB0OeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:34:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50256 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfB0OeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:34:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1RESxWg120936;
        Wed, 27 Feb 2019 14:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=OShQuXTENS7iMQaPTLnE/0eVP72WuNnkWWFYiKcwFjQ=;
 b=hCmHEH2MA/rZIDjstNIeoc0enqApsPe0DINQedD5DngeH10pDnqZhz1z7ClmA9K7zTDM
 XROM/QF8Kp5/wKl4U9ag6vhxAxuaF9FOotizFCLKWskw3VPKqpY8L9NBzpJm6HPNpsXN
 YkJaLfy89qaJyNm93w+QS55Ai8MROnG7oFROi5vjxaEy2+I680wPqK2lQu6Nqs/HuVch
 0JTvN0ZAhetY0Nu6LVTijOgCTgc5ihDGuJywyvkgzI7wCTrNLFtOL5vD++vQI2pc3FW2
 HBW3o7rHWs6E1tnxZshO6YuiIvTlVMpm/g2NOVdu2d90kOsRsTlmjA7A0ixZ8eO8ddLT mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qtupebccq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:33:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1REXr8f008032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:33:53 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1REXomv024964;
        Wed, 27 Feb 2019 14:33:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 06:33:50 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: aacraid: Fix missing break in switch statement
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190215214242.GA8393@embeddedor>
Date:   Wed, 27 Feb 2019 09:33:47 -0500
In-Reply-To: <20190215214242.GA8393@embeddedor> (Gustavo A. R. Silva's message
        of "Fri, 15 Feb 2019 15:42:42 -0600")
Message-ID: <yq1pnrd9u7o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=633 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Add missing break statement and fix identation issue.

So much bad indentation in this driver. Tried various tab widths and it
is still all over the place.

Anyway. After staring at the firmware header I have convinced myself
that your fix is correct. Applied to 5.1/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
