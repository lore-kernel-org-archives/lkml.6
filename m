Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CDEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EAC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UxiQeQsb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zg4xRm6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeHCOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:14:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeHCOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:14:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C321606AC; Fri,  3 Aug 2018 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298716;
        bh=cmWBkuS6pZ4rv7XPwrmfTY0PBvzACQLoQ27GgedibUM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=UxiQeQsbKkAamG+T1Bwj/Lr/WptrHR8IlzjSa8bgP50tThhkEtxzxMFBdVu6uxq8L
         xkJbmC4E/8fvy/9ns4qgsr6rbjhC/q2zcCpa6YiWMKfBwXgbEUmllY82zWIjtc76lt
         oBiD2yh3UlfmdYuPZ+j5BnUlPnbnS/f3m4GJpgOY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 97423602B7;
        Fri,  3 Aug 2018 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298715;
        bh=cmWBkuS6pZ4rv7XPwrmfTY0PBvzACQLoQ27GgedibUM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=Zg4xRm6vdVcnJXdDCYzgOSzF8dpoWvP2DxgP5ZrJlK+P49GJKQK5RtEzN0A2bb3FV
         PoAwWMZYzSSzAfuAjucPSvRldekYa8UL48nrCsGXsDD3uI/qDF2/gxPxLTUvP62SXT
         PoJOBS0KdAqRs+J9HkNkfrl9B1/pA3/ZmFQyKyhQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 17:48:35 +0530
From:   dkota@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
In-Reply-To: <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
Message-ID: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Mark,

>>> Do you mean spi-rx-delay-us and spi-tx-delay-us properties? Those are
>>> documented but don't seem to be used. There's also the delay_usecs 
>>> part
>>> of the spi_transfer structure, which may be what you're talking 
>>> about.
>> 
>> delay_usecs is for inter-transfer delays within a message rather than
>> after the initial chip select assert (it can be used to keep chip 
>> select
>> asserted for longer after the final transfer too).  Obviously this is
>> also something that shouldn't be configured in a driver specific
>> fashion.
>> 
> 
> Hmmm ok, so you mean don't send these as controller_data, rather add 
> new
> members to the spi_device struct ?

spi_cs_clk_delay -> Adds Delay from CS line toggle to Clock line toggle
spi_inter_words_delay -> Adds inter-word delay for each transfer.

Could you please provide more information on accommodating these 
parameters in
SPI core structures like spi_device or spi_transfer? Why because these 
are very
specific to SPI GENI controller.


>> +       if (of_property_read_u32(pdev->dev.of_node, 
>> "spi-max-frequency",
>> +                               &spi->max_speed_hz)) {

> Why does this need to come from DT?

This is required to set the SPI controller max frequency.
As it is specific to the controller, so looks meaningful to specify it 
in dtsi.
Also, spi core framework will set the transfer speed to controller max 
frequency
if transfer frequency is greater than controller max frequency.
Please mention if you have a other opinion.

Code snippet from spi.c
====
2826		if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
2827			xfer->speed_hz = ctlr->max_speed_hz;
====

>> +       mas->cur_speed_hz = spi_slv->max_speed_hz;
> 
> Why can't you use clk_get_rate() instead? Or call clk_set_rate() with
> the rate you want the master clk to run at and then divide that down
> from there?
> 
> 
>> > Not sure I follow, the intention is to run the controller clock based on
>> > the slave's max frequency.
> 
>> That's good. The problem I see is that we have to specify the max
>> frequency in the controller/bus node, and also in the child/slave 
>> node.
>> It should only need to be specified in the slave node, so making the
>> cur_speed_hz equal the max_speed_hz is problematic. The current speed 
>> of
>> the master should be determined by calling clk_get_rate().
> 
> We don't require that the slaves all individually set a speed since it
> gets a bit redundant, it should be enough to just use the default the
> controller provides.  A bigger problem with this is that the driver 
> will
> never see a transfer which doesn't explicitly have a speed set as the
> core will ensure something is set, open coding this logic in every
> driver would obviously be tiresome.

clock_get_rate() will returns the rate which got set as per the
clock plan(which was the rounded up frequency). For that reason
using the cur_speed_hz.
