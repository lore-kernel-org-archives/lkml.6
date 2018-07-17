Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75222064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avISY3Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75222064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeGQUmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:42:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41682 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbeGQUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:42:52 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so4413116oiw.8;
        Tue, 17 Jul 2018 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sF5AlaQP39FqOPzedF3gA0UAv8cCONHNYLOBoqDZm/k=;
        b=avISY3Kd1GSHWsSir1HMr6HTodWZgXzVvsHKf7TGf+ZfEc6/R3MYDVUUDS6Brsttkc
         oKzcOcU6eZp7WvCFXpNBCpYlXLDTgWNfMKcDB+QYS/vVd+/3g9CYpmcQ3mcrvfmAUtqO
         UvYtfIhFLg9w2XTDGDU+HImIlh3hdm9vCcn6V03vj2biAAbXHES/Eb0x5bnK/dFTIrHz
         j01QR1gpFdkR0grWpVN7phD9CKw57gr2GxyKRsfbPy0YOnO4Eiu7gjGCQhF18K6qvH6v
         c65xIFQsz73iEib39zOGOM6uQu20DZ7/U1Yrw/e0gQuUfC9lfu431uE7mJFfZyJKC/su
         g+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sF5AlaQP39FqOPzedF3gA0UAv8cCONHNYLOBoqDZm/k=;
        b=No0QZIvcpAiZ9/DKGDQaB+s0PZUqr3h3Tr7C5sMVImHSIrPBGs8nzYDybOZo0UimvV
         fvAo7vILB4pvC8TWtNm8YVf9ssS3fME/sS5veTZIvFOLEr73JkDXUxSM1ALVE9Hvyyh8
         6qUjM7nTc/VSlfzgRzyVlMam+XUjWmtqrjYyxJSznXxSP+lEBJLmDmq1ypd60eR/4NeP
         1Cq5QA/ZKtkxLT/JPWqATq+DXXB6+9//qhLUL5BytClDWuM/rWf0fWyN7Upl2JuhO6W6
         YSzEIBtwhcWOzeoPXDp1ONV8bYVSATKvVWrXtUqDhWWZLPeH32B85XjbHbbEq4B4oNgj
         tOXA==
X-Gm-Message-State: AOUpUlFqodx0qC55uvZu7d83BKJrpu5OCYDukRPBkEGKkSZr7Y+laAiY
        TMGzA5ly5+wMPLVdS65gMSMxyFZpHv6KKMoXBzM=
X-Google-Smtp-Source: AAOMgpe8vSsmMVMtxjBo+umoRlrrLHkbRPrG5K/ETmGDP21bkqfl5DA5fp2qE3GBvbNRQTBV0L2XzQCMtLbEzeG/LCU=
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr2974796oib.319.1531858118040;
 Tue, 17 Jul 2018 13:08:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:08:17
 -0700 (PDT)
In-Reply-To: <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-2-git-send-email-linux.amoon@gmail.com> <CAJKOXPdtEbaOaqU1uzPLq6-MUANJq+2GCviy47b3zkjmRMcc8A@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 01:38:17 +0530
Message-ID: <CANAwSgTrsOv_cg470tze2vLLNAPEV1oApTEKep6gK8mPzWMiQg@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: exynos: cleanup of clk err check for exynos_tmu_work
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 17 July 2018 at 17:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> cleanup err check in exynos_tmu_work as clk internal
>> framework will perform if clk is enable/disable
>> so drop the double check of IS_ERR and other such references.
>
> I do not understand the statement. Clock framework will perform if clk
> is enable/disable? How clock can be "enable" or "disable"? You mean
> gate clock? you mean clock pointer is an ERR pointer?
>

if (!IS_ERR(data->clk_sec))
check if the pointer is valid or not
this check is again performed in
clk_enable.

>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index 0164c9e..2dbde97 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -300,8 +300,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>
>>         mutex_lock(&data->lock);
>>         clk_enable(data->clk);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_enable(data->clk_sec);
>> +       clk_enable(data->clk_sec);
>>
>>         status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>>         if (!status) {
>> @@ -334,8 +333,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>  err:
>>         clk_disable(data->clk);
>>         mutex_unlock(&data->lock);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_disable(data->clk_sec);
>> +       clk_disable(data->clk_sec);
>>  out:
>>         return ret;
>>  }
>> @@ -789,19 +787,16 @@ static void exynos_tmu_work(struct work_struct *work)
>>         struct exynos_tmu_data *data = container_of(work,
>>                         struct exynos_tmu_data, irq_work);
>>
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_enable(data->clk_sec);
>> -       if (!IS_ERR(data->clk_sec))
>> -               clk_disable(data->clk_sec);
>> -
>>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>>
>>         mutex_lock(&data->lock);
>>         clk_enable(data->clk);
>> +       clk_enable(data->clk_sec);
>
> You are changing here the logic completely. Before the "enable" was
> followed immediately by "disable". Now you are moving disable
> somewhere else... All this looks suspicious...

I chose to move enable/disable of clk_sec this under the mutex lock for safe
which dose the same sequence with different order.

Second approach:
We should get rid of clk_enable/disable in exynos_tmu_work
as this looks unnecessary for toggle clk's on every update.

Best Regards
-Anand
