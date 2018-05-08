Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeEHCAB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:00:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46583 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEHB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:59:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180508015956epoutp01f4c9f6645cf82cc647f359e24a769391~siM72cRnH2508325083epoutp01_
X-AuditID: b6c32a36-b55ff70000001027-cb-5af10499a0ae
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AF10498.1000408@samsung.com>
Date: Tue, 08 May 2018 10:59:52 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v2 1/2] scsi: ufs: Extract devfreq registration
In-reply-to: <20180504224427.32606-2-bjorn.andersson@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3b3ebeLqOr9ejHRdKXCw6d2cXcOJfRCD/GFEFAtZF71sptvk
        3hklFJqR5VdaWTmstILEiKWZzGZZfmam9K1UJiHWsJJWWlpg3e0W9et9znOe57znHI4EkR/H
        oiW5NgfD2uh8AgtGO3rjVap61GdM/HBDTQ13z6LUyKGPYqq2e0RMPb3VgFFfq/oAVTHmxqgr
        g0si6lVJM0a5m4qo+4tuJD3Y8LS6SmTodE6IDa9fdGEG3/RL1FDd3gIMX9tiMjEjk2ph6ByG
        VTC2bHtOrs2sJ7ZsM2006ZITSRWZQq0lFDbayuiJTRmZqs25+XxnhGIvnV/IU5k0xxEJaams
        vdDBKCx2zqEndpGkRk0mrlVrNPyrzVqn0fGS3YzlwWQXKPgSvu/ZXY+4GAzg5UAigXgSvDss
        LQfBEjnuBnBhuhcIwXcAn72e4ANpQHSi7igiJDwA3r4+hPkTMjwULpx8g/orIXgs7HuS56cR
        PB7e9LjEgn4CQE99RZCgV8KZytIARvHVcPH9COLHGM93e8cDNZfjq+DzhanAxxH4Tth54Vug
        UDheC2B1Xb3IHyD4TwCvfGoMOMLwjfBhXynqx1I8Hd5x/gi0CvEPGDxd8hgVBt3EY5kwThic
        GWwXC/QK+KRfL8jLACy7ff6P9xSAo2NvRIJBC981lYuE2ZbB2fnKIMEsg0ePyAWJAY67G4IE
        vB62ehcxYfwhAEcmZ5AaEOP8b2POfxtz/rexRoC0gEimgLOaGY4s0Kg52soV2szqbLu1DQSO
        UZnsBhdHM3oALgFEiCyT+2yUB9F7uf3WHgAlCBEuw+J4SpZD7y9iWLuJLcxnuB6g4xdei0RH
        ZNv507Y5TKROo9VqqSQyWUeSRJRsOuOhUY6baQeTxzAFDPvXJ5JIo4vBuayUnA2a7bHWWWW9
        vTI1Nd3rNEd4jdfShleGzUYODaSnxQU/aj1wTDfaH0XpjZedFaTuqjctci77km+zb9y1JvQH
        qQpRNihMHlfcvXWu4vd7TrBn2Y+HndWu5LmojvkdSzVnlhdNbQ9PmRwO9UkjK+uaf21tSHjb
        vXhOdfB8KIFyFppUIixH/wYaHg9KogMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t9jAd2ZLB+jDFZ8lLc4vf8di8XZpjfs
        FhP3n2W3uLxrDpvF594jjBbd13ewWSw//o/J4nbjCjaLHQurLE783MHswOVxua+XyWPnrLvs
        Hneu7WHz+Pj0FotH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZZy6v4ex4JNIxZUDu9kbGI8J
        dDFyckgImEhMmtrBDGILCexklNh3vAjE5hUQlPgx+R5LFyMHB7OAvMSRS9kgYWYBdYlJ8xYB
        lXMBld9nlDi4dAcbRL2WxKueZlYQm0VAVeLn87NgM9mA4vtf3ACr4RdQlLj64zEjyExRgQiJ
        7hOVIHNEBCYzSvyeeIkJxGEW+M0o8XPmP7AGYQFniTNHmlkgtp1klFjd2Qs2lVPAQWLfrF/M
        ExgFZiE5dhbCsbOQHLuAkXkVo2RqQXFuem6xUYFhXmq5XnFibnFpXrpecn7uJkZgTGw7rNW3
        g/H+kvhDjAIcjEo8vD8KPkQJsSaWFVfmHmKU4GBWEuFlUwYK8aYkVlalFuXHF5XmpBYfYpTm
        YFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwCj4eMXaZLu0KJW5av9Tl/xZ9mpfwirfgx07
        +mQ6dd0F2v4sCjk5ZaP5M6czxUlfzMRE45nsjy1o41eUqskIjua5MH0Dj8/0TR/tzRd8nh/C
        0OMzaRn7hZYV53wY/XuTTJ/1PM4MzI9YGB3lGHxQuF1rU/CJ8ixZKa9MyZgZMYUdTtOjlO5X
        KLEUZyQaajEXFScCAH45puuFAgAA
X-CMS-MailID: 20180508015953epcas1p3cac2c96ba3868262a95404b3fd0346eb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504224510epcas4p2e6a1303ea814642ad851bc6072be6089
X-RootMTR: 20180504224510epcas4p2e6a1303ea814642ad851bc6072be6089
References: <20180504224427.32606-1-bjorn.andersson@linaro.org>
        <CGME20180504224510epcas4p2e6a1303ea814642ad851bc6072be6089@epcas4p2.samsung.com>
        <20180504224427.32606-2-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 05일 07:44, Bjorn Andersson wrote:
> Failing to register with devfreq leaves hba->devfreq assigned, which
> causes the error path to dereference the ERR_PTR(). Rather than bolting
> on more conditionals, move the call of devm_devfreq_add_device() into
> it's own function and only update hba->devfreq once it's successfully
> registered.
> 
> The subsequent patch builds upon this to make UFS actually work again,
> as it's been broken since f1d981eaecf8 ("PM / devfreq: Use the available
> min/max frequency")
> 
> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  drivers/scsi/ufs/ufshcd.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 8f22a980b1a7..2253f24309ec 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1255,6 +1255,26 @@ static struct devfreq_dev_profile ufs_devfreq_profile = {
>  	.get_dev_status	= ufshcd_devfreq_get_dev_status,
>  };
>  
> +static int ufshcd_devfreq_init(struct ufs_hba *hba)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	devfreq = devm_devfreq_add_device(hba->dev,
> +			&ufs_devfreq_profile,
> +			"simple_ondemand",

You better to use 'DEVFREQ_GOV_SIMPLE_ONDEMAND' definition
in include/linux/devfreq.h in order to prevent the some typo.
- aa7c352f9841 ("PM / devfreq: Define the constant governor name")


> +			NULL);
> +	if (IS_ERR(devfreq)) {
> +		ret = PTR_ERR(devfreq);
> +		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
> +		return ret;
> +	}
> +
> +	hba->devfreq = devfreq;
> +
> +	return 0;
> +}
> +
>  static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
>  {
>  	unsigned long flags;
> @@ -6399,16 +6419,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>  				sizeof(struct ufs_pa_layer_attr));
>  			hba->clk_scaling.saved_pwr_info.is_valid = true;
>  			if (!hba->devfreq) {
> -				hba->devfreq = devm_devfreq_add_device(hba->dev,
> -							&ufs_devfreq_profile,
> -							"simple_ondemand",
> -							NULL);
> -				if (IS_ERR(hba->devfreq)) {
> -					ret = PTR_ERR(hba->devfreq);
> -					dev_err(hba->dev, "Unable to register with devfreq %d\n",
> -							ret);
> +				ret = ufshcd_devfreq_init(hba);
> +				if (ret)
>  					goto out;
> -				}
>  			}
>  			hba->clk_scaling.is_allowed = true;
>  		}
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
