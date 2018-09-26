Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA7C21546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="npULKWnz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5NIzhpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA7C21546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeI0AvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:51:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeI0AvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:51:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29C1960B13; Wed, 26 Sep 2018 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537987011;
        bh=cGn4ZC/eSXW140uepSZQpcTMVvrdBpnar+M3gVXlIWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=npULKWnzeJzsTYOlaHHqt7j67C+pS3X6hz4acrreSWS3VwHTkLtGOUZ5iclF/oXYb
         hzc42g0SuAnSlPZqb0/lIpZxFMnlHY8YXeELnler6oLvS4T/G/eYJqYdOHIGrkwL/B
         NHmct99Ua390SueauOVaW9Cya3mQLW79JMY1RJdI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9A4E5602BA;
        Wed, 26 Sep 2018 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537987010;
        bh=cGn4ZC/eSXW140uepSZQpcTMVvrdBpnar+M3gVXlIWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n5NIzhplM2RCy5/Hlh9YklYaukAMqTUBPtVymfoVwlxZfspuy2OCkXis2aVOqxv0t
         2Z8+ATOKBdI+KNdf4DsQzZbxAikgjnHxP1k0m/AY4ScLNRehMDZa2Mc7ruUq5GJBEr
         5A7JBJR5EEVDDlHE66bF6/pNtp3Lf5NuEMgFYECI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Sep 2018 00:06:50 +0530
From:   dkota@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>, dkota@codeaurora.org
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
In-Reply-To: <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
 <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
 <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
 <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
Message-ID: <12ec7543043b89eeb848a2cc87db5c47@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 01:24, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 25, 2018 at 12:36 PM <dkota@codeaurora.org> wrote:
>> >> +       unsigned int cur_speed_hz;
>> >
>> > unsigned long for Hz? The clk framework uses that type.
>> 
>> cur_speed_hz stores the speed value requested as part of transfer (not
>> the resultant or rounded off frequency got from clk framework. It is 
>> u32
>> type, i will change cur_speed_hz to u32 type instead of unsigned long.
>> Code snippet:
>>          mas->cur_speed_hz = xfer->speed_hz;
> 
> Change it to "unsigned long" anyway to match the clock framework.  In
> theory maybe the "xfer" structure will be updated eventually.
Ok. WIll update it
> 


>> Is it possible for all three conditions above to happen in one
>> interrupt? I ask because 'ret' is overwritten and so what may have 
>> been
>> IRQ_HANDLED may become IRQ_NONE which will lead to confusion in the 
>> irq
>> layer. Maybe the handle tx/rx functions can return a bool, that gets
>> orred together each time so that we know if something handled an
>> interrupt?
>> 
> Will check it again by running fullduplex transfer and update.
Added the changes in V5 to ensure return value doesn't get overwritten.

--Dilip
