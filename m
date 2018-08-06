Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED09C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3548D219EB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwUL+08j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3548D219EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeHFLHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:07:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59744 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeHFLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:07:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w768xC4q010586;
        Mon, 6 Aug 2018 08:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YU4qCdrlgGXdsJvvgy3wYu7emTzhok7+wAHKUoMRzps=;
 b=IwUL+08jlJW+LEGYBAMiUcbLcseWsSjbCwkrgacJkBrXw5+rCTd1kYVPVG4GMiuXHdDJ
 Sen2At2HwPOi2mVqcKd7Lv7mJwQkhpmms5Ge2ZVJjbsxhzysQ6SVimB5Kob4lFe+YKlY
 yRPKwU+kN+IiLlpgdF8GvmIpd2ShnHHeO5JgFr1aRCLYBVo+QHUTkdN+jkIV40IlIvXN
 v2eD7uuvsTJD4H8LH8uc/1wnQCKoeb362xnR1ITTIfckI02gqDCcwVjAXJd1SUCniwT7
 xNoDF7JQUrITmcuvIR+/rhKQ6CcLFu/RB+MtnJUlOp9B6gjy5+6fMmyYa5gM5zoEN3JS 6g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kn43nkw2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Aug 2018 08:59:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w768xY2i023365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Aug 2018 08:59:34 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w768xXSk003293;
        Mon, 6 Aug 2018 08:59:33 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Aug 2018 01:59:32 -0700
Date:   Mon, 6 Aug 2018 11:59:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     miquel.raynal@bootlin.com, palle.christensen@microsemi.com,
        devel@driverdev.osuosl.org, boris.brezillon@bootlin.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, arunrasppi@gmail.com
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180806085924.pqmbebt6gk3pmgfe@mwanda>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
 <20180801120551.ju6zhxhoef6w5zim@mwanda>
 <20180801155530.6e824927@xps13>
 <20180801140447.yw47ynz7bsgfbwb3@mwanda>
 <CALtPoQDadUE2qD0yVHO7yDggE1w0mNqteQ3iqYxiEDvorY6d2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtPoQDadUE2qD0yVHO7yDggE1w0mNqteQ3iqYxiEDvorY6d2A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8976 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=697
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:49:01AM +0800, Jheng-Jhong Wu wrote:
> So should I change this into a revert patch, or you will revert commit
> 6efb21d6d0e7 ("staging:mt29f_spinand: MT29F2G failing as only 16 bits
> used for addressing.") by yourself?
> Thanks.
> 

Are you asking me?  I'm not going to revert it.

regards,
dan carpenter
