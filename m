Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21018C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE149208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNUtZEVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE149208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJROHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:07:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJROHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:07:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I63fDE075637;
        Thu, 18 Oct 2018 06:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=NYu72LsLzhrlpCGcJ2mN5WoawYVpC0oFg5JRfWH+YhA=;
 b=hNUtZEVlFWei36dWiTkxHL8hx7uZAYQ6xH+4/KJ+6pa4h8mNLxmlLacuKw9uJzFN0l7Z
 vx1SZvw+UGajSRDqu4C4g8KEUDLT/tZDkwPZJRdYlOF16I8ykemh3UnqE/DDkNglG3Jy
 IPDuiCWGQvqjjlrXAsKUPvPOCt/cuVH+IL3Dbl8oTC7dSRdTszXxFmpxjAaC1FDanS1J
 1OcLjuYPPfCRmpTqBSrrX8NnTH9z+fGlFVlQo5NZERM0Gz2f1YFd3fmcAyX+Mw8AVlvH
 lWj7RUTHartYR3sBKCOePsHSHFz54MK6m3xJ5FFxP71IAprC1yldr3ZmTW/OeyER2OTA Qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384ucm8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 06:07:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9I67lcq011741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 06:07:47 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9I67jVU004427;
        Thu, 18 Oct 2018 06:07:45 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 23:07:44 -0700
Date:   Thu, 18 Oct 2018 09:07:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] Staging iio/adc: fixes parenthesis alignment
Message-ID: <20181018060734.f7ysidkikuoxnkkw@mwanda>
References: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
 <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=387
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I feel like these are overly nit-picky...

I understand that everyone is picky about different things.  For
example, I have a prefered style for error handling.  So two days ago
there was a new staging driver and it used label name like
"goto kmalloc_failed;" and I looked until I found an error handling bug
and then I said, "Here is a bug, plus your label names are bad."  When
people have bad style but it doesn't lead to bugs then I let them get
away with it.

regards,
dan carpenter

