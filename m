Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB36C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6346A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbZ8d2tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6346A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeGZLYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:24:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45895 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeGZLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:24:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so851385pgq.12;
        Thu, 26 Jul 2018 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YzYc/dt8BQ4jn+yNOHuOe5Y0bAOMSieMbzLtSJYvrk=;
        b=BbZ8d2tZgmYv5ey2qUokuQoTxss4m+lOz8iXcM5NZrrUeCqp0g3nceWFd4iuHqeBZD
         BdguLFQtF9cWfNms2qchfgPtu3M6S4K2dTheXjVKa6A+jop8xk6PAxeb489jEZjPLueD
         vnzuYwu/HqvfY75uaACWVbTGT4OqLIMGdcYVg6aT8dW9JK2x4iQKBnhi0rfX0TX2mblr
         QrFxdtNCaxADSgD9W3t+Br75pMY3wmf7XbWhaRkQShlFN7PHFtRMsqh6XWxRogiKVJjE
         jXpaLV0JZJ2DPNNDj00bk9tIILTV0fqwe9Rsp6SJd63kphEvA3SWY4WRNJJCsxKwBZzf
         Ka1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YzYc/dt8BQ4jn+yNOHuOe5Y0bAOMSieMbzLtSJYvrk=;
        b=HXN+n/9Xe+b40veA3Y90T1e116LiVq6fhaM49Zz+71pXIuwpsgwgbT9i9CE1wGnYKt
         asKVCAs0rZD+oK2/PQM0aVRBMoiY1wS1nH41aEaqbjy1uMrp+VvPH8qbb5SOnx0bOBLs
         QVqm1vjdPTotfYPL7Y/Ntwk6MyWdWZbVprhH3YdDjG5s50xwh3PWMgQjKjirAlTGDEZM
         9JoJNIm72Df6JCqnYpZjA3+CU5qUZr39T6fbYZxK/m9OEhJj9+26apwPadDDFXD/ptqf
         wZkkcsNLIrZ2/2d1gbSF+xnmbI00it17VHfnjbetTYdC9WcAfIHkNfZgPjJLJeM7m20V
         +eqA==
X-Gm-Message-State: AOUpUlHTsYxsnirwvu7j6+lVvMhu5gbGx8WeKsv6pW8QX4UqWEBcgmih
        XLDtCDcgbjSolUIiql60RTk=
X-Google-Smtp-Source: AAOMgpdixr8KynJZC4cAYp0YU1EaQvyVbD1yYgP8QdK6iAipikv7c8lX4ltHP720cmPBzJSUWjcojA==
X-Received: by 2002:a63:91c8:: with SMTP id l191-v6mr1308683pge.180.1532599725885;
        Thu, 26 Jul 2018 03:08:45 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id a15-v6sm1891463pfe.32.2018.07.26.03.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:08:44 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: Add BTF build flags to Makefile
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>
References: <20180725163039.2838-1-treeze.taeung@gmail.com>
 <20180725181603.69289f5d@cakuba.netronome.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <67fd8ddc-088e-469a-d093-b92f637cab11@gmail.com>
Date:   Thu, 26 Jul 2018 19:08:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725181603.69289f5d@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 10:16 AM, Jakub Kicinski wrote:
> On Thu, 26 Jul 2018 01:30:39 +0900, Taeung Song wrote:
>> To smoothly test BTF supported binary on samples/bpf,
>> let samples/bpf/Makefile probe llc, pahole and
>> llvm-objcopy for BPF support and use them
>> like tools/testing/selftests/bpf/Makefile
>> changed from the commit c0fa1b6c3efc ("bpf: btf:
>>   Add BTF tests")
>>
>> Cc: Martin KaFai Lau <kafai@fb.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>   samples/bpf/Makefile | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 1303af10e54d..e079266360a3 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -191,6 +191,8 @@ HOSTLOADLIBES_xdpsock		+= -pthread
>>   #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
>>   LLC ?= llc
>>   CLANG ?= clang
>> +LLVM_OBJCOPY ?= llvm-objcopy
>> +BTF_PAHOLE ?= pahole
>>   
>>   # Detect that we're cross compiling and use the cross compiler
>>   ifdef CROSS_COMPILE
>> @@ -198,6 +200,20 @@ HOSTCC = $(CROSS_COMPILE)gcc
>>   CLANG_ARCH_ARGS = -target $(ARCH)
>>   endif
>>   
>> +BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
>> +BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
>> +BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
>> +
>> +ifneq ($(BTF_LLC_PROBE),)
>> +ifneq ($(BTF_PAHOLE_PROBE),)
>> +ifneq ($(BTF_OBJCOPY_PROBE),)
> 
> Nice patch!  FWIW you could consider using $(and ...) here:
> 
> ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
> 
> https://www.gnu.org/software/make/manual/html_node/Conditional-Functions.html#Conditional-Functions
> 
> Not sure it's worth a respin..
> 

Hi Jakub,

Thanks for reviewing this.
I also think the conditional functions looks more tidy, will change it!

Thanks,
Taeung

>> +	EXTRA_CFLAGS += -g
>> +	LLC_FLAGS += -mattr=dwarfris
>> +	DWARF2BTF = y
>> +endif
>> +endif
>> +endif
>> +
>>   # Trick to allow make to be run from this directory
>>   all:
>>   	$(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)
>> @@ -256,4 +272,7 @@ $(obj)/%.o: $(src)/%.c
>>   		-Wno-gnu-variable-sized-type-not-at-end \
>>   		-Wno-address-of-packed-member -Wno-tautological-compare \
>>   		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
>> -		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
>> +		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
>> +ifeq ($(DWARF2BTF),y)
>> +	$(BTF_PAHOLE) -J $@
>> +endif
