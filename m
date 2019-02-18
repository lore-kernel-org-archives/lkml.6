Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525BFC10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22412218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O+YorYW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfBRG0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:26:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:26:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1I6QXrR018406;
        Mon, 18 Feb 2019 00:26:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550471193;
        bh=M6kpEB2XPLYbFaY2QVO/H7oFKYVqahsWv30SJy/eY0s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O+YorYW/+C+NRuK53MvViY3Q11iyDl9WYmBE/8jF6QqsWmyuM3MBg5G+FXnfc0leJ
         VtJNCRSlr9UVjBqzGGiWHaKU3IEthUQWwzQq7h6uzm6ea3ya+jP/FpXMvJAmGlVea1
         lKTjpitSEzxHwFAvDRdijDn7FtGFzLeZdRMYzQVE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1I6QXew017837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 00:26:33 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 00:26:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 00:26:33 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1I6QU33017673;
        Mon, 18 Feb 2019 00:26:31 -0600
Subject: Re: [PATCH] cpufreq: davinci: move configuration to
 include/linux/platform_data
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190214170505.27251-1-brgl@bgdev.pl>
 <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <979dd2f6-17dd-9569-42fe-9490c09be1bf@ti.com>
Date:   Mon, 18 Feb 2019 11:56:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/19 11:46 AM, Viresh Kumar wrote:
> Applied. Thanks.

Here is a belated ack from my side.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
