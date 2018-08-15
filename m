Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0A6214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0A6214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeHOU5D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:57:03 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7514 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeHOU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:57:03 -0400
X-IronPort-AV: E=Sophos;i="5.53,243,1531810800"; 
   d="scan'208";a="15961110"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Aug 2018 11:03:54 -0700
Received: from CHN-SV-EXMX02.mchp-main.com ([fe80::7dfe:3761:863e:3963]) by
 CHN-SV-EXCH06.mchp-main.com ([fe80::5404:4dc9:559:e436%16]) with mapi id
 14.03.0352.000; Wed, 15 Aug 2018 11:03:52 -0700
From:   <Bryan.Whitehead@microchip.com>
To:     <arnd@arndb.de>,
        <UNGLinuxDriver@MicrochipTechnology.Mail.Onmicrosoft.com>
CC:     <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Topic: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Thread-Index: AQHUNMCYlbXSpfUC+UKbWoa5lLa8NqTBGY5w
Date:   Wed, 15 Aug 2018 18:03:51 +0000
Message-ID: <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
References: <20180815175040.3736548-1-arnd@arndb.de>
In-Reply-To: <20180815175040.3736548-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Question: this is the only ptp driver that sets the hardware time to the
> current system time in TAI. Why does it do that?

This is done when the driver starts up after reset. Otherwise the clock is off by 48 years. 
It seemed to me that the system time was the most appropriate clock to sync to. 
If my reasoning is incorrect, please enlighten me.

Thanks,
Bryan
