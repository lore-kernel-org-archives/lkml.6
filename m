Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594DAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BD52081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0DB0JmHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BD52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2W1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:27:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45200 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeK2W1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:27:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATBJFmw079939;
        Thu, 29 Nov 2018 11:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=4kfgYQcSIPn1y/6yJZQV43BXu6Z7poeKthZZSCTVAn0=;
 b=0DB0JmHusURTxyL+OicQQ7+/nrRE++68p2mOMsRVUgkLLJlWpzZYXdDz4ZhBFktVyCDt
 /mzPNDL0c5MJeK30Ge5fDL2F6WoKANSbT2KlRkLVR5KMLt5oVFUMqjlU0+EOYtYDvCdQ
 y/Cl/t6HV/AXpoohahb/7CGXF29AjUozeth7d2/IdjkqU068hKElZlqNae7H+QBtSIsr
 n2btF9f870sEULmGwXtjtIHvnY2BFElIy1y2mYDc2MH6cguTwtAEhqJFlFh2CouCm7EP
 WwYDNjtE/Bp75SVoNhq0mXFydzSWSN3ERtKSvMVKTLsCu6rPHag5hxHQbLtFtlxaWXi/ 7w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkqqkg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 11:21:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATBLsaM024781
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 11:21:54 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATBLs78001772;
        Thu, 29 Nov 2018 11:21:54 GMT
Received: from unbuntlaptop (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 03:21:53 -0800
Date:   Thu, 29 Nov 2018 14:21:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     kbuild-all@01.org, lee.jones@linaro.org, gwendal@chromium.org,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 5/7] mfd / platform: cros_ec: move device sysfs
 attributes to its own driver.
Message-ID: <20181129112141.GR3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122113356.23610-6-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/mfd-cros_ec-use-devm_mfd_add_devices/20181123-025253

smatch warnings:
drivers/platform/chrome/cros_ec_sysfs.c:366 cros_ec_sysfs_probe() warn: variable dereferenced before check 'ec_dev' (see line 362)

# https://github.com/0day-ci/linux/commit/b3074e331f36fff8890e7bd5c1f5874f4c59d38f
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout b3074e331f36fff8890e7bd5c1f5874f4c59d38f
vim +/ec_dev +366 drivers/platform/chrome/cros_ec_sysfs.c

b3074e33 Enric Balletbo i Serra 2018-11-22  358  
b3074e33 Enric Balletbo i Serra 2018-11-22  359  static int cros_ec_sysfs_probe(struct platform_device *pd)
b3074e33 Enric Balletbo i Serra 2018-11-22  360  {
b3074e33 Enric Balletbo i Serra 2018-11-22  361  	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
b3074e33 Enric Balletbo i Serra 2018-11-22 @362  	struct cros_ec_platform *ec_platform = dev_get_platdata(ec_dev->dev);
                                                                                                                ^^^^^^^^^^^
b3074e33 Enric Balletbo i Serra 2018-11-22  363  	struct device *dev = &pd->dev;
b3074e33 Enric Balletbo i Serra 2018-11-22  364  	int ret;
b3074e33 Enric Balletbo i Serra 2018-11-22  365  
b3074e33 Enric Balletbo i Serra 2018-11-22 @366  	if (!ec_dev) {
                                                             ^^^^^^
Presumable this test can be removed?

b3074e33 Enric Balletbo i Serra 2018-11-22  367  		dev_err(dev, "No EC dev found\n");
b3074e33 Enric Balletbo i Serra 2018-11-22  368  		return -EINVAL;
b3074e33 Enric Balletbo i Serra 2018-11-22  369  	}
b3074e33 Enric Balletbo i Serra 2018-11-22  370  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
