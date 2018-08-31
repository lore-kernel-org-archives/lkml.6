Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C43C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EDD2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hth26sQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EDD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIAB1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:27:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10073 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIAB1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535750283; x=1567286283;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AzBH+Tvtlqkm0ten07yP+A1EZFsALSV7gstfTEMQnEo=;
  b=hth26sQT9G/xYxXlYSo0snX8Od8987RGcFL/9X7OxJyG9vP0O/cW2a9N
   mbzS613mpeiePMnCaT4ZXhpJamvOooDKc+jRgGElh8KrhT1Wq4uTE+y4c
   swDW7obJfQXHmpqkVnUVNDxLk4IP6tAGo07prOG5Mh97hcYgAqFn1xS4h
   ySSiNAO2Mqfb64y/IlR6PC+s6UF9lNEOI8oWTQmY/7h08iel1O0rmxwxh
   9dVvAkepuaZlj5FlJGapPFLha2qMlrCk2haqiMJJPP0fBKnCQDW6YdhAj
   NMd1BjzF6LTlYnc130/w5eg2O4QW7wOQLQQXRzApqQqmWIa2114jDCRgg
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,313,1531756800"; 
   d="scan'208";a="192946877"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2018 05:18:03 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 31 Aug 2018 14:04:58 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.64.114]) ([10.111.64.114])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Aug 2018 14:18:03 -0700
Subject: Re: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to
 found_boot_cpu
To:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-6-palmer@sifive.com>
 <20180830144118.GA27233@infradead.org>
 <30229ef5-ce4e-e78b-32f9-7c563f63827b@wdc.com>
 <20180831055447.GA18478@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f62e9466-bd77-096d-fcc7-f5750d0257bb@wdc.com>
Date:   Fri, 31 Aug 2018 14:18:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831055447.GA18478@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 10:54 PM, Christoph Hellwig wrote:
> On Thu, Aug 30, 2018 at 09:11:11AM -0700, Atish Patra wrote:
>> On 8/30/18 7:41 AM, Christoph Hellwig wrote:
>>>>    	struct device_node *dn = NULL;
>>>> -	int hart, im_okay_therefore_i_am = 0;
>>>> +	int hart, found_boot_cpu = 0;
>>>
>>> If you rename this anyway please switch to use a bool.
>>>
>>
>> I can address the comment on this patch and fold it in my series to avoid
>> unnecessary conflict.
>>
>> @Palmer: You can drop this patch.
> 
> If Palmer is ok with it how about you include a respin of his whole
> series?  There are some overlaps I think and having a single person
> in charge might be helpful.
> 

Sure. I am fine with it. Palmer ?

> Btw, I've found your series in my linux-kernel folder, but it did
> not make it to linux-riscv or my personal inbox despite the CC.
> 

Thanks for the review.
I checked my scripts. I couldn't figure out what went wrong.
Not sure if there was some issue with infradead.org at that time.

Anyways, sorry again for the mess. I will keep a watch on this next time.

Regards,
Atish
