Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuuzTjgW9JkXP7dROqGz6jl4gK7+VXnIKUZ0bdfmA2A1EJZuBQAq9Tsm/jZi39dLKHKgCLP
ARC-Seal: i=1; a=rsa-sha256; t=1522140797; cv=none;
        d=google.com; s=arc-20160816;
        b=ARbvLkziEUW/aYE9C2IithJfFHodTmsw6jLQe/FL9pTceGznXJoZ/RDEZ4zpLcmdiR
         HOWPBrCqwVjDEefb/naJZSYu6+Y4y4w53EZtGxbmKw8byeRQBz5+Pt47WhlSG/D9Cffb
         jz564/lmiSGbMFueiPBgl5VFKnDwEy3GIQ4gJjKhsYc0xnctzFzChUWabvzFsvC3EvEJ
         1M0hFsM+293mfaqL0Igg9Xa6e5ly3N85qMy0SiYnUk4JO6f0P/SICKe8U1ciWQLbv6sy
         7CvgGxgIz326C3nZ5hlzW9fzZNGePll/ayGK66RF+WwbmzrO0mGvBzoljET4CxXFDkYr
         /EYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=21znroIlc9RcqEH2srv/XK5uPEkMoA19Ikz3wLj5Spg=;
        b=Xc9loNarjppbYzcCPxg/FLoRWziLEfRhauHEFg7U9/JPScXr3Hi5iJzOZ5lJ4/qQ9b
         MqzXPmKKhHfhmkkITdHaxWSa37Po+hMZ2xOIiJnf8yHipNalJ8y4BBrUFqUno+YrGYzy
         d2hEYVImbeovbs8A6w/GcEk1XlHV+1k/ryWA/OzDR67euyuciL/BAKDCG8NbVbnEzARE
         Em6zbnr7hlIloXJGQG+O6pW0yEwOEI05l8MI4jszdCbBfrOuvzMV7UIbwskLF/4002o1
         GiRymrNxAp6vln7zWfD3Dp31ry5bi0nw3/sOKp+7HdQBhTsjjt+rtIPnKLTFhTA1inOQ
         9mKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC0IxF (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 04:53:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:40504 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeC0IxD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 04:53:03 -0400
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
To: "Du, Changbin" <changbin.du@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
 <20180327022010.57u6rn73inbkrycn@intel.com>
 <20180327030229.txifuth2qmnjo3hy@ast-mbp>
 <20180327030613.hkp7hox3g4prnbsg@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2dd7c04a-eb10-e730-148e-3b04a18e9b44@iogearbox.net>
Date: Tue, 27 Mar 2018 10:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180327030613.hkp7hox3g4prnbsg@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596080308742784399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27/2018 05:06 AM, Du, Changbin wrote:
> On Mon, Mar 26, 2018 at 08:02:30PM -0700, Alexei Starovoitov wrote:
>> On Tue, Mar 27, 2018 at 10:20:10AM +0800, Du, Changbin wrote:
>>> On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
>>>> On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
>>>>> Signed-off-by: Changbin Du <changbin.du@intel.com>
>>>>> ---
>>>>>  tools/testing/selftests/bpf/Makefile | 5 +++--
>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>>> index 5c43c18..dc0fdc8 100644
>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>> @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
>>>>>    GENFLAGS := -DHAVE_GENHDR
>>>>>  endif
>>>>>  
>>>>> -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
>>>>> +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
>>>>> +	  -I../../../include -I../../../../usr/include
>>>>>  LDLIBS += -lcap -lelf -lrt -lpthread
>>>>>  
>>>>>  # Order correspond to 'make run_tests' order
>>>>> @@ -62,7 +63,7 @@ else
>>>>>    CPU ?= generic
>>>>>  endif
>>>>>  
>>>>> -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
>>>>> +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
>>>>>  	      -Wno-compare-distinct-pointer-types
>>>>
>>>> Nack.
>>>> I suspect that will break the build for everyone else who's doing it in the directory
>>>> itself instead of the outer one.
>>>
>>> This one? But I didn't see any problem.
>>
>> because the build was lucky and additional path ../../../../usr/include didn't point
>> to a valid dir?

Agree.

> I am sorry but I don't understand why you mean *lucky*. Of cause, the path is valid.

The problem is that this suddenly requires users to do a 'make headers_install' in
order to populate usr/include/ directory in the first place. While it's annoying
enough for BPF samples where this is needed, I absolutely don't want to introduce
this for BPF kselftests. It's the wrong approach. Besides, in tools infra, there is
a tools/arch/*/include/uapi/asm/bitsperlong.h header copy already, so we really need
to use that instead. Please adapt your patch accordingly and respin. Please also Cc
us and netdev@vger.kernel.org for BPF kselftests changes.

Thanks,
Daniel
