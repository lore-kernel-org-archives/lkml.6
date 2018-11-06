Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68846C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2260120818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p/Mr814b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2260120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeKFNLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:11:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKFNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:11:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA63iGPN014395;
        Tue, 6 Nov 2018 03:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cPzXZVvUSW9MF1UCs8Mh1WcsnwzEFZLL+THF3UO7Zak=;
 b=p/Mr814bc0l3hA6sfTsFifRB9a/J+aEYFTOImeSpe3PeHgw3prtlBacndvNXoWPeJzd5
 pZEQgx95RXeJvUhFLknszkEqOvyqpJjktfmvEQ5G6yoErOlSzfBzjsQpbC6Wc23dhAAk
 hJDof7e2gwwXd9wBquaJUjmEe3+eJWzrbZ5voYfUaOEhF+zaGs3aXtowtRKH2MCxSXkh
 M6kKvHlnqGqZL6PIyW+g5GxskMlwHSaYVudBwyQBovySc1ocVWWEwTXr3b2kkqQ+xAhz
 zROTKEUH6L11CIVKhyvq3Q1z0VLrzSEdtIEn652oIQKZ8ncMZsQe3/4dPmRj3HTkuC2H Fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33ttt5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 03:48:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA63mVpm018161
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 03:48:31 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA63mUvw032695;
        Tue, 6 Nov 2018 03:48:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 19:48:30 -0800
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NCR5380: Return false instead of NULL
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <2e765651c37d951fb424eb966e1a91ff08c8391b.1540367133.git.fthain@telegraphics.com.au>
Date:   Mon, 05 Nov 2018 22:48:27 -0500
In-Reply-To: <2e765651c37d951fb424eb966e1a91ff08c8391b.1540367133.git.fthain@telegraphics.com.au>
        (Finn Thain's message of "Wed, 24 Oct 2018 18:45:33 +1100")
Message-ID: <yq1r2fy6f3o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> I overlooked this statement when I recently converted the function result
> type from struct scsi_cmnd * to bool. No change to object code.

Applied to 4.20/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
