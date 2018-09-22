Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6664DECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18BC21522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ayCt8v+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18BC21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeIVSiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:38:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbeIVSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:38:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8MCijnW009945;
        Sat, 22 Sep 2018 12:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vfPaQq9V0iPJct/l+UmolX8Y4ZIExnzvm9i3fNjxAjE=;
 b=ayCt8v+g2SfXrWo0JxJYlSho//cYqgmPnTNZtPtTgQGgHwAO6z18qDAxGZG2izqKclKI
 4nHyp0TBPeSo9+gRXcuDOOXw9/utPLEYzkmBqtfbv1JtrLmSsu4jCm91C7zRSNmP161l
 bB7iEEZZZsDwY1c78wkmLQ//i/9QaFgXkE4d7VnW6oDBQtJjBNzUsmQS0OAY1PCj5j4a
 3nLxHuu58zITVJGcQuCcvx7uqONnh9pR06TQQDTGFXnsT3MgN2gecrWp+yjhrY0g3NdA
 KRH7fWUR8JSMYVRy/hdTNd6Pvh7wtMeErguUoH1XofkyPvtRDNYhxIoqWxBoPRf5RUqc 9Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mnd5t0t9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 12:44:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8MCid6j018414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Sep 2018 12:44:39 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8MCidtv016128;
        Sat, 22 Sep 2018 12:44:39 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Sep 2018 05:44:38 -0700
Date:   Sat, 22 Sep 2018 15:44:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karthik Nishanth <nishanthkarthik@live.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Message-ID: <20180922124432.tcykwwisip3rl7ll@mwanda>
References: <BN6PR17MB099677ADA332476DC575F2EDCA120@BN6PR17MB0996.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR17MB099677ADA332476DC575F2EDCA120@BN6PR17MB0996.namprd17.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9023 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=522
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809220135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject needs a subsystem prefix.  It's also slightly long.

[PATCH] Staging: rtlwifi: remove unnecessary NULL check

regards,
dan carpenter

