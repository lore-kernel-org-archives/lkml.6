Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A57ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A3208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3pkYc0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8A3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbeGMDPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:15:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbeGMDPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:15:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CNrcng129314;
        Fri, 13 Jul 2018 03:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=o2kPQAZqxJhpE6DgICCJa219iuNUXiz7IfCVNn0+Dyo=;
 b=I3pkYc0r9peyM+kbTqfMoC/DfNPmnwEQwXip+uc+MKHQWjHn3P2MbNQTD4rujEp6bmnN
 KvpTYsEwuP+OlswP4LwGJlk1GEcYmlZ4I9WNa+ZfOujLskfB5qeph+2t5ClIYm0bCVm8
 kLEcqH4PlXFPpVNRwtmH03m1M3oEsWAtibhQOG+hC9HxXxD/FjO+CXazDj5aXMg2tmZK
 LmkFQE//TfyhDZfBONhzg7tAJXmtwoRhcn6CvAYWDMNeEaUSOEcKnccd9Kn5KAWQiWC5
 ZfAJz2r1fgCsdf7a10ltLCLwneRHnL5rw2TQCFctrNeOh0JXncqRG07zbo6gN6l/AuII +A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7e61ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 03:02:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6D32RPS013142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 03:02:28 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6D32QvH031172;
        Fri, 13 Jul 2018 03:02:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 20:02:26 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] snic: fix printing time intervals
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180711123752.773163-1-arnd@arndb.de>
Date:   Thu, 12 Jul 2018 23:02:23 -0400
In-Reply-To: <20180711123752.773163-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 11 Jul 2018 14:37:37 +0200")
Message-ID: <yq1a7qvj0sg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=402
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> We don't want to use 'struct timespec' because of the y2038 overflow
> problem. The overflow is not actually an issue here, but it's easy to
> replace with 'timespec64' for consistency. However, it's worth pointing
> out that nanosecond values have nine digits, not eight or ten, so I'm
> fixing the format strings accordingly as well.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
