Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A751ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E369720824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAsiQYlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E369720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJYK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:27:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39222 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeJYK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:27:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so5488751lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 18:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3MAOzR6LOCJt++ofCZuUAgfpHuME7Ee1ftRjmgI42/o=;
        b=RAsiQYlLJj1gxv1EDYRjLlP5+Ti6HddKAwVMBGxWzgG6e0pz3VXv9eAgsDPA1caBRK
         ulsSGuWAKMYYrlBwxqcVV2FeGqw5JPXPZk1D8HVT1h+3tnW2W8USBHIeNRt9ElUx0VDr
         U/spS4xVycAfdh73k+Z0ldkwpzx7tDJPfiV+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3MAOzR6LOCJt++ofCZuUAgfpHuME7Ee1ftRjmgI42/o=;
        b=mh+uOJeiDnEzJ0EIm80AFeH4w85aiV3s/yytOGMqAek3eEsVFCGxzau5wJO4MYVolh
         btW/bTLkdqxThedbISmCrTno5uHuzpXPI1ex1grFEulvBNubbrsl+xIbQ1/ZlBSQef3t
         vU4REumj98EmFKaZbnhXoM43jRRhGWLSvfGIQEkQeqjKC8zE+cB+V4+2dZEWsCXYURMv
         Jt6xwS2fIAQPC08197JtmQ4cGhhKUiqesB2d/MIZNnAEvHbUt6hlVsI4SPf0iA2GtuxC
         ImZ0s0n0/pZeq2Jk1d7vlSW+xOurkRNGZzx6cQ+II/iEE46h9cm5Bl3xrRfjt2qfe1ee
         2Q3g==
X-Gm-Message-State: AGRZ1gLlTxr1nnhNc3hXDin8cnC6ay6bOak/251dUEzcsC8y4iqcBTiA
        HOAdsM4+Ow+Cz8xi/lUPrBIFdNY4u2ZqNham/cM4dA==
X-Google-Smtp-Source: AJdET5eEFR4NDyJIOLKzK7543zqc6tQ8W2qyRZvCI3hiyfhvduil3LcRpTlqPZH6/0aCkDXaE2C4m79FizSBBmPkZvs=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr81759lfj.126.1540432635951;
 Wed, 24 Oct 2018 18:57:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 18:57:15
 -0700 (PDT)
In-Reply-To: <20181025003456.GB2737@piout.net>
References: <cover.1539851865.git.baolin.wang@linaro.org> <e3b4f8848cad42e5a2f4dfb34e342c69c8b95786.1539851865.git.baolin.wang@linaro.org>
 <20181025003456.GB2737@piout.net>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 25 Oct 2018 09:57:15 +0800
Message-ID: <CAMz4ku+ObP5vUijEbzMFF3hBe+RaQoOv7O2JxhGbq6Qs-t+iCQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] rtc: sc27xx: Always read normal alarm when
 registering RTC device
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 25 October 2018 at 08:34, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Hello,
>
> On 18/10/2018 16:52:30+0800, Baolin Wang wrote:
>> When registering one RTC device, it will check to see if there is an
>> alarm already set in RTC hardware by reading RTC alarm, at this time
>> we should always read the normal alarm put in always-on region by
>> checking the rtc->registered flag.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/rtc/rtc-sc27xx.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
>> index 72bb002..b4eb3b3 100644
>> --- a/drivers/rtc/rtc-sc27xx.c
>> +++ b/drivers/rtc/rtc-sc27xx.c
>> @@ -415,10 +415,14 @@ static int sprd_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>>       u32 val;
>>
>>       /*
>> -      * If aie_timer is enabled, we should get the normal alarm time.
>> +      * Before RTC device is registered, it will check to see if there is an
>> +      * alarm already set in RTC hardware, and we always read the normal
>> +      * alarm at this time.
>> +      *
>> +      * Or if aie_timer is enabled, we should get the normal alarm time.
>>        * Otherwise we should get auxiliary alarm time.
>>        */
>> -     if (rtc->rtc && rtc->rtc->aie_timer.enabled == 0)
>> +     if (rtc->rtc && rtc->rtc->registered && rtc->rtc->aie_timer.enabled == 0)
>
> Note that the driver should not access rtc->registered and
> rtc->aie_timer.enabled and this is a bit fragile.
> But, on the other hand, I currently don't have anything better to
> suggest. I was also planning to add an in-kernel API for multiple alarms
> but I'm not sure it will actually help in your case.

Yes, I understand your concern. I will glad to help to test if you
introduce new APIs for multiple alarms to see if they can help in our
case. Thanks.

-- 
Baolin Wang
Best Regards
