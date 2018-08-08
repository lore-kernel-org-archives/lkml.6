Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30081C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D129321758
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DxJWKznK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129321758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeHHTtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:49:46 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:51628 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:49:46 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 155FF24E0513;
        Wed,  8 Aug 2018 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533749346; bh=isckySDeIk7AP7iRCfgSz6UBAaNYH/Dl/bANN9mk7Q4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=DxJWKznKcqHLOaIyAHXCQWsyA5dDMpBBY8jZaJZ+w6MaN0r/D+jcRQoB7BOLkjaGh
         YxEKXh81nWN/ydeXnbrWUkFHI8vOKuDQ9KrD5DiwT8d+mA2irOvcFwjzAZAPBaexVz
         /y7lmog6l1VzIt6MLtBOciHpDmXGp/7PCK9mi2esRMBemmyR8suzGKIQeI/bgCj7tW
         qJzVeUBlGryAbyuRdwnjP/3MN9GlJPpTOg9ff+equnacUa+3x8Cp8uU5lg4yg4VQXr
         iFYCF4vwUPz9kCixunw8DzvFgQil5gFm0qGEHW6NruxphIz+Nfc4Aud3grN1tvT3eC
         YEJtsdkrUQGfA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1D7CC3707;
        Wed,  8 Aug 2018 10:29:03 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 10:29:02 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 8 Aug 2018 19:29:00 +0200
Received: from [10.0.2.15] (10.107.25.93) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Aug
 2018 19:29:00 +0200
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vitor soares <Vitor.Soares@synopsys.com>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <Joao.Pinto@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-2-git-send-email-soares@synopsys.com>
 <20180727153850.5a8ca75c@bbrezillon>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <04ae034c-ec6c-ce43-6536-9da9d765d558@synopsys.com>
Date:   Wed, 8 Aug 2018 18:28:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727153850.5a8ca75c@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.93]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 27-07-2018 14:38, Boris Brezillon wrote:
> Hi Victor,
>
> On Fri, 20 Jul 2018 21:57:50 +0100
> Vitor soares <Vitor.Soares@synopsys.com> wrote:
>
>> This patch add driver for Synopsys DesignWare IP on top of
>> I3C subsystem patchset proposal V6
> The fact that you based your work on v6 of the I3C patchset should be
> placed ....
>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
>> ---
> ... here, so that it does not appear in the final commit message.
>
>
> [...]

I will do that in the next submission.

>> +static int dw_i3c_master_get_free_pos(struct dw_i3c_master *master)
>> +{
>> +	if (!(master->free_pos & GENMASK(master->maxdevs - 1, 0)))
>> +		return -ENOSPC;
>> +
>> +	return ffs(master->free_pos) - 1;
>> +}
> Okay, maybe we can have a generic infrastructure for that part (I have
> the same logic in the Cadence driver), but let's keep that for later.

I think everyone will need a table (SW or HW) to mask the slots 
available for DAA.

>
>> +
>> +static void dw_i3c_master_wr_tx_fifo(struct dw_i3c_master *master,
>> +				     const u8 *bytes, int nbytes)
>> +{
>> +	int i, j;
>> +
>> +	for (i = 0; i < nbytes; i += 4) {
>> +		u32 data = 0;
>> +
>> +		for (j = 0; j < 4 && (i + j) < nbytes; j++)
>> +			data |= (u32)bytes[i + j] << (j * 8);
>> +
>> +		writel(data, master->regs + RX_TX_DATA_PORT);
> Maybe you can use writesl() as suggested by Arnd in his review of the
> Cadence driver.

Andy also suggest get_unaligned_le32() / put_unaligned_le32() to 
read/write from FIFOS. I will try both solutions.

>
>> +	}
>> +}
>> +
> [...]
>
>> +
>> +static void dw_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
>> +{
>> +	struct dw_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
>> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
>> +	struct dw_i3c_master *master = to_dw_i3c_master(m);
>> +
>> +	writel(NULL,
> 		^ 0 not NULL

I will change it.

>
>> +	       master->regs +
>> +	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
>> +
>> +	i2c_dev_set_master_data(dev, NULL);
>> +	master->addrs[data->index] = 0;
>> +	master->free_pos |= BIT(data->index);
>> +	kfree(data);
>> +}
>> +
>> +static int dw_i3c_probe(struct platform_device *pdev)
>> +{
>> +	struct dw_i3c_master *master;
>> +	struct resource *res;
>> +	int ret, irq;
>> +
>> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
>> +	if (!master)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	master->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(master->regs))
>> +		return PTR_ERR(master->regs);
>> +
>> +	master->core_clk = devm_clk_get(&pdev->dev, "core_clk");
>> +	if (IS_ERR(master->core_clk))
>> +		return PTR_ERR(master->core_clk);
>> +
>> +	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>> +								    "core_rst");
>> +	if (IS_ERR(master->core_rst))
>> +		return PTR_ERR(master->core_rst);
>> +
>> +	ret = clk_prepare_enable(master->core_clk);
>> +	if (ret)
>> +		goto err_disable_core_clk;
>> +
>> +	reset_control_deassert(master->core_rst);
>> +
>> +	spin_lock_init(&master->xferqueue.lock);
>> +	INIT_LIST_HEAD(&master->xferqueue.list);
>> +
>> +	writel(INTR_ALL, master->regs + INTR_STATUS);
>> +	irq = platform_get_irq(pdev, 0);
>> +	ret = devm_request_irq(&pdev->dev, irq,
>> +			       dw_i3c_master_irq_handler, 0,
>> +			       dev_name(&pdev->dev), master);
>> +	if (ret)
>> +		goto err_assert_rst;
>> +
>> +	platform_set_drvdata(pdev, master);
>> +
>> +	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
>> +	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
>> +
>> +	ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
>> +	master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
>> +
>> +	ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
>> +	master->datstartaddr = ret;
>> +	master->maxdevs = ret >> 16;
>> +	master->free_pos = GENMASK(master->maxdevs - 1, 0);
>> +
>> +	/* read controller version */
>> +	ret = readl(master->regs + I3C_VER_ID);
>> +	master->version[0] = (char)(ret >> 24);
>> +	master->version[1] = '.';
>> +	master->version[2] = (char)(ret >> 16);
>> +	master->version[3] = (char)(ret >> 8);
>> +	master->version[4] = '\0';
>> +
>> +	/* read controller type */
>> +	ret = readl(master->regs + I3C_VER_TYPE);
>> +	master->type[0] = (char)(ret >> 24);
>> +	master->type[1] = (char)(ret >> 16);
>> +	master->type[2] = (char)(ret >> 8);
>> +	master->type[3] = (char) ret;
>> +	master->type[4] = '\0';
> Hm, do you really intend to read these as strings? If you do, maybe you
> can use sprintf() here:
>
> 	sprintf(master->version, "%c.%c%c", ...)
> 	sprintf(master->type, "%c%c%c%c", ...)

Maybe this information is unnecessary. I will remove it.

>
>
>> +
>> +	ret = i3c_master_register(&master->base, &pdev->dev,
>> +				  &dw_mipi_i3c_ops, false);
>> +	if (ret)
>> +		goto err_assert_rst;
>> +
>> +	dev_info(&pdev->dev, "Synopsys DW MIPI I3C Master: version %s-%s\n",
>> +		 master->version, master->type);
>> +
>> +	return 0;
>> +
>> +err_assert_rst:
>> +	reset_control_assert(master->core_rst);
>> +
>> +err_disable_core_clk:
>> +	clk_disable_unprepare(master->core_clk);
>> +
>> +	return ret;
>> +}
> The driver looks pretty good already, and I'm pleasantly surprised to
> see that the Synopsys IP works pretty much the same way the Cadence one
> does. I could find some of the logic I implemented in the Cadence
> driver almost directly applied to this one, so I think there's room for
> code factorization. Anyway, let's see what the next controller looks
> like before doing that.
>
> Thanks for sharing your work early and for reviewing the previous
> versions of the I3C patchset.
>
> Regards,
>
> Boris

I tried to not reinvent the wheel. Right now the test with I3C devices 
are running very well.
I still have one or another detail that can be optimize.

Thanks for your feedback.

Best regards,
Vitor Soares


