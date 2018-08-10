Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B9C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E93223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FsAb2TFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E93223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHJMOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:14:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeHJMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7A9donU120334;
        Fri, 10 Aug 2018 09:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+R//3CXZJqoYa1/IBSm0O+kFxKvMqEACTvwXcHwcPZQ=;
 b=FsAb2TFEO7mflxYp7pHsKMK1W87G4SXOLYrV2n4SdyEJ3huoUV6AUyemTeesVmzF5BXJ
 PQxcRInZCm3OZeqEAOnmKLvOH61SKp8tctldwAkV6cOGoJL0rl5tm+pM0Rkor8m9AgeH
 OO931/whFTdTcYxZvfK7HhAIoKStZTZ2lvFtaAFon3SoOXcz5MF8c/XLPRsQ5Iue2psN
 sp6nyDiVZ/iqPqEMMUZpjSu8AXaOxH95DfBfW2hpRhV9EaEPW3MKnXnUosx11r1W34va
 C+VZBN4MIokRYCNOFtylg4LFvmVfRS6VDIpbZJnPPnEL6/ZyN7xajUkSyzHNaxcgsX1R 4w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kn43p6n19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 09:45:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7A9j3Mb005125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 09:45:03 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7A9j2wZ026216;
        Fri, 10 Aug 2018 09:45:02 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 02:45:02 -0700
Date:   Fri, 10 Aug 2018 12:44:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] staging: rtl8188eu: use phydm_reg.h from rtlwifi
Message-ID: <20180810094455.4sji7ex2d7jaq3x4@mwanda>
References: <20180810071833.1661-1-straube.linux@gmail.com>
 <20180810071833.1661-5-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810071833.1661-5-straube.linux@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8980 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=546
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808100106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Thanks!  I reviewed the series.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

