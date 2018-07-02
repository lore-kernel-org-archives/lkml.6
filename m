Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D70CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15E924662
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WyDpIAti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15E924662
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeGBF4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:56:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeGBF4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:56:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w625smP0022285;
        Mon, 2 Jul 2018 05:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=8sjdmq8HULbOUGwoOXOmRvUCduS4J3LzgUbnE1qsLwk=;
 b=WyDpIAti1rcFAaUKYcLr2X1nTsg26NK87GCnC+p2aWNGpIbc/bwhA8TuGhkHviw3/Y2B
 Vdjs4fsnPYFAZosPfCFUzAMWeAk85k/5t09r+27LhSToaRtzV0P7FOhvVPhS1jxAQ+SE
 SX8UyoJhYPx0BYvhtK++R3NDMi+htxLjGdIlrdBjZJQoPCYSx/1XGjnoXA0Ke0H3yd5T
 lUGVlJL1y0HAw9WBJpam6mveUqy0kVhaB4N29BZY3LSItrMBCtb5cO/td/x5OWRccWmb
 NsBmfK/1EeBv7j/SkMP/th6cPVf5uuvWrZTf5vw8kr5ul+YWtW5nxxXzCN0UBs+oqZ+I NQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jx2gptvmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 05:56:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w625u1EC032117
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 05:56:02 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w625txgf013689;
        Mon, 2 Jul 2018 05:55:59 GMT
Received: from mwanda (/197.157.34.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 22:55:58 -0700
Date:   Mon, 2 Jul 2018 08:55:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     kbuild-all@01.org, Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RESEND][PATCH v6 3/6] cx25840: add pin to pad mapping and
 output format configuration
Message-ID: <20180702055548.4puqbtjzgf2afyyb@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69af3169d998d78c4ce1fe8702ff795dbe89b4b7.1530305665.git.mail@maciej.szmigiero.name>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Maciej-S-Szmigiero/Add-analog-mode-support-for-Medion-MD95700/20180630-050341
base:   git://linuxtv.org/media_tree.git master

New smatch warnings:
drivers/media/i2c/cx25840/cx25840-core.c:468 cx25840_s_io_pin_config() warn: bitwise AND condition is false here

Old smatch warnings:
drivers/media/i2c/cx25840/cx25840-core.c:497 cx25840_s_io_pin_config() warn: bitwise AND condition is false here
drivers/media/i2c/cx25840/cx25840-core.c:526 cx25840_s_io_pin_config() warn: bitwise AND condition is false here

# https://github.com/0day-ci/linux/commit/64372f380e540a77b73d4628a585c9c92956a7fd
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 64372f380e540a77b73d4628a585c9c92956a7fd
vim +468 drivers/media/i2c/cx25840/cx25840-core.c

64372f38 Maciej S. Szmigiero 2018-06-29  435  
64372f38 Maciej S. Szmigiero 2018-06-29  436  static int cx25840_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
64372f38 Maciej S. Szmigiero 2018-06-29  437  				   struct v4l2_subdev_io_pin_config *p)
64372f38 Maciej S. Szmigiero 2018-06-29  438  {
64372f38 Maciej S. Szmigiero 2018-06-29  439  	struct i2c_client *client = v4l2_get_subdevdata(sd);
64372f38 Maciej S. Szmigiero 2018-06-29  440  	unsigned int i;
64372f38 Maciej S. Szmigiero 2018-06-29  441  	u8 pinctrl[6], pinconf[10], voutctrl4;
64372f38 Maciej S. Szmigiero 2018-06-29  442  
64372f38 Maciej S. Szmigiero 2018-06-29  443  	for (i = 0; i < 6; i++)
64372f38 Maciej S. Szmigiero 2018-06-29  444  		pinctrl[i] = cx25840_read(client, 0x114 + i);
64372f38 Maciej S. Szmigiero 2018-06-29  445  
64372f38 Maciej S. Szmigiero 2018-06-29  446  	for (i = 0; i < 10; i++)
64372f38 Maciej S. Szmigiero 2018-06-29  447  		pinconf[i] = cx25840_read(client, 0x11c + i);
64372f38 Maciej S. Szmigiero 2018-06-29  448  
64372f38 Maciej S. Szmigiero 2018-06-29  449  	voutctrl4 = cx25840_read(client, 0x407);
64372f38 Maciej S. Szmigiero 2018-06-29  450  
64372f38 Maciej S. Szmigiero 2018-06-29  451  	for (i = 0; i < n; i++) {
64372f38 Maciej S. Szmigiero 2018-06-29  452  		u8 strength = p[i].strength;
64372f38 Maciej S. Szmigiero 2018-06-29  453  
64372f38 Maciej S. Szmigiero 2018-06-29  454  		if (strength != CX25840_PIN_DRIVE_SLOW &&
64372f38 Maciej S. Szmigiero 2018-06-29  455  		    strength != CX25840_PIN_DRIVE_MEDIUM &&
64372f38 Maciej S. Szmigiero 2018-06-29  456  		    strength != CX25840_PIN_DRIVE_FAST) {
64372f38 Maciej S. Szmigiero 2018-06-29  457  
64372f38 Maciej S. Szmigiero 2018-06-29  458  			v4l_err(client,
64372f38 Maciej S. Szmigiero 2018-06-29  459  				"invalid drive speed for pin %u (%u), assuming fast\n",
64372f38 Maciej S. Szmigiero 2018-06-29  460  				(unsigned int)p[i].pin,
64372f38 Maciej S. Szmigiero 2018-06-29  461  				(unsigned int)strength);
64372f38 Maciej S. Szmigiero 2018-06-29  462  
64372f38 Maciej S. Szmigiero 2018-06-29  463  			strength = CX25840_PIN_DRIVE_FAST;
64372f38 Maciej S. Szmigiero 2018-06-29  464  		}
64372f38 Maciej S. Szmigiero 2018-06-29  465  
64372f38 Maciej S. Szmigiero 2018-06-29  466  		switch (p[i].pin) {
64372f38 Maciej S. Szmigiero 2018-06-29  467  		case CX25840_PIN_DVALID_PRGM0:
64372f38 Maciej S. Szmigiero 2018-06-29 @468  			if (p[i].flags & V4L2_SUBDEV_IO_PIN_DISABLE)

V4L2_SUBDEV_IO_PIN_DISABLE is zero.  It's sometimes used as a bit zero
BIT(V4L2_SUBDEV_IO_PIN_DISABLE) and presumably that's what is intended
here.

64372f38 Maciej S. Szmigiero 2018-06-29  469  				pinctrl[0] &= ~BIT(6);
64372f38 Maciej S. Szmigiero 2018-06-29  470  			else
64372f38 Maciej S. Szmigiero 2018-06-29  471  				pinctrl[0] |= BIT(6);
64372f38 Maciej S. Szmigiero 2018-06-29  472  
64372f38 Maciej S. Szmigiero 2018-06-29  473  			pinconf[3] &= 0xf0;
64372f38 Maciej S. Szmigiero 2018-06-29  474  			pinconf[3] |= cx25840_function_to_pad(client,
64372f38 Maciej S. Szmigiero 2018-06-29  475  							      p[i].function);
64372f38 Maciej S. Szmigiero 2018-06-29  476  
64372f38 Maciej S. Szmigiero 2018-06-29  477  			cx25840_set_invert(&pinctrl[3], &voutctrl4,
64372f38 Maciej S. Szmigiero 2018-06-29  478  					   p[i].function,
64372f38 Maciej S. Szmigiero 2018-06-29  479  					   CX25840_PIN_DVALID_PRGM0,
64372f38 Maciej S. Szmigiero 2018-06-29  480  					   p[i].flags &
64372f38 Maciej S. Szmigiero 2018-06-29  481  					   V4L2_SUBDEV_IO_PIN_ACTIVE_LOW);
64372f38 Maciej S. Szmigiero 2018-06-29  482  
64372f38 Maciej S. Szmigiero 2018-06-29  483  			pinctrl[4] &= ~(3 << 2); /* CX25840_PIN_DRIVE_MEDIUM */
64372f38 Maciej S. Szmigiero 2018-06-29  484  			switch (strength) {
64372f38 Maciej S. Szmigiero 2018-06-29  485  			case CX25840_PIN_DRIVE_SLOW:
64372f38 Maciej S. Szmigiero 2018-06-29  486  				pinctrl[4] |= 1 << 2;
64372f38 Maciej S. Szmigiero 2018-06-29  487  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  488  
64372f38 Maciej S. Szmigiero 2018-06-29  489  			case CX25840_PIN_DRIVE_FAST:
64372f38 Maciej S. Szmigiero 2018-06-29  490  				pinctrl[4] |= 2 << 2;
64372f38 Maciej S. Szmigiero 2018-06-29  491  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  492  			}
64372f38 Maciej S. Szmigiero 2018-06-29  493  
64372f38 Maciej S. Szmigiero 2018-06-29  494  			break;
64372f38 Maciej S. Szmigiero 2018-06-29  495  
64372f38 Maciej S. Szmigiero 2018-06-29  496  		case CX25840_PIN_HRESET_PRGM2:
64372f38 Maciej S. Szmigiero 2018-06-29  497  			if (p[i].flags & V4L2_SUBDEV_IO_PIN_DISABLE)
64372f38 Maciej S. Szmigiero 2018-06-29  498  				pinctrl[1] &= ~BIT(0);
64372f38 Maciej S. Szmigiero 2018-06-29  499  			else
64372f38 Maciej S. Szmigiero 2018-06-29  500  				pinctrl[1] |= BIT(0);
64372f38 Maciej S. Szmigiero 2018-06-29  501  
64372f38 Maciej S. Szmigiero 2018-06-29  502  			pinconf[4] &= 0xf0;
64372f38 Maciej S. Szmigiero 2018-06-29  503  			pinconf[4] |= cx25840_function_to_pad(client,
64372f38 Maciej S. Szmigiero 2018-06-29  504  							      p[i].function);
64372f38 Maciej S. Szmigiero 2018-06-29  505  
64372f38 Maciej S. Szmigiero 2018-06-29  506  			cx25840_set_invert(&pinctrl[3], &voutctrl4,
64372f38 Maciej S. Szmigiero 2018-06-29  507  					   p[i].function,
64372f38 Maciej S. Szmigiero 2018-06-29  508  					   CX25840_PIN_HRESET_PRGM2,
64372f38 Maciej S. Szmigiero 2018-06-29  509  					   p[i].flags &
64372f38 Maciej S. Szmigiero 2018-06-29  510  					   V4L2_SUBDEV_IO_PIN_ACTIVE_LOW);
64372f38 Maciej S. Szmigiero 2018-06-29  511  
64372f38 Maciej S. Szmigiero 2018-06-29  512  			pinctrl[4] &= ~(3 << 2); /* CX25840_PIN_DRIVE_MEDIUM */
64372f38 Maciej S. Szmigiero 2018-06-29  513  			switch (strength) {
64372f38 Maciej S. Szmigiero 2018-06-29  514  			case CX25840_PIN_DRIVE_SLOW:
64372f38 Maciej S. Szmigiero 2018-06-29  515  				pinctrl[4] |= 1 << 2;
64372f38 Maciej S. Szmigiero 2018-06-29  516  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  517  
64372f38 Maciej S. Szmigiero 2018-06-29  518  			case CX25840_PIN_DRIVE_FAST:
64372f38 Maciej S. Szmigiero 2018-06-29  519  				pinctrl[4] |= 2 << 2;
64372f38 Maciej S. Szmigiero 2018-06-29  520  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  521  			}
64372f38 Maciej S. Szmigiero 2018-06-29  522  
64372f38 Maciej S. Szmigiero 2018-06-29  523  			break;
64372f38 Maciej S. Szmigiero 2018-06-29  524  
64372f38 Maciej S. Szmigiero 2018-06-29  525  		case CX25840_PIN_PLL_CLK_PRGM7:
64372f38 Maciej S. Szmigiero 2018-06-29  526  			if (p[i].flags & V4L2_SUBDEV_IO_PIN_DISABLE)
64372f38 Maciej S. Szmigiero 2018-06-29  527  				pinctrl[2] &= ~BIT(2);
64372f38 Maciej S. Szmigiero 2018-06-29  528  			else
64372f38 Maciej S. Szmigiero 2018-06-29  529  				pinctrl[2] |= BIT(2);
64372f38 Maciej S. Szmigiero 2018-06-29  530  
64372f38 Maciej S. Szmigiero 2018-06-29  531  			switch (p[i].function) {
64372f38 Maciej S. Szmigiero 2018-06-29  532  			case CX25840_PAD_XTI_X5_DLL:
64372f38 Maciej S. Szmigiero 2018-06-29  533  				pinconf[6] = 0;
64372f38 Maciej S. Szmigiero 2018-06-29  534  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  535  
64372f38 Maciej S. Szmigiero 2018-06-29  536  			case CX25840_PAD_AUX_PLL:
64372f38 Maciej S. Szmigiero 2018-06-29  537  				pinconf[6] = 1;
64372f38 Maciej S. Szmigiero 2018-06-29  538  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  539  
64372f38 Maciej S. Szmigiero 2018-06-29  540  			case CX25840_PAD_VID_PLL:
64372f38 Maciej S. Szmigiero 2018-06-29  541  				pinconf[6] = 5;
64372f38 Maciej S. Szmigiero 2018-06-29  542  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  543  
64372f38 Maciej S. Szmigiero 2018-06-29  544  			case CX25840_PAD_XTI:
64372f38 Maciej S. Szmigiero 2018-06-29  545  				pinconf[6] = 2;
64372f38 Maciej S. Szmigiero 2018-06-29  546  				break;
64372f38 Maciej S. Szmigiero 2018-06-29  547  
64372f38 Maciej S. Szmigiero 2018-06-29  548  			default:
64372f38 Maciej S. Szmigiero 2018-06-29  549  				pinconf[6] = 3;
64372f38 Maciej S. Szmigiero 2018-06-29  550  				pinconf[6] |=
64372f38 Maciej S. Szmigiero 2018-06-29  551  					cx25840_function_to_pad(client,
64372f38 Maciej S. Szmigiero 2018-06-29  552  								p[i].function)
64372f38 Maciej S. Szmigiero 2018-06-29  553  					<< 4;
64372f38 Maciej S. Szmigiero 2018-06-29  554  			}
64372f38 Maciej S. Szmigiero 2018-06-29  555  
64372f38 Maciej S. Szmigiero 2018-06-29  556  			break;
64372f38 Maciej S. Szmigiero 2018-06-29  557  
64372f38 Maciej S. Szmigiero 2018-06-29  558  		default:
64372f38 Maciej S. Szmigiero 2018-06-29  559  			v4l_err(client, "invalid or unsupported pin %u\n",
64372f38 Maciej S. Szmigiero 2018-06-29  560  				(unsigned int)p[i].pin);
64372f38 Maciej S. Szmigiero 2018-06-29  561  			break;
64372f38 Maciej S. Szmigiero 2018-06-29  562  		}
64372f38 Maciej S. Szmigiero 2018-06-29  563  	}
64372f38 Maciej S. Szmigiero 2018-06-29  564  
64372f38 Maciej S. Szmigiero 2018-06-29  565  	cx25840_write(client, 0x407, voutctrl4);
64372f38 Maciej S. Szmigiero 2018-06-29  566  
64372f38 Maciej S. Szmigiero 2018-06-29  567  	for (i = 0; i < 6; i++)
64372f38 Maciej S. Szmigiero 2018-06-29  568  		cx25840_write(client, 0x114 + i, pinctrl[i]);
64372f38 Maciej S. Szmigiero 2018-06-29  569  
64372f38 Maciej S. Szmigiero 2018-06-29  570  	for (i = 0; i < 10; i++)
64372f38 Maciej S. Szmigiero 2018-06-29  571  		cx25840_write(client, 0x11c + i, pinconf[i]);
64372f38 Maciej S. Szmigiero 2018-06-29  572  
64372f38 Maciej S. Szmigiero 2018-06-29  573  	return 0;
64372f38 Maciej S. Szmigiero 2018-06-29  574  }
64372f38 Maciej S. Szmigiero 2018-06-29  575  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
