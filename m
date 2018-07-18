Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="E01YqDxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAC82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeGRKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:14:02 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33616 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbeGRKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:14:01 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id D7D90B00779
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:36:58 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531906618; x=1532770619; bh=q9bff1CxvIjU/qnakhxvKHRuxlh4thoXbSA
        8370vLtA=; b=E01YqDxTa6Rdy7f1N9ylkWwHdF/F/+sctoZxU6aRElWRSXbfGzt
        xzPLaZbwuR+KT31yJ0p12eRonLxCypYhWrSe2KH3pNIYNsQhK7Cg8D0J4NijtnnC
        s069/r3B80TcGvWhBMpKAWucOA+61xAv+TgmHe2EKT2GZzrxUwJh8ip8=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4EQRP9D2fSk3 for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 11:36:58 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 09CC7B0018C;
        Wed, 18 Jul 2018 11:36:57 +0200 (CEST)
Subject: Re: [PATCH v8 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718092216.91053-1-giulio.benetti@micronovasrl.com>
 <20180718092216.91053-2-giulio.benetti@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <265d0f74-d1ca-11c3-4157-6c0405ecbcda@micronovasrl.com>
Date:   Wed, 18 Jul 2018 11:36:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718092216.91053-2-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/07/2018 11:22, Giulio Benetti ha scritto:
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		BIT(7)
> +#	define M41TXX_BIT_FT		BIT(6)
> +#	define M41TXX_BIT_CALIB_SIGN	BIT(5)
> +#	define M41TXX_M_CALIBRATION	GENMASK(5, 0)

This must be GENMASK(4, 0) to be 0x1f.
I'm going to send last patchset, sorry everyone for the mess.

Giulio
