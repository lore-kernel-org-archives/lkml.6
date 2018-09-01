Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B3CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF612083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsPvfm4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF612083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIAO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:57:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:57:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w81Aj4Kk168800;
        Sat, 1 Sep 2018 10:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=WJ5nYJklBZ7fxOb0YUAm04IlUMVXpKEgbKuWPYs87zU=;
 b=DsPvfm4Plp9ZbD1da3iov0Ghr045uZg+oDajKL7ipMgcEeVyDwD0juspBnAVC7UluC6R
 lH/oNZZMpoPIFkvbX8C95LMn/8occyLMpTHFd1s1xQIxOzSTx4w3l/SkOo7LvjFxN1yi
 2M9zD4MFbiE2xIIaWrcgjPN0TCvg69LutZKftPnjIOuv1ZG+Z9pLJKETN/zl2FZtr5H+
 tdO8iziCF7MLJfeovRrsGl6fzyy4hODzoJ2ohh6zWTewXdUhHlIZCv9lM/V6HoYSSP10
 /9VQJvebyDQjRXJ+C6nYpAcxkx6wu65oi6fIURyAw06N8pBtHQXEZvYO/xCB3LTwPM6r qw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m7j6t1620-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Sep 2018 10:46:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w81Ak5mN028521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Sep 2018 10:46:05 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w81Ak4hW014377;
        Sat, 1 Sep 2018 10:46:04 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 01 Sep 2018 03:46:04 -0700
Date:   Sat, 1 Sep 2018 13:45:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Subject: Re: [PATCH mfd+gpio 1/2] drivers: mfd: Add support for Moxtet bus
Message-ID: <20180901104556.ldj4vftjfb5glbmz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830144151.13417-1-marek.behun@nic.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9002 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809010121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Marek-Beh-n/drivers-mfd-Add-support-for-Moxtet-bus/20180831-031806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next

smatch warnings:
drivers/mfd/moxtet.c:267 of_register_moxtet_device() warn: passing zero to 'ERR_PTR'

# https://github.com/0day-ci/linux/commit/316bda5c94917aa3b0a67c3cf79cca211d08138d
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 316bda5c94917aa3b0a67c3cf79cca211d08138d
vim +/ERR_PTR +267 drivers/mfd/moxtet.c

316bda5c Marek Behún 2018-08-30  213  
316bda5c Marek Behún 2018-08-30  214  static struct moxtet_device *
316bda5c Marek Behún 2018-08-30  215  of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
316bda5c Marek Behún 2018-08-30  216  {
316bda5c Marek Behún 2018-08-30  217  	struct moxtet_device *dev;
316bda5c Marek Behún 2018-08-30  218  	u32 val;
316bda5c Marek Behún 2018-08-30  219  	int ret;
316bda5c Marek Behún 2018-08-30  220  
316bda5c Marek Behún 2018-08-30  221  	dev = moxtet_alloc_device(moxtet);
316bda5c Marek Behún 2018-08-30  222  	if (!dev) {
316bda5c Marek Behún 2018-08-30  223  		dev_err(moxtet->dev,
316bda5c Marek Behún 2018-08-30  224  			"Moxtet device alloc error for %pOF\n", nc);
316bda5c Marek Behún 2018-08-30  225  		return ERR_PTR(-ENOMEM);
316bda5c Marek Behún 2018-08-30  226  	}
316bda5c Marek Behún 2018-08-30  227  
316bda5c Marek Behún 2018-08-30  228  	ret = of_property_read_u32(nc, "reg", &val);
316bda5c Marek Behún 2018-08-30  229  	if (ret || val >= TURRIS_MOX_MAX_MODULES) {
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
No error code set.  It means we return NULL.  Presumably it leads to a
NULL dereference in the caller?

316bda5c Marek Behún 2018-08-30  230  		dev_err(moxtet->dev, "%pOF has no valid 'reg' property (%d)\n",
316bda5c Marek Behún 2018-08-30  231  			nc, ret);
316bda5c Marek Behún 2018-08-30  232  		goto err_put;
316bda5c Marek Behún 2018-08-30  233  	}
316bda5c Marek Behún 2018-08-30  234  	dev->idx = val;
316bda5c Marek Behún 2018-08-30  235  
316bda5c Marek Behún 2018-08-30  236  	ret = of_property_read_u32(nc, "moxtet,id", &val);
316bda5c Marek Behún 2018-08-30  237  	if (ret || val > 0xf) {
                                                   ^^^^^^^^^

316bda5c Marek Behún 2018-08-30  238  		dev_err(moxtet->dev,
316bda5c Marek Behún 2018-08-30  239  			"%pOF has no valid 'moxtet,id' property (%d)\n", nc,
316bda5c Marek Behún 2018-08-30  240  			ret);
316bda5c Marek Behún 2018-08-30  241  		goto err_put;
316bda5c Marek Behún 2018-08-30  242  	}
316bda5c Marek Behún 2018-08-30  243  	dev->id = val;
316bda5c Marek Behún 2018-08-30  244  
316bda5c Marek Behún 2018-08-30  245  	if (moxtet->modules[dev->idx] != dev->id) {
316bda5c Marek Behún 2018-08-30  246  		dev_err(moxtet->dev,
316bda5c Marek Behún 2018-08-30  247  			"%pOF requested Moxtet device ID 0x%x, 0x%x found\n",
316bda5c Marek Behún 2018-08-30  248  			nc, dev->id, moxtet->modules[dev->idx]);
316bda5c Marek Behún 2018-08-30  249  		goto err_put;
                                                ^^^^^^^^^^^^

316bda5c Marek Behún 2018-08-30  250  	}
316bda5c Marek Behún 2018-08-30  251  
316bda5c Marek Behún 2018-08-30  252  	of_node_get(nc);
316bda5c Marek Behún 2018-08-30  253  	dev->dev.of_node = nc;
316bda5c Marek Behún 2018-08-30  254  
316bda5c Marek Behún 2018-08-30  255  	ret = moxtet_add_device(dev);
316bda5c Marek Behún 2018-08-30  256  	if (ret) {
316bda5c Marek Behún 2018-08-30  257  		dev_err(moxtet->dev,
316bda5c Marek Behún 2018-08-30  258  			"Moxtet device register error for %pOF\n", nc);
316bda5c Marek Behún 2018-08-30  259  		of_node_put(nc);
316bda5c Marek Behún 2018-08-30  260  		goto err_put;
316bda5c Marek Behún 2018-08-30  261  	}
316bda5c Marek Behún 2018-08-30  262  
316bda5c Marek Behún 2018-08-30  263  	return dev;
316bda5c Marek Behún 2018-08-30  264  
316bda5c Marek Behún 2018-08-30  265  err_put:
316bda5c Marek Behún 2018-08-30  266  	put_device(&dev->dev);
316bda5c Marek Behún 2018-08-30 @267  	return ERR_PTR(ret);
316bda5c Marek Behún 2018-08-30  268  }
316bda5c Marek Behún 2018-08-30  269  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
