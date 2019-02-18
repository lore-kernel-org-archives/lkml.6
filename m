Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927D921736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ahd4lZy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbfBROmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:42:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfBROmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:42:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1IEcqk2069955;
        Mon, 18 Feb 2019 14:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Sdh5gxVK+gZ9BiZKjcXGLF0oqJBlvYU82+RTEeFhQbI=;
 b=Ahd4lZy0q/FcjwDQtFqoSSVlNNGS/a1hDOXzgBFA5/NEDg83SrqpF9Cub+QkPv/7O6tC
 czVAiNRzBugQq3h+3ddHSwjtz5fpZRrLnovg7UOVVCMrZcSYxVLZWOJbUZcWfYh6feuB
 Y0ecjO/SuJ5mEjo5cCVBHbWb1IPfRaxSxz4g7ZVGDrF1gMGN7UxDa0/EKKgJl5Z+//fC
 70oTA51om3o6/DOO6zp753sfryqWfUaZeRgWceVHLIM5+4aEFcl+rNnpjEtyVVtlXDXz
 MOENaE635GF8GSjxkIUd00pfcgiiYdChGsahXtzn+AE4mSpBJ1AyZ5ggZkJ9rzjPR9fl rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5r6fj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 14:41:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1IEfi6e030462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 14:41:44 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1IEfiY0022006;
        Mon, 18 Feb 2019 14:41:44 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 06:41:43 -0800
Date:   Mon, 18 Feb 2019 17:41:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: stm32: sai: remove set but not used
 variables 'mask, cr1'
Message-ID: <20190218144133.GF17104@kadam>
References: <20190218134836.107220-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218134836.107220-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 01:48:36PM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
> sound/soc/stm/stm32_sai_sub.c:902:11: warning:
>  variable 'mask' set but not used [-Wunused-but-set-variable]
> sound/soc/stm/stm32_sai_sub.c:902:6: warning:
>  variable 'cr1' set but not used [-Wunused-but-set-variable]
> 
> It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
> mclk clock provider")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index d4825700b63f..a00640f1df06 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  				     struct snd_pcm_hw_params *params)
>  {
>  	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
> -	int cr1, mask, div = 0;
> +	int div = 0;
>  	int sai_clk_rate, mclk_ratio, den;
>  	unsigned int rate = params_rate(params);
>  
> @@ -944,8 +944,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>  			if (sai->mclk_rate) {
>  				mclk_ratio = sai->mclk_rate / rate;
>  				if (mclk_ratio == 512) {
> -					mask = SAI_XCR1_OSR;
> -					cr1 = SAI_XCR1_OSR;
> +					;
>  				} else if (mclk_ratio != 256) {


Please, no...

				if (mclk_ratio != 512 && mclk_ratio != 256) {
					dev_err(...

regards,
dan carpenter

