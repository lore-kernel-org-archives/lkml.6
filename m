Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeD0J7X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:59:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:48816 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeD0J7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:59:18 -0400
Subject: Re: [PATCH bpf-next] bpf, doc: Update bpf_jit_enable limitation for
 CONFIG_BPF_JIT_ALWAYS_ON
To: Leo Yan <leo.yan@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1524709611-29437-1-git-send-email-leo.yan@linaro.org>
 <275e03a2-b74e-8f60-4ffe-26c9a79fae9d@iogearbox.net>
 <20180427094910.GA31015@leoy-ThinkPad-X240s>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cf3700a3-3d92-ee43-62f3-481d00baf330@iogearbox.net>
Date: Fri, 27 Apr 2018 11:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180427094910.GA31015@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 11:49 AM, Leo Yan wrote:
> On Fri, Apr 27, 2018 at 11:44:44AM +0200, Daniel Borkmann wrote:
>> On 04/26/2018 04:26 AM, Leo Yan wrote:
>>> When CONFIG_BPF_JIT_ALWAYS_ON is enabled, kernel has limitation for
>>> bpf_jit_enable, so it has fixed value 1 and we cannot set it to 2
>>> for JIT opcode dumping; this patch is to update the doc for it.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>  Documentation/networking/filter.txt | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
>>> index fd55c7d..feddab9 100644
>>> --- a/Documentation/networking/filter.txt
>>> +++ b/Documentation/networking/filter.txt
>>> @@ -483,6 +483,12 @@ Example output from dmesg:
>>>  [ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
>>>  [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
>>>  
>>> +When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is set to 1 by default
>>> +and it returns failure if change to any other value from proc node; this is
>>> +for security consideration to avoid leaking info to unprivileged users. In this
>>> +case, we can't directly dump JIT opcode image from kernel log, alternatively we
>>> +need to use bpf tool for the dumping.
>>> +
>>
>> Could you change this doc text a bit, I think it's slightly misleading. From the first
>> sentence one could also interpret that value 0 would leaking info to unprivileged users
>> whereas here we're only talking about the case of value 2. Maybe something roughly like
>> this to make it more clear:
>>
>>   When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set to 1 and
>>   setting any other value than that will return in failure. This is even the case for
>>   setting bpf_jit_enable to 2, since dumping the final JIT image into the kernel log
>>   is discouraged and introspection through bpftool (under tools/bpf/bpftool/) is the
>>   generally recommended approach instead.
> 
> Yeah, your rephrasing is more clear and better.  Will do this and send
> new patch soon.  Thanks for your helping.

Awesome, thank you!
