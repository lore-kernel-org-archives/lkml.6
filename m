Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B660C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7526208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YuqUnLWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7526208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbeHAPvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:51:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbeHAPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:51:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71Dwdo6098991;
        Wed, 1 Aug 2018 14:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=a9zpVG17XnXJUag+LHh0QIvRYfKJI6tsgxrEl3HKypk=;
 b=YuqUnLWJTLUxA9wAc1BK3jx1EVViW0aK22oPLxeHTIgVKoP9zO2KUNQhfFfcXFOyCF9q
 0rA5MNKzBnMoS45Wd4X4ToC3NYj+uNnkuJWlFB4JmqmiDjBa9WVgN0FMU5y/hwPSHEsx
 ll7kt3K6bJc1h87O9h97spxx6dtwJvZPJuuFOcekql0jAA88W+rDn4R1P5yiNR58yY5s
 43dYI92fPPAA/eXs2yVQy8yI33EvN8B4OLJdr0Lk1fb9oChUVrQ8eyq/TgLbvwaLVQtf
 q3pquHxIryMMPWVwzzKoFB/gAGWC0pNeaI2lnu/VJo9zvBV0BdE+vA+d0aNpJF4ZemNA Pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kgh4q5r2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 14:04:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w71E4w1h012109
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 14:04:58 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71E4uWM018213;
        Wed, 1 Aug 2018 14:04:57 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 07:04:56 -0700
Date:   Wed, 1 Aug 2018 17:04:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jheng-Jhong Wu <goodwater.wu@gmail.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180801140447.yw47ynz7bsgfbwb3@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
 <20180801120551.ju6zhxhoef6w5zim@mwanda>
 <20180801155530.6e824927@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801155530.6e824927@xps13>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 03:55:30PM +0200, Miquel Raynal wrote:
> Hi Dan,
> 
> Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 1 Aug 2018
> 15:05:51 +0300:
> 
> > On Wed, Aug 01, 2018 at 11:24:19AM +0800, Jheng-Jhong Wu wrote:
> > > For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> > > are necessary to address the correct page. The driver sets the address for
> > > more than 16 bits, but it uses 16-bit arguments and variables (these are
> > > page_id, block_id, row) to do address operations. Obviously, these
> > > arguments and variables cannot deal with more than 16-bit address.
> > > 
> > > Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>  
> > 
> > This seems reasonable...  It would be needed to make commit 6efb21d6d0e7
> > ("staging:mt29f_spinand: MT29F2G failing as only 16 bits used for
> > addressing.") work.  It also fixes a static checker warning.
> > 
> > My only concern is that the mtd/nand code seems to use -1 as a magical
> > page_id.  For example:
> 
> I guess you missed Boris' comment: this driver is very likely to be
> removed. A SPI-NAND framework has been added. It does not use the raw
> NAND framework anymore, which was wrong anyway.
> 

We should probably revert commit 6efb21d6d0e7 ("staging:mt29f_spinand:
MT29F2G failing as only 16 bits used for addressing.") in that case if
all it does is add static checker warnings...

regards,
dan carpenter


