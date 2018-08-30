Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E316FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FD420652
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D+kCUDTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FD420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeH3UGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:06:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34230 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3UGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535645059; x=1567181059;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aeitlVnUoOwVOV/d0KAgAhBtXLBHvpboRR3njhjdT7E=;
  b=D+kCUDTxZOa57J+Mq+dWSAeK0SBeneCAZ2lWZY1bBUDBQKBhSU/hPCp7
   urJYPKt8kyOkZZrovgBlA9phAbmncDDGgPCdzdRoWnM2Ij7BiNulXdWPm
   3TcJ5bOoSIWnLgalH2RwZdMTqOuKcf1xOPqHaRebgKfXRqP2un0UjTbE5
   QMkUdEEya8mxqsQ1Ul5ZnmeWFmd7KP4crb6Ob5Y6e6u98XdZhbBSdSSfO
   sTmN9ndEHHGIxlPNdN7L70i/WO3QFS2tcv06WI/vPrzGf/ZM3qZ1Z/OUS
   Wq9n+tdNg9RNxgwdeMO0xsvyN0c/EzPHA8lmODL5nO7vuIBfhe8aeu2cq
   g==;
X-IronPort-AV: E=Sophos;i="5.53,307,1531756800"; 
   d="scan'208";a="186212566"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2018 00:04:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 30 Aug 2018 08:51:06 -0700
Received: from lpt-kim-271.ad.shared (HELO [10.86.62.101]) ([10.86.62.101])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Aug 2018 09:04:04 -0700
Subject: Re: [PATCH v2 0/3] RISC-V: Add new smp features
To:     Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com>
 <20180830141120.GA1724@infradead.org>
 <CAAhSdy2Ma6DXfVTYWpByvmKKbrdaAsyr_-b947+oNSgGVk4E5g@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <1b9d1096-2d4d-4835-1a62-0ab47e24f81a@wdc.com>
Date:   Thu, 30 Aug 2018 09:04:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2Ma6DXfVTYWpByvmKKbrdaAsyr_-b947+oNSgGVk4E5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 7:18 AM, Anup Patel wrote:
> On Thu, Aug 30, 2018 at 10:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Aug 30, 2018 at 09:53:50AM -0400, Anup Patel wrote:
>>>> Atish Patra (3):
>>>>    RISC-V: Add logical CPU indexing for RISC-V
>>>>    RISC-V: Use Linux logical cpu number instead of hartid
>>>>    RISC-V: Support cpu hotplug.
>>>>
>>>
>>> This series looks good to me.
>>
>> Hmm, that series didn't make it to my inbox, neither directly, nor
>> through the linux-riscv list.  Where did you see it?
> 

Strange.

> Ahh, looks like some issue indeed. I am in TO list of patch series, thats why
> I got the patch series.
> 

So is Christoff & linux-riscv. I see it in lkml but not in linux-riscv.
Apologies for the issues. I will resend it again.

Regards,
Atish
> --
> Anup
> 

