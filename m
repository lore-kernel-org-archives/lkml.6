Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D27C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFAA258FF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQ6sEoJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFAA258FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeFYMZb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:25:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57754 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933191AbeFYMZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:25:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PCO21B059339;
        Mon, 25 Jun 2018 12:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=sLChqYlp3FQphphvBoWlOT7gvc9i4CvqYc+XYHL6u2s=;
 b=JQ6sEoJINydWT7MKo4Micjhyg9DGkymUGxsxsdtvRhcZgQY+676zquZ798aRYzf/Hr8M
 fpr3AB8pWIrOOnebHbxJFm2JFw6Kzk/82IxQJ3bNEj4ecT4E6mCZOaWNWQ/cgeRWmGUg
 KKVgbCODoGqJTVgBMgsqpYecUW0m0atNb398Ew39bXMUz35o6Rs1/XCtgAONCJ+HJFYG
 pTKPZx67UXSUGMOzaHctPOfshyVD/ivEc64cJ8qUYSD5wl31rKT9QQLCPvCWt3NP5IYR
 aL0T7a1LqQPAPg03arg9+ahPVkp++oaC1PxfX7BKavwkNjfkgrX05jMLFbyXUfuqoXvC kQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jt7natghu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:25:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCPDeo032481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:25:14 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCPCXD004943;
        Mon, 25 Jun 2018 12:25:13 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:25:12 -0700
Date:   Mon, 25 Jun 2018 15:24:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <michael.straube@posteo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
Message-ID: <20180625122453.souir6wzzyhbkj4m@mwanda>
References: <20180621182155.27769-1-michael.straube@posteo.de>
 <20180622102800.4p6wabmte4yf4rtp@mwanda>
 <CAHp75VeASBAsBrrq65qhkAGXHoSE8Hg-9dSGcgjT2bNND-1MBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeASBAsBrrq65qhkAGXHoSE8Hg-9dSGcgjT2bNND-1MBw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:47:44PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 22, 2018 at 1:28 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Thu, Jun 21, 2018 at 08:21:55PM +0200, Michael Straube wrote:
> >> Remove braces from single line if statements.
> >> Also fix a comparsion to NULL in one of the conditions.
> >> Issues found by checkpatch.
> >>
> >> Signed-off-by: Michael Straube <michael.straube@posteo.de>
> >> ---
> >>  drivers/staging/rtl8723bs/core/rtw_debug.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> >> index f852fde47350..2244ed72ab9c 100644
> >> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> >> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> >> @@ -618,9 +618,8 @@ ssize_t proc_set_wait_hiq_empty(struct file *file, const char __user *buffer, si
> >>       if (count < 1)
> >>               return -EFAULT;
> >>
> >> -     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
> >> +     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
> >>               sscanf(tmp, "%u", &g_wait_hiq_empty);
> >> -     }
> >
> >
> > The original code is kind of bad.  The NULL check isn't required.
> > The sscanf call should have error checking.  The error code is wrong if
> > the copy from user fails.  The tmp buffer isn't NUL terminated.
> >
> >         if (copy_from_user(tmp, buffer, sizeof(tmp)))
> >                 return -EFAULT;
> >         tmp[sizeof(tmp) - 1] = '\0';
> >
> >         if (sscanf(tmp, "%u", &g_wait_hiq_empty) != 1)
> >                 return -EINVAL;
> >
> >         return count;
> 
> Shouldn't this be
> 
> kstrtouint_from_user()
> 
> instead of all those lines?

I wasn't sure kstrtoint() was the exact same as sscanf()...  If so then
sure.

regards,
dan carpenter

