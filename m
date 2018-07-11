Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2991BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37A6208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OnXV6heU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37A6208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeGKC4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:56:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbeGKC4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:56:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6B2iMhd008811;
        Wed, 11 Jul 2018 02:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yFWzKHZWnfcDZN6pJt4bH5CTmJFGeVcEzkE9ruTZhXY=;
 b=OnXV6heUkj+MwDNaQTqAUON0GTH76lesAITNSZ//qNzaAEsi/r6bYzRrpqnHxiiPHuQB
 NPqgu8c/pWBRzj74LGQzpxKq6NGM8Lu6QFF5iwI89Az+VZ1OcwYlmEdvinOOdreT8+Et
 wmhNs4vuXHPiz6JaPeTOKtePZTwIlkdESngjjnXXfzR4Vhd/+rzjvPLH31BHnNxnHyNt
 GGmu5rijS7MVkJdS+uV7X31FgzBBFmw8c6vbgt32QO0t+Y4QXPzT3hGTPvUZyHhrxftb
 PoGWJTe/kEqP9qu+kkoNx4+tJJU8B8HFTb7ji46wC7cBb6cl4AzdNtFIrNx+SiEc7ggy 1Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k2p7vca7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:54:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6B2sXMS005688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:54:33 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6B2sWsa019252;
        Wed, 11 Jul 2018 02:54:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 19:54:32 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/2] Remove remainig MCR SCSI drivers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180706133349.28508-1-jthumshirn@suse.de>
Date:   Tue, 10 Jul 2018 22:54:30 -0400
In-Reply-To: <20180706133349.28508-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Fri, 6 Jul 2018 15:33:47 +0200")
Message-ID: <yq1muuyo521.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=332
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> MCR Support was ripped out of the kernel in 2012. I think 6 years
> later we can kill the remaining drivers which couldn't have been
> compiled since then.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
