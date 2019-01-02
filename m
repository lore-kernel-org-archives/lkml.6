Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E28C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275AF218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 12:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wg8yYmEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfABMBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 07:01:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfABMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 07:01:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02BxCME042537;
        Wed, 2 Jan 2019 12:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7HiVX7d3rek3Z/8mdOIso43GkxZg6XsT4WQ4QEGVNuk=;
 b=wg8yYmEd0Lo0QgZmFno0qaemsXgoNkhKR/CLklT9GTWpdiOMu2hgp+9wK0m1n/VdvZ9D
 EUgzmfdIHQBLVt6hUbMEqxY457UunqyPBNphK72nP/8bZBSB+Vum7UUehmHcOCcvP4vj
 JSu7j1S9ovoHLXRgufWDiUoHPrgM5bbbkfON8vQ8wyEgWYxyVYj8QXkpJ6zFYHHk+wdR
 XN7DuZOY0m349e2fh3Z3Kem7yvTfcOUjlRyhYPDA/iyyqv7xFkJyH8BTx64BR3M0ubFp
 zWAGYbUuc51VHsSf0IV1kamBcNMIxu3g+MxYBVL1zbmDDWQ28jZttcRDBgk9XYYp9u1H vw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pp1jr1p37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 12:01:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02C1eeR026244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 12:01:44 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02C1Xvf015833;
        Wed, 2 Jan 2019 12:01:34 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 04:01:33 -0800
Date:   Wed, 2 Jan 2019 15:01:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: base: swnode: check if swnode is null
 before dereferencing it
Message-ID: <20190102120113.GN3781@kadam>
References: <20181222124333.13561-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222124333.13561-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=474
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:43:33PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The macro to_software_mode can potentially return NULL, so also add
> a null check on the swnode before dereferencing it to avoid any null
> pointer dereferences.
> 
> Detected by CoverityScan, CID#1476052 ("Explicit null dereferenced")
> 
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

to_software_mode() can't return NULL though...

We shouldn't change the code just to make the static checker happy.

Sometimes if we just silence every static checker warning maybe we will
fix some bugs in the middle of silencing all the false positive, but
Smatch is almost at the stage of being able to parse this code
correctly.  Maybe by the end of the year.  So let's hold off and then
think about taking the fix everything approach next year.

regards,
dan carpenter

