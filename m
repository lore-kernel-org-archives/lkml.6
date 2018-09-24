Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZX/L4Gvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA1A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIXQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:08:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:08:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8O9wlxo040553;
        Mon, 24 Sep 2018 10:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ovgOb2djhF+MzRWpR+XaGAmnMv1P6gsPE69iUwjyg/4=;
 b=ZX/L4GvhgrQYbUFp5HcM5zRS/91vrpmLPXDW6nuiab3hEhe5cKOc7DjTiGz0tvPtLIdN
 1b1M0/pMOQjNcMu843orv9P5E/l4vTFpDuBI9reyPqRqoR9VaCyA623Lsty1d3GIQWzy
 9oTSGEXZFF5ULTZHh5kmsKA8km3Xgiauce6cRoGy4+PeLvO9JzFTjyxvuEDQAfaA3mHU
 EZ9Ds+wsRudG/xonpHCn90J7KDFD68kK7d3/Lq82roXb0MyYoal/lOM4oyngaErys/TQ
 Wk8kzreca0KiypwJG5zrwujihboYsvlhKLjfczSlDBAWBuojSgoEkpBzgCNGSGB5WmDV JA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnvtube51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 10:06:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8OA6eOo002358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 10:06:40 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8OA6eQr026923;
        Mon, 24 Sep 2018 10:06:40 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 03:06:40 -0700
Date:   Mon, 24 Sep 2018 13:06:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] staging: vc04_services: Fix checkpatch.pl errors
Message-ID: <20180924100633.gyvnvjfwzsckrql6@mwanda>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=454
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 03:06:15PM +0100, Aymen Qader wrote:
> v2: Added cover letter correctly
> 

We weren't super stressed that the cover letter threading was wrong.
We're not ogres.  Anyway, just fixup the last two and resend a v3.

regards,
dan carpenter

