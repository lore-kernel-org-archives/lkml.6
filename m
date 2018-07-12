Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E900C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C020842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357C020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeGLRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:21:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:58538 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbeGLRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:20:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 10:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,344,1526367600"; 
   d="scan'208";a="64234634"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2018 10:10:33 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
To:     Brendan Higgins <brendanhiggins@google.com>, joe@perches.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
 <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com>
 <c13fc12e859f7bdb300f08ad805cdf6d7ec09f52.camel@perches.com>
 <CAFd5g47-Bq_wUkL4vP93si+urDs-A0j26ukZ+Riy24HWi5AuuA@mail.gmail.com>
Message-ID: <41770e0f-c0ab-5fb7-6c8f-6cf4f80f01f0@linux.intel.com>
Date:   Thu, 12 Jul 2018 10:10:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47-Bq_wUkL4vP93si+urDs-A0j26ukZ+Riy24HWi5AuuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/2018 1:38 AM, Brendan Higgins wrote:
> On Wed, Jul 11, 2018 at 10:10 AM Joe Perches <joe@perches.com> wrote:
>>
>> On Wed, 2018-07-11 at 09:53 -0700, Jae Hyun Yoo wrote:
>>> On 7/10/2018 10:42 PM, Brendan Higgins wrote:
>>>> On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>>> There are some log printing without a newline character. This
>>>>> patch adds the missing newline characters.
>> []
>>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> []
>>>>> @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>>>>>            */
>>>>>           if (bus->master_state == ASPEED_I2C_MASTER_START) {
>>>>>                   if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
>>>>> -                       pr_devel("no slave present at %02x", msg->addr);
>>>>> +                       pr_devel("no slave present at %02x\n", msg->addr);
>>>>
>>>> Unless something changed in the last couple versions of the kernel, this is the
>>>> only line that actually changes anything. dev_* inserts a newline for every
>>>> call.
>>
>> Not true.
>>
>> Any printk without KERN_CONT inserts a newline
>> if the last character
>> emitted is not a newline.
>>
>> dev_<level> uses can also be followed by pr_cont.
>>
>> So this patch does reduce the possibility of
>> interleaved messages from multiple processes.
> 
> My mistake. Thanks for pointing that out.
> 
> Jae, forget what I said earlier. This looks good to me.
> 

Okay. I'll keep this patch as is.
Thanks Joe for your clarification!
Thanks Brendan for your 'Reviewed-by' tag!

Jae
