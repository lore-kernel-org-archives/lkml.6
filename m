Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366CC218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WrVlcC8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeLUAsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:48:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeLUAso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:48:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBL0iO1A072383;
        Fri, 21 Dec 2018 00:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=iM5MNNaEfcLYbBagwz8Nqm3mOBjzZMlGD4Kmt0kgBbs=;
 b=WrVlcC8RC6eVMa712lwdWe/WWOBrO4LEkSUlxCKxxxKn66j2j2guGco7XTo1jSLMpwhV
 +orudSQ09Y2lLjVXJKGO59QC5whEf9ZYU6ZS6q60YDXYWVoaZZOmyvJh6DwfNegqXyQg
 AImCcr2delbOMyXpQ524GflHnpVj1wfz52nP9Qo9NuNuO5YUdBVeRyorNfoQHVCg2sLr
 RyE68R+pSTAeurRzUl6yB4zXE27LvF5GFZ+zz7spfABe0mVtjGWjy0lEZUDo8H4LAypn
 8eJHSIK87KVhA1x1WLKlxgBG17q2endjBeI7zFKL3bLw9FKDuIsoItaFOBuQkXGltjLo zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pfn200v9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:48:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0mT9O025678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:48:29 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBL0mSLj030570;
        Fri, 21 Dec 2018 00:48:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 16:48:28 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: mpt3sas_scsih: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181220154353.GA17873@embeddedor>
Date:   Thu, 20 Dec 2018 19:48:25 -0500
In-Reply-To: <20181220154353.GA17873@embeddedor> (Gustavo A. R. Silva's
        message of "Thu, 20 Dec 2018 09:43:53 -0600")
Message-ID: <yq1zhszbt7q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=637
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo A.,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied to 4.21/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
