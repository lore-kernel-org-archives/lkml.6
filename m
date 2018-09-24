Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B985E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1IbKML/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIXP1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:27:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeIXP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:27:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8O9OA1K012846;
        Mon, 24 Sep 2018 09:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/RosDxHIEnWcpjyEGX7go3nRh3mXCvSZJTXUP0qsAmU=;
 b=I1IbKML/bEzhO7KRxv04e+8jJXwKq3Pr6YsqdjsLzwS8a0kxSw1v/uuM/kEaE13DtGGR
 ajSjLnPzdItb/p3OQCM+i2UnyEFKbqeJSG3soZClFR3xR2vtNNAgYB2FaOTy/OF/FDBz
 D/eASnmuhETdA45qcfLlBQw+MzZ/plkPxNmAmMpU0O5athvIMQiXf5lzVjDODDuN+dj/
 vvTjuriDVXMGxfde7GRgix0W7fdb/+mndc5WtFJ+ewNAWF5NaG71hIGSWZMQLv1TIJgM
 hPgDyQWGozW3p4HQOnTPYELrUiWgAHuel1HGVrJa4tXqYwdDhikEskV/M4Z5ZA0cHkrJ FA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnvtub8tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 09:26:29 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8O9QMAo021091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 09:26:23 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8O9QMiR027461;
        Mon, 24 Sep 2018 09:26:22 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 02:26:21 -0700
Date:   Mon, 24 Sep 2018 12:26:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu, rtl8723bs: fix spelling mistake
 "evet" -> "event"
Message-ID: <20180924092608.aa7sm33xmi3s7amk@mwanda>
References: <20180923092555.6316-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923092555.6316-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=493
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to just delete these.

regards,
dan carpenter
