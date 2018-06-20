Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE132C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D082083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXBsf1kZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D082083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFTUI7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:08:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59570 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeFTUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:08:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KJwjUR007728;
        Wed, 20 Jun 2018 20:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=tP5FToi1P3fywvKiUb8p4ma2NlirWppsuuD7Xkm9oMw=;
 b=JXBsf1kZrHNL0z0Q0/K5uWMeqoi8997h9TFOaxfTeUJr6FYyRHEul7yUjmRpkxjDLGUB
 G7gqKhnd+lVlh0OE3u23vz0Q3be0EjUiJuxZM56j3ujaQPopHZ2akbFKMGzA2LzOKir3
 6Mq82Jaqy9tC6d9HcBO6aUZU7wAskJYCAX6LQ9magcQ75fjSb2vJgr/CEA2h9jZldbhK
 ZQHnzp7f9IS1sTCrRMAVRQ1Q7uxtpJh8zzZQkJKlWvRXs/fH/C3FmGQgS3tIfBgeiYxj
 +8loYlMMEsJEMgi4MnpATra9DJb+HX0Ed0/YCUvjqY0m93ZO6OdECLPUwCV4F0oFWG9A FQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgwx1wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 20:08:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KK8cWh011883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 20:08:38 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KK8cq2020419;
        Wed, 20 Jun 2018 20:08:38 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 13:08:37 -0700
Date:   Wed, 20 Jun 2018 23:08:29 +0300
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
Message-ID: <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=734
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:10:26PM +0200, Chris Opperman wrote:
> b) Added temporary "key" variable to reduce line length.

No, that's nonsense.  Just fix the original variable so that it's not a
million characters long.

Using a shorter variable is good if it simplifies the code like so:

	struct foo *foo = &my->random_variable[INDEX].whatever;

You've reduced 4 variable names and a butt load of punctuation down to
just "foo" so that we don't have to look at it repeated over and over
on every line.

But if you're just using a temporary variable because the original
variable name was poorly chosen, that's not the right thing.

regards,
dan carpenter

