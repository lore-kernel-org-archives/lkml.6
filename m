Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DEEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F6020C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xXDwsMQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F6020C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeHTNF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:05:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:05:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K9ovCX030609;
        Mon, 20 Aug 2018 09:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=i+P5v3dPuikTbllZEU5fNZuNPbD1RI9OEoB6M7hDIIU=;
 b=xXDwsMQTA4YY7vANjvqscyKqCBPGu3GDRFAoQSzVIDwu7koCBfi2fjERBk4IuWCqyQMP
 H+UhuTsESfO7aOCqE73f2/HBXCLZRyY7WU971FTLGJgOWj9c9HOTZQZwh5jjGnbw1UT3
 4uDWLSEpjKDuawVLGgPtIxyDgGefqjFlMBibUjkbuFe2q9DOJFHdjSL5nAdOga2gWTI8
 G/o1bbXx/YLDi/1JhAlkPmrTQpkdkPpAz/1hBuYu2/Fd3yb8ej1oYyvwGG947B9GFZTQ
 RBgo46tUVslx6WdZRDmvvX8hYBe3Yct5blhpCEfpl/gTtbaoGZhG2LJbThU7jxDxWsfz 7A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3qd9m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:50:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9ooeD023914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:50:51 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9ooGx002741;
        Mon, 20 Aug 2018 09:50:50 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 02:50:49 -0700
Date:   Mon, 20 Aug 2018 12:50:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180820095042.pgucu7e3i3aiu3lb@mwanda>
References: <20180817074729.GA16204@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817074729.GA16204@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=389
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 01:17:29PM +0530, Bhaskar Singh wrote:
> This patch removed code which are valid for IEEE 802.11a i.e. 5GHz.

I would be uncomfortable accepting this kind of change without an Ack
from the maintainers.

The messes up the indenting so we can accept it anyway.

regards,
dan carpenter

