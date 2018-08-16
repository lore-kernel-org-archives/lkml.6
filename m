Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E68C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7820936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxgqJ4ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B7820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbeHPNBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:01:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35182 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeHPNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:01:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so7033875oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TXZmpRb/NmzG8w/RDUMO2wTVk/j99qe6L1IDjdmxW+Y=;
        b=dxgqJ4ejppzEbgT/a8+8ey3V9c+7Ybfzodq664ddmkJ/BU8AjgZU90TC+lY/6LI2C8
         QBDBvXfsfG+9NPecwHA6v0z3F+YGuevpGf91A4r3YkqLAwuX58gjZRsIppEPfPYJ3Uqq
         h+ha+UFjXewLXAhccuHBgK0a7XOPxRtksstOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TXZmpRb/NmzG8w/RDUMO2wTVk/j99qe6L1IDjdmxW+Y=;
        b=LSbsLL0tLX7qjgu8Tnb6cq6oZYCbggVeknajWfCb927si6kzGpMGQ4+mpWJmApMRNp
         +V7RB2LI39/+LHNYh+TXalis+Mvdl83mYZ7WjHG1d9YyM02wN0hy1EZENbUJbOjOOaJK
         s7QAX/LJFk/DXVNo4sB3IkJF+O8DR1bgjiTBeCcF9j9ySb1L2yeLqnRPSl/wfyXbk4V3
         tRNMEdJBcF+rAXMAMHIDvNw9isSQCP0Fl6hS5Os/eu4cGpZCgKW9c2YjGyAzMazbeNhv
         ucQ/Zr5S8Iq7fx+aVBoiuNMnu5wbAuR7Lsce7B1rLREud5kjrr5cFJDwQy3CFlv1t2yW
         SrhQ==
X-Gm-Message-State: AOUpUlEhQ8Np8T9P+VHKCIprlFp0D6I2ldCfC+y7d8e6syN3wX0ZoG6p
        QjF6PDhEQ/vZTFMKogx2sPKiV7tc39cfdX0DF0XaSQ==
X-Google-Smtp-Source: AA+uWPztGb2FlJ8I3ahszmoh1FH+u0U7DL3rEpAUyso6dvPr+Foz1bo9bXS6XGudHulN1qW8kepDdY/ejJ7cNRCAuuY=
X-Received: by 2002:aca:ed45:: with SMTP id l66-v6mr31774763oih.40.1534413827343;
 Thu, 16 Aug 2018 03:03:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f9b:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 03:03:06
 -0700 (PDT)
In-Reply-To: <CAAQ0ZWRj6VhgY_hBz0iaxG8rJQVOVCKn4GOpoC_m1opp+qEyqQ@mail.gmail.com>
References: <1534333184-25599-1-git-send-email-igor.opaniuk@linaro.org> <CAAQ0ZWRj6VhgY_hBz0iaxG8rJQVOVCKn4GOpoC_m1opp+qEyqQ@mail.gmail.com>
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
Date:   Thu, 16 Aug 2018 13:03:06 +0300
Message-ID: <CAModR+VU9XmhYt_BdXd1QCTX0d5yUXjQNVjVQpViLuW8aWdMOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 capability
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        tianshuliang <tianshuliang@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Will test it today with the change you suggested, in case if
everything is OK will send v2 asap

Thanks

On 16 August 2018 at 11:01, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 15, 2018 at 7:39 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>>
>> Enable access to the RPMB on the on-board eMMC of the
>> Poplar board.
>>
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> index f9b333f..7a023f0 100644
>> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
>> @@ -23,6 +23,12 @@ struct hi3798cv200_priv {
>>         struct clk *drive_clk;
>>  };
>>
>> +static unsigned long dw_mci_hi3798cv200_caps[] = {
>> +       MMC_CAP_CMD23,
>> +       MMC_CAP_CMD23,
>> +       0
>> +};
>
> I believe the three dwmmc blocks integrated on Hi3798CV200 SoC are
> identical on CMD23 support.  So I expect the zero to be MMC_CAP_CMD23
> as well.
>
> Shawn
>
>> +
>>  static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>  {
>>         struct hi3798cv200_priv *priv = host->priv;
>> @@ -160,6 +166,8 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
>>  }
>>
>>  static const struct dw_mci_drv_data hi3798cv200_data = {
>> +       .caps = dw_mci_hi3798cv200_caps,
>> +       .num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
>>         .init = dw_mci_hi3798cv200_init,
>>         .set_ios = dw_mci_hi3798cv200_set_ios,
>>         .execute_tuning = dw_mci_hi3798cv200_execute_tuning,
>> --
>> 2.7.4
>>



-- 
Regards,
Igor Opaniuk
