Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC051C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43F2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7chWmjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfA2Fba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:31:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2Fba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:31:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T5OULo040173;
        Tue, 29 Jan 2019 05:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=IE6pz2KTjBXyRHRzxXGPCB80cdVP2rDX+hxYyXjdFUU=;
 b=R7chWmjvRnWbadyMSh/pxXXbxpvioYRyzZEwii/MDRo5o/HZHhZdTqJHjr9AdM8NVxFY
 HsR5WreDPso/qBRrhGD9wyeKwtv+XAT35zRjSp5DVe3F+sgJgC7HDdpvJAeXqHfDi3rq
 96L/m+C0UMxyYNClvjK5/rW1uTr0Mf0P9+eFhWJRjU52RiTPqJQirNV9pj0gb+T7D3mJ
 7d43EbQ3csnwQaN+y3KC4UlXz8E4vV3i26gnt/HvezvHw4VkZy8x+I9qYT866glXw2dc
 T89rliSBy1w1IeJ0CVLxyUaq2YP7ODhuFTgLdnbTg+BoRPGdoJ37ie6e0W9gD22QSO2x aQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2e2c5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:31:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5VK38032528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:31:20 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5VKVO006875;
        Tue, 29 Jan 2019 05:31:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 21:31:19 -0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] SCSI: fcoe: remove unneeded fcoe_ctlr_destroy_store export
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190122142818.GC18225@kroah.com>
Date:   Tue, 29 Jan 2019 00:31:17 -0500
In-Reply-To: <20190122142818.GC18225@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 22 Jan 2019 15:28:18 +0100")
Message-ID: <yq18sz4f2sa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> There's no need to export fcoe_ctlr_destroy_store as a symbol, so remove
> the EXPORT_SYMBOL() line for it.

Applied to 5.1/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
