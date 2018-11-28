Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82CD206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P/kA/6zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82CD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeK2FR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:17:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56486 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543428929; x=1574964929;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VbCtUK0B6nIp8n9Xq8wecIQp5tDLrwRfU98MVtEmGLc=;
  b=P/kA/6zrBhuw87gtYjSZS0pglvdxHXnpvFkVX57ODYAwgIebRoNhxe3E
   +wD13yhT+HfTKbz1A8c7NeUxoFTy0vTZEKuwBXkmn/Oo5djGMVIeZMnlf
   AtddFST3WLZCdlIYmPLDZPZFL/HNo3pLrrzLO8MXL+ZpoptmKR0jc5BeC
   UVON1zC+uSoCPOY/cXKblmxnyw4tHtxrBSUjeAm/01/wngOFtEpCZm56T
   tfRV7NcSjI0DWgybFZ7cnqg3icGkpAAiz2KvgKU4C8A3HGpb6/aNOKvxa
   RLxed5xjHEc1Kw6/BXohzm8BQdbzAyh1OwBenoR1ZCa17eQOaRxcTqeT7
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,291,1539619200"; 
   d="scan'208";a="97070176"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2018 02:15:29 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Nov 2018 09:58:27 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.72.98]) ([10.111.72.98])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Nov 2018 10:15:29 -0800
Subject: Re: macb: probe of 10090000.ethernet failed with error -110
To:     Andreas Schwab <schwab@suse.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <mvmefb5fr6d.fsf@suse.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f1e5d078-bc4d-910e-8717-f5870a0e994a@wdc.com>
Date:   Wed, 28 Nov 2018 10:15:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <mvmefb5fr6d.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 2:11 AM, Andreas Schwab wrote:
> The PHY probing of the macb driver appears to be rather unreliable.
> Most of the time it doesn't work the first time, I have to reload the
> module several times to let it succeed.
> 
> [   40.530000] macb: GEM doesn't support hardware ptp.
> [   40.530000] libphy: MACB_mii_bus: probed
> [   41.450000] macb 10090000.ethernet (unnamed net_device) (uninitialized): Could not attach to PHY
> [   41.510000] macb: probe of 10090000.ethernet failed with error -110
> [ 1354.400000] macb: GEM doesn't support hardware ptp.
> [ 1354.410000] libphy: MACB_mii_bus: probed
> [ 1355.260000] macb 10090000.ethernet (unnamed net_device) (uninitialized): Could not attach to PHY
> [ 1355.300000] macb: probe of 10090000.ethernet failed with error -110
> [ 1358.100000] macb: GEM doesn't support hardware ptp.
> [ 1358.110000] libphy: MACB_mii_bus: probed
> [ 1358.310000] Microsemi VSC8541 SyncE 10090000.ethernet-ffffffff:00: attached PHY driver [Microsemi VSC8541 SyncE] (mii_bus:phy_addr=10090000.ethernet-ffffffff:00, irq=POLL)
> [ 1358.320000] macb 10090000.ethernet eth0: Cadence GEM rev 0x10070109 at 0x10090000 irq 12 (70:b3:d5:92:f1:07)
> 
> This is 4.20-rc4 on a HiFive-U.
> 
> Andreas.
> 

Here is my previous analysis on the issue.
http://lists.infradead.org/pipermail/linux-riscv/2018-September/001503.html

Not sure if you have tried the hack already. But here it is anyways.
https://github.com/atishp04/riscv-linux/commit/aa230e7dc2ab01db5b630f427e57297ffc25c884


Regards,
Atish
