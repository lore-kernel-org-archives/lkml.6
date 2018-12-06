Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B21DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6wFlKgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB5C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeLFI4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:56:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:56:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so22381795wrt.7;
        Thu, 06 Dec 2018 00:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppQG7sNryngECTu+LNkt4DIQCb8bcLgnVlG0Bpj+qVQ=;
        b=P6wFlKgEy2JX5KrhqwJZQ6CKo5Mg/B2QbnhEIHXyj4USiSbxZKUBsLojDylL03W3FC
         qCf1+90/vUwb56j8P1n/7xWaok/R/Pxh2nw9cNAapEvVqLMQk7wlpxlmGK69/fIpNGGH
         Qil5nV8Lqwqm/X+R/rqnw3KHks1bKQ+cNi1ZwFBHpc5+ElF2xNn1GsQIx4I9QPZVdEUC
         dnJcOFueno0N5Oo8WiJ3SEuZv/bRBox6E3ad0qKGUt2lwK/z7fQJK3MFL6VBn9KvjDEO
         TuGYvutMz/hnCp2nj70wZyX2yW/Q19IHqXXyYJJKM3jIWVB7g976WSVgRSgONCIG9fjs
         t9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppQG7sNryngECTu+LNkt4DIQCb8bcLgnVlG0Bpj+qVQ=;
        b=aiC996JHfS5pCHLakmZdsK/QDxZGUtdCXfe8wkzB/oNlkUhmW+RQlEgbfxaqkOYUvX
         VYrpflDmApGzPHlyzpuVjF1gl/sOrw8Hw6vLcMf5JIMlKMohJeucc2a+HKF5PlcfneSm
         vsfjUiF4Q1xnuyxLOYatS9/YoSVz0XZybyRiSkhF2h6KiGCX9OjDXccL+K5wi0QSjT5p
         LeWeySZzYBKlS2ZeMPDSOzvz1t2hp/VU+n6s1E1smp0DwA12D8h58sd3okiHMMDnEedN
         6ufRi2ciQoV5Qae4/rW8KCcKzRzawssyqnWr/hgCY8+83onxM8Bo7cSAX2wbizqGKZl3
         40mQ==
X-Gm-Message-State: AA+aEWbG3Xx5joKLPKfd4DiRwWFcJzLcd+Huce6aGAtDX7Bd8lFuTvWl
        8FlUruB4EmRGUsh2pjHJ5k0=
X-Google-Smtp-Source: AFSGD/VsTonkn/L3a9DVFzUu1m5n4fQJO1+3gYx0KzQX/RVX3TofHqCAXsVWaJbtR8APMda6OZraMQ==
X-Received: by 2002:adf:f101:: with SMTP id r1mr24950312wro.32.1544086606133;
        Thu, 06 Dec 2018 00:56:46 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id k7sm25053359wrl.51.2018.12.06.00.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 00:56:45 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw, Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWEiOTSSM=rKu67r-kgJ=TyAi7p7ndhAS4d5-6gccmmoQ@mail.gmail.com>
 <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <2c6c23fc-299a-f64d-c81f-4b4123f1577b@gmail.com>
Date:   Thu, 6 Dec 2018 09:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 06:56 AM, masonccyang@mxic.com.tw wrote:
> Hi Geert,
> 
>> "Geert Uytterhoeven" <geert@linux-m68k.org>
>> 2018/12/05 下午 05:06
>>
>> To
>>
>> masonccyang@mxic.com.tw,
>>
>> cc
>>
>> "Mark Brown" <broonie@kernel.org>, "Marek Vasut"
>> <marek.vasut@gmail.com>, "Linux Kernel Mailing List" <linux-
>> kernel@vger.kernel.org>, "linux-spi" <linux-spi@vger.kernel.org>,
>> "Boris Brezillon" <boris.brezillon@bootlin.com>, "Linux-Renesas"
>> <linux-renesas-soc@vger.kernel.org>, "Geert Uytterhoeven" <geert
>> +renesas@glider.be>, juliensu@mxic.com.tw, "Simon Horman"
>> <horms@verge.net.au>, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
>>
>> Hi Mason,
>>
>> On Mon, Dec 3, 2018 at 10:19 AM Mason Yang <masonccyang@mxic.com.tw>
> wrote:
>> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>
>> Thanks for your patch!
>>
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
>> > @@ -528,6 +528,12 @@ config SPI_RSPI
>> >         help
>> >           SPI driver for Renesas RSPI and QSPI blocks.
>> >
>> > +config SPI_RENESAS_RPC
>> > +       tristate "Renesas R-Car Gen3 RPC SPI controller"
>> > +       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>>
>> So this driver is intended for SuperH SoCs, too?
>> If not, please drop the dependency.
>>
> 
> okay, I will drop "SUPERH".
> 
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>>
>> > +#ifdef CONFIG_RESET_CONTROLLER
>> > +static int rpc_spi_do_reset(struct rpc_spi *rpc)
>>
>> What's the purpose of the reset routine?
> 
> in case RPC xfer is time-out due to something wrong in RPC module,
> as Marek comments.
> 
>> Given the #ifdef, is it optional or required?
>>
>> > +{
>> > +       int i, ret;
>> > +
>> > +       ret = reset_control_reset(rpc->rstc);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       for (i = 0; i < LOOP_TIMEOUT; i++) {
>> > +               ret = reset_control_status(rpc->rstc);
>> > +               if (ret == 0)
>> > +                       return 0;
>> > +               usleep_range(0, 1);
>> > +       }
>>
>> Why do you need this loop?
>> The delay in cpg_mssr_reset() should be sufficient.
>>
> 
> yup, I know there is already 35 us delay in cpg_mssr_reset().
> If you think reset_control_status()checking is not necessary,
> I will drop it.
> 
>> > +
>> > +       return -ETIMEDOUT;
>> > +}
>> > +#else
>> > +static int rpc_spi_do_reset(struct rpc_spi *rpc)
>> > +{
>> > +       return -ETIMEDOUT;
>> > +}
>> > +#endif
>>
>> > +static int rpc_spi_transfer_one_message(struct spi_master *master,
>> > +                                       struct spi_message *msg)
>> > +{
>> > +       struct rpc_spi *rpc = spi_master_get_devdata(master);
>> > +       struct spi_transfer *t;
>> > +       int ret;
>> > +
>> > +       rpc_spi_transfer_setup(rpc, msg);
>> > +
>> > +       list_for_each_entry(t, &msg->transfers, transfer_list) {
>> > +               if (!list_is_last(&t->transfer_list, &msg->transfers))
>> > +                       continue;
>> > +               ret = rpc_spi_xfer_message(rpc, t);
>>
>> rpc_spi_xfer_message() sounds like a bad name to me, given it operates
>> on a transfer, not on a message.
>>
> 
> Because RPC send a entire SPI message at one time, not separately,
> that is the 1'st transfer is for command, the 2'nd transfer is for
> address/data
> and so on.
> The reason is CS# pin control restriction in RPC HW module.
> 
> 
>> > +               if (ret)
>> > +                       goto out;
>> > +       }
>> > +
>> > +       msg->status = 0;
>> > +       msg->actual_length = rpc->totalxferlen;
>> > +out:
>> > +       spi_finalize_current_message(master);
>> > +       return 0;
>> > +}
>>
>>
>> > +static int rpc_spi_probe(struct platform_device *pdev)
>> > +{
>>
>> > +       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>> > +       if (IS_ERR(rpc->rstc))
>> > +               return PTR_ERR(rpc->rstc);
>>
>> This will return an error if CONFIG_RESET_CONTROLLER is not set, hence
>> the #ifdef above is moot.
>>
> 
> You are right.
> so, I should do
> Option 1: remove #CONFIG_RESET_CONTROLLER
> Option 2: add #CONFIG_RESET_CONTROLLER for
> devm_reset_control_get_exclusive()
> 
> please comments on it, thanks.
> 
> 
>> > +
>> > +       pm_runtime_enable(&pdev->dev);
>> > +       master->auto_runtime_pm = true;
>> > +
>> > +       master->num_chipselect = 1;
>> > +       master->mem_ops = &rpc_spi_mem_ops;
>> > +       master->transfer_one_message = rpc_spi_transfer_one_message;
>>
>> Is there any reason you cannot use the standard
>> spi_transfer_one_message, i.e. provide spi_controller.transfer_one()
>> instead of spi_controller.transfer_one_message()?
>>
> 
> It seems there is a RPC HW restriction in CS# pin control.
> Therefore, it can't send the 1'st spi-transfer for command and then
> keeping CS# pin goes low for the 2'nd spi-transfer for address/data and
> so on.

Isn't register DRCR bit SSLN/SSLE exactly for this purpose ?

-- 
Best regards,
Marek Vasut
