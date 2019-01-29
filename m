Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F851C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BE22148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="orvN8M0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfA2Faf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:30:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2Fae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:30:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T5NtsS055703;
        Tue, 29 Jan 2019 05:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=c47iu4RThyU5VHlKfGMrS5jK+0YKaRFQBOIVCj2zRA4=;
 b=orvN8M0Yr65Uji3gerTe8kGuFiAUzDPrum1n0ARhSR8rf8pwoxcbLpLHFjfUsiJrpZz9
 qSLldKC3envo210Yw+BG96te5btSK18rhWCeFMGMqA/ZpDRfGTdeer43EufSOXLFxyM9
 HzCDwxQJphKAh3MTtwS+/VKWRTEAwLrbnuzfVS9a7ydk+f6hlWEBuCKq9gGWFKypFy60
 /NiwnhlZbCEBLsrnQ/AVl1LvXddbyLPVQiK7tPQ32uHhqC7Qsh4Qepoz9nPoNR6pCE8R
 /qY80uj9Dkc1vkOzIjdIK+7S7IGE516LlvbozgGQKMxJuqwTeWoM0B5DfR3FG9U5CHwT ug== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q8g6r2329-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:30:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0T5UEqE027730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 05:30:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T5UDP2028475;
        Tue, 29 Jan 2019 05:30:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 21:30:13 -0800
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] SCSI: fcoe: convert to use BUS_ATTR_WO
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190122142735.GB18225@kroah.com>
Date:   Tue, 29 Jan 2019 00:30:10 -0500
In-Reply-To: <20190122142735.GB18225@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 22 Jan 2019 15:27:35 +0100")
Message-ID: <yq1d0ogf2u5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

> We are trying to get rid of BUS_ATTR() and the usage of that in the
> fcoe driver can be trivially converted to use BUS_ATTR_WO(), so use
> that instead.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
