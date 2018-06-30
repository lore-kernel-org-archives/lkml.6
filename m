Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2804C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4327029
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdXt4cSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB4327029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbeF3I24 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:28:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbeF3I2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:28:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5U8Sdk9012873;
        Sat, 30 Jun 2018 08:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=tUH7OjOMsXQdVnt6WpKoJyB6mJ3riNKUgNvnZRbR66A=;
 b=GdXt4cSvHe7/yrjDUMd4zl3r84BdPi7Jdma+3A7IYtXMUBprY9Xw2Pq5NCKJKnLagq78
 d0oSMOVfl5o45WmxNK1LZN9ydQovCfFYC+l4pzPVgCwT92wsqRpKG8SO8ks8cmpd5e3U
 A8s3TqCJnG8tcGWeUetvEMpBTJAqNNSczQhtchYoSOjcZ3t9rts1IlZqsMDCAjlLQvYR
 PKdgbeG4cglOT4E7e8HeOQgbZiejt5hPCthcXxOFRf9Cv1FZB8f6oAUITfF2GJ34E8Jr
 9yleDmqJvTpgajxkRma64UwrGDBsTpgzVw9J2l8g6sjTHzuJCbuwSH4YPyEfRZ64PtJt 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jx2gpr6sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 08:28:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5U8SeOv024776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jun 2018 08:28:41 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5U8Sbv7016295;
        Sat, 30 Jun 2018 08:28:37 GMT
Received: from mwanda (/197.157.0.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 Jun 2018 01:28:37 -0700
Date:   Sat, 30 Jun 2018 11:28:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Jerome Brunet <jbrunet@baylibre.com>
Cc:     kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: es7241: add es7241 codec support
Message-ID: <20180630082829.qwnhkk4f76n32omm@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629152444.21525-3-jbrunet@baylibre.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806300100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc2 next-20180629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ASoC-add-es7241-support/20180630-021159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

smatch warnings:
sound/soc/codecs/es7241.c:147 es7241_set_fmt() warn: missing break? reassigning 'priv->is_slave'

# https://github.com/0day-ci/linux/commit/d494a70ae50e5f95d2ab09bcaf3065b4359bde0e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d494a70ae50e5f95d2ab09bcaf3065b4359bde0e
vim +147 sound/soc/codecs/es7241.c

d494a70a Jerome Brunet 2018-06-29  123  
d494a70a Jerome Brunet 2018-06-29  124  static int es7241_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
d494a70a Jerome Brunet 2018-06-29  125  {
d494a70a Jerome Brunet 2018-06-29  126  	struct es7241_data *priv = snd_soc_dai_get_drvdata(dai);
d494a70a Jerome Brunet 2018-06-29  127  
d494a70a Jerome Brunet 2018-06-29  128  	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
d494a70a Jerome Brunet 2018-06-29  129  		dev_err(dai->dev, "Unsupported dai clock inversion\n");
d494a70a Jerome Brunet 2018-06-29  130  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  131  	}
d494a70a Jerome Brunet 2018-06-29  132  
d494a70a Jerome Brunet 2018-06-29  133  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
d494a70a Jerome Brunet 2018-06-29  134  	case SND_SOC_DAIFMT_I2S:
d494a70a Jerome Brunet 2018-06-29  135  	case SND_SOC_DAIFMT_LEFT_J:
d494a70a Jerome Brunet 2018-06-29  136  		break;
d494a70a Jerome Brunet 2018-06-29  137  
d494a70a Jerome Brunet 2018-06-29  138  	default:
d494a70a Jerome Brunet 2018-06-29  139  		dev_err(dai->dev, "Unsupported dai format\n");
d494a70a Jerome Brunet 2018-06-29  140  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  141  	}
d494a70a Jerome Brunet 2018-06-29  142  
d494a70a Jerome Brunet 2018-06-29  143  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
d494a70a Jerome Brunet 2018-06-29  144  	case SND_SOC_DAIFMT_CBS_CFS:
d494a70a Jerome Brunet 2018-06-29  145  		priv->is_slave = true;
d494a70a Jerome Brunet 2018-06-29  146  	case SND_SOC_DAIFMT_CBM_CFM:
d494a70a Jerome Brunet 2018-06-29 @147  		priv->is_slave = false;
d494a70a Jerome Brunet 2018-06-29  148  		break;
d494a70a Jerome Brunet 2018-06-29  149  
d494a70a Jerome Brunet 2018-06-29  150  	default:
d494a70a Jerome Brunet 2018-06-29  151  		dev_err(dai->dev, "Unsupported clock configuration\n");
d494a70a Jerome Brunet 2018-06-29  152  		return -EINVAL;
d494a70a Jerome Brunet 2018-06-29  153  	}
d494a70a Jerome Brunet 2018-06-29  154  
d494a70a Jerome Brunet 2018-06-29  155  	return 0;
d494a70a Jerome Brunet 2018-06-29  156  }
d494a70a Jerome Brunet 2018-06-29  157  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
