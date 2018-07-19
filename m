Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C83ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xKsvqAMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F0C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGSLHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:07:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50390 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeGSLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:07:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JANTpi095813;
        Thu, 19 Jul 2018 10:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=t/xaaVqoQ/f/LgZxiyUJNJ/HPdDx97I+V6UPT7T73Zw=;
 b=xKsvqAMTXKYy4VDoaqZbdk7o1r4Q8dvzOAaoKnhV1lsWu/euIOqZV4pKp7NYau/DOcxL
 ZSVWsn7HTB3CPDuHBVe4ys5b9vJ8XDhT3ZzxKRVtaPjao6F+PyTIW4GNyiTOjdVsUqKo
 4XQdbFWHBerUgeFf0e9tpX6lOZcPMRU7VQfFV9H4w4mCxF3EKBnlTZ1OugBLum0eGwk7
 +ag/ocJiSvM/8oLH77C+s0sJjEz83INcl8t6hMJPXa/umN0je/4UtRJcL4WKgNraQZmE
 v2u23IwQbXP7QyuItSB4mx74uCH3KAwVMBnNNoRWy99iHKndpcuvXeTzPVz7sPviuFE6 EA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k7a3t9xy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 10:24:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JAOSIp003254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 10:24:28 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JAOQ7c005939;
        Thu, 19 Jul 2018 10:24:26 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 03:24:26 -0700
Date:   Thu, 19 Jul 2018 13:24:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v3] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
Message-ID: <20180719102416.7gnzuo4vmax44qv2@mwanda>
References: <20180719093713.3643-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719093713.3643-1-andr2000@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=508
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

