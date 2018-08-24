Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05075C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0E208D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oclvr3Px";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oclvr3Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD0E208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeHXOe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:34:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:34:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AAEBF60117; Fri, 24 Aug 2018 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535108417;
        bh=WuPw2QpifX1YgWj3hakbZVDop6h0IfA7ttlQDqr+ExU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oclvr3PxiXQ6ZBshnhGaxIKlEMzrAM6zFhaSYVaAg6Qe9W3+nwXXJ8rtvMAH4s/Ql
         o4u09PYCiytevY2iF4V2q7plAjmaCVHS+tSUssQzVAmni6OwZdqhRney/OYqsNOgvk
         1x0wFkT3ldPfZa0YFxOt+j23xrZzsgamFGPKbyz8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 120FC60117;
        Fri, 24 Aug 2018 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535108417;
        bh=WuPw2QpifX1YgWj3hakbZVDop6h0IfA7ttlQDqr+ExU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oclvr3PxiXQ6ZBshnhGaxIKlEMzrAM6zFhaSYVaAg6Qe9W3+nwXXJ8rtvMAH4s/Ql
         o4u09PYCiytevY2iF4V2q7plAjmaCVHS+tSUssQzVAmni6OwZdqhRney/OYqsNOgvk
         1x0wFkT3ldPfZa0YFxOt+j23xrZzsgamFGPKbyz8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 16:30:16 +0530
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
In-Reply-To: <20180817145914.GA6885@sirena.org.uk>
References: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
 <b32c205955e0f42182b16e90f539a919@codeaurora.org>
 <20180814150340.GE5810@sirena.org.uk>
 <caea8294d20c515a33c090c4fddb15c3@codeaurora.org>
 <20180817145914.GA6885@sirena.org.uk>
Message-ID: <9d334f90694ce3940cf28fb0d64a303e@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-17 20:29, Mark Brown wrote:
> On Fri, Aug 17, 2018 at 04:06:06PM +0530, dkota@codeaurora.org wrote:
> 
>> Could you please clarify on below query.
> 
> I'm not seeing any further questions in your e-mail?
My bad; i mean, you to comment on below explanation on using 
cur_speed_hz instead of clk_get_rate().

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

I have uploaded the new patchset addressing all these review comments.
Please review it.

--Dilip


