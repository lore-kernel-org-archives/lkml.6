Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BD9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5E420870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lr/Kd7MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5E420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbeKVN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:29:55 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52342 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbeKVN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:29:54 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181122025234epoutp01fc0d0c46fb4c287ec6ed9f81cbb6d1d0~pUpbLfPG81526015260epoutp01o;
        Thu, 22 Nov 2018 02:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181122025234epoutp01fc0d0c46fb4c287ec6ed9f81cbb6d1d0~pUpbLfPG81526015260epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542855155;
        bh=4JAgoglx01hh32kRswoD1EyjkVp/OARBkm3WgJOfqEQ=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=lr/Kd7MBsvYFsMDGE42XrqEh+2c32sN+qzjLrOIvtVbXbNIiGtd3BMonKuAzPLr/0
         6ycVDh3sQLIdDAVkEdi1oahfEuaXumX9JX64VMaxxMb2fDhHn2+6spQli51Dsd/1/w
         piFkaLwLcqfr/SeihRrPdw1UnggcE/O/Heixdbbk=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181122025231epcas1p4b0857a3f4469e02640408e2c992ec9ea~pUpXnkKZz3097830978epcas1p4K;
        Thu, 22 Nov 2018 02:52:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.10.04057.EE916FB5; Thu, 22 Nov 2018 11:52:31 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122025230epcas1p13ab78e9702de6a7a7906384880361ce2~pUpXThe4D1525615256epcas1p1r;
        Thu, 22 Nov 2018 02:52:30 +0000 (GMT)
X-AuditID: b6c32a36-d19ff70000000fd9-03-5bf619ee7d62
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F5.DC.03601.EE916FB5; Thu, 22 Nov
        2018 11:52:30 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK009VEQNIFB80@mmp2.samsung.com>; Thu, 22 Nov 2018 11:52:30 +0900 (KST)
Message-id: <5BF619EE.8090006@samsung.com>
Date:   Thu, 22 Nov 2018 11:52:30 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/6] devfreq: refactor set_target frequency function
In-reply-to: <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbZRjO17vrHRvFsxvyyZTBJSYDx+xRyr7NQUwk5hb2B4lL/IFLPeGk
        SHttegXd/nDoAig6YKiRFUudbJMAy9YWy5gdHdCxBCYdbEOCgHE0EydBAhRmSBbb3hb573nf
        PM/7vc/zfR+FqReVyVSZaBOsIm9klFtw72C6JvOfZ9eKNLXLAPX/lI5czRcJ1ONaI5AzMEqg
        E20XlejmFybUMPc3hoLBSyT65dMFEk1VPYfsX19VIPfcBIFuX/lOiVZOBgBqDvYp0IXADInO
        /TqmQL990q5EM8PXIzNGxglUfTVAoprOJQIt3JrFX0nivD97Ca6rtQtwLVVjONfYsAy4Nt9f
        Cs7d8bmS8zu6SM5z9jj3aIjk+hd9Cq77bi3O1Xd3AK69c53kVtwphQlvlx8wCHyJYE0VxGJz
        SZlYmssUvK5/Va/L0bCZ7D60l0kVeZOQy+QfKsx8rcwYsc+kVvLGikirkJck5qW8A1ZzhU1I
        NZglWy4jWEqMln2WPRJvkirE0j3FZtN+VqPJ0kWI75YbFqb9wPJj2kf2nq1V4MyOOhBHQTob
        hupbsTqwhVLTlwGsaZkk5WIdwCt/hrEnLL97HUSxmr4E4LctaVGsop+GD7+axesARWH0ThgY
        L4+2MTodzq824fKcGQB7VldJmZ8BZ/tdeBTj9Atwsq01Nl8Z6fvnJ5VR/BSdBu8+nIudlUi/
        CXuda7GFttNBALt6fYpogdHVGHy01B1TbKM5uDJ0LaaIowvgtLMh5gfS/5Jw2rGIyxbyYdM9
        72O8DT640U1G14b0Djh+PVfm1wK4On+CkItGAJeGPQpZoIX3z9QpZHMJcDH8JSGLVfCzGrVM
        4eA3G6OPs/sdQJ/nNtkInrdvisn+f0z2TTF9D7AO8IxgkUylgsRasjZfnxvE3npGzmXww+ih
        AUBTgIlX7XorXKQm+ErpqGkAQApjtqtutUdaqhL+6DHBatZbK4yCNAB0kZRPYcmJxebIzxFt
        elaXpdVqUTabo2NZJkkVSnYUqelS3iaUC4JFsD7RKai45Crg1b8R9yA/Lz7eZbs5eNi3XOmc
        +DioXZ9PfF88spCyf6Tz/J0Efy+HNxccLrqROfxh9UiL/bTGkTe+O/zyUsr9re8NNu2y9ZVN
        WTKcoXdEf5Lj4HndQGP2BWHq2NjGnb6DLs/xP/AJ25C490i94dTGtdDOD+61mXt3h076AuE+
        z4sMLhl4NgOzSvx/PSsfkwEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRzGeXfO2TnOVsel+KqRuYhSyEsGvR8k/BKdiECEQvODHfXgdXPs
        eE1BK9RUvEQac6YWUxSdly3T8tKaLYlmTU1T8ob6pXJJOZoGpjml7NvD8zz8/g/8KUwygXtS
        ifI0TilnU6RCEW7eWnY5vephjwr83eyLjE99kU7VSaBenZ1ADab3BLqj6RSikVIZqlhewZDF
        0kWid7etJPqUfwSpqwYFSL/8kUAf+h4Kka3MBJDK8kKA2k1zJGqaGhOgmVstQjT39vUOwzxO
        oIJBE4kK274TyDo6j4e6Mz39PQSjrdcCpjZ/DGcqK9YAoxn4ImD0rcVCxlCnJZknjXnM1jDJ
        GFcHBEz3ZBHOlHe3AqalbZ1kbPqjYQevi0LiuJTEDE4ZcP6GKME6awCKZp8sda9zPnjsVQKc
        KEifhQb9OigBIkpCdwC42PSLdARi2gVu3J/HSwBFYbQ3NI0n78mTsKpKtldfALBhxYbt1f3g
        vFGHOzROn4DTmvpdX7jjGz5PCx36EO0DJzeWgYPjRkfA0jfZDo4rbQHQWF5MODoYXYDBpcIk
        hz5MM9A2/BL8OzahX9uFOtGX4WxDBVYJaPV/U9X7U9X7Ux8BrBV4cApeFi/jzyiC5FymP8/K
        +HR5vH9sqkwPdn7d88qv/BlYaIweAjQFpAfEpyJ/RkkINoPPlg0BSGFSV/Foy44ljmOzb3LK
        1GhlegrHDwEvCpe6i2fkw5ESOp5N45I5TsEp/6YCyskzH1AJ92LM7tV1dr1r5rqzqsZOZpjc
        qptyc8LDs3KOh7Hftn9wKnbTG/BWDfiqnWrX5wU3lKSqPXPXQmrJ+IsLSQZnZ7MtgJcErsVs
        Xh3oekBeWAqOgNsTK1kdOf3eNf1lm4vnQMu15z6aS4G62NAi1YjoroS64ll1TO7fVyjF+QQ2
        yA9T8uwfBCU/8ecCAAA=
X-CMS-MailID: 20181122025230epcas1p13ab78e9702de6a7a7906384880361ce2
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
        <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> The refactoring is needed for the new client in devfreq: suspend.
> To avoid code duplication, move it to the new local function
> devfreq_set_target.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

As I commented on patch1, please remove it.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e20e7e4..cf9c643 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> +			      unsigned long *prev_freq, u32 flags)

Please remove the unused space in front of 'unsigned long *prev_freq'.
Use tab only for indentation.

> +{
> +	struct devfreq_freqs freqs;
> +	unsigned long cur_freq;
> +	int err = 0;
> +
> +	if (devfreq->profile->get_cur_freq)
> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> +	else
> +		cur_freq = devfreq->previous_freq;
> +
> +	freqs.old = cur_freq;
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +
> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
> +	if (err) {
> +		freqs.new = cur_freq;
> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +		return err;
> +	}
> +
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +
> +	if (devfreq_update_status(devfreq, new_freq))
> +		dev_err(&devfreq->dev,
> +			"Couldn't update frequency transition information.\n");
> +
> +	devfreq->previous_freq = new_freq;
> +	*prev_freq = cur_freq;
> +
> +	return err;
> +}
> +
>  /* Load monitoring helper functions for governors use */
>  
>  /**
> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>   */
>  int update_devfreq(struct devfreq *devfreq)
>  {
> -	struct devfreq_freqs freqs;
>  	unsigned long freq, cur_freq, min_freq, max_freq;


cur_freq is not used after modification. Remove it.

>  	int err = 0;
>  	u32 flags = 0;
> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
>  
> -	if (devfreq->profile->get_cur_freq)
> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> -	else
> -		cur_freq = devfreq->previous_freq;
> -
> -	freqs.old = cur_freq;
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);

You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
from devfreq_set_target().

Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
Please remove the 'cur_freq' parameter from devfreq_set_target.

>  
> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
> -	if (err) {
> -		freqs.new = cur_freq;
> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -		return err;
> -	}
> -
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -
> -	if (devfreq_update_status(devfreq, freq))
> -		dev_err(&devfreq->dev,
> -			"Couldn't update frequency transition information.\n");
> -
> -	devfreq->previous_freq = freq;
> -	return err;
>  }
>  EXPORT_SYMBOL(update_devfreq);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
