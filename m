Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101CE2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101CE2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbeISWpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:45:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57224 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbeISWpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:45:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5FD5A20798; Wed, 19 Sep 2018 19:06:31 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8AE0720719;
        Wed, 19 Sep 2018 19:06:20 +0200 (CEST)
Date:   Wed, 19 Sep 2018 19:06:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
Message-ID: <20180919170618.GC2479@piout.net>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
 <20180725172605.108040-4-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725172605.108040-4-giulio.benetti@micronovasrl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 19:26:05+0200, Giulio Benetti wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
> 
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> V10 => V11:
> * kstrtobool(): check error if (ret) avoiding checking specific error.
> 
>  drivers/rtc/rtc-ds1307.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
