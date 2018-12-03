Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7DB214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vFzyy0c9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7DB214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeLCKmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:42:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:42:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3AdXQ4187966;
        Mon, 3 Dec 2018 10:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=kXqNM+YpGULFy0VCuxdmKrUb+2+MNWPZ6fvMQXcgt/M=;
 b=vFzyy0c90Ur5jCJ45bsCDSZwstb+0mmpKPgvNTGVK40cN9jU1gsfof1ekITH3lJZItck
 U49ZM1vtRZA05uFsxfwEYKJAF+0t6TZgatcq4m9MEKfHhQqnTO5NbBgrydkR3Wwp0SwA
 7ALOtdmULuf+CS+MN6t/7zA0vtGXMqkYuWUQGNwrpYqvfvnfVVXBbWvkSz/zYM14oVnn
 dQeTUY24h+cVRu1+1KnW5af7PVSJa0ZhnRwu0FM3L4umVBHxghLKZGsVoKSCVAWPAgqk
 jY4JZvAIifd4sL/VGoEyMZUI3/VEimWeskrEp5ZDSfHU4krUlqSKp4E+eb5GI9VS9zhk 5w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxr5drt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 10:41:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB3Afnpx016801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 10:41:49 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3AfmGL012182;
        Mon, 3 Dec 2018 10:41:48 GMT
Received: from unbuntlaptop (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 02:41:48 -0800
Date:   Mon, 3 Dec 2018 13:43:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Lubomir Rintel <lkundrak@v3.sk>
Cc:     kbuild-all@01.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 4/6] media: ov2680: get rid of extra ifdefs
Message-ID: <20181203104339.GD3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128171918.160643-5-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9095 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

url:    https://github.com/0day-ci/linux/commits/Lubomir-Rintel/media-don-t-ifdef-v4l2_subdev_get_try_format-any-more/20181129-205631
base:   git://linuxtv.org/media_tree.git master

smatch warnings:
drivers/media/i2c/ov2680.c:687 ov2680_get_fmt() warn: inconsistent returns 'mutex:&sensor->lock'.
  Locked on:   line 677
  Unlocked on: line 670

# https://github.com/0day-ci/linux/commit/45699a2f04294ea9ca96a3d178232ecae7f607ed
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 45699a2f04294ea9ca96a3d178232ecae7f607ed
vim +687 drivers/media/i2c/ov2680.c

3ee47cad Rui Miguel Silva 2018-07-03  660  
3ee47cad Rui Miguel Silva 2018-07-03  661  static int ov2680_get_fmt(struct v4l2_subdev *sd,
3ee47cad Rui Miguel Silva 2018-07-03  662  			  struct v4l2_subdev_pad_config *cfg,
3ee47cad Rui Miguel Silva 2018-07-03  663  			  struct v4l2_subdev_format *format)
3ee47cad Rui Miguel Silva 2018-07-03  664  {
3ee47cad Rui Miguel Silva 2018-07-03  665  	struct ov2680_dev *sensor = to_ov2680_dev(sd);
3ee47cad Rui Miguel Silva 2018-07-03  666  	struct v4l2_mbus_framefmt *fmt = NULL;
3ee47cad Rui Miguel Silva 2018-07-03  667  	int ret = 0;
3ee47cad Rui Miguel Silva 2018-07-03  668  
3ee47cad Rui Miguel Silva 2018-07-03  669  	if (format->pad != 0)
3ee47cad Rui Miguel Silva 2018-07-03  670  		return -EINVAL;
3ee47cad Rui Miguel Silva 2018-07-03  671  
3ee47cad Rui Miguel Silva 2018-07-03  672  	mutex_lock(&sensor->lock);
3ee47cad Rui Miguel Silva 2018-07-03  673  
3ee47cad Rui Miguel Silva 2018-07-03  674  	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
3ee47cad Rui Miguel Silva 2018-07-03  675  		fmt = v4l2_subdev_get_try_format(&sensor->sd, cfg, format->pad);
45699a2f Lubomir Rintel   2018-11-28  676  		if (IS_ERR(fmt))
45699a2f Lubomir Rintel   2018-11-28  677  			return PTR_ERR(fmt);
                                                                ^^^^^^^^^^^^^^^^^^^
goto unlock;

3ee47cad Rui Miguel Silva 2018-07-03  678  	} else {
3ee47cad Rui Miguel Silva 2018-07-03  679  		fmt = &sensor->fmt;
3ee47cad Rui Miguel Silva 2018-07-03  680  	}
3ee47cad Rui Miguel Silva 2018-07-03  681  
3ee47cad Rui Miguel Silva 2018-07-03  682  	if (fmt)
3ee47cad Rui Miguel Silva 2018-07-03  683  		format->format = *fmt;
3ee47cad Rui Miguel Silva 2018-07-03  684  
3ee47cad Rui Miguel Silva 2018-07-03  685  	mutex_unlock(&sensor->lock);
3ee47cad Rui Miguel Silva 2018-07-03  686  
3ee47cad Rui Miguel Silva 2018-07-03 @687  	return ret;
3ee47cad Rui Miguel Silva 2018-07-03  688  }
3ee47cad Rui Miguel Silva 2018-07-03  689  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
