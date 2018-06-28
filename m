Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350F23E5F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CaKtsTS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A350F23E5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeF1Hin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:38:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeF1Him (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:38:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S7ccxX159870;
        Thu, 28 Jun 2018 07:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=qWZxD8lcPYofy4Uhthved/bHQo7Fyq7p9uMmlzdfJNY=;
 b=CaKtsTS1aHmL48syL6eLH7Ai1qHYJYMVcZF4rfMjSjZgT5YEcYVfqgljyzmgYBRiI9Ci
 QS4UDuyjmgIvjSYJ5Is9PO6pXa3ePsq2TyfUlBAvEyFCNoNqlq2ZX+HG/2gc8sDHqsZB
 rY5ykqS7CVPDqbTM3E7NJ+dEKarEZJS6fEMLa00PA3wKuSsg9W24SreocI6DbmMRVjcI
 6QeT7RjceeuLWr/OBvyLCfllfMwlFvvU/JQBkbWJqD3dMl46VXY3qBl7sFnrPJm82fHm
 uDplVeWHdefzwcrvG/Jkj1UaUAjaOG4ftDha+sP1r7GhOT6mo2Y2z7V2ZynThFVAAWR/ +Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jum0a93v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 07:38:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5S7caO7001645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 07:38:37 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5S7caB9022328;
        Thu, 28 Jun 2018 07:38:36 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 00:38:35 -0700
Date:   Thu, 28 Jun 2018 10:38:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Whitmore <arigead@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of
 hardcoded string - Style
Message-ID: <20180628073828.hur7njmsstg2jwvx@mwanda>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-6-johnfwhitmore@gmail.com>
 <20180626035624.GA26173@kroah.com>
 <20180627202248.mvohkxjhwsv5hcn6@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627202248.mvohkxjhwsv5hcn6@xux707-tw>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=766
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:22:50PM +0100, John Whitmore wrote:
> On Tue, Jun 26, 2018 at 11:56:24AM +0800, Greg KH wrote:
> > On Sun, Jun 24, 2018 at 04:34:51PM +0100, John Whitmore wrote:
> > > Changed a number of hard coded function names to use %s and __func__
> > > 
> > > Mailing list response suggest that there is a better method for debugging
> > > using netdev_dbg(). I can't argue with that, but for the moment this change
> > > will clear the checkpatch.pl Warning.
> > > 
> > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > Did not apply :(
> 
> No worries, can I just ask is that because it should be changed to use
> netdev_dbg as was suggested? And should that be across the whole file?

"Does not apply" means you save the raw email to email.txt then download
the latest code from
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-next
then `cat email.txt | git am` and it fails.

Probably someone else's patch was merged ahead of yours.  Fix it up and
then resend.

regards,
dan carpenter
