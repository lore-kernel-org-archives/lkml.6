Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B68C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B1420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vWToak2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfANMWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:22:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58026 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:22:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ECM5hu022736;
        Mon, 14 Jan 2019 06:22:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547468525;
        bh=pomoWjXu4RCf3I1O8QUVAUkXL2nJYqEeNElihQ5YGko=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vWToak2UyxfbpQ0zZ3dgwsL5ey5gy9OiN0eko5gxKjfdfiHSAd9N0jp9EcYvXY4ol
         AJg6MF/7n7tw0XT04sawyiTbAwohMR7inNzkVf9+xoG9pUIkLsQRdbZ1ZdvoJg4cSE
         DfUW+buB/uaWRkkFumYydUZBKn7IFFINLrS2BQ6w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ECM5So030284
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 06:22:05 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 06:22:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 06:22:04 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ECM1kO010732;
        Mon, 14 Jan 2019 06:22:02 -0600
Subject: Re: [PATCH 04/17] ARM: davinci: da850: WARN() if clk_get() fails
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-5-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <fcee383c-f2cb-1faf-d2a3-a35a17d57b8b@ti.com>
Date:   Mon, 14 Jan 2019 17:52:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111172134.30147-5-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the timer code checks if the clock pointer passed to it is
> good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> be functional and doesn't perform any checks so emit a warning if
> clk_get() fails.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I think 4-9 can be a single patch. They are doing something very similar
and its unlikely we will have to patch/revert just one of them.

Thanks,
Sekhar
