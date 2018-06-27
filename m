Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE3923C32
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nq+HTrFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE3923C32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeF0CRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:17:24 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36458 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeF0CRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:17:22 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so511444otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QdtZqjNB56cuv6P2+2qAxXejqQGAnhJV3nzPHfZAx5I=;
        b=Nq+HTrFvoMy49GiNZLuWy27XlPQP8x29LV81mHXCGTO/hnrJRzFBIYCwbGEAxkH8pS
         QOr+F2Wps91SVeiDHVUD+SfwpEWchbnjxPZjzlC9RkqRD/XElkQRFIdtv+oEDtyvXjuY
         OqG2zT5G9IqC5FHh1321ixgPjs1KuM9G2vG/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QdtZqjNB56cuv6P2+2qAxXejqQGAnhJV3nzPHfZAx5I=;
        b=M9hGAdi2+hGl+mCBQCqWs5ot051f0u+0cipCfltNZRJgmyBtpi1IpcME9T2Sz0J2Fc
         CNLUcrKPWhcWox5nTPAIMblkQOmNv1VmLoo8ECFGeQ5HNX9+Z/2coCHND+HdLtXvYIkJ
         IrYG/9jYcsS0mSZiOlH9kcXtTNTtT4ruBTP3decvNZKfe9xc52Zb73nTnBTwJv47uLnW
         qsFPWI8iJeJlpPm+LMwKxgqva0IurbhguLeJNqZfeEhDnsiDEBl4rvXK2UERs6u41WXs
         W04jbc1pSlZcLuSUasUcLjDqGpORfXPHgJKTRrN8PnTb1Y06OWkXD2cY+5dzSa5n7sbC
         T0dw==
X-Gm-Message-State: APt69E04JFxt5LuFUHGY6A8Drw3M9Ek69mQCIQZNadljqZlo6EBd7q9D
        kXxlpEOazSR2Mc+AEDoUCsxNHKtA7o7RKP4JKHmYUw==
X-Google-Smtp-Source: AAOMgpd9IVNBEf2gn2FCH5HnqcySpvABncFO3GTaex+ROX/2YddDeuCJCvuJsT/6ZJaBQN+/p1Rb3oLeMnEFDQRNMik=
X-Received: by 2002:a9d:a66:: with SMTP id 93-v6mr2171159otg.177.1530065841636;
 Tue, 26 Jun 2018 19:17:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 19:17:21
 -0700 (PDT)
In-Reply-To: <20180626205138.GF3206@builder>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <e5f5f315a882fe5cdd161c8cb1790c9f3de0920a.1529654288.git.baolin.wang@linaro.org>
 <20180626205138.GF3206@builder>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 27 Jun 2018 10:17:21 +0800
Message-ID: <CAMz4kuLVFc3YuSue8AQ8brjj+bDq-k-fOTRp_3M4xV1O=aYhgg@mail.gmail.com>
Subject: Re: [PATCH 6/8] hwspinlock: sprd: Use devm_hwspin_lock_register()
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 04:51, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Fri 22 Jun 01:09 PDT 2018, Baolin Wang wrote:
>
>> Use devm_hwspin_lock_register() to register the hwlock controller to
>> avoid unregistering the device explicitly.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/hwspinlock/sprd_hwspinlock.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
>> index dc42bf5..ba5daf6 100644
>> --- a/drivers/hwspinlock/sprd_hwspinlock.c
>> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
>> @@ -120,8 +120,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
>>       platform_set_drvdata(pdev, sprd_hwlock);
>>       pm_runtime_enable(&pdev->dev);
>>
>> -     ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
>> -                                &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
>> +     ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
>> +                                     &sprd_hwspinlock_ops, 0,
>> +                                     SPRD_HWLOCKS_NUM);
>>       if (ret) {
>>               pm_runtime_disable(&pdev->dev);
>>               clk_disable_unprepare(sprd_hwlock->clk);
>> @@ -135,7 +136,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
>>  {
>>       struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
>>
>> -     hwspin_lock_unregister(&sprd_hwlock->bank);
>
> Until the hwspinlock is unregistered it's possible for clients to issue
> operations on it, so disabling power and clocks before that seems bad.

Yes, you are right. So may be register some additional actions with devm
core to call the clock disable as appropriate. Thanks.

-- 
Baolin.wang
Best Regards
