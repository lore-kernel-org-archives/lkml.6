Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108032081C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lZ9DXH9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108032081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbeKNKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:10:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63149 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:10:05 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181114000920epoutp0261b41352d730f4e029eac7e43cbce8b1~m1Qncx7sk0340303403epoutp022;
        Wed, 14 Nov 2018 00:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181114000920epoutp0261b41352d730f4e029eac7e43cbce8b1~m1Qncx7sk0340303403epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542154160;
        bh=G6M/G8A4LeHSA6kE3nAgopS/0y7V+gDNj/rBXiGyIOs=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=lZ9DXH9GRwGorcU7ETR5SXlJFDy0pLJhuZFfpI2TdUJeIbmjJd+MptnijuT+NQgAI
         WP4inmIKg87cLd6NBDTWNK7GEJ2C6tccX61d8bqjwwsO6DQSarS1xWMS6mOqdf/1Ou
         4uTot2Grx9GAOTCveXcosXvtOCvoewSgGnnNZR+s=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181114000918epcas1p4fa80bf1f09da147dafbed3b702573386~m1Qk4jEMW0633106331epcas1p4P;
        Wed, 14 Nov 2018 00:09:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.8A.04407.DA76BEB5; Wed, 14 Nov 2018 09:09:17 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181114000917epcas2p14bd73bd6d659354f69150ab73b515334~m1QkQEXDi2713027130epcas2p1V;
        Wed, 14 Nov 2018 00:09:17 +0000 (GMT)
X-AuditID: b6c32a46-7a1ff70000001137-4d-5beb67ad12c0
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 81.13.03702.DA76BEB5; Wed, 14 Nov
        2018 09:09:17 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI50016TPRGF390@mmp2.samsung.com>; Wed, 14 Nov 2018 09:09:17 +0900 (KST)
Message-id: <5BEB67AD.30800@samsung.com>
Date:   Wed, 14 Nov 2018 09:09:17 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        krzk@kernel.org, b.zolnierkie@samsung.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: max77686: Fix the returned value in case of error
 in 'max77686_rtc_read_time()'
In-reply-to: <20181113233645.9118-1-christophe.jaillet@wanadoo.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmhe7a9NfRBv+Pm1ssuXiV3aL93TJ2
        i40z1rNabD04F0jckrY4f34Du8XlXXPYLI6tvsLmwOExb021x6ZVnWwefVtWMXpMn/eTyePz
        JjmPz3fXswawRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gCdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1
        MjQwMDIFKkzIzjjbeZyt4D9HxfmNm1kaGNezdzFyckgImEis+HiUrYuRi0NIYAejxO1Dv5kh
        nO+MEsenvGGCqfowZyMTRGIDo0TPxYMsIAleAUGJH5PvAdkcHMwC8hJHLmWDhJkFNCW27gbZ
        AFJ/l1GiffImdoh6DYkVb7ewgtgsAqoST27vYwOx2QS0JPa/uAFm8wsoSlz98ZgRxBYViJDY
        Of8b2CARgVmMErPXbmSEWBYn8e0uF0iNsEC2xLMXu5lBbE4BJ4mfr88yQxx9n01i9ipNCNtF
        Yt+lv1BxYYlXx7dAvS8t8WwVyEguILudUeLLi2ZWCGcCo8SHU5uh3jeWeLawiwniNT6JjsN/
        2UGOkBDglehoE4Io8ZD4cmEfI8THUxklVt78zT6BUXYWUiDNQgTSLKRAWsDIvIpRLLWgODc9
        tdiowAg5+jYxgtOeltsOxiXnfA4xCnAwKvHwWtx+FS3EmlhWXJl7iFGCg1lJhNc/+nW0EG9K
        YmVValF+fFFpTmrxIUZTYBhPZJYSTc4HpuS8knhDUyNjY2MLU3NLYwNLJXHeh9Jzo4UE0hNL
        UrNTUwtSi2D6mDg4pRoYF1fUPPINZ4nUemP/hun2MqGsOdnf7+yRuFJStnCztsaVSDbZcJOE
        rLimGUv/GftaBOefFY050SjSJdP9RueWcIzGId/WRT39857xKS09X3L+xbVbjByLuu/46q/r
        urx0beIhD+HbT2Y+nNA033/z0sQ6f6VNu3JlHuz59GinWtO7O4+W1dmXK7EUZyQaajEXFScC
        AP7PJ6qRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t9jQd216a+jDdqmCVgsuXiV3aL93TJ2
        i40z1rNabD04F0jckrY4f34Du8XlXXPYLI6tvsLmwOExb021x6ZVnWwefVtWMXpMn/eTyePz
        JjmPz3fXswawRXHZpKTmZJalFunbJXBlnO08zlbwn6Pi/MbNLA2M69m7GDk5JARMJD7M2cgE
        YgsJrGOUeN7ICGLzCghK/Jh8j6WLkYODWUBe4silbJAws4C6xKR5i5i7GLmAyu8zSjzu6WKH
        qNeQWPF2CyuIzSKgKvHk9j42EJtNQEti/4sbYDa/gKLE1R+PGUFmigpESHSfqASZIyIwg1Fi
        2cPF7BAL4iQOTvsMVi8skC3RMPkSK8Sy6YwSxz5+ZQZJcAo4Sfx8fZZ5AqPALCS3zkK4dRaS
        WxcwMq9ilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAgM/W2Htfp3MD5eEn+IUYCDUYmH
        1+L2q2gh1sSy4srcQ4wSHMxKIrz+0a+jhXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJI
        TyxJzU5NLUgtgskycXBKNTBmLM/f4+18/tgsvWmXm2+1zO2bzpi1ssthPvu9hfXfDBsiK9fc
        e/goY6/iXLWN81MXpAg9DVV6zTG7dEud7hPmJSqNxz5qH3OIZZJKYYzM9vtmHcjM8Xpp0P87
        9VvfBVQeFCgLKTzpZ9a22a//1dZN2wMkf+oYfTifMzd5tvSH+12fLqeIRl9TYinOSDTUYi4q
        TgQAm6LEinkCAAA=
X-CMS-MailID: 20181114000917epcas2p14bd73bd6d659354f69150ab73b515334
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181113233753epcas4p2ecc97f5931a34bc0d176111b155738b8
References: <CGME20181113233753epcas4p2ecc97f5931a34bc0d176111b155738b8@epcas4p2.samsung.com>
        <20181113233645.9118-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 08:36, Christophe JAILLET wrote:
> In case of error, we return 0.
> This is spurious and not consistent with the other functions of the driver.
> Commit e115a2bf1426 has modified more than what is said in the commit
> message. Reverse part of it znd return an error when needed, as it was
> previously.
> 
> Fixes: e115a2bf1426 ("rtc: max77686: stop validating rtc_time in .read_time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/rtc/rtc-max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index 8a60900d6b8b..4aff349ae301 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -360,7 +360,7 @@ static int max77686_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  out:
>  	mutex_unlock(&info->lock);
> -	return 0;
> +	return ret;
>  }
>  
>  static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
