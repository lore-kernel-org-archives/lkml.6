Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9362AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0B82145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJ7QyVRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0B82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeJRTix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:38:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbeJRTix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:38:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9IBYEQt102127;
        Thu, 18 Oct 2018 11:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=UQk+xpKDyC/fGkXE+iw+IjXAukZ+9vxURVAMx3pt4jw=;
 b=iJ7QyVRyx9CVjugqYq+0DlKQYjs0ud9V73P1CAL0CK4rV/lL1SgIhH1c4BV92coTCCF1
 64NAf0qxrSCMWLViQGM8I39k7wt8lIdxXkIZYrLKc6VuYlbhp2luo5KBGfqJmNyneBS/
 3RR2VO9EGwpme7mHyZn9nKi7c2NGy0RP65sHJS0IYnVFY3rTOg7bewpaSO0YcgOa6UoU
 58K5v9p7qLxTcauDySakub9kqUW3cUUXvsymKwQ6mpz7GU4RKOvZpv6662Rsk4L6DYfx
 kgfjjvz4bTjRxavlrZqZ8o/o6Fwh5qLZJGxChcA6W9jdd/XgWUSytvmvtFX9ioBbk4uR vA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brnssu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 11:37:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9IBbquI023338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 11:37:52 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9IBbprt016676;
        Thu, 18 Oct 2018 11:37:51 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 04:37:50 -0700
Date:   Thu, 18 Oct 2018 14:37:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     kbuild-all@01.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181018113743.lafgvpc43bickkln@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017012426.26958-2-nicoleotsuka@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Nicolin-Chen/hwmon-ina3221-Implement-PM-runtime-to-save-power/20181018-010754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next

smatch warnings:
drivers/hwmon/hwmon.c:631 __hwmon_device_register() warn: variable dereferenced before check 'dev' (see line 628)

# https://github.com/0day-ci/linux/commit/aa912316f2d30d4e699ac2f11b6197a4da011274
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout aa912316f2d30d4e699ac2f11b6197a4da011274
vim +/dev +631 drivers/hwmon/hwmon.c

d560168b Guenter Roeck    2015-08-26  562  
d560168b Guenter Roeck    2015-08-26  563  static struct device *
d560168b Guenter Roeck    2015-08-26  564  __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
d560168b Guenter Roeck    2015-08-26  565  			const struct hwmon_chip_info *chip,
bab2243c Guenter Roeck    2013-07-06  566  			const struct attribute_group **groups)
1236441f Mark M. Hoffman  2005-07-15  567  {
bab2243c Guenter Roeck    2013-07-06  568  	struct hwmon_device *hwdev;
d560168b Guenter Roeck    2015-08-26  569  	struct device *hdev;
d560168b Guenter Roeck    2015-08-26  570  	int i, j, err, id;
ded2b666 Mark M. Hoffman  2006-03-05  571  
74d3b641 Guenter Roeck    2017-01-27  572  	/* Complain about invalid characters in hwmon name attribute */
648cd48c Guenter Roeck    2014-02-28  573  	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
74d3b641 Guenter Roeck    2017-01-27  574  		dev_warn(dev,
74d3b641 Guenter Roeck    2017-01-27  575  			 "hwmon: '%s' is not a valid name attribute, please fix\n",
74d3b641 Guenter Roeck    2017-01-27  576  			 name);
648cd48c Guenter Roeck    2014-02-28  577  
4ca5f468 Jonathan Cameron 2011-10-31  578  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
4ca5f468 Jonathan Cameron 2011-10-31  579  	if (id < 0)
4ca5f468 Jonathan Cameron 2011-10-31  580  		return ERR_PTR(id);
1236441f Mark M. Hoffman  2005-07-15  581  
bab2243c Guenter Roeck    2013-07-06  582  	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
bab2243c Guenter Roeck    2013-07-06  583  	if (hwdev == NULL) {
bab2243c Guenter Roeck    2013-07-06  584  		err = -ENOMEM;
bab2243c Guenter Roeck    2013-07-06  585  		goto ida_remove;
bab2243c Guenter Roeck    2013-07-06  586  	}
1236441f Mark M. Hoffman  2005-07-15  587  
d560168b Guenter Roeck    2015-08-26  588  	hdev = &hwdev->dev;
d560168b Guenter Roeck    2015-08-26  589  
239552f4 Guenter Roeck    2016-10-16  590  	if (chip) {
d560168b Guenter Roeck    2015-08-26  591  		struct attribute **attrs;
b2a4cc3a Guenter Roeck    2016-10-16  592  		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
d560168b Guenter Roeck    2015-08-26  593  
d560168b Guenter Roeck    2015-08-26  594  		if (groups)
d560168b Guenter Roeck    2015-08-26  595  			for (i = 0; groups[i]; i++)
d560168b Guenter Roeck    2015-08-26  596  				ngroups++;
d560168b Guenter Roeck    2015-08-26  597  
d560168b Guenter Roeck    2015-08-26  598  		hwdev->groups = devm_kcalloc(dev, ngroups, sizeof(*groups),
d560168b Guenter Roeck    2015-08-26  599  					     GFP_KERNEL);
38d8ed65 Colin Ian King   2016-10-23  600  		if (!hwdev->groups) {
38d8ed65 Colin Ian King   2016-10-23  601  			err = -ENOMEM;
38d8ed65 Colin Ian King   2016-10-23  602  			goto free_hwmon;
38d8ed65 Colin Ian King   2016-10-23  603  		}
d560168b Guenter Roeck    2015-08-26  604  
d560168b Guenter Roeck    2015-08-26  605  		attrs = __hwmon_create_attrs(dev, drvdata, chip);
d560168b Guenter Roeck    2015-08-26  606  		if (IS_ERR(attrs)) {
d560168b Guenter Roeck    2015-08-26  607  			err = PTR_ERR(attrs);
d560168b Guenter Roeck    2015-08-26  608  			goto free_hwmon;
d560168b Guenter Roeck    2015-08-26  609  		}
d560168b Guenter Roeck    2015-08-26  610  
d560168b Guenter Roeck    2015-08-26  611  		hwdev->group.attrs = attrs;
d560168b Guenter Roeck    2015-08-26  612  		ngroups = 0;
d560168b Guenter Roeck    2015-08-26  613  		hwdev->groups[ngroups++] = &hwdev->group;
d560168b Guenter Roeck    2015-08-26  614  
d560168b Guenter Roeck    2015-08-26  615  		if (groups) {
d560168b Guenter Roeck    2015-08-26  616  			for (i = 0; groups[i]; i++)
d560168b Guenter Roeck    2015-08-26  617  				hwdev->groups[ngroups++] = groups[i];
d560168b Guenter Roeck    2015-08-26  618  		}
d560168b Guenter Roeck    2015-08-26  619  
d560168b Guenter Roeck    2015-08-26  620  		hdev->groups = hwdev->groups;
d560168b Guenter Roeck    2015-08-26  621  	} else {
d560168b Guenter Roeck    2015-08-26  622  		hdev->groups = groups;
d560168b Guenter Roeck    2015-08-26  623  	}
d560168b Guenter Roeck    2015-08-26  624  
bab2243c Guenter Roeck    2013-07-06  625  	hwdev->name = name;
d560168b Guenter Roeck    2015-08-26  626  	hdev->class = &hwmon_class;
d560168b Guenter Roeck    2015-08-26  627  	hdev->parent = dev;
aa912316 Nicolin Chen     2018-10-16 @628  	hdev->driver = dev->driver;
                                                               ^^^^^^^^^^^
aa912316 Nicolin Chen     2018-10-16  629  	hdev->power = dev->power;
                                                              ^^^^^^^^^^
aa912316 Nicolin Chen     2018-10-16  630  	hdev->pm_domain = dev->pm_domain;
                                                                  ^^^^^^^^^^^^^^
The patch adds unchecked dereferences.

d560168b Guenter Roeck    2015-08-26 @631  	hdev->of_node = dev ? dev->of_node : NULL;
                                                                ^^^
The old code checks for NULL.

d560168b Guenter Roeck    2015-08-26  632  	hwdev->chip = chip;
d560168b Guenter Roeck    2015-08-26  633  	dev_set_drvdata(hdev, drvdata);
d560168b Guenter Roeck    2015-08-26  634  	dev_set_name(hdev, HWMON_ID_FORMAT, id);
d560168b Guenter Roeck    2015-08-26  635  	err = device_register(hdev);
bab2243c Guenter Roeck    2013-07-06  636  	if (err)
d560168b Guenter Roeck    2015-08-26  637  		goto free_hwmon;
d560168b Guenter Roeck    2015-08-26  638  
319fe159 Guenter Roeck    2017-01-31  639  	if (dev && chip && chip->ops->read &&
d560168b Guenter Roeck    2015-08-26  640  	    chip->info[0]->type == hwmon_chip &&
d560168b Guenter Roeck    2015-08-26  641  	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
d560168b Guenter Roeck    2015-08-26  642  		const struct hwmon_channel_info **info = chip->info;
d560168b Guenter Roeck    2015-08-26  643  
d560168b Guenter Roeck    2015-08-26  644  		for (i = 1; info[i]; i++) {
d560168b Guenter Roeck    2015-08-26  645  			if (info[i]->type != hwmon_temp)
d560168b Guenter Roeck    2015-08-26  646  				continue;
d560168b Guenter Roeck    2015-08-26  647  
d560168b Guenter Roeck    2015-08-26  648  			for (j = 0; info[i]->config[j]; j++) {
d560168b Guenter Roeck    2015-08-26  649  				if (!chip->ops->is_visible(drvdata, hwmon_temp,
d560168b Guenter Roeck    2015-08-26  650  							   hwmon_temp_input, j))
d560168b Guenter Roeck    2015-08-26  651  					continue;
47c332de Linus Walleij    2017-12-05  652  				if (info[i]->config[j] & HWMON_T_INPUT) {
47c332de Linus Walleij    2017-12-05  653  					err = hwmon_thermal_add_sensor(dev,
47c332de Linus Walleij    2017-12-05  654  								hwdev, j);
47c332de Linus Walleij    2017-12-05  655  					if (err)
47c332de Linus Walleij    2017-12-05  656  						goto free_device;
47c332de Linus Walleij    2017-12-05  657  				}
d560168b Guenter Roeck    2015-08-26  658  			}
d560168b Guenter Roeck    2015-08-26  659  		}
d560168b Guenter Roeck    2015-08-26  660  	}
bab2243c Guenter Roeck    2013-07-06  661  
d560168b Guenter Roeck    2015-08-26  662  	return hdev;
bab2243c Guenter Roeck    2013-07-06  663  
47c332de Linus Walleij    2017-12-05  664  free_device:
47c332de Linus Walleij    2017-12-05  665  	device_unregister(hdev);
d560168b Guenter Roeck    2015-08-26  666  free_hwmon:
bab2243c Guenter Roeck    2013-07-06  667  	kfree(hwdev);
bab2243c Guenter Roeck    2013-07-06  668  ida_remove:
4ca5f468 Jonathan Cameron 2011-10-31  669  	ida_simple_remove(&hwmon_ida, id);
bab2243c Guenter Roeck    2013-07-06  670  	return ERR_PTR(err);
bab2243c Guenter Roeck    2013-07-06  671  }
d560168b Guenter Roeck    2015-08-26  672  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
