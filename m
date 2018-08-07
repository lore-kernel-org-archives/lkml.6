Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADCC219A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADCC219A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbeHGJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:31:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:50697 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388760AbeHGJbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:31:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 00:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="81295776"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by orsmga002.jf.intel.com with ESMTP; 07 Aug 2018 00:18:46 -0700
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com>
 <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com>
 <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de>
 <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
 <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com>
 <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
 <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com>
 <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
Date:   Tue, 7 Aug 2018 15:18:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2018 5:29 PM, Geert Uytterhoeven wrote:
> Hi Songjun,
>
> On Mon, Aug 6, 2018 at 10:58 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
>> On 8/6/2018 3:20 PM, Geert Uytterhoeven wrote:
>>> On Mon, Aug 6, 2018 at 9:15 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
>>>> On 8/5/2018 5:03 AM, Arnd Bergmann wrote:
>>>>> On Sat, Aug 4, 2018 at 2:43 PM, Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>> On Sat, Aug 04, 2018 at 12:54:22PM +0200, Hauke Mehrtens wrote:
>>>>>>> On 08/03/2018 12:30 PM, Greg Kroah-Hartman wrote:
>>>>>>>> On Fri, Aug 03, 2018 at 03:33:38PM +0800, Wu, Songjun wrote:
>>>>>>> This patch makes it possible to use it with the legacy lantiq code and
>>>>>>> also with the common clock framework. I see multiple options to fix this
>>>>>>> problem.
>>>>>>>
>>>>>>> 1. The current approach to have it as a compile variant for a) legacy
>>>>>>> lantiq arch code without common clock framework and b) support for SoCs
>>>>>>> using the common clock framework.
>>>>>>> 2. Convert the lantiq arch code to the common clock framework. This
>>>>>>> would be a good approach, but it need some efforts.
>>>>>>> 3. Remove the arch/mips/lantiq code. There are still users of this code.
>>>>>>> 4. Use the old APIs also for the new xRX500 SoC, I do not like this
>>>>>>> approach.
>>>>>>> 5. Move lantiq_soc.h to somewhere in include/linux/ so it is globally
>>>>>>> available and provide some better wrapper code.
>>>>>> I don't really care what you do at this point in time, but you all
>>>>>> should know better than the crazy #ifdef is not allowed to try to
>>>>>> prevent/allow the inclusion of a .h file.  Checkpatch might have even
>>>>>> warned you about it, right?
>>>>>>
>>>>>> So do it correctly, odds are #5 is correct, as that makes it work like
>>>>>> any other device in the kernel.  You are not unique here.
>>>>> The best approach here would clearly be 2. We don't want platform
>>>>> specific header files for doing things that should be completely generic.
>>>>>
>>>>> Converting lantiq to the common-clk framework obviously requires
>>>>> some work, but then again the whole arch/mips/lantiq/clk.c file
>>>>> is fairly short and maybe not that hard to convert.
>>>>>
>>>>> >From looking at arch/mips/lantiq/xway/sysctrl.c, it appears that you
>>>>> already use the clkdev lookup mechanism for some devices without
>>>>> using COMMON_CLK, so I would assume that you can also use those
>>>>> for the remaining clks, which would be much simpler. It registers
>>>>> one anonymous clk there as
>>>>>
>>>>>            clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
>>>>>
>>>>> so why not add replace that with two named clocks and just use
>>>>> the same names in the DT for the newer chip?
>>>>>
>>>>>          Arnd
>>>> We discussed internally and have another solution for this issue.
>>>> Add one lantiq.h in the serial folder, and use "#ifdef preprocessor" in
>>>> lantiq.h,
>>>> also providing no-op stub functions in the #else case, then call those
>>>> functions
>>>> unconditionally from lantiq.c to avoid #ifdef in C file.
>>>>
>>>> To support CCF in legacy product is another topic, is not included in
>>>> this patch.
>>>>
>>>> The implementation is as following：
>>>> #ifdef CONFIG_LANTIQ
>>>> #include <lantiq_soc.h>
>>>> #else
>>>> #define LTQ_EARLY_ASC 0
>>>> #define CPHYSADDR(_val) 0
>>>>
>>>> static inline struct clk *clk_get_fpi(void)
>>>> {
>>>>        return NULL;
>>>> }
>>>> #endif
>>> Why not use clkdev_add(), as Arnd suggested?
>>> That would be a 3-line patch without introducing a new header file and an ugly
>>> #ifdef, which complicates compile coverage testing?
>>>
>> The reason we add a new head file is also for two macros(LTQ_EARLY_ASC
>> and CPHYSADDR)
>> used by legacy product. We need to provide the no-op stub for these two
>> macro for new product.
> No you don't. The line number should not be obtained by comparing the
> resource address with a hardcoded base address.
This is the previous code. Now the line number is obtained from dts.
We keep this code for the compatibility.

Referring to the conditional-compilation part in coding-style,
We add a header file to avoid using “#ifdef” in C file.
> Perhaps the override of port->line should just be removed, as IIRC, the serial
> core has already filled in that field with the (next available) line number?
>
> Gr{oetje,eeting}s,
>
>                          Geert
