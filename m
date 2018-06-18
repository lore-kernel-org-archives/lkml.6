Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978DAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FD6208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FD6208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935350AbeFRKFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:05:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:33469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934927AbeFRKFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:05:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 03:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="58164420"
Received: from zhuyixin-mobl1.gar.corp.intel.com (HELO [10.226.38.83]) ([10.226.38.83])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2018 03:05:16 -0700
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        chuanhua.lei@linux.intel.com,
        Linux-MIPS <linux-mips@linux-mips.org>, qi-ming.wu@intel.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com>
 <20180612223725.GC2197@rob-hp-laptop>
 <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
 <CAL_JsqJVcKPexrVrnGnr-zga1n6n00nYdUmKZWOz2VQJ7BV-oA@mail.gmail.com>
From:   yixin zhu <yixin.zhu@linux.intel.com>
Message-ID: <4bb8f16e-2663-3a62-3c09-dc58fcb11831@linux.intel.com>
Date:   Mon, 18 Jun 2018 18:05:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJVcKPexrVrnGnr-zga1n6n00nYdUmKZWOz2VQJ7BV-oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2018 10:09 PM, Rob Herring wrote:
> On Thu, Jun 14, 2018 at 2:40 AM, yixin zhu <yixin.zhu@linux.intel.com> wrote:
>>
>>
>> On 6/13/2018 6:37 AM, Rob Herring wrote:
>>>
>>> On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
>>>>
>>>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>>>
>>>> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below
> 
> [...]
> 
>>>> +Example:
>>>> +       clkgate0: clkgate0 {
>>>> +               #clock-cells = <1>;
>>>> +               compatible = "intel,grx500-gate0-clk";
>>>> +               reg = <0x114>;
>>>> +               clock-output-names = "gate_xbar0", "gate_xbar1",
>>>> "gate_xbar2",
>>>> +               "gate_xbar3", "gate_xbar6", "gate_xbar7";
>>>> +       };
>>>
>>>
>>> We generally don't do a clock node per clock or few clocks but rather 1
>>> clock node per clock controller block. See any recent clock bindings.
>>>
>>> Rob
>>
>> Do you mean only one example is needed per clock controller block?
>> cpuclk is not needed in the document?
> 
> No, I mean generally we have 1 DT node for the h/w block with all the
> clock control registers rather than nodes with a single register and 1
> or a couple of clocks. Sometimes the clock registers are mixed with
> other functions which complicates things a bit. But I can't tell that
> here because you haven't documented what's in the rest of the register
> space.
> 
> Rob
> 
Thanks
Will update to use one DT node for the whole clock controller.
