Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF0C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEB52082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKkaY2DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLCKl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:41:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:41:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3AdQxR029711;
        Mon, 3 Dec 2018 10:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=nRNvb8GYQS66hf6cQV6tfZFGvZT3rLCIIm6+DtMCM+U=;
 b=gKkaY2DG7TT2qb9WAHVoEvJIrzMgnkywnqU7mbIbubdo4hVKRt9KhxWzXG99FJ4Vb6qp
 qxvIFtlxeB+0eRnmFo40/dPUI10cdedj4I/9S9VnRfsn1iFhuBVLPa53L6cHfXaZ3ZNj
 z4eKj2GZ8Vg8BmU2lPpuDXDKScGwv5/vvLX2sBMUqvDxzr9yd2+QId/lWOpIASgBn85K
 0EIJBZ4o9UI/3eElTNJvevLGrG45LrwEKG8y4qzjq5cvCv50ER6BbzZt75LZ1PVg5THJ
 lIl30iMocSoMVtunJnR7Sz6BBpgqPRqbtcILOhQFPq6DmJJq9xwzzss3qDHzxbiLR+++ tg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqtngq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 10:40:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB3Aefkt010418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 10:40:42 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3AedjC011647;
        Mon, 3 Dec 2018 10:40:39 GMT
Received: from unbuntlaptop (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 02:40:39 -0800
Date:   Mon, 3 Dec 2018 13:42:28 +0300
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
Subject: Re: [PATCH 3/6] media: ov2659: get rid of extra ifdefs
Message-ID: <20181203104228.GC3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128171918.160643-4-lkundrak@v3.sk>
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
drivers/media/i2c/ov2659.c:1157 ov2659_set_fmt() warn: inconsistent returns 'mutex:&ov2659->lock'.
  Locked on:   line 1129
  Unlocked on: line 1119

# https://github.com/0day-ci/linux/commit/ceed6707bbb8d34fa04448a9eaf77a574dae59a8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout ceed6707bbb8d34fa04448a9eaf77a574dae59a8
vim +1157 drivers/media/i2c/ov2659.c

c4c0283a Benoit Parrot  2015-03-20  1098  
c4c0283a Benoit Parrot  2015-03-20  1099  static int ov2659_set_fmt(struct v4l2_subdev *sd,
c4c0283a Benoit Parrot  2015-03-20  1100  			  struct v4l2_subdev_pad_config *cfg,
c4c0283a Benoit Parrot  2015-03-20  1101  			  struct v4l2_subdev_format *fmt)
c4c0283a Benoit Parrot  2015-03-20  1102  {
c4c0283a Benoit Parrot  2015-03-20  1103  	struct i2c_client *client = v4l2_get_subdevdata(sd);
5f5859d1 Dan Carpenter  2015-04-15  1104  	int index = ARRAY_SIZE(ov2659_formats);
c4c0283a Benoit Parrot  2015-03-20  1105  	struct v4l2_mbus_framefmt *mf = &fmt->format;
c4c0283a Benoit Parrot  2015-03-20  1106  	const struct ov2659_framesize *size = NULL;
c4c0283a Benoit Parrot  2015-03-20  1107  	struct ov2659 *ov2659 = to_ov2659(sd);
c4c0283a Benoit Parrot  2015-03-20  1108  	int ret = 0;
c4c0283a Benoit Parrot  2015-03-20  1109  
c4c0283a Benoit Parrot  2015-03-20  1110  	dev_dbg(&client->dev, "ov2659_set_fmt\n");
c4c0283a Benoit Parrot  2015-03-20  1111  
c4c0283a Benoit Parrot  2015-03-20  1112  	__ov2659_try_frame_size(mf, &size);
c4c0283a Benoit Parrot  2015-03-20  1113  
c4c0283a Benoit Parrot  2015-03-20  1114  	while (--index >= 0)
c4c0283a Benoit Parrot  2015-03-20  1115  		if (ov2659_formats[index].code == mf->code)
c4c0283a Benoit Parrot  2015-03-20  1116  			break;
c4c0283a Benoit Parrot  2015-03-20  1117  
c4c0283a Benoit Parrot  2015-03-20  1118  	if (index < 0)
c4c0283a Benoit Parrot  2015-03-20  1119  		return -EINVAL;
c4c0283a Benoit Parrot  2015-03-20  1120  
c4c0283a Benoit Parrot  2015-03-20  1121  	mf->colorspace = V4L2_COLORSPACE_SRGB;
c4c0283a Benoit Parrot  2015-03-20  1122  	mf->field = V4L2_FIELD_NONE;
c4c0283a Benoit Parrot  2015-03-20  1123  
c4c0283a Benoit Parrot  2015-03-20  1124  	mutex_lock(&ov2659->lock);
c4c0283a Benoit Parrot  2015-03-20  1125  
c4c0283a Benoit Parrot  2015-03-20  1126  	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
c4c0283a Benoit Parrot  2015-03-20  1127  		mf = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
ceed6707 Lubomir Rintel 2018-11-28  1128  		if (IS_ERR(mf))
ceed6707 Lubomir Rintel 2018-11-28  1129  			return PTR_ERR(mf);
                                                                ^^^^^^^^^^^^^^^^^^
goto unlock;

c4c0283a Benoit Parrot  2015-03-20  1130  		*mf = fmt->format;
c4c0283a Benoit Parrot  2015-03-20  1131  	} else {
c4c0283a Benoit Parrot  2015-03-20  1132  		s64 val;
c4c0283a Benoit Parrot  2015-03-20  1133  
c4c0283a Benoit Parrot  2015-03-20  1134  		if (ov2659->streaming) {
c4c0283a Benoit Parrot  2015-03-20  1135  			mutex_unlock(&ov2659->lock);
c4c0283a Benoit Parrot  2015-03-20  1136  			return -EBUSY;
c4c0283a Benoit Parrot  2015-03-20  1137  		}
c4c0283a Benoit Parrot  2015-03-20  1138  
c4c0283a Benoit Parrot  2015-03-20  1139  		ov2659->frame_size = size;
c4c0283a Benoit Parrot  2015-03-20  1140  		ov2659->format = fmt->format;
c4c0283a Benoit Parrot  2015-03-20  1141  		ov2659->format_ctrl_regs =
c4c0283a Benoit Parrot  2015-03-20  1142  			ov2659_formats[index].format_ctrl_regs;
c4c0283a Benoit Parrot  2015-03-20  1143  
c4c0283a Benoit Parrot  2015-03-20  1144  		if (ov2659->format.code != MEDIA_BUS_FMT_SBGGR8_1X8)
c4c0283a Benoit Parrot  2015-03-20  1145  			val = ov2659->pdata->link_frequency / 2;
c4c0283a Benoit Parrot  2015-03-20  1146  		else
c4c0283a Benoit Parrot  2015-03-20  1147  			val = ov2659->pdata->link_frequency;
c4c0283a Benoit Parrot  2015-03-20  1148  
c4c0283a Benoit Parrot  2015-03-20  1149  		ret = v4l2_ctrl_s_ctrl_int64(ov2659->link_frequency, val);
c4c0283a Benoit Parrot  2015-03-20  1150  		if (ret < 0)
c4c0283a Benoit Parrot  2015-03-20  1151  			dev_warn(&client->dev,
c4c0283a Benoit Parrot  2015-03-20  1152  				 "failed to set link_frequency rate (%d)\n",
c4c0283a Benoit Parrot  2015-03-20  1153  				 ret);
c4c0283a Benoit Parrot  2015-03-20  1154  	}
c4c0283a Benoit Parrot  2015-03-20  1155  
c4c0283a Benoit Parrot  2015-03-20  1156  	mutex_unlock(&ov2659->lock);
c4c0283a Benoit Parrot  2015-03-20 @1157  	return ret;
c4c0283a Benoit Parrot  2015-03-20  1158  }
c4c0283a Benoit Parrot  2015-03-20  1159  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
