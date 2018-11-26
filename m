Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E160C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B89120672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oD+AzEYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B89120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeK0AV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:21:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeK0AV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:21:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQDNW0B170618;
        Mon, 26 Nov 2018 13:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=84AL21H5oIBu7C7QJwmgflKv66+weMV8UjZZJKyxnLo=;
 b=oD+AzEYCuLIXBPqOxDxyU9kp6+FcUsqM75LddFxQfTownD7Btkcn57zIZfF7JN5HWmqE
 bFAn/p4PEwqYSidN/YpvQ7yk6SzRFUFyeTC3azwv9LbgIlYwOd4CTG07S6V8krX+HzIv
 PbXJql6yu5eYDkbuhwHvvMsKcjtXABBcNNY7aVya0xpRbZ7i+axaqNeJML2b6D3a/FGI
 evnITXWHi6ZSEmARdTlmgw3xkcUTHo5GT/0OkxzlGjYtIYjh1wq3YfTcqRbp+ub8zlza
 ORyiAnIMgIEgGLvVHmn+TVb9/TMwFnLWCHUwEzMXCJVoNQU12pJs/ly9Db0BTQk0HaY7 uQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2twp82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 13:26:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAQDQP1R023723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 13:26:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAQDQOuM008474;
        Mon, 26 Nov 2018 13:26:24 GMT
Received: from unbuntlaptop (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 05:26:23 -0800
Date:   Mon, 26 Nov 2018 16:26:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
Message-ID: <20181126132612.GJ2970@unbuntlaptop>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
 <20181126130032.GJ3088@unbuntlaptop>
 <20181126131009.GA19931@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126131009.GA19931@osadl.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=595
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:10:09PM +0100, Nicholas Mc Guire wrote:
> On Mon, Nov 26, 2018 at 04:00:32PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> > > devm_kasprintf() may return NULL on failure of internal allocation thus
> > > the assignments to  attr.name  are not safe if not checked. On error
> > > ad7280_attr_init() returns a negative return so -ENOMEM should be
> > > OK here (passed on as return value of the probe function).
> > > 
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> > > ---
> > > 
> > > Problem located with an experimental coccinelle script
> > > 
> > > As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> > > unreadable in this case the  (var  == NULL)  variant was used. Not
> >                                    ^^
> > Why two spaces?
> 
> just a typo 
> 
> > 
> > > sure if there are objections against this (checkpatch.pl issues
> > > a CHECK on this).
> > > 
> > 
> > You should just follow checkpatch rules here.  If you don't, someone
> > else will just send a patch to make it checkpatch compliant.  One thing
> > you could do is at the start of the loop do:
> > 
> > 	struct iio_dev_attr *attr = &st->iio_attr[cnt];
> > 
> > Then it becomes:
> > 
> > 	if (!attr->dev_attr.attr.name)
> > 
> > It's slightly more readable that way.  Keep in mind that we increment
> > cnt++ in the middle of the loop so you'll have to update attr as well.
> >
> My understanding was that CHECK: notes are not strict rules but
> those that may vary from case to case.

Checkpatch is just a script.  It's not a genius or the king of the
world.  Sometimes checkpatch compliant code is clearly worse than
breaking the rules.  But fighting against checkpatch is a huge hassle so
you should avoid it if you can.

I actually agree with checkpatch on this one but it's a minor thing.
Sometimes a maintainer will get obsessed with minor things.  You have to
be a bit obsessed to be a good kernel maintainer.  Anyway, they have
their fights with checkpatch and it creates a small thread every time a
newbie sends a patch.  And everyone on the CC list has to endure it as
well.

Btw, when I get annoyed with checkpatch, I feel like it's pretty obvious
I am correct.  I'm not like other kernel developers who have debatable
style preferences...  ;)

regards,
dan carpenter

