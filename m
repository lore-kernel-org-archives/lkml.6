Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAACC46479
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C371C21502
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C371C21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeIYW2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:28:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:39455 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbeIYW2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:28:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 09:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="86445651"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2018 09:20:02 -0700
Subject: Re: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-aspeed@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
 <20180924215850.GD18592@kunai>
 <2c8563fd-0641-5237-0026-f559c480ad91@linux.intel.com>
 <20180925082717.GB2270@kunai>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <7b4e5715-3a87-8f77-8d0d-4647f02c87a8@linux.intel.com>
Date:   Tue, 25 Sep 2018 09:20:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925082717.GB2270@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2018 1:27 AM, Wolfram Sang wrote:
> On Mon, Sep 24, 2018 at 03:15:46PM -0700, Jae Hyun Yoo wrote:
>> Hi Wolfram,
>>
>> On 9/24/2018 2:58 PM, Wolfram Sang wrote:
>>> On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
>>>> On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
>>>>> +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
>>>>> +			  multi-master is set, defaults to 100 ms when not
>>>>> +			  specified.
>>>>
>>>> Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
>>>> property.
>>>
>>> No need. This binding is not a HW description, so not a DT property in
>>> my book. I still don't understand: Your IP core in master mode does not
>>> have a BUSY bit or similar which detects when a START was detected and
>>> clears after a STOP?
>>>
>>
>> Okay, I'll keep this property as it is then.
> 
> Sorry for the misunderstanding. I don't think this a property, at all.
> It doesn't describe the hardware, it is more of a configuration thing,
> or?
> 

You are right. It doesn't describe the hardware but it needs to be
configurable because it very depends on the peer master's behavior.
If peer master sends a long packet usually, it should have a long
timeout value since a slave receiving operation takes long time,
and it should be adjusted with an optimal value with taking some
experiments to make it not too long. Any suggestion?

Thanks,
Jae
