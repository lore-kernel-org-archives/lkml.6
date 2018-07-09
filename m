Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D5FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017620896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w4gtNkR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1017620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeGILn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:43:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbeGILn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:43:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69Bd765168532;
        Mon, 9 Jul 2018 11:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7DWRgwCwulxiY6fn7tMwrFmIzfMFr2d/bLjZhZOjCU0=;
 b=w4gtNkR5pmV6Nw1ZknQHrP+RyNOh0sEuBSRbmGuAbSnZYQDfgtIGib6LbQIyfM4Dqfn7
 cOtUh6eFodEZ5Qm+8mjVGErawtj8gF2BJHsxJq5wbmPupagflGgToEltEIgYb6GuI7Cy
 ROGjJF2WgmJyS/UghMKJ3qvas4ZU8gxOISt2Vt7VLTaBr4ZT+601Vvpdtc9JuQrnZ3OP
 7Kn4YzgGwCLUb9V0Q4r5I/dcdjXTbVR5GMOOXFlmyfqzm+MZTE1rzFBTC3j/1o4hg3sb
 FD7JghxK6aqr8RHJG1EiWUC6IydOyjQ6G04IYNpSkl55Wd5U2Yh4EaZ2+1wYe9UhT5Qr dQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k2p7v3shx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 11:43:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69BhFm6014558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 11:43:15 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69BhDAc022708;
        Mon, 9 Jul 2018 11:43:13 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 04:43:12 -0700
Date:   Mon, 9 Jul 2018 14:43:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaya Durga <rjdurga@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        deanahn@gctsemi.com, jonathankim@gctsemi.com, quytelda@tamalin.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Message-ID: <20180709114305.cpsrft5l5dursxbi@mwanda>
References: <20180709105758.7943-1-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709105758.7943-1-rjdurga@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=453
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, you really should be sending this as a [PATCH v3] with a note
under the --- cut off that says "V3: fix From header, and indenting"

Google for how to send a v2 patch.

regards,
dan carpenter

