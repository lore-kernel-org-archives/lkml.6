Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FEFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022D2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeeGvkzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfBYQ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:29:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tmljqv3EAT+SSUz8hYCZ8G7QpAqltJvyerLUjv5ToSY=; b=OeeGvkzjCyIfP0BqOm0Aap2uOZ
        o8yxbQaG+80F3ZirFY6nWDF9pzk7akCetmjpYDfh+qOHDGe0V71sq95ROJB0fp6heaZaP9Hyz48jn
        jRNgitXeaxb8Z1dqHb5ueP2+G6IO9jD+255o1HBr+G0gbufSu8nZOmUWDV8B2jhAsu4zyWEUliedy
        nrdVUkybYNTLgStuiPs9kGLbT5/tr4fckITJtMeo+s3LTRgpW4LoOszqSgcnK836CRmeDL2FyM18s
        YK0srS9EALKwaVhR1TVgmsrRapu2AuDMpbOmpPRKBDWrMBI5Klv3EQlRMhh12RqLvpCJdaF5FXEYx
        RjWlCvog==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyJ7o-0007Vk-4V; Mon, 25 Feb 2019 16:29:04 +0000
Subject: Re: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        ncrews@chromium.org, bleung@chromium.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
References: <20190225135405.108052-1-cychiang@chromium.org>
 <82fe83ba-b967-66ee-1299-1cd98072089a@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b9b11c13-260f-444c-1b82-993f1bc9ea0f@infradead.org>
Date:   Mon, 25 Feb 2019 08:29:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <82fe83ba-b967-66ee-1299-1cd98072089a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 6:37 AM, Enric Balletbo i Serra wrote:
> Hi,
> 
> On 25/2/19 14:54, Cheng-Yi Chiang wrote:
>> SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
>> Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
>> warning.
>>
>> Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> 
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Thanks,
> Enric

Works for me.  Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>

>> ---
>>  sound/soc/qcom/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index 8f206cb4fcc0..75ceb04d8bf0 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -98,7 +98,7 @@ config SND_SOC_MSM8996
>>  
>>  config SND_SOC_SDM845
>>  	tristate "SoC Machine driver for SDM845 boards"
>> -	depends on QCOM_APR
>> +	depends on QCOM_APR && MFD_CROS_EC
>>  	select SND_SOC_QDSP6
>>  	select SND_SOC_QCOM_COMMON
>>  	select SND_SOC_RT5663
>>


-- 
~Randy
