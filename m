Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53BF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCd+VtK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfAQKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:19:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:19:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0HAJ2VY133468;
        Thu, 17 Jan 2019 10:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=FdD+tfeB95Rqy4UfXmfRkY/80328GdayO5ZQelHfPHY=;
 b=oCd+VtK+UzT5Mm8ons8XKW9UVskFM5nIxvc7VlwE+JnHYumSXX7lWpEnI6uQMWFzlPXl
 uhXa7MrIbARWLAL3RZbnZHvUpeWNvi611iMbWCQBgO2BWD+bFd/CFW9otbvWTy9ywnQ4
 VuizWiyid+hNHQe5vwI60xCZBTU0z5p25eYBzt+dv+/gjQPSgczPdjW65IeCXUU/fHYU
 XKDOyO7cRFfBgg/UYgHtUEegrnDMR+90sH99YUgGv1Y8KD6jlemVFbKW0Vp4P2h+HcOG
 zkhdYl0xpcvAVQcHOkZ2PlgjRyL1aDHVuw8jdxMQ/PEkn1dSnarUfYm/AbHmya+HVAyZ Ww== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjny1p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 10:19:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0HAJbPM031189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 10:19:37 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0HAJaK9012213;
        Thu, 17 Jan 2019 10:19:36 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 02:19:36 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm/page_alloc: check return value of
 memblock_alloc_node_nopanic()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1547621481-8374-1-git-send-email-rppt@linux.ibm.com>
Date:   Thu, 17 Jan 2019 03:19:35 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5195030D-7ED9-4074-AB6C-92A3AFF11E00@oracle.com>
References: <1547621481-8374-1-git-send-email-rppt@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This seems very reasonable, but if the code is just going to panic if =
the allocation fails, why not call memblock_alloc_node() instead?

If there is a reason we'd prefer to call memblock_alloc_node_nopanic(), =
I'd like to see pgdat->nodeid printed in the panic message as well.

