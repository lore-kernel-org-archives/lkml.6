Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EBC20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IF4R5bA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfAIJlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:41:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:41:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x099YTrA120049;
        Wed, 9 Jan 2019 09:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XtsWQdeBiWKeqbA0ReMuybCIR15EaiwRfnUIR99WF/I=;
 b=IF4R5bA2wXUkIgLx8bgD+oDnmf6BccjjRwKcVy7AZ1Ys24T/pYQp1MBQdhxKzMVWvd8R
 auMCZ2vauEhtlUH3A1DNczME4EnRC9N6wEPDxy/3/Q2uiV/LKyNuqyoavbQ3pLxOvVtN
 jbJDCKbr/hj4Rnypl1RdQpDomYoELo2uRwMW2vFgKGiML2H+XcuoTfsJQmxUIfUCrH+9
 vYJSnsyN6pEY8wZW1hPIvWxDcKez37Vqhmg7rqvQ9kgaOyBcTrD7nERe43Bnolyc2u2g
 UsD/NIiLJLwa4Os3ciqlAW4lB5Z265U9TWnIjTPP/srnHLxpgimLlWyYDbHzLX4GsMip /A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ptm0u8c1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 09:41:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x099fOwq009708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 09:41:24 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x099fLFx001542;
        Wed, 9 Jan 2019 09:41:23 GMT
Received: from kadam (/41.202.241.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jan 2019 01:40:54 -0800
Date:   Wed, 9 Jan 2019 12:40:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: Intel: bytcht_es8316: Set correct platform
 drvdata in snd_byt_cht_es8316_mc_probe()
Message-ID: <20190109094039.GD1718@kadam>
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <20190109092924.GB1743@kadam>
 <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:33:38AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 09-01-19 10:29, Dan Carpenter wrote:
> > I think the correct fix is actually this (untested):
> 
> Right, I'm pretty sure the soc framework depends on dev_get_drvdata
> returning the snd_soc_card and I forgot about this when adding
> the remove function.
> 
> Wei Yongjun, thank you for catching this.
> 
> Dan, thank you for the correct version of the patch :)
> 
> Dan, can you do an official submission of the correct version of the
> patch, with a Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
> or shall I submit your version upstream ?

Wei can resend and get authorship credit.  I only wrote the patch by
accident because it was easier than explaining.  (Or if you really don't
want to, Wei, then message me and I will do it).

regards,
dan carpenter

