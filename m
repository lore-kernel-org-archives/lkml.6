Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA82087A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="30dS8vQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DA82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeIWQ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 12:59:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58208 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 12:59:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8NAxeDW015960;
        Sun, 23 Sep 2018 11:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=zhfYydu8EkiizokEyYsKKQTDrtUfWVymQz2lkzhFA8Y=;
 b=30dS8vQ1DZQORBqUmR4Gq5C1KvgRPT+j2/1R8+6sjyQF5vzjjnrKWLJAAU00y/FrNPEM
 rTe0lO9enJQ+ZqIZFc1AU+kZmlyGtIicr6oQ7k1KVOgsU0Op91NegBKk82c3gmZt7HLJ
 51hELH8k+qdIwxduFc4RLoDymgN7MIk8gcxhRIq4oQmMD1dqZ8F+ii3EWC8Fvjlrs3k/
 r9Jv43MPtboPUR7pKXV4UwR3S9SwYWrRvMPl+zb80yfYfsjvAUVIctoYSoNTdImdysqt
 huwfvaFLxHoZO2e+/NHuYisBtPntIvMNWD4EmoayuRcvcdqXpqZsg5EfEyWliUEg7YB3 Sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mndpp26wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Sep 2018 11:01:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8NB1RxH032014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Sep 2018 11:01:27 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8NB1P09025362;
        Sun, 23 Sep 2018 11:01:26 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Sep 2018 04:01:25 -0700
Date:   Sun, 23 Sep 2018 14:01:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Song Qiang <songqiang1304521@gmail.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180923110115.vjnmfssmeq3i37pf@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920131340.6699-1-songqiang1304521@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9024 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809230120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-Add-support-for-PNI-RM3100-9-axis-magnetometer/20180920-215124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

smatch warnings:
drivers/iio/magnetometer/rm3100-core.c:235 rm3100_set_samp_freq() warn: inconsistent returns 'mutex:&data->lock'.
  Locked on:   line 206
  Unlocked on: line 194
drivers/iio/magnetometer/rm3100-core.c:319 rm3100_trigger_handler() warn: inconsistent returns 'mutex:&data->lock'.
  Locked on:   line 310
  Unlocked on: line 319

# https://github.com/0day-ci/linux/commit/0345472c15bab336397b25a25eb76a9f8586faf0
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 0345472c15bab336397b25a25eb76a9f8586faf0
vim +235 drivers/iio/magnetometer/rm3100-core.c

0345472c Song Qiang 2018-09-20  183  
0345472c Song Qiang 2018-09-20  184  static int rm3100_set_samp_freq(struct rm3100_data *data, int val, int val2)
0345472c Song Qiang 2018-09-20  185  {
0345472c Song Qiang 2018-09-20  186  	struct regmap *regmap = data->regmap;
0345472c Song Qiang 2018-09-20  187  	int cycle_count;
0345472c Song Qiang 2018-09-20  188  	int ret;
0345472c Song Qiang 2018-09-20  189  	int i;
0345472c Song Qiang 2018-09-20  190  
0345472c Song Qiang 2018-09-20  191  	/* All cycle count registers use the same value. */
0345472c Song Qiang 2018-09-20  192  	ret = regmap_read(regmap, RM_REG_CCXL, &cycle_count);
0345472c Song Qiang 2018-09-20  193  	if (cycle_count < 0)
0345472c Song Qiang 2018-09-20  194  		return cycle_count;
0345472c Song Qiang 2018-09-20  195  
0345472c Song Qiang 2018-09-20  196  	for (i = 0; i < RM_SAMP_NUM; i++) {
0345472c Song Qiang 2018-09-20  197  		if (val == rm3100_samp_rates[i][0] &&
0345472c Song Qiang 2018-09-20  198  			val2 == rm3100_samp_rates[i][1])
0345472c Song Qiang 2018-09-20  199  			break;
0345472c Song Qiang 2018-09-20  200  	}
0345472c Song Qiang 2018-09-20  201  
0345472c Song Qiang 2018-09-20  202  	if (i != RM_SAMP_NUM) {
0345472c Song Qiang 2018-09-20  203  		mutex_lock(&data->lock);
                                                ^^^^^^^^^^^^^^^^^^^^^^^
0345472c Song Qiang 2018-09-20  204  		ret = regmap_write(regmap, RM_REG_TMRC, i + RM_TMRC_OFFSET);
0345472c Song Qiang 2018-09-20  205  		if (ret < 0)
0345472c Song Qiang 2018-09-20  206  			return ret;
                                                        ^^^^^^^^^^
goto unlock;  there are a bunch of these.

0345472c Song Qiang 2018-09-20  207  
0345472c Song Qiang 2018-09-20  208  		/* Checking if cycle count registers need changing. */
0345472c Song Qiang 2018-09-20  209  		if (val == 600 && cycle_count == 200) {
0345472c Song Qiang 2018-09-20  210  			for (i = 0; i < 3; i++) {
0345472c Song Qiang 2018-09-20  211  				regmap_write(regmap, RM_REG_CCXL + 2 * i, 100);
0345472c Song Qiang 2018-09-20  212  				if (ret < 0)
0345472c Song Qiang 2018-09-20  213  					return ret;
0345472c Song Qiang 2018-09-20  214  			}
0345472c Song Qiang 2018-09-20  215  		} else if (val != 600 && cycle_count == 100) {
0345472c Song Qiang 2018-09-20  216  			for (i = 0; i < 3; i++) {
0345472c Song Qiang 2018-09-20  217  				regmap_write(regmap, RM_REG_CCXL + 2 * i, 200);
0345472c Song Qiang 2018-09-20  218  				if (ret < 0)
0345472c Song Qiang 2018-09-20  219  					return ret;
0345472c Song Qiang 2018-09-20  220  			}
0345472c Song Qiang 2018-09-20  221  		}
0345472c Song Qiang 2018-09-20  222  		/* Writing TMRC registers requires CMM reset. */
0345472c Song Qiang 2018-09-20  223  		ret = regmap_write(regmap, RM_REG_CMM, 0);
0345472c Song Qiang 2018-09-20  224  		if (ret < 0)
0345472c Song Qiang 2018-09-20  225  			return ret;
0345472c Song Qiang 2018-09-20  226  		ret = regmap_write(regmap, RM_REG_CMM, RM_CMM_PMX |
0345472c Song Qiang 2018-09-20  227  			RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
0345472c Song Qiang 2018-09-20  228  		if (ret < 0)
0345472c Song Qiang 2018-09-20  229  			return ret;
0345472c Song Qiang 2018-09-20  230  		mutex_unlock(&data->lock);
0345472c Song Qiang 2018-09-20  231  
0345472c Song Qiang 2018-09-20  232  		data->conversion_time = rm3100_samp_rates[i][2] + 3000;
0345472c Song Qiang 2018-09-20  233  		return 0;
0345472c Song Qiang 2018-09-20  234  	}
0345472c Song Qiang 2018-09-20 @235  	return -EINVAL;
0345472c Song Qiang 2018-09-20  236  }
0345472c Song Qiang 2018-09-20  237  
0345472c Song Qiang 2018-09-20  238  static int rm3100_read_raw(struct iio_dev *indio_dev,
0345472c Song Qiang 2018-09-20  239  			   const struct iio_chan_spec *chan,
0345472c Song Qiang 2018-09-20  240  			   int *val, int *val2, long mask)
0345472c Song Qiang 2018-09-20  241  {
0345472c Song Qiang 2018-09-20  242  	struct rm3100_data *data = iio_priv(indio_dev);
0345472c Song Qiang 2018-09-20  243  	int ret;
0345472c Song Qiang 2018-09-20  244  
0345472c Song Qiang 2018-09-20  245  	switch (mask) {
0345472c Song Qiang 2018-09-20  246  	case IIO_CHAN_INFO_RAW:
0345472c Song Qiang 2018-09-20  247  		ret = iio_device_claim_direct_mode(indio_dev);
0345472c Song Qiang 2018-09-20  248  		if (ret < 0)
0345472c Song Qiang 2018-09-20  249  			return ret;
0345472c Song Qiang 2018-09-20  250  		ret = rm3100_read_mag(data, chan->scan_index, val);
0345472c Song Qiang 2018-09-20  251  		iio_device_release_direct_mode(indio_dev);
0345472c Song Qiang 2018-09-20  252  
0345472c Song Qiang 2018-09-20  253  		return ret;
0345472c Song Qiang 2018-09-20  254  	case IIO_CHAN_INFO_SAMP_FREQ:
0345472c Song Qiang 2018-09-20  255  		return ret = rm3100_get_samp_freq(data, val, val2);
0345472c Song Qiang 2018-09-20  256  	default:
0345472c Song Qiang 2018-09-20  257  		return -EINVAL;
0345472c Song Qiang 2018-09-20  258  	}
0345472c Song Qiang 2018-09-20  259  }
0345472c Song Qiang 2018-09-20  260  
0345472c Song Qiang 2018-09-20  261  static int rm3100_write_raw(struct iio_dev *indio_dev,
0345472c Song Qiang 2018-09-20  262  			    struct iio_chan_spec const *chan,
0345472c Song Qiang 2018-09-20  263  			    int val, int val2, long mask)
0345472c Song Qiang 2018-09-20  264  {
0345472c Song Qiang 2018-09-20  265  	struct rm3100_data *data = iio_priv(indio_dev);
0345472c Song Qiang 2018-09-20  266  	int ret;
0345472c Song Qiang 2018-09-20  267  
0345472c Song Qiang 2018-09-20  268  	switch (mask) {
0345472c Song Qiang 2018-09-20  269  	case IIO_CHAN_INFO_SAMP_FREQ:
0345472c Song Qiang 2018-09-20  270  		ret = rm3100_set_samp_freq(data, val, val2);
0345472c Song Qiang 2018-09-20  271  		if (ret < 0)
0345472c Song Qiang 2018-09-20  272  			return ret;
0345472c Song Qiang 2018-09-20  273  		return 0;
0345472c Song Qiang 2018-09-20  274  	default:
0345472c Song Qiang 2018-09-20  275  		return -EINVAL;
0345472c Song Qiang 2018-09-20  276  	}
0345472c Song Qiang 2018-09-20  277  
0345472c Song Qiang 2018-09-20  278  }
0345472c Song Qiang 2018-09-20  279  
0345472c Song Qiang 2018-09-20  280  static const struct iio_info rm3100_info = {
0345472c Song Qiang 2018-09-20  281  	.read_raw = rm3100_read_raw,
0345472c Song Qiang 2018-09-20  282  	.write_raw = rm3100_write_raw,
0345472c Song Qiang 2018-09-20  283  };
0345472c Song Qiang 2018-09-20  284  
0345472c Song Qiang 2018-09-20  285  static irqreturn_t rm3100_trigger_handler(int irq, void *p)
0345472c Song Qiang 2018-09-20  286  {
0345472c Song Qiang 2018-09-20  287  	struct iio_poll_func *pf = p;
0345472c Song Qiang 2018-09-20  288  	struct iio_dev *indio_dev = pf->indio_dev;
0345472c Song Qiang 2018-09-20  289  	struct rm3100_data *data = iio_priv(indio_dev);
0345472c Song Qiang 2018-09-20  290  	struct regmap *regmap = data->regmap;
0345472c Song Qiang 2018-09-20  291  	u8 *buffer;
0345472c Song Qiang 2018-09-20  292  	int ret;
0345472c Song Qiang 2018-09-20  293  	int i;
0345472c Song Qiang 2018-09-20  294  
0345472c Song Qiang 2018-09-20  295  	buffer = devm_kzalloc(data->dev, indio_dev->scan_bytes, GFP_KERNEL);
0345472c Song Qiang 2018-09-20  296  	if (!buffer)
0345472c Song Qiang 2018-09-20  297  		goto done;
0345472c Song Qiang 2018-09-20  298  
0345472c Song Qiang 2018-09-20  299  	mutex_lock(&data->lock);
0345472c Song Qiang 2018-09-20  300  	ret = rm3100_wait_measurement(data);
0345472c Song Qiang 2018-09-20  301  	if (ret < 0) {
0345472c Song Qiang 2018-09-20  302  		mutex_unlock(&data->lock);
0345472c Song Qiang 2018-09-20  303  		goto done;
0345472c Song Qiang 2018-09-20  304  	}
0345472c Song Qiang 2018-09-20  305  
0345472c Song Qiang 2018-09-20  306  	for (i = 0; i < 3; i++) {
0345472c Song Qiang 2018-09-20  307  		ret = regmap_bulk_read(regmap, RM_REG_MX2 + 3 * i,
0345472c Song Qiang 2018-09-20  308  				buffer + 4 * i, 3);
0345472c Song Qiang 2018-09-20  309  		if (ret < 0)
0345472c Song Qiang 2018-09-20  310  			return ret;
0345472c Song Qiang 2018-09-20  311  	}
0345472c Song Qiang 2018-09-20  312  	mutex_unlock(&data->lock);
0345472c Song Qiang 2018-09-20  313  
0345472c Song Qiang 2018-09-20  314  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
0345472c Song Qiang 2018-09-20  315  			iio_get_time_ns(indio_dev));
0345472c Song Qiang 2018-09-20  316  done:
0345472c Song Qiang 2018-09-20  317  	iio_trigger_notify_done(indio_dev->trig);
0345472c Song Qiang 2018-09-20  318  
0345472c Song Qiang 2018-09-20 @319  	return IRQ_HANDLED;
0345472c Song Qiang 2018-09-20  320  }
0345472c Song Qiang 2018-09-20  321  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
