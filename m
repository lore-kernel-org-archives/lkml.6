Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BB1216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRf+0YdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BB1216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeHHFC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:02:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38194 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHHFC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:02:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so1242909oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ieiwpquYvmpT36udiVji+hFKdfTM5k4XEPUQW249/iY=;
        b=VRf+0YdRmMSmr1FB+aFZ/+E4R5GC8mLxLsPmDMF4FzhbhaWRX1dJjZYG1YKzHL/raR
         WeFp4O3qNon7NFX6wNl8oujhntgWpVtQuj6sRA0qjhCCRW51wXlh9dezzSSC0LJ5m53r
         T9HtW126zxkvneaKU4uYUINkFFZZwtOcRS1T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ieiwpquYvmpT36udiVji+hFKdfTM5k4XEPUQW249/iY=;
        b=TOvBFWFCHXFDs1WeYhxrwrZ/26/G12TRVebN/+9KyIMl91KMhHtblhwqKqa2AVPqjO
         li7UW1JGTJD8gzqnboW0iXuav3fKnr/pbIgxN2WfeLpoYY/oM1cCFTvjZzOa/JZm3iPl
         Eut9V0b+e7/FcqZ6lEiE3LkWEiR47ug3q4r7/cYwjX0edyN9TsrsgR7vMVAJKG5uxaGa
         DNJV4ln/n0XmuJnol5kxm221bTZofJyyvnZOiFwNheyaeUp3dGdWwqb3Pyfcy9ybkiAl
         R+Uqf++IMMVt0iavJTr4oChKeKvIJkWc0dkmTl2KW8BNvrZT1st5BZ93yXzYcK4TBFAs
         f0kA==
X-Gm-Message-State: AOUpUlH8jAnmzoTuJ9bDFjyQEp1FDBf1KFkbBO2BWcO/LB1EVM8uTID1
        jE40dfZxyS1HgWhnngKqoiNncd6bEcBPFRa5n0uR8A==
X-Google-Smtp-Source: AA+uWPw2fI88zjt+HcDxubzxMsA2Z0F0BAujhc5BUGP8X5bzmd2oh9Q6UtEPODwemz0656EuxI20ZslfORZ8P+Uzo/8=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr1000393oie.68.1533696333773;
 Tue, 07 Aug 2018 19:45:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 19:45:33 -0700 (PDT)
In-Reply-To: <20180807142408.GB7958@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <20180807142408.GB7958@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 10:45:33 +0800
Message-ID: <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 7 August 2018 at 22:24, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:
>> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>>
>> This patch adds the SPI controller driver for Spreadtrum SC9860 platform.
>
> This all looks pretty clean, a few comments below but nothing too major:
>
>> +static void sprd_spi_chipselect(struct spi_device *sdev, bool cs)
>> +{
>> +     struct spi_controller *sctlr = sdev->controller;
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     u32 val;
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             return;
>> +     }
>
> Something else further up the stack should probably have runtime PM
> enabled already - we should only be changing chip select as part of a
> bigger operation.  If you use the core auto_runtime_pm feature this will
> definitely happen.

Indeed, will use auto_runtime_pm.

>
>> +     bits_per_word = bits_per_word > 16 ? round_up(bits_per_word, 16) :
>> +             round_up(bits_per_word, 8);
>
> Please

Sorry I did not get your points here, could you elaborate on?

>
>> +     switch (bits_per_word) {
>> +     case 8:
>> +     case 16:
>> +     case 32:
>
> It'd be nice to have a default case, the core should check for you but
> it's nice to have defensive programming here.

Sure.

>
>> +static int sprd_spi_transfer_one(struct spi_controller *sctlr,
>> +                              struct spi_device *sdev,
>> +                              struct spi_transfer *t)
>> +{
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             goto rpm_err;
>> +     }
>
> Same thing with runtime PM here - the core can do this for you.

Yes.

>
>> +static int sprd_spi_setup(struct spi_device *spi_dev)
>> +{
>> +     struct spi_controller *sctlr = spi_dev->controller;
>> +     struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
>> +     int ret;
>> +
>> +     ret = pm_runtime_get_sync(ss->dev);
>> +     if (ret < 0) {
>> +             dev_err(ss->dev, "failed to resume SPI controller\n");
>> +             return ret;
>> +     }
>> +
>> +     ss->hw_mode = spi_dev->mode;
>> +     sprd_spi_init_hw(ss);
>
> This can be called for one chip select while another is in progress so
> it's not good to actually configure the hardware here unless the
> configuration is in a chip select specific set of registers.  Instead
> you should defer to when the transfer is being set up.

You are right, will move these into transfer setup.

>
>> +static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
>> +{
>> +     struct clk *clk_spi, *clk_parent;
>> +
>> +     clk_spi = devm_clk_get(&pdev->dev, "spi");
>> +     if (IS_ERR(clk_spi)) {
>> +             dev_warn(&pdev->dev, "can't get the spi clock\n");
>> +             clk_spi = NULL;
>> +     }
>
> I suspect some of these clocks are essential and you should probably
> return an error if you can't get them (especially if probe deferral
> becomes a factor).

The 'spi' and 'source' clock can be optional, and the SPI can work at
default source clock without setting 'spi' and 'source' clock. This is
used on our FPGA board which has not set the spi source clock, but
still make the SPI can work. So here we just give a warning.

>> +     if (!clk_set_parent(clk_spi, clk_parent))
>> +             ss->src_clk = clk_get_rate(clk_spi);
>> +     else
>> +             ss->src_clk = SPRD_SPI_DEFAULT_SOURCE;
>
> Are upstream DTs going to be missing the clock setup needed here?

Right. DTs can not set 'spi' and 'source' clock to make SPI work at
default clock. Thanks for your useful comments.

-- 
Baolin Wang
Best Regards
