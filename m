Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70107C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nW8mGEU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB2220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeKGOLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:11:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeKGOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:11:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA74dCDq175471;
        Wed, 7 Nov 2018 04:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=JoPJA4LpqyVgIOoH0Wu5l8B2TZznbHZwQFuPvZ4jZZ0=;
 b=nW8mGEU8dDEyCaTUUu2axIu5TrLphUP9Yla5mTu5I0VwrnkCMTO9IVWpiNRQa/LgHo0B
 XHAYUEl//3BgrrfeWmS0B3RINCrq5WcdQMNMSYskzyL6J6LuSU5Ke3ndUCM6NHxTDCh9
 4fBOq0ieMKWbya1emEneu/jeeNHv+4RS332/Gvuf3muuZQeoJoERabvi6WML1u9ERLRQ
 xW99QVANPQwUkrB1P+7dRtvvdHwXMwV4xQXn///6VC374zqkxHDBD6CTIA5p0ad0tuLJ
 8xgYtQ3PfrJBdY7N42U/RIScu1BatCL0kAtB0F/GQegY6spJ38NFlG3uAdovyZdf7+U3 Ow== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqs4yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 04:42:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA74gKKC018078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 04:42:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA74gIES015615;
        Wed, 7 Nov 2018 04:42:18 GMT
Received: from mwanda (/73.241.165.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 20:42:18 -0800
Date:   Wed, 7 Nov 2018 07:42:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Lubomir Rintel <lkundrak@v3.sk>
Cc:     kbuild-all@01.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/11] [media] marvell-ccic: provide a clock for the
 sensor
Message-ID: <20181107044146.d5lsvtyjeit7goas@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105073054.24407-12-lkundrak@v3.sk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

url:    https://github.com/0day-ci/linux/commits/Lubomir-Rintel/media-ov7670-hook-s_power-onto-v4l2-core/20181105-163336
base:   git://linuxtv.org/media_tree.git master

smatch warnings:
drivers/media/platform/marvell-ccic/mcam-core.c:1682 mcam_v4l_open() warn: inconsistent returns 'mutex:&cam->s_mutex'.
  Locked on:   line 1673
  Unlocked on: line 1682

# https://github.com/0day-ci/linux/commit/a4f7d692c7067355da433bbb534531a4e1a55ac6
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a4f7d692c7067355da433bbb534531a4e1a55ac6
vim +1682 drivers/media/platform/marvell-ccic/mcam-core.c

abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1656  
abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1657  /* ---------------------------------------------------------------------- */
abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1658  /*
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1659   * Our various file operations.
abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1660   */
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1661  static int mcam_v4l_open(struct file *filp)
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1662  {
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1663  	struct mcam_camera *cam = video_drvdata(filp);
949bd408 drivers/media/platform/marvell-ccic/mcam-core.c Hans Verkuil    2015-03-05  1664  	int ret;
abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1665  
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1666  	mutex_lock(&cam->s_mutex);
949bd408 drivers/media/platform/marvell-ccic/mcam-core.c Hans Verkuil    2015-03-05  1667  	ret = v4l2_fh_open(filp);
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1668  	if (ret)
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1669  		goto out;
949bd408 drivers/media/platform/marvell-ccic/mcam-core.c Hans Verkuil    2015-03-05  1670  	if (v4l2_fh_is_singular_file(filp)) {
a4f7d692 drivers/media/platform/marvell-ccic/mcam-core.c Lubomir Rintel  2018-11-05  1671  		ret = sensor_call(cam, core, s_power, 1);
05fed816 drivers/media/platform/marvell-ccic/mcam-core.c Libin Yang      2013-07-03  1672  		if (ret)
a4f7d692 drivers/media/platform/marvell-ccic/mcam-core.c Lubomir Rintel  2018-11-05  1673  			return ret;
^^^^^^^^^^
This should be a goto out;

a4f7d692 drivers/media/platform/marvell-ccic/mcam-core.c Lubomir Rintel  2018-11-05  1674  		mcam_clk_enable(cam);
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1675  		__mcam_cam_reset(cam);
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1676  		mcam_set_config_needed(cam, 1);
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1677  	}
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1678  out:
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08  1679  	mutex_unlock(&cam->s_mutex);
44fbcb10 drivers/media/platform/marvell-ccic/mcam-core.c Hans Verkuil    2015-03-05  1680  	if (ret)
44fbcb10 drivers/media/platform/marvell-ccic/mcam-core.c Hans Verkuil    2015-03-05  1681  		v4l2_fh_release(filp);
d43dae75 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-07-08 @1682  	return ret;
a9b36e85 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-20  1683  }
abfa3df3 drivers/media/video/marvell-ccic/mcam-core.c    Jonathan Corbet 2011-06-11  1684  

:::::: The code at line 1682 was first introduced by commit
:::::: d43dae75cc1140bf27a59aa6d8e8bc7a00f009cc [media] marvell-cam: core code reorganization

:::::: TO: Jonathan Corbet <corbet@lwn.net>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
