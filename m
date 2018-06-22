Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FB6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1137824093
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2kJZSCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1137824093
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeFVKrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:47:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeFVKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:47:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5MAiQER173939;
        Fri, 22 Jun 2018 10:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=gFPLduRLemvPJfaCSgyIld7u34UXTJH0jXC4Syxztpw=;
 b=B2kJZSCZib6knIf+S2EhhrsV6TshoRYr90TtfVzyTZIcb758iiuBVZpmkcRW3ulvpNkR
 i3iunSWBIMryxUNkwvV4VwycGOjM/eHJ1iFMGHKlFGomAy7BXkST3iIA0qUhipKWJm/w
 bFIDKdmnSBcFN0RYGYyR1/8PQ+C4Koj0ypaI6tPjreodI6wPt9qNiR6nWDQHXHepRNTJ
 fcCYPwyDxzZ0G5hDzAquzkiymbRBuB6tKVOqZuYayqrSusGCM0kBrXFQ5eJ0YsSAq/Ol
 JAiWZDOnmv7hthX8IaR0vzR9knaAOyNCMVqjciza9rhCkHztuItUm/Y+tl9p1gIW3Xo4 jA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jrp8hsf64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:47:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAl5HM012996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:47:05 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAl3iM018530;
        Fri, 22 Jun 2018 10:47:04 GMT
Received: from mwanda (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 03:47:03 -0700
Date:   Fri, 22 Jun 2018 13:46:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] staging: wlan-ng: improved readability of function
 prism2_add_key
Message-ID: <20180622104654.2snozuvc7sc6tk76@mwanda>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
 <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
 <20180621044252.GA19583@kerdev>
 <20180621082225.xuhqvm7bevbiuaso@mwanda>
 <20180621155352.GA20712@kerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621155352.GA20712@kerdev>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=345
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I liked the patch, but just go over the 80 character limit instead of
adding a "key" variable.  It's better that it generate a checkpatch
warning and forces someone to rename the variable...

regards,
dan carpenter


