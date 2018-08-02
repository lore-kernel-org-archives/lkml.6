Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BC8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEBB20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="bh1w2ezl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEBB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeHBCvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:51:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44587 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbeHBCvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533172583; x=1564708583;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=X0vn4b2wg+zQaykurDVD7zRJ/2R7dLDbwuKLGNA9Hmw=;
  b=bh1w2ezlyYHSP0WCYAuTc46ONDqAv4VRMj+JHVfaaSMA+SJyxKX8waEY
   hNBMotqvriqIXntlTmS6WiJ34otJksDiLlsGDPd42oJRB4Y/A6P3aR/cA
   hEHKu7MTnxFGC99eyZyFnYbW4l13sq2M9sQAhNzhMNVa/HtKxHAAku80h
   fkN4xLVIrKjoACypRyXEa7VmSyRdQXQM4GiQZkDMZEhNUE0K3GNnf8G4B
   nYAp2W0IDPEhAwAln46ICYMbLPGU7TKeT80Ag5eD62nW0EggNJuDtlxAa
   dPrrR/TYmgdFM9ZT0YUUPsMxfySntqMPLpXQM2rT08CtVlZ5ybB9AejQt
   A==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="183171385"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 09:16:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Aug 2018 17:51:17 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2018 18:02:53 -0700
Subject: Re: [PATCH 7/9] irqchip: add a RISC-V PLIC driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180726143723.16585-1-hch@lst.de>
 <20180726143723.16585-8-hch@lst.de>
 <1b3f6066-0c7c-a5f5-75ad-559fe81091ee@wdc.com>
 <dc69d688-f765-74cc-3234-563fecff6002@wdc.com> <20180731165712.GA2521@lst.de>
 <dcb17e67-9f83-0ff5-a2c6-a6dd1b4d9c0d@wdc.com>
 <20180801141858.GA28203@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <41a996bf-b591-db0c-718e-524743f348fd@wdc.com>
Date:   Wed, 1 Aug 2018 18:02:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801141858.GA28203@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 7:14 AM, Christoph Hellwig wrote:
> I've pushed out an update to the riscv-irq-simple.2 branch to better
> handle with sparse contexid maps, please retry with that.
> 

I see you have changed the driver file name from irq-riscv-plic to 
irq-riscv-sifive along with default Y for SIFIVE_PLIC. I guess it was 
done because PLIC register spec is SIFIVE specific rather than RISC-V.

But can we keep the new kconfig option "SIFIVE_PLIC" enabled in 
driver/irqchip/Kconfig or arch/riscv/Kconfig for now to avoid breakage 
without linux_defconfig update.

With the config enabled, Qemu virt machine booting has no issues with 
riscv-irq-simple.2 branch. I am still looking at the crash from the 
hardware.

Regards,
Atish
