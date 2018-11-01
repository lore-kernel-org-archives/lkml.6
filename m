Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59EFC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9212081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9212081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeKAXB0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:01:26 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:14733 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeKAXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:01:25 -0400
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="scan'208";a="22660334"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 06:58:20 -0700
Received: from CHN-SV-EXMX06.mchp-main.com ([fe80::c5f4:117d:550d:f375]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%13]) with mapi id
 14.03.0352.000; Thu, 1 Nov 2018 06:58:19 -0700
From:   <RaghuramChary.Jallipalli@microchip.com>
To:     <frieder.schrempf@kontron.de>, <steve.glendinning@shawell.net>,
        <UNGLinuxDriver@microchip.com>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: RE: [PATCH v2] usbnet: smsc95xx: disable carrier check while
 suspending
Thread-Topic: [PATCH v2] usbnet: smsc95xx: disable carrier check while
 suspending
Thread-Index: AQHUcWd9aklJyp5mQ0edcpRJO/GcyKU68cuw
Date:   Thu, 1 Nov 2018 13:58:19 +0000
Message-ID: <0573C9D4B793EF43BF95221F2F4CC8515B56CB@CHN-SV-EXMX06.mchp-main.com>
References: <1541022739-24678-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1541022739-24678-1-git-send-email-frieder.schrempf@kontron.de>
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

> We need to make sure, that the carrier check polling is disabled while
> suspending. Otherwise we can end up with usbnet_read_cmd() being issued
> when only usbnet_read_cmd_nopm() is allowed. If this happens, read
> operations lock up.
> 
> Fixes: d69d169493 ("usbnet: smsc95xx: fix link detection for disabled
> autonegotiation")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Raghuram Chary J <RaghuramChary.Jallipalli@microchip.com>

-Raghu


