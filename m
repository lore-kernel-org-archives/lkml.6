Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A5DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EA920862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gnryV7RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EA920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeKZXzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:55:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeKZXzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:55:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQCiARk105983;
        Mon, 26 Nov 2018 13:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ice7oyEmjHoCDXbmjBAOLFr2/xqsCdYgmiQZPiRWBM0=;
 b=gnryV7RVSn3DN/RXy/45F8w6nqcgO5srNPC5XGCuQAqMbN0VEQRwWij8lVtSB6gZoIYO
 6S0wXfVE0u0Me8GtQy3+CadUmOQr/ifBYZbaUdPcSTP+6NgGRPjQ7V5kXnaKtiWEXg7W
 jcRAHvm0m/4CObvFZ6MYvQsk13PY2WGxf2Owz8KMwfsPEcKqIugSshNaRAl44W6OS6Hy
 HEsDFg5qjB66VnBrhKfwiePsPbcO3JPZBCQRG2GlRf2I8xF4zN8bmN2huEOKw+knrykz
 dyf67SZogIXp6AxIk0ILKHEWJSAoXQLQ9ChqNnN+0yyRQwzKFU+sCgg8i3DeH9WuZ47Y dw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkq5hfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 13:00:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQD0kBs026567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 13:00:46 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAQD0inH008016;
        Mon, 26 Nov 2018 13:00:44 GMT
Received: from unbuntlaptop (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 05:00:43 -0800
Date:   Mon, 26 Nov 2018 16:00:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint()
 failure
Message-ID: <20181126130032.GJ3088@unbuntlaptop>
References: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:39:04AM +0100, Nicholas Mc Guire wrote:
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  attr.name  are not safe if not checked. On error
> ad7280_attr_init() returns a negative return so -ENOMEM should be
> OK here (passed on as return value of the probe function).
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
> unreadable in this case the  (var  == NULL)  variant was used. Not
                                   ^^
Why two spaces?

> sure if there are objections against this (checkpatch.pl issues
> a CHECK on this).
> 

You should just follow checkpatch rules here.  If you don't, someone
else will just send a patch to make it checkpatch compliant.  One thing
you could do is at the start of the loop do:

	struct iio_dev_attr *attr = &st->iio_attr[cnt];

Then it becomes:

	if (!attr->dev_attr.attr.name)

It's slightly more readable that way.  Keep in mind that we increment
cnt++ in the middle of the loop so you'll have to update attr as well.

regards,
dan carpenter

