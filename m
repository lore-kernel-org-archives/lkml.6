Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D80C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281A121522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAG4WKcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281A121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbeIUI6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:58:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:58:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L3AAD4139560;
        Fri, 21 Sep 2018 03:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oNf6GCK/JcT3kDLIAzgtrz8wMYc3lphOyHqbHHFVRIA=;
 b=lAG4WKcUofcJ3klXea6nSdqKaxMhZ9qiDPJzBOe+IJDybqld8/+VYdNIHcyy0lCZASxB
 qFwUvcx4sCXix77S0UitHNjgKCoxtM7293rre0y4SP7i92jaQd/eHAmX0l3uwgqRk18X
 zMFy64T/45v1MHysHLHyW9e+Aq4XbVMxTHr0Mc91mwj3vPzZ3bz25Xh/HKoodVOhpZZP
 Usct65vkr7e7GrsW5smFSEnhcmdauDxfvizY7AfOJfu8WsWjCm8lmrZJd//xDNuBME9r
 t6D9lMmARYFzvJP5PfMrgki6iaLNLBZUi4+xxKxeSVXEtjSEQVPjIAUEgDOfNlH/2wAR rg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mmkm20r6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 03:12:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8L3C3eL024454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 03:12:03 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8L3C2uS029398;
        Fri, 21 Sep 2018 03:12:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 20:12:01 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Matthew Wilcox <matthew@wil.cx>, Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: advansys: Remove unnecessary parentheses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180920205858.6035-1-natechancellor@gmail.com>
Date:   Thu, 20 Sep 2018 23:11:59 -0400
In-Reply-To: <20180920205858.6035-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 20 Sep 2018 13:58:58 -0700")
Message-ID: <yq11s9nmtmo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
>
> drivers/scsi/advansys.c:6451:20: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>                                 if ((sdtr_data == 0xFF)) {
>                                      ~~~~~~~~~~^~~~~~~
> drivers/scsi/advansys.c:6451:20: note: remove extraneous parentheses
> around the comparison to silence this warning
>                                 if ((sdtr_data == 0xFF)) {
>                                     ~          ^      ~
> drivers/scsi/advansys.c:6451:20: note: use '=' to turn this equality
> comparison into an assignment
>                                 if ((sdtr_data == 0xFF)) {
>                                                ^~
>                                                =
> 1 warning generated.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
