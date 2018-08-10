Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B78C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357B520845
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MSbIccQ2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aZaO9/ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357B520845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHKBgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:36:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:36:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9570360B23; Fri, 10 Aug 2018 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533942277;
        bh=RCRxMyZLf+jEJ1vrE01bc469wUxzbSUr/UeIQPORsC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MSbIccQ2brGxGiShpBTASY3ynAwsptPsqfStB4x73vHEQKCqD2/5yz4ysOImkLH78
         ECd2XhwvZims3Nvt+lAVE+VI/N2tkZ4hgpRISeXqoBc0NPY5qyZEVHFxCT69orfHWV
         IpX1r505noTUoEVt2WOGbIRnclEqWzW1qEueBOdI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7B85960590;
        Fri, 10 Aug 2018 23:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533942276;
        bh=RCRxMyZLf+jEJ1vrE01bc469wUxzbSUr/UeIQPORsC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aZaO9/nyjOqaGaCN60t7j2BlaaKrGAhVhYr4IUQqCEf5cD45paFfotK54GZahZnzJ
         ENcP0xOJBKOykTZ8D3VpSDl8fnbWsEfD5Ev+o+ECAi1WFuVL/0LjZcXdEMQx64zI5s
         /SlVF8FlFScfQEyg/BwDhnM6rQpn6H6fMaxdBRTs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Aug 2018 16:04:36 -0700
From:   vnkgutta@codeaurora.org
To:     Evan Green <evgreen@chromium.org>
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Subject: Re: [PATCH v1 2/4] drivers: soc: Add support to register LLCC EDAC
 driver
In-Reply-To: <CAE=gft4zc8vHt_O0dTomu=3zq-_ri52WnjH=F6BhyaNoybu2hQ@mail.gmail.com>
References: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org>
 <1533155615-27929-3-git-send-email-vnkgutta@codeaurora.org>
 <CAE=gft4zc8vHt_O0dTomu=3zq-_ri52WnjH=F6BhyaNoybu2hQ@mail.gmail.com>
Message-ID: <6ab4d15223aa4299b0c45613c3859255@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-10 10:21, Evan Green wrote:
> On Wed, Aug 1, 2018 at 1:33 PM Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org> wrote:
>> 
>> Cache error reporting controller is to detect and report single
>> and double bit errors on Last Level Cache Controller (LLCC) cache.
>> Add required support to register LLCC EDAC driver as platform driver,
>> from LLCC driver.
>> 
>> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
>> ---
>>  drivers/soc/qcom/llcc-slice.c      | 18 ++++++++++++++++--
>>  include/linux/soc/qcom/llcc-qcom.h |  2 ++
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/soc/qcom/llcc-slice.c 
>> b/drivers/soc/qcom/llcc-slice.c
>> index a63640d..09c8bb0 100644
>> --- a/drivers/soc/qcom/llcc-slice.c
>> +++ b/drivers/soc/qcom/llcc-slice.c
>> @@ -224,7 +224,7 @@ static int qcom_llcc_cfg_program(struct 
>> platform_device *pdev)
>>         u32 attr0_val;
>>         u32 max_cap_cacheline;
>>         u32 sz;
>> -       int ret;
>> +       int ret = 0;
>>         const struct llcc_slice_config *llcc_table;
>>         struct llcc_slice_desc desc;
>> 
>> @@ -282,6 +282,7 @@ int qcom_llcc_probe(struct platform_device *pdev,
>>         struct resource *llcc_banks_res, *llcc_bcast_res;
>>         void __iomem *llcc_banks_base, *llcc_bcast_base;
>>         int ret, i;
>> +       struct platform_device *llcc_edac;
>> 
>>         drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>         if (!drv_data)
>> @@ -341,6 +342,19 @@ int qcom_llcc_probe(struct platform_device *pdev,
>>         mutex_init(&drv_data->lock);
>>         platform_set_drvdata(pdev, drv_data);
>> 
>> -       return qcom_llcc_cfg_program(pdev);
>> +       ret = qcom_llcc_cfg_program(pdev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       drv_data->ecc_irq = platform_get_irq(pdev, 0);
>> +       if (drv_data->ecc_irq >= 0) {
> 
> This condition will always be true for u32. See below...
That's true. I missed that.
> 
>> +               llcc_edac = platform_device_register_data(&pdev->dev,
>> +                                               "qcom_llcc_edac", -1, 
>> drv_data,
>> +                                               sizeof(*drv_data));
>> +               if (IS_ERR(llcc_edac))
>> +                       dev_err(dev, "Failed to register llcc edac 
>> driver\n");
>> +       }
>> +
>> +       return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_llcc_probe);
>> diff --git a/include/linux/soc/qcom/llcc-qcom.h 
>> b/include/linux/soc/qcom/llcc-qcom.h
>> index c681e79..1a3bc25 100644
>> --- a/include/linux/soc/qcom/llcc-qcom.h
>> +++ b/include/linux/soc/qcom/llcc-qcom.h
>> @@ -78,6 +78,7 @@ struct llcc_slice_config {
>>   * @num_banks: Number of llcc banks
>>   * @bitmap: Bit map to track the active slice ids
>>   * @offsets: Pointer to the bank offsets array
>> + * @ecc_irq: interrupt for llcc cache error detection and reporting
>>   */
>>  struct llcc_drv_data {
>>         struct regmap *regmap;
>> @@ -89,6 +90,7 @@ struct llcc_drv_data {
>>         u32 num_banks;
>>         unsigned long *bitmap;
>>         u32 *offsets;
>> +       u32 ecc_irq;
> 
> The return type for platform_get_irq is int, so this should probably
> be int, or "unsigned", but then you'd need to fix your logic above.
I think we should keep that as int. I'll check on which one I'm supposed 
to use here and update in the next version.
> 
>>  };
>> 
>>  #if IS_ENABLED(CONFIG_QCOM_LLCC)
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
