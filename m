Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6B8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F8625B30
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F8625B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeGBIe3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:34:29 -0400
Received: from mout.web.de ([212.227.15.4]:36533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933640AbeGBIeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:34:19 -0400
Received: from [192.168.1.3] ([92.227.235.76]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoLKj-1g27Io1nab-00gKLE; Mon, 02
 Jul 2018 10:34:11 +0200
To:     Kees Cook <keescook@chromium.org>, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>
References: <20180629184818.GA37439@beast>
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b531d35a-631f-c84c-831d-9ce6cff02436@users.sourceforge.net>
Date:   Mon, 2 Jul 2018 10:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629184818.GA37439@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LTKu1fy8Ijfqq5IGtI+GT9QJPIblrA6D1zFKTVd3MfHxMfgCuS9
 rq7cBmYn6PHtCVZRo5NQiu2e+2z15FZvlDpDJ+XoaVXdyuFUaO5S70uEl/oFF6ieKILlfAP
 BzqIe6dXixWHscsfrtBgg2kqGtsDbQUxrBcQT7wDQgb1o836oKpaOnXlHPYxVvrFva9rUbt
 TPg9ltV6IwOvueAZ7NNxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rIN9+Trdl9Q=:QSIaf41SLcoihUUILPwMK1
 CrkB7PxSNkLkWog1Qf7YGXoOBrrbnE/BkGPkY0RjFJAiRUO+LF46oon3A0iXaDMnoi1zLIB7S
 DPXLxubSExoScnnA3IgS37vIdLwV1gAPzauM85JDje1VZ+QJ3l2BKhMHlUnJFVFHTo3u4XwqF
 bcky73BH40yYXsLVESWpuJ2tX75HAPWwPIWIktoBGiVvQs2wShC/Cat402RsTI2OWev0fRAyv
 +p/Z9f6Uzu7WTuoZSnyumRYyf45YR0y0wn9CzCH1ViBzUyTBnOhXQO4Rr++29OSBXqt050Ohw
 LndpZ21vUNNqBjon1IpHu5cIsiY0AcQC3V+QH9T9nN2EAPwwCo6M8t1wfKnclkV3UXkPKWpoH
 ZL7PiXssW8QeAAQYU2ztkpJANxqJTzc2eW8zb7fNrz99N4MQ14o6s/eEGIVcZfF7ygRSaJPUD
 rMY3pTl9CUi0sWa6JjPzAYised2Vig7Vc/Yz6JtBidFZ0MO+QtVi5RxA6sDNWkTHAjaRnn9en
 gSzVxnN/UCcXeqaFMtgBAy79mIwIboylR3zeWGsx5EBPE48w73t7J8Prs8ZO0oiTMGrcp+zVE
 BB/Bjuf7q65DAhYs4Lfm/Hrr8qqesdHdu82GmqTnCmaF24hfL4+ugFHatpVMMSJluS3NbKm3l
 rX3ZeyTgRJhkH8fESCcBWvzWMcatX3TYrEAZzMX3apyxWInZH54nqDvE2Uh7J2bFqlQSVsvCN
 NTyGI55D2uY3fuAesk/cNcY59pzYKZpYsP7Xi/GElqpwwJYcN1/SdG5soJ75IRMTR2jJ3EBVY
 OAGZ/fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -91,12 +93,13 @@  static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
>  		ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
>  				mem_region, mem_phys, mem_size, NULL);
>  	} else {
> -		char newname[strlen("qcom/") + strlen(fwname) + 1];
> +		char *newname;
> 
> -		sprintf(newname, "qcom/%s", fwname);
> +		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
> 
>  		ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
>  				mem_region, mem_phys, mem_size, NULL);

I have taken another look also at this update suggestion.
Now I wonder why the return value is not checked for the added name construction
in the way as it is specified for the function “adreno_request_fw”.
Will another condition check make sense at this place?

Regards,
Markus
