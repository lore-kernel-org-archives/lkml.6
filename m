Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42173C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE16A216F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TxFJxS56";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A1+svyl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE16A216F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeHNLqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:46:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeHNLqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:46:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43C7E6076A; Tue, 14 Aug 2018 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534237203;
        bh=wpOFNrTqT0pT7zZxq3pO2UF2hJ1eT80s8Wsjz/7SZfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TxFJxS56tvGcVClcQdkDyG/L3rS7Wkk2AM52N9HrW00ilrShTgqp3UWPj6sZM7Uow
         6dL5TqnZC05s5ZUcmiGKSiU68mQWpU6JaRlJe2rRRCAXsXHu21DohEY4fc8/Zn+mpr
         5F4DAiC+najUddFF/BROk2UoBuD/fSHDCE/JMZ64=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 626BF601B4;
        Tue, 14 Aug 2018 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534237202;
        bh=wpOFNrTqT0pT7zZxq3pO2UF2hJ1eT80s8Wsjz/7SZfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A1+svyl1PXwcqmShPALNXrQA89QEZn81k0scEdvPShyhUdA/DKLS0aa4Se/0MOUxm
         iv81HMrO4xTuoDdF4ARDQ5H7OeotPpI7FJ4J2f712UlhWJZthqFswG6b9op0R1w4Mq
         EKh64KbzgVgnE8dQhkElzZSGscV2Zpsc7qtcq4ws=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Aug 2018 14:30:02 +0530
From:   dkota@codeaurora.org
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
In-Reply-To: <20180810164636.GI20971@sirena.org.uk>
References: <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
Message-ID: <b32c205955e0f42182b16e90f539a919@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-10 22:16, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:
> 
>> Now the need is, how to communicate the SPI controller maximum 
>> frequency to
>> SPI core framework?
>> Is it by DTSI entry or hardcoding in the SPI controller driver?
> 
> If you've got a limit that exists in the IP the hard code it in the
> driver.
> 
>> My stand is for providing the DTSI entry.
>> Why because, this keeps SPI controller driver generic across the 
>> boards and
>> portable.
>> Also it is not against to Device tree usage because maximum frequency
>> is describing the property of the hardware.
> 
> If the limit the controller has is not coming from the clock tree then
> presumably it's a physical limitation of the silicon and isn't going to
> vary per board.  If the limit is coming from the board then it should 
> be
> specified per slave since different slaves may have different
> requirements on different boards.

Agree with you guys, will hard code the controller maximum frequency in 
the driver.
I will address this change in the next patchset.


Could you all please comment on the other points too:

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
parameters in SPI core structures like spi_device or spi_transfer? Why 
because these are very
specific to Qualcomm SPI GENI controller.

If we define them in spi core framework structures, SPI Slave driver 
will program and expect it in the SPI transfers.

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

clock_get_rate() will returns the rate which got set as per the clock 
plan(which was the rounded up frequency) which can be less than or equal 
to the requested frequency. For that reason using the cur_speed_hz to 
store the requested frequency and skip clock configuration for the 
consecutive transfers with same frequency.


--Dilip
