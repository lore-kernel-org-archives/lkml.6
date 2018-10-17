Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E45ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BCF20869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KaRwnyou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BCF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJQSOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:14:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:14:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9HAIpM3182653;
        Wed, 17 Oct 2018 10:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TuXzmfD3eux8r3w9ljgHHREkHl3kBAYLjhd9J1lgT9g=;
 b=KaRwnyouz0ux/9YA58qX/prtZLKXu2F9M8vadQhJfd133P+Jh0M1FQvN2+F5+tl7j5Z9
 q6/BGSlBiqKba635MKySzkdn12ZS5URqI9ai7m4dWYNnhzDO6KlVvNTPh9ZusWD5tinR
 DPewCnfW3YL+KmUCMKpfHgkOL/37ywUb6xurRtCHJZGTt9O+MEKrwcGoalGM0XChnULT
 68iGjLQWGn/uGgFUMtdor6zeTZjWFSOcG/rRfWqugoVBlGqvTDrzr68ltTQFzPlVOqy0
 f1RRnExkXQje8MuishxOdOQI/6sKy5110scXSiX8WQSF2UTbN7bhg9M9KNnkBRH9+/kc AA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n384u65cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 10:18:50 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9HAIhSa019781
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 10:18:44 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9HAIeHE029986;
        Wed, 17 Oct 2018 10:18:41 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 03:18:40 -0700
Date:   Wed, 17 Oct 2018 13:18:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, phil@raspberrypi.org,
        Eric Anholt <eric@anholt.net>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
Message-ID: <20181017101831.b5kvh5jw3sqqhbat@mwanda>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715113043.52878.1538821118324@email.1und1.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=733
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 12:18:38PM +0200, Stefan Wahren wrote:
> Hi Tuomas,
> 
> > Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 11:37 geschrieben:
> > 
> > 
> > Drop various pieces of dead code from here and there to get rid of
> > the remaining users of VCHI_CONNECTION_T. After that we get to drop
> > entire header files worth of unused code.
> > 
> > I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> > snd-bcm2835 can still play analog audio just fine.
> > 
> 
> thanks and i'm fine with your patch series:
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Unfortunately this would break compilation of the downstream vchi
> drivers like vcsm [1]. Personally i don't want to maintain another
> one, because i cannot see the gain of the resulting effort.
> 
> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm


I feel like everyone else already knows the answer but why don't we just
merge that code into staging?

regards,
dan carpenter

