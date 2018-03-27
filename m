Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuZHN1MuOD8JIB0xqcvg3bOqUeBL4osdymHjQTtOdsZcQ7sl8YdpO2OzMaF5sJlsQTMC4tG
ARC-Seal: i=1; a=rsa-sha256; t=1522144354; cv=none;
        d=google.com; s=arc-20160816;
        b=H5fDQkqeM4yUrbVg8RilWttgXigAit0EPuiqwdcfgUBk97Z7E5MWYkvb9HHoULroWJ
         qdVjOShW+v1WZE0c9z/vV1iuQI5DzASlpOtlNyvzx0jGbwYaPUNs5EFNPaQmvWA1RbG1
         mT4+JABMxg4go+P5TbeEN1vXdENpYoc+pBvbjQaOwApjXzM0ZZX6eXBeQ9DqOCuG0FjW
         OxjRguuKBZA8wmvDqJBXE+Dxv+Yz3PQP6gi22nK95fssFBhfrkruYJ1UYiLpTNMIsAnA
         mCUTGKlnBvLxkOxK/9gY8zi4onHaxcLYYCVy+pNscpbfqhuM/fKPjjZshi3soEBfw0R2
         Vc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=DTmwc2XFuTUfPDBYlHbRAN3HIP3p6adnuMImxvDk4ks=;
        b=Y7rlzM/66Emo4lksL1MUjXWOp2BcsoYtbyhF+WpYeKfSdaw2qd9YtGJHsF8+9c2BcF
         I+vxnH6CC70giSJGCd7eOb1VSsP/4M7onTQgjDwk5Xgzy0OuWX5t0cBy1FMn/0gSVjjC
         0lh2X/ofo9eTI/oBT5af0MLsH25q6Je7GlBpzCalWDhRnW9FErhHIced85VHcYqLRVyG
         yegeBcISyTdp6BkOuPJoXU4lv44R7dydsL9ifbiD3VKrqPB0HpzWEUcYleJFRL4mk/pP
         phCCQr8JFnojlUxcvb20EtCGUXZBuu9DF/Mp77M1tgECWguWEE696h0K2deeWBxInVDh
         LYhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbeC0Jwd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 05:52:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:54247 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0Jwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 05:52:32 -0400
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
 <20180327022010.57u6rn73inbkrycn@intel.com>
 <20180327030229.txifuth2qmnjo3hy@ast-mbp>
 <20180327030613.hkp7hox3g4prnbsg@intel.com>
 <2dd7c04a-eb10-e730-148e-3b04a18e9b44@iogearbox.net>
 <20180327090000.fou6oyvr663lbyuq@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <90ce8146-cecd-c928-f9c6-470db97b2051@iogearbox.net>
Date: Tue, 27 Mar 2018 11:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180327090000.fou6oyvr663lbyuq@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596084037990275885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27/2018 11:00 AM, Du, Changbin wrote:
> On Tue, Mar 27, 2018 at 10:52:57AM +0200, Daniel Borkmann wrote:
>> On 03/27/2018 05:06 AM, Du, Changbin wrote:
>>> On Mon, Mar 26, 2018 at 08:02:30PM -0700, Alexei Starovoitov wrote:
>>>> On Tue, Mar 27, 2018 at 10:20:10AM +0800, Du, Changbin wrote:
>>>>> On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
>>>>>> On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
>>>>>>> Signed-off-by: Changbin Du <changbin.du@intel.com>
>>>>>>> ---
>>>>>>>  tools/testing/selftests/bpf/Makefile | 5 +++--
>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>>>>> index 5c43c18..dc0fdc8 100644
>>>>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>>>>> @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
>>>>>>>    GENFLAGS := -DHAVE_GENHDR
>>>>>>>  endif
>>>>>>>  
>>>>>>> -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
>>>>>>> +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
>>>>>>> +	  -I../../../include -I../../../../usr/include
>>>>>>>  LDLIBS += -lcap -lelf -lrt -lpthread
>>>>>>>  
>>>>>>>  # Order correspond to 'make run_tests' order
>>>>>>> @@ -62,7 +63,7 @@ else
>>>>>>>    CPU ?= generic
>>>>>>>  endif
>>>>>>>  
>>>>>>> -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
>>>>>>> +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
>>>>>>>  	      -Wno-compare-distinct-pointer-types
>>>>>>
>>>>>> Nack.
>>>>>> I suspect that will break the build for everyone else who's doing it in the directory
>>>>>> itself instead of the outer one.
>>>>>
>>>>> This one? But I didn't see any problem.
>>>>
>>>> because the build was lucky and additional path ../../../../usr/include didn't point
>>>> to a valid dir?
>>
>> Agree.
>>
>>> I am sorry but I don't understand why you mean *lucky*. Of cause, the path is valid.
>>
>> The problem is that this suddenly requires users to do a 'make headers_install' in
>> order to populate usr/include/ directory in the first place. While it's annoying
>> enough for BPF samples where this is needed, I absolutely don't want to introduce
>> this for BPF kselftests. It's the wrong approach. Besides, in tools infra, there is
>> a tools/arch/*/include/uapi/asm/bitsperlong.h header copy already, so we really need
>> to use that instead. Please adapt your patch accordingly and respin. Please also Cc
>> us and netdev@vger.kernel.org for BPF kselftests changes.
>>
> Thanks for the explanation. So we expect that tools/arch/*/include is in the searching list, right?
> The corrent makefile seems not. How do you get this built?

E.g. take a look at tools/include/asm/barrier.h or tools/include/uapi/asm/bpf_perf_event.h
just to name two examples. We'd need something similar to this which then points to the
arch specific includes.

Thanks,
Daniel

> changbin@gvt-dell-host:~/work/linux/tools/testing/selftests/bpf$ make -p
> [...]
> clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
>          -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_pkt_access.o
> In file included from test_pkt_access.c:9:
> In file included from ../../../include/uapi/linux/bpf.h:11:
> In file included from ./include/uapi/linux/types.h:5:
> /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
> #include <asm/bitsperlong.h>
> 
> 

