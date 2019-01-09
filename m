Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D149C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDB5206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFH4P5NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfAIJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:30:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAIJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:30:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x099T0o1071356;
        Wed, 9 Jan 2019 09:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AdoCB21R2rXFSYwqSCMMHByG8GM6T7u/C2obaxnrkJ8=;
 b=jFH4P5NX6AUoTRvAPlJRZQlkfCn8WDGQgGl4ctXMAU6UywSDIJYcspjN3JYVh8vxCYxD
 VBByBqCjCWMJKpHC8ihLfQFTJjKU8VyLtcsrNZmlFtyhC9zCDIvvtIjubWpEX31UjZc/
 vrEqIXN23LCy1yUkSWra7voIQpy5xhhHvrqXhh3zjUipSBNHC7oqLFHB1yqDp67O0yNx
 e6IED25zj34cp5RqA+wie3/Daj7fUXWp2FnEQvifhe/8OLz3o5OVeyBie107OFGHyBGt
 xPGF7adzquoesHs7z8rOsizFRGaHmMjonG4UnQfrBynvshEDjlv8vtkA0y8CTbiw9aTH uA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7r02ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 09:29:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x099TnCs015124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 09:29:49 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x099TkCT013245;
        Wed, 9 Jan 2019 09:29:47 GMT
Received: from kadam (/41.202.241.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jan 2019 01:29:35 -0800
Date:   Wed, 9 Jan 2019 12:29:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: Intel: bytcht_es8316: Set correct platform
 drvdata in snd_byt_cht_es8316_mc_probe()
Message-ID: <20190109092924.GB1743@kadam>
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the correct fix is actually this (untested):

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index cdf2061e7613..fa9c4cf97686 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 {
-	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
 	return 0;
