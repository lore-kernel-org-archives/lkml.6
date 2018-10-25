Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA35FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7472C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dy8fx7TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7472C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJYRS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:18:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeJYRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:18:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9P8djLu029582;
        Thu, 25 Oct 2018 08:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1y906mlYnip2daOlexcupWfQ8t0gr92PUiIJT+7LfcA=;
 b=dy8fx7TN5CPanWFnB+w/ZlOc+HT61kGkECwZlUDJXO09OlYPQQDsQpXSwiQmVTht4Pzf
 UTs3D9MJn+ofKzgwswEomuNebYOY0diJJEF1I29FFwb95Zk7hirF/mdM3NMQmr4fTM6/
 aZgDDi+XE0NblbiO7y+gFkOTbNNRR5KEBv4ebzHaIbBQ2m0eFsiY7CMPVWfGVd3de8o7
 s+1cxrCyLJGxs7ip+7++dsoEx+y+TnUa6nN4eoGcRiNFzp0UFYaMnxRHbmtKrEKP7wc2
 ZOrDKcrUtLke5OQ5RR5UGJaKukmC41IZZeuAG22VmyVCsSS7mO3XQRykktSnlIO7+Rbp XA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n7w0r060p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 08:46:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9P8kseG018808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 08:46:54 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9P8krqF004130;
        Thu, 25 Oct 2018 08:46:53 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 01:46:52 -0700
Date:   Thu, 25 Oct 2018 11:46:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mattias Wallin <mattias.wallin@stericsson.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: ab8500-core: Return zero in
 get_register_interruptible()
Message-ID: <20181025084643.tz72tsh7fulsnnzq@mwanda>
References: <20181018080534.yw2crvhguen5vajg@kili.mountain>
 <20181025082508.GJ4939@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025082508.GJ4939@dell>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:25:08AM +0100, Lee Jones wrote:
> On Thu, 18 Oct 2018, Dan Carpenter wrote:
> 
> > I just noticed this in review.  The get_register_interruptible() should
> > return zero on success but it instead returns the value that it read.
> > 
> > I looked at all the places that called this directly and they check for
> > negatives and treat greater than or equal to zero as success.  This
> > function is also called as the ->get_register() function pointer.  Some
> > of the callers of that treat all non-zero returns as errors, so it's
> > possible that this bug causes some problems in real life.
> > 
> > I could not find any callers that rely on the current behavior, and this
> > makes the function align with the get_register_interruptible() in
> > ab3100-core.c.
> > 
> > Fixes: 47c1697508f2 ("mfd: Align ab8500 with the abx500 interface")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/mfd/ab8500-core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> > index 30d09d177171..66458a329127 100644
> > --- a/drivers/mfd/ab8500-core.c
> > +++ b/drivers/mfd/ab8500-core.c
> > @@ -252,16 +252,18 @@ static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
> >  	mutex_lock(&ab8500->lock);
> >  
> >  	ret = ab8500->read(ab8500, addr);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >  		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
> >  			addr, ret);
> > -	else
> > -		*value = ret;
> > +		return ret;
> 
> Looks like you just broke the AB8500.
> 


Oh wow.  I screwed up the locking.


> What is it you're trying to achieve here?  Apart from attempting to
> return with the mutex still held, what semantics have you changed?
> 

Sorry that wasn't clear.  Here is the relevant bits from the commit
message.

> > function is also called as the ->get_register() function pointer.  Some
> > of the callers of that treat all non-zero returns as errors, so it's
> > possible that this bug causes some problems in real life.

We're returning positive non-zero values on success instead of zero.
It's definitely a bug, but I'm not sure if it has an impact in real
life.

regards,
dan carpenter

