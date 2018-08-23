Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4777C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCD8208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PPGCWpG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCD8208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeHWHx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:53:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeHWHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534998346; x=1566534346;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KF7QyF6hqWf5lZJXqD5PIKFJaq5UV+tubKsVcz9gZWA=;
  b=PPGCWpG/JExqmf2mybp7N/jqcfIIcGNZQdgj/rxDHVvGEDpCMz9/7WhR
   bDTVCk5eHtnYkkTL2E71WQDRxegRWf4andqGOWt+FR1lEMvt3VwcCHTqG
   wkFawvGtdcM2uI5c4yQBT42xMuFQ6Dvgcs1j1XA3XhZW/rsM2+u/G7tVM
   f7UAYGQss/9QwBTFWKYuTRhPMGq8D9W+mkQ6NnzUcU/nQfZ7ysMb92S3V
   xcEQO47ddBqSU1FAAutKvSw6zZGW8wnbFQsol7WmQBTECIeWT8iWW2HRR
   RIWLwvcBVEu0uUmf6Dru61yhburrur3YlLVufMpXkYyDaxbSNV64pJirB
   A==;
X-IronPort-AV: E=Sophos;i="5.53,276,1531756800"; 
   d="scan'208";a="89121464"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2018 12:25:46 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 22 Aug 2018 21:12:57 -0700
Received: from usa003209.ad.shared (HELO [10.86.60.90]) ([10.86.60.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2018 21:25:46 -0700
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
 <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org>
 <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
 <20180822060353.GA27106@infradead.org>
 <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <2b317c0a-aa06-002a-a3f3-148a25e897ae@wdc.com>
Date:   Thu, 23 Aug 2018 09:55:45 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 8:54 PM, Anup Patel wrote:
> On Wed, Aug 22, 2018 at 11:33 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Tue, Aug 21, 2018 at 10:34:38PM +0530, Anup Patel wrote:
>>> The cpu_operations is certainly required because SOC vendors will add
>>> vendor-specific mechanism to selectively bringing-up CPUs/HARTs instead
>>> of all CPUs entering Linux kernel simultaneously. In fact, we might also end-up
>>> having CPU ON/OFF operations in SBI.
>>
>> Your forgot an essential part in your analysis:  Right now we only have
>> one single way to deal with cpu on/offlining, and that is the dummy WFI
>> kind.  Once other ways show up we can build proper infrastructure, but
>> until then this is just a white elephant as we have no idea how these
>> abstractions will look like.
>>
>> And my hope is that we'll just see new SBI calls, in which case we'll
>> just need SBI and dummy version and can avoid all the indirect calls.
> 
> IMHO, rather than waiting for new CPU ON/OFF methods to come-up we
> can keep the cpu_operations ready. Also, we are not re-inventing anything
> here which we might have to discard later because cpu_operations are
> already tried and hardened for Linux ARM64.
> 
> I agree with you that in long-term SBI-based CPU ON/OFF will be widely
> used. Most likely we will have at-least two CPU ON/OFF methods:
> 1. Existing lottery based spinning
> 2. New SBI calls
> 
> Regards,
> Anup
> 

I am fine with either keeping the cpu_ops infrastructure for now or 
reintroducing again along with better smp enablement methods.

Anyways, there were concerns about all existing booting method (all cpu 
thrown to Linux at the same time). I was thinking to adopt spin table 
boot method for RISC-V as well. I can drop this patch now and 
reintroduce with spin table boot method.

Any thoughts ?

Regards,
Atish
