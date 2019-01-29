Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62814C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DBA2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xGpLEMAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfA2GYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:24:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2GYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:24:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T6979i087473;
        Tue, 29 Jan 2019 06:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=PvW3AFDlj1/TicYVaN0zhPoPjXdiZIr2sF61879Oj/o=;
 b=xGpLEMAmT2wxXHD7LgNIP+ZmohEPU1TAy1phyXGDZvcFT8xxk85PXVZmDXzFgyf91lOr
 6BOJ5eTcPnNvZYS09VvWUEQrJiuynIUnXOjUHGsPNI/STQbUQEAC94FjaipXptDU0Lsk
 npI0DyAe3i0mbCZVzhAeK5KaiaQHVwK1UC/X2Ig9aXVBB1RhwluGejTNHdeb2rzsyrEn
 oRhj7QYGoUG2UNyCnT5e8janrNdC2/fkr+/ldOTwvL9qqxLUiR498cycsu7Qbn10JeMZ
 bfw5bBWKue3C35vRv2/AAt4/TaCRuMiiWl+idk8wFGeuZk65SeI8vPytcs+ZmkWd9s4b gw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q8g6r28ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:24:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6O531021611
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:24:05 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T6O4sk021652;
        Tue, 29 Jan 2019 06:24:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 22:24:03 -0800
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        esc.storagedev@microsemi.com, Hannes Reinecke <hare@suse.com>,
        linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: Re: [PATCH 0/2] scsi: trivial header search path fixups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Tue, 29 Jan 2019 01:24:01 -0500
In-Reply-To: <1548400144-22513-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Fri, 25 Jan 2019 16:09:02 +0900")
Message-ID: <yq15zu8dlry.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=526
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro,

> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
>
> Before that, I want to do as many treewide cleanups as possible.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
