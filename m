Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298BFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F67208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp5FPv4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F67208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936140AbeFRJyK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:54:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36679 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935594AbeFRJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:54:07 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so7279858pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sst1dR0AQdYXpt5vAFHDZufnV87LqWRo98UpbkhGn4o=;
        b=Dp5FPv4Fehb5QQO/ntMMRMUs7ln4vqOz0KOd34V/Flp05YdolOpK6/t7FSOGrT+bqS
         /qTMzBFKGyS0SyCIA22kFtWJPq4KqanYtgXWg/Z5qxLWmaEhmn+dEFmhTrzFt2ooOSvI
         UBiPRZ9qd50JiQRSqqXHuQin10mo3565USoqHproxpojh5bmSwZUViUv0DCjlaqNYogY
         LjA1QS00G82zSFNkoaymAU4oTKvmullsenpvybRwq/sU82oaUpQFdDAVZnsderfoUhf8
         TumwiCJvshgb3RIzCpjXNIOED9N4R3v3T+82XhVRpTQi6XKOWhb9SUiDtfI7Xpv9MvhO
         FOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sst1dR0AQdYXpt5vAFHDZufnV87LqWRo98UpbkhGn4o=;
        b=qAVN+9CKehQIFYVGuY8K4V5+EaZ3PPuxXxu238YSas+KV0dAiDecEUHvDJ3EwFPxbp
         RZa+iDprygoj73JySFP4uES4HAK1sF8cqPyH6RX96ukZH4dFtH5vAcv/9VH2lFdNtmBa
         XsKHGM8nMmC9SuXF+mAbuQNRs1+qcx2QBc23U66En5pP4QknfovTdGNPo/WbS4ujSDe7
         oElbN6OdfYpeMRi0xW+jpIyg1N2/FjfORNdlRspTKMakSpUPD/xUWaA+9afzi4SpXuFj
         xJzn1V1nLSHyvvWo+4OPz9OVTBapZGauIr7GMC6YEb6N6e+G96KTIcVThq6ikiqKHtlK
         ElLg==
X-Gm-Message-State: APt69E28QpSEnBJI8UV1tsSYRCKtNeGo43AKnMkpQ3kfxNPRfBb0xhC5
        ptB36kv9BRxgiPyis+6lTTY=
X-Google-Smtp-Source: ADUXVKI6ACsD3BIKrjLha7WnlNmRoUiz7JDXhaP/qDoUSRLuV5XLdVvBQjWCBN4siORLxRyTlZiS4w==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr10653508pge.203.1529315646431;
        Mon, 18 Jun 2018 02:54:06 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.100])
        by smtp.gmail.com with ESMTPSA id j3-v6sm10228554pff.35.2018.06.18.02.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 02:54:05 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <20180618114920.654647c0@bbrezillon>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
Date:   Mon, 18 Jun 2018 11:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618114920.654647c0@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 11:49 AM, Boris Brezillon wrote:
> Hi Claudiu,
> 
> The subject prefix should be "mtd: spi-nor: atmel-quadspi: ". No need
> to send a new version just for that, I'll fix it when applying the
> patch.
> 
> Looks good otherwise. Marek, any objection? If not, can you add your
> Acked-by?

Will this work if you have ie. ubifs mounted on that QSPI NOR and you
suspect and resume during IO ? I think it would, but just curious if
there could be some problem.

> Thanks,
> 
> Boris
> 
> On Mon, 4 Jun 2018 11:46:33 +0300
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> 
>> Implement suspend/resume hooks.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>
>> Changes in v2:
>> - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
>>
>>  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
>> index 6c5708bacad8..ceaaef47f02e 100644
>> --- a/drivers/mtd/spi-nor/atmel-quadspi.c
>> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
>> @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>> +{
>> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
>> +
>> +	clk_disable_unprepare(aq->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused atmel_qspi_resume(struct device *dev)
>> +{
>> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
>> +
>> +	clk_prepare_enable(aq->clk);
>> +
>> +	return atmel_qspi_init(aq);
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
>> +			 atmel_qspi_resume);
>>  
>>  static const struct of_device_id atmel_qspi_dt_ids[] = {
>>  	{ .compatible = "atmel,sama5d2-qspi" },
>> @@ -749,6 +769,7 @@ static struct platform_driver atmel_qspi_driver = {
>>  	.driver = {
>>  		.name	= "atmel_qspi",
>>  		.of_match_table	= atmel_qspi_dt_ids,
>> +		.pm	= &atmel_qspi_pm_ops,
>>  	},
>>  	.probe		= atmel_qspi_probe,
>>  	.remove		= atmel_qspi_remove,


-- 
Best regards,
Marek Vasut
