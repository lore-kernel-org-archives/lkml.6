Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFD2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2889D20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JJim01Ru";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JJim01Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2889D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIJItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:49:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIJItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:49:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D017760452; Mon, 10 Sep 2018 03:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536551829;
        bh=lVYS+vRittL9Pv4kik2VBIPnxBHKymcQRrqlSxMyXrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJim01RucqQyaaUuEOQm+Om84larmnrTzcuwAfwJDeY1u28DUICqDV3Qq9+Hh6Ne8
         vRw/kUP5BaOhbrgml3FjHiWAZX7pVEeCdwBngvw/4MW05ZZlhOBxhoJR/qnhIotnWz
         uEIUK7scQRWWXaGjxSWpnNkoII6SavbW8x/mJFk4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1E5CC60452;
        Mon, 10 Sep 2018 03:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536551829;
        bh=lVYS+vRittL9Pv4kik2VBIPnxBHKymcQRrqlSxMyXrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJim01RucqQyaaUuEOQm+Om84larmnrTzcuwAfwJDeY1u28DUICqDV3Qq9+Hh6Ne8
         vRw/kUP5BaOhbrgml3FjHiWAZX7pVEeCdwBngvw/4MW05ZZlhOBxhoJR/qnhIotnWz
         uEIUK7scQRWWXaGjxSWpnNkoII6SavbW8x/mJFk4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Sep 2018 09:27:09 +0530
From:   dkota@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
In-Reply-To: <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
 <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
 <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
Message-ID: <c4982ce3fde57c86387cc906332f6d48@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I see there is no need of taking the spinlock as timeout will be 
>> handled
>> after the calculated time as per data size and speed.
>> There is 99.9% less chances of interrupt during the timeout handler.
>>> 
>>> 
>>> 
>>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201081
> 
> The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
> it somehow wrong to add the spinlock?  ...or are you noticing
> performance problems with the spinlock there?  It's just nice not to
> have to think about it.

As I said, timeout will be handled after the calculated time as per data 
size and speed. Enough time is given for interrupt, there is no chance 
of interrupt occurrence during the handle_fifo_timeout(). So there is no 
need of spinlock.
