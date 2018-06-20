Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76533C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fk3NC3sl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MQ91TebH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeFTJJE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:09:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbeFTJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:09:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79EED60376; Wed, 20 Jun 2018 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529485739;
        bh=vrbVqj9+/OR0HL6XOwh5vs8QDgiTIrwdcw1ZQaMTEag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fk3NC3sl3CcWouNzXuQb3nhZg88bICXlSTvM3cl46WM86PHOqLsfxr6Y5FUsyGR6w
         iIqv83RCYM5h5NrnNdF/uPFeMt1EsGYVOG/CwYO1vagfsXzU5+F9T7Tn9Sxavpat3l
         tug1m++gR5/qNuw7MuSfvbDASgwVsw+NAVZXCdBM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B1A9260376;
        Wed, 20 Jun 2018 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529485738;
        bh=vrbVqj9+/OR0HL6XOwh5vs8QDgiTIrwdcw1ZQaMTEag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MQ91TebHDDj/fIXETx6V101pkZN4MkgitrhD07rhavTJHi1nPbJa8ZEx2kzqR+m/d
         brZPbv//mA+2oFjafFk+tjwBW7I/936XHiaTILhkh9QT6YsqmU9gTmIcKH3h1WPYJg
         VH0V20F/DYlA0MQwCwJM5Umsr9aDElXWZ+OZ6awI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 14:38:58 +0530
From:   sricharan@codeaurora.org
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     mark.rutland@arm.com, robh@kernel.org, linux@arm.linux.org.uk,
        ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        sboyd@codeaurora.org, linux@armlinux.org.uk,
        thierry.escande@linaro.org, linux-kernel@vger.kernel.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 13/14] cpufreq: Add module to register cpufreq on
 Krait CPUs
In-Reply-To: <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
 <f195e30e-bef3-9352-9584-fec35631ec5e@arm.com>
Message-ID: <4a15ab80f732ae22f12a1351550be6dc@codeaurora.org>
X-Sender: sricharan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

>> 
>> Register a cpufreq-generic device whenever we detect that a
>> "qcom,krait" compatible CPU is present in DT.
>> 
> 
> Just curious to know how different is this from qcom kryo driver
> that was added recently. IIRC even that gets the speedbin from nvmem.
> Can they be merged ? I don't see need to have different driver for 
> Krait
> and Kryo CPUs when the code is not even remotely related to CPU type.
> 
> Sorry if I have missed anything from previous versions, I just happen
> to open and looked at this series first time today.

  Correct, having these two merged was pointed out earlier as well by 
Viresh.
  Now that kryo is merged, i will check once and see if they can be 
nicely
  merged.

Regards,
  Sricharan
