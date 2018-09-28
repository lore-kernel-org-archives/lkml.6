Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F90C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709CA20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRo17/A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1U6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:58:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1U6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:58:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8SEXhOb175717;
        Fri, 28 Sep 2018 14:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3Mxns4Z5ziskavW3ri/hWwJgxG/l9w1bjTsGHMSzoXk=;
 b=gRo17/A8wB5WrO0rNYTEinmOiIfJAkJ/ve8jZKuqvjBsgd6EPboXP1DCFbIRDcU885p1
 WXTzvJBzZV8UAUC/2ebu0rtIDDag0dOJ/6Fmm3p1BGUILX5hNxfDMw/OcHLSaOAepT2h
 3iMeTUDeAsUY/2KELsH/pZH+vsSqFK9XBvMEniehn0fDtAIf/Et1ulPwmrV3Hwd1KB5B
 Md3uWyaP0nYNccbZ6Ccv9Ui58pBSG9x/r7jiv1TEDCHjk3b0NtvPi7BHQES1N148NLOu
 lzlZq3T9MsnxNwrBUb0iiSAxbSdIjq/mRwI+PNTwf7B6yyBKVb9GXJ7KG2z+Y1FZk2gj 6A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mnd5u0na6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:33:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8SEXqLm018977
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 14:33:52 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8SEXqIq012922;
        Fri, 28 Sep 2018 14:33:52 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 07:33:51 -0700
Date:   Fri, 28 Sep 2018 17:33:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 07/13] staging:rtl8192u: Remove DelayBA, PSMP and Rsvd1 -
 Style
Message-ID: <20180928143346.krtmmpd2v7j5m3mt@mwanda>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-8-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191704.16322-8-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah...  :(  All the remaining patches are similar and risky.

regards,
dan carpenter

