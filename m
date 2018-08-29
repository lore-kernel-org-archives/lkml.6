Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2B20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WC5WQ8+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A2B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeH2SMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:12:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55608 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeH2SMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:12:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TEE6jQ158620;
        Wed, 29 Aug 2018 14:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VkhiR7jeFqvoJDQ8FiCWT3hauUpUStqroUr5BgrXaOw=;
 b=WC5WQ8+7SLtWk5prb5URYw/XLLbBQGzIxmKe3SobhDngDddvIJ0vk7jSvf3BbbI1Y2As
 l9H/4EFgWQobKJ3QQ2gvtOx1O84GCJi/clUeurml2GiTfMgbJIYa1upRTij66/TucU0X
 rEENPqUkLsuOuqKfswssKCxoJUnRb8dvKjm/+JbsMo2ZnIUMd4C1CAVsIawST4+/GJVl
 sZ3AIf4d0i/95ru7PmGBayOC8QFyKcMBHjwcTatTSRTGJ+uylzkI3+oeROag/Fw1sdPX
 LJSKEjT5rQ6glcaHPkbRgzRd52caSbT9bccpRaw8G/KKbHlLojoRhQFs0zmVNF7PGW34 Mw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrq9xcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 14:15:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TEFSil004585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 14:15:28 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7TEFSQn030991;
        Wed, 29 Aug 2018 14:15:28 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 07:15:27 -0700
Date:   Wed, 29 Aug 2018 17:15:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sameer Nanda <snanda@chromium.org>
Cc:     colin.king@canonical.com, sre@kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: remove unused pointer 'dev'
Message-ID: <20180829141520.vaiuepmjdvizzhh2@mwanda>
References: <20180828162842.17503-1-colin.king@canonical.com>
 <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=591
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:54:13PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 28 Aug 2018 at 18:29, Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Pointer 'dev' is being assigned but is never used hence it is
> > redundant and can be removed.
> >
> > Cleans up clang warning:
> > variable 'dev' set but not used [-Wunused-but-set-variable]
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/power/supply/cros_usbpd-charger.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> 
> Maybe add cros_usbpd prefix to the subject?
> 

Yeah.

The problem is that the prefix wasn't added to the subject in the
original commit f68b883e8fad ("power: supply: add cros-ec USBPD charger
driver.") which added the driver.  It's a common problem.  Normally what
happens is that someone adds a driver and then random static checker
people like Colin or I send the first fixes and we have no idea what the
correct prefix should be.  Anyway, checking the prefix is one of the
things we should look for when people add a new driver.

Also Colin you should CC Sameer because it's really his code.  Someone
should fix get_maintainer.pl so that it does git blame on the
lines before and after and adds people if the code is less than two
years old maybe.

regards,
dan carpenter

