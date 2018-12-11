Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29219C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z1gjnjbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81F82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeLKALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:11:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18111 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLKALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544487083; x=1576023083;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yOAXje27PgeYE34HSOVYaOHf47IeAXxcPCAr+k9KhTU=;
  b=Z1gjnjbnwz9rq9JqAHiz1qNWFTG4cjHelkLqI48WTocanaytVm3pXhRx
   dxuDQSdXlY+DtsGXKaTBw6LriwnsCeL0TlMrHMIAp6R8TC0ojfLclOph4
   LRrpX5Yf0AtAp/8AV3sZ69It6ojEOy//k0drZNSbZF8CimudHM96CHVLI
   oWi1v13EpHkiwZ9UaLmgnS1JyTBtG6PEruViLBmm6Yk//yQdTUbyuBFp1
   Vz4QyGSAbUOk9xFxx/JzjhkCOCnhO+TWIKQicvpzkuJ/eIfVrg+yHowwW
   J84IEEkGGtxMSu5vLOaRaIp6erNgyLM4dXDiSNHOUwliDFGXSZoU/qxSU
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,340,1539619200"; 
   d="scan'208";a="98025677"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2018 08:11:23 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Dec 2018 15:53:08 -0800
Received: from colley-l-lt.ad.shared (HELO [10.86.57.118]) ([10.86.57.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Dec 2018 16:11:21 -0800
Subject: Re: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <20181207134509.GA5913@e105550-lin.cambridge.arm.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <dffd0d6e-bebe-ae31-548b-1778d08a3285@wdc.com>
Date:   Mon, 10 Dec 2018 16:11:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181207134509.GA5913@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 5:45 AM, Morten Rasmussen wrote:
> Hi,
> 
> On Thu, Nov 29, 2018 at 03:28:16PM -0800, Atish Patra wrote:
>> The cpu-map DT entry in ARM64 can describe the CPU topology in
>> much better way compared to other existing approaches. RISC-V can
>> easily adopt this binding to represent it's own CPU topology.
>> Thus, both cpu-map DT binding and topology parsing code can be
>> moved to a common location so that RISC-V or any other
>> architecture can leverage that.
>>
>> The relevant discussion regarding unifying cpu topology can be
>> found in [1].
>>
>> arch_topology seems to be a perfect place to move the common
>> code. I have not introduced any functional changes in the moved
>> code. The only downside in this approach is that the capacity
>> code will be executed for RISC-V as well. But, it will exit
>> immediately after not able to find the appropriate DT node. If
>> the overhead is considered too much, we can always compile out
>> capacity related functions under a different config for the
>> architectures that do not support them.
>>
>> The patches have been tested for RISC-V and compile tested for
>> ARM64 & x86.
> 
> The cpu-map bindings are used for arch/arm too, and so is
> arch_topology.c. In fact, it was introduced to allow code-sharing
> between arm and arm64. Applying patch three breaks arm.
> 
> Moving the DT parsing to arch_topology.c we have to unify all three
> architectures. Be aware that arm and arm64 have some differences in how
> they detect cpu capacities. I think we might have to look at the split
> of code between arch/* and arch_topology.c again :-/
> 
> Morten
> 
Thank you for bringing this up. I will send a new version and make sure 
that it works on arm32 as well.


Regards,
Atish
