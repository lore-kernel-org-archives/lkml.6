Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FFB21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545144835;
	bh=2dpshEut2yHTzIQ57or8Rxgx0kWdLvyD3iA0La9ewEs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hu5AAdOA6ow5QMna7ZdZfDzo/37MikQVx18eeoPghs10pRCk6gfYyJ0snyE85C9Nl
	 qHxTGoH6nO6sWpQnmI+B3+/rnZjuR65wzZC9KH1o0OjaBOQMAtT11z7WRVFhLbIlRe
	 VqnLMXqMxEaqOB+cT+6yHw9mR8kRGBoesZuZQzx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeLROxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLROxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:53:54 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935F521850;
        Tue, 18 Dec 2018 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545144833;
        bh=2dpshEut2yHTzIQ57or8Rxgx0kWdLvyD3iA0La9ewEs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R3CG8O/LI0KI9eYItvy+ZC4rKxegixVczykTeTgIgf3IkT77C58hN2I9nBYK+c76r
         aS+UjBDVCyTyazYXTFZjpwJa/zhADG5ePDqVZ4b/byROP1JuEjKghBywMXOCSTyVOo
         C70Wn6rrSfY3ORzRU9AaJk1W8tfw3VOPkbzvrZcM=
Subject: Re: selftests/net: udpgso: LTS kernels supportability ?
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        shuah <shuah@kernel.org>
References: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
 <1d2c9a10-6caf-49ff-b921-8b93dbe96f78@kernel.org>
 <1de7a003-0aac-1f4f-b836-267136e30a0a@linaro.org>
From:   shuah <shuah@kernel.org>
Message-ID: <fd4c527a-daeb-1c73-c423-95d02e1b8e86@kernel.org>
Date:   Tue, 18 Dec 2018 07:53:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1de7a003-0aac-1f4f-b836-267136e30a0a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 4:37 AM, Rafael David Tinoco wrote:
> On 12/17/18 4:42 PM, shuah wrote:
>> Hi Rafael,
>>
>> On 12/17/18 10:53 AM, Rafael David Tinoco wrote:
>>> Shuah,
>>>
>>> I was recently investigating some errors coming out of our functional
>>> tests and we, Dan and I, came up with a discussion that might not be new
>>> for you, but, interests us, in defining how to better use kselftests as
>>> a regression mechanism/tool in our LKFT (https://lkft.linaro.org).
>>>
>>> David / Willem,
>>>
>>> I'm only using udpgso as an example for what I'd like to ask Shuah. Feel
>>> free to jump in in the discussion if you think its worth.
>>>
>>> All,
>>>
>>> Regarding: udpgso AND https://bugs.linaro.org/show_bug.cgi?id=3980
>>>
>>> udpgso tests are failing in kernels bellow 4.18 because of 2 main
>>> reasons:
>>>
>>> 1) udp4_ufo_fragment does not seem to demand the GSO SKB to be > than
>>> the MTU for older kernels (4th test case in udpgso.c).
>>>
>>> 2) setsockopt(...UDP_SEGMENT) support is not present for older kernels.
>>> (commits "udp: generate gso with UDP_SEGMENT" and its fixes seem to be
>>> needed).
>>
>> This case is easy right? Based on the test output below , I can see that
>> the failure is due to
>>
>> ./udpgso: setsockopt udp segment: Protocol not available. setsockopt()
>> is returning an error to clearly indicate that this options isn't
>> supported. This will be a test change to say test is a skip as opposed
>> to fail.
> 
> You referred to (2). (1) isn't that straightforward.
> 
>> We have a solution for this - test should SKIP as opposed to FAIL.
>>
>>> With that explained, finally the question/discussion:
>>>
>>> Shouldn't we enforce a versioning mechanism for tests that are testing
>>> recently added features ? I mean, some of the tests inside udpgso
>>> selftest are good enough for older kernels...
>>
>> Right - we do have generic way to handle that by detecting if feature is
>> supported and skip instead of using Kernel version which is going to be
>> hard to maintain.
> 
> You can't distinguish case (1) failures between real failures OR older
> kernel behaving differently then testcase expects.
> 
>>>
>>> But, because we have no control over "kernel features" and "supported
>>> test cases", we, Linaro, have to end up blacklisting all selftests that
>>> have new feature oriented tests, because one or two test cases only.
>>>

Can you share the blacklisted tests?

thanks,
-- Shuah
