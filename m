Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BFAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE972083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="oXZZYr1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfBECQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:16:29 -0500
Received: from vern.gendns.com ([98.142.107.122]:50832 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfBECQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lLrqOBtSViQA2wCXVQlz2enVbxgYHmowKusSCboT5og=; b=oXZZYr1DQTIRRCyM3GzH3Ai2e9
        DLDRV+DwqnwFYfQ7wnl4CwLkeU0ccjp6ukU6wimYFWz3bvs54jjI1opT+h/FLrv/Y0Gt033BPxdaf
        VeHPaEiXz8/qs19PEDuv5R28iFY7bfI6dIH0mlGZVHd7h2Bh1SpwqbkASIWsijATdkYTOJ4nDvpfc
        gllS28oHCZQdBzU79bYjwyucbm6JPCvfqEiTubyHeWniXivHBT9xxXsgjObjhLbaypA6tZehBEphL
        fMU+iYuDKd2Bly0OnWZj1YYQOtFNr4Tx0EW92xGt7D5d22ykuOZWAqF0RVrQxHPdAmmSaGF0u9JE0
        PMMPrSgw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34204 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqqEF-0003tK-Cp; Mon, 04 Feb 2019 21:12:51 -0500
Subject: Re: [PATCH v2 03/12] ARM: davinci: enable the clocksource driver for
 DT mode
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <e2276265-7c20-81d3-6e55-ddff446c7e54@lechnology.com>
Date:   Mon, 4 Feb 2019 20:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch all davinci boards using device tree to using the new
> clocksource driver: remove the previous OF_TIMER_DECLARE() from
> mach-davinci and select davinci-timer to be built for
> davinci_all_defconfig.

I don't see how this patch is related to davinci_all_defconfig.
It looks like the new driver is just selected when ARCH_DAVINCI
is selected in Kconfig.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
