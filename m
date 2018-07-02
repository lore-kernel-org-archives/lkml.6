Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B96F25116
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ArmgLnC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B96F25116
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeGBM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:29:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49206 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeGBM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:29:37 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62CSRIZ112881;
        Mon, 2 Jul 2018 07:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530534507;
        bh=Qwq+/SQtHYYsI4UsPtINepBJtJ1+b2rB3uyWOtNb6Ys=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ArmgLnC7tI17ZKuYYq+EZF5gJ/Lrcioz8SYMySEQJtfvmvlWZqaOAFpFZ8ajKFJLz
         IuNaOAyOnAn6LqU7S0J+busy7byd/sf8xfWk4Yyjj+XULciqZq1M/onlp/96+qP5C4
         nWgFM3ziWun0YP+vPWcuXp9ZlXhIrUQGawxA7sME=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62CSROs020457;
        Mon, 2 Jul 2018 07:28:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 07:28:27 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 07:28:27 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62CSMpf007012;
        Mon, 2 Jul 2018 07:28:23 -0500
Subject: Re: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
Date:   Mon, 2 Jul 2018 17:58:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Stephen,

On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series moves all aemif/nand users to using the ti-aemif platform
> driver located in drivers/memory instead of the older API located in
> mach-davinci.
> 
> First five patches add necessary changes to the clock driver. Next
> seven convert the board files to using the ti-aemif driver. Last patch
> removes now dead code.

How do you want to handle this series? I can apply the series and
provide you an immutable branch on v4.18-rc1 with the clock patches
applied if that can work.

Thanks,
Sekhar
