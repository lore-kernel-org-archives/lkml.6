Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF96ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957FE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957FE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeGQQvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:51:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:3412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeGQQvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:51:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 09:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="216739584"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.149]) ([10.7.153.149])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2018 09:18:17 -0700
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     Gary Hsu <gary_hsu@aspeedtech.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Benjamin Fair <benjaminfair@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Venture <venture@google.com>,
        "vernon.mauery@linux.intel.com" <vernon.mauery@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
 <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
 <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
 <921b1ab7-9c9f-0aeb-da89-5a1a27d009f0@linux.intel.com>
 <d3f10fc1-635b-3a5d-a967-2816eac005fc@linux.intel.com>
 <CAFd5g47zdPdqqjVJtNHtFk+jKgciKbMcEH9M-W9rL4DgLM5hkg@mail.gmail.com>
 <b8232faa-58f5-f3a5-d12a-3f326cf1d03d@linux.intel.com>
 <a84da5d076924f40b1c836fe8b9d0844@TWMBX01.aspeed.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <26400cb7-972e-7be9-81ba-8e08d42abd4e@linux.intel.com>
Date:   Tue, 17 Jul 2018 09:18:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a84da5d076924f40b1c836fe8b9d0844@TWMBX01.aspeed.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/2018 8:05 PM, Gary Hsu wrote:
> Hi Jae,
> 
> In originally, we reserved these register bits for debug purpose. But for some error handling case, we found it is also useful to help to clarify some error conditions. So driver also can use these fields information to check something.
> As for how driver use these information in their code, I have no comment. I don’t understand the driver. But these information is the real controller state, it had no problem to use information.
> 

Thanks Gary!

Hi Brendan,
Is it acceptable now if I add this as a comment like below?

Thanks,
Jae

> Best Regards,
> 
> 許馥疇 Gary Hsu
> 
> 信驊科技股份有限公司
> ASPEED Technology Inc.
> 
> 2F,No.15,Industry East Road 4.,Hsinchu Science Park, Hsinchu City 30077, Taiwan
> 新竹科學園區工業東四路 15 號 2F
> 
> Tel : 886-3-5789568 ext:807
> Fax : 886-3-5789586
> Web : http://www.aspeedtech.com
> 
> ************* Email Confidentiality Notice ********************
> 免責聲明:
> 因應個人資料保護法施行,本信件(或其附件)可能包含機密資訊，並受法律保護。如 台端非指定之收件者，請以電子郵件通知本電子郵件之發送者, 並請立即刪除本電子郵件及其附件和銷毀所有複印件。謝謝您的合作!
> 
> DISCLAIMER:
> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
> 
> -----Original Message-----
> From: Jae Hyun Yoo [mailto:jae.hyun.yoo@linux.intel.com]
> Sent: Saturday, July 14, 2018 2:54 AM
> To: Brendan Higgins <brendanhiggins@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; linux-i2c@vger.kernel.org; OpenBMC Maillist <openbmc@lists.ozlabs.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; linux-aspeed@lists.ozlabs.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; james.feist@linux.intel.com; vernon.mauery@linux.intel.com; Benjamin Fair <benjaminfair@google.com>; Patrick Venture <venture@google.com>; Gary Hsu <gary_hsu@aspeedtech.com>; Ryan Chen <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use cases stably
> 
> On 7/13/2018 11:12 AM, Brendan Higgins wrote:
>> On Fri, Jul 13, 2018 at 10:22 AM Jae Hyun Yoo
>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> On 7/12/2018 11:21 AM, Jae Hyun Yoo wrote:
>>>> On 7/12/2018 2:33 AM, Brendan Higgins wrote:
>>>>> On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
>>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>> <snip>
>>>>> <snip>
>>>>>>>> +       for (;;) {
>>>>>>>> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>>>>>>>> +                     (ASPEED_I2CD_BUS_BUSY_STS |
>>>>>>>> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
>>>>>>>
>>>>>>> Is using the Transfer Mode State Machine bits necessary? The
>>>>>>> documentation marks it as "for debugging purpose only," so
>>>>>>> relying on it makes me nervous.
>>>>>>>
>>>>>>
>>>>>> As you said, the documentation marks it as "for debugging purpose only."
>>>>>> but ASPEED also uses this way in their SDK code because it's the
>>>>>> best way for checking bus busy status which can cover both single
>>>>>> and multi-master use cases.
>>>>>>
>>>>>
>>>>> Well, it would also be really nice to have access to this bit if
>>>>> someone wants to implement MCTP. Could we maybe check with Aspeed
>>>>> what them meant by "for debugging purposes only" and document it
>>>>> here? It makes me nervous to rely on debugging functionality for
>>>>> normal usage.
>>>>>
>>>>
>>>> Okay, I'll check it with Aspeed. Will let you know their response.
>>>>
>>>
>>> I've checked it with Gary Hsu <gary_hsu@aspeedtech.com> and he
>>> confirmed that the bits reflect real information and good to be used
>>> in practical code.
>>
>> Huh. For my own edification, could you ask them why they said "for
>> debugging purpose only" in the documentation? I am just really curious
>> what they meant by that. I would be satisfied if you just CC'ed me on
>> your email thread with Gary, and I can ask him myself.
>>
> 
> I've already CC'ed Gary and Ryan in this thread.
> 
> Hi Gary,
> 
> Can you explain why the documentation says that the bit field is 'for debugging purpose only'? Any plan to change the description?
> 
> Thanks,
> 
> Jae
> 
>>>
>>> I'll add a comment like below:
>>>
>>> /*
>>>     * This is marked as 'for debugging purpose only' in datasheet but
>>>     * ASPEED confirmed that this reflects real information and good
>>>     * to be used in practical code.
>>>     */
>>>
>>> Is it acceptable then?
>>
>> Yeah, that's fine.
>>
>> <snip>
>>
>> Cheers
>>
