Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08731C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1047208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVondpFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1047208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbeFNT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:26:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:26:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EJOrZk121954;
        Thu, 14 Jun 2018 19:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=WyfMYC5mbx6Zx4doQ5496TNJfAN5CtjyEwHE4LYhEl8=;
 b=RVondpFeDzjZCbQtFTxkblMV+7ld1jnEF+GuW4Sy+m6sx04S5Csa7tFdWTYKdIOJ2Xsb
 m5GIkfrBCBd6GKJbbcFuJWk9Ilvr87cvbNWtRnPPH0vUCBIf/apc6e/XkU4+QCypKmiv
 CfId2UZU0TV2TeNUO078DzuKDdpTW30anyLrPkzCNwkZPQOwpg7ZkyeUXcQoZ95J1YQ3
 iw7qiP80/9LMuAxyDykuRYfwaCoF/t8DPZfJ+ZVvIAoV/NWaKHRCqO0H/tAnNroqoDcW
 xesaJJiWWOKuBnRGEHHjtX3lsO0yQ3ooxy+pyhxhJ0JlnHa3z5PP251o+/UnC0Y/wjqh Ag== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jk0xreeg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 19:26:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5EJQhWD028425
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 19:26:43 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5EJQg5f025047;
        Thu, 14 Jun 2018 19:26:42 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 12:26:41 -0700
Date:   Thu, 14 Jun 2018 22:26:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>, devel@driverdev.osuosl.org,
        Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180614192631.5hl3gzueeseueqzn@mwanda>
References: <1528910104-1360-1-git-send-email-eklikeroomys@gmail.com>
 <4c33a400-f840-0a21-efad-2a9318dfdb09@mev.co.uk>
 <20180614161718.GA3846@kerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614161718.GA3846@kerdev>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=458
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 06:17:18PM +0200, Chris Opperman wrote:
> Hi Ian,
> 
> Thank you! Are there any more steps for me to take to complete this
> patch process?
> 

No.  You're done...  Greg will apply the patch in a week or two and
you'll get an email.

regards,
dan carpenter

