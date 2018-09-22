Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D62ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF602150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hI8U5zVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF602150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeIVT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:58:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:58:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8ME4K9x019146;
        Sat, 22 Sep 2018 14:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vBWSQ7/JyPV+Vxzvg+Uqckmfnl7OPrdOnlPPh2lEY+8=;
 b=hI8U5zVbl1uhNsn2j2iSf/OZAk4NacfK4c75SNRmtvzZVpCH3rF3P28tY9I4NWVB74xS
 dnnRdlP39LbMmaR9PAF+Bl4tb4bS55jG5rj5iFzX+oc2pT7qtOi6g4U4qJ9oBknHDMSj
 E303SFKYg0Pmj01ImEy3HsNzUp9QJU+g2KRL/6WjZWhcxv2N5x/ybyhZBbghj2tdIAQX
 yr2JORaq9JVBuwaashx+ja6QiY22miMXI3dsf8UuvY16f43naK8aam+UIcJiG7oyrSLQ
 jJKSejVRP8Bf8JU9uyEVFjPKtTLV2YNz27iRf/R9pTR8vyKnLJSmVwKp1YA+pSfHdZzh 7g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnecq8t1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 14:04:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8ME4Ira028057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 14:04:19 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8ME4IdT006905;
        Sat, 22 Sep 2018 14:04:18 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Sep 2018 07:04:17 -0700
Date:   Sat, 22 Sep 2018 17:04:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karthik Nishanth <nishanthkarthik@live.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Message-ID: <20180922140407.tmgf4roc2c67sadn@mwanda>
References: <BN6PR17MB099677ADA332476DC575F2EDCA120@BN6PR17MB0996.namprd17.prod.outlook.com>
 <20180922124432.tcykwwisip3rl7ll@mwanda>
 <BN6PR17MB099607D1E30583A179197495CA110@BN6PR17MB0996.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR17MB099607D1E30583A179197495CA110@BN6PR17MB0996.namprd17.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9023 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=522
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809220150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 01:40:19PM +0000, Karthik Nishanth wrote:
> Do I submit a new patch with the modified subject?
> 

Yeah.  Put [PATCH v2] in the subject and then at the end of the patch
description put:

Signed-off-by: Your Name <email>
---
v2: changed the subject.

regards,
dan carpenter

