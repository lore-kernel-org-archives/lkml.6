Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B61C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A55E20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP9rUXQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeIYKpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:45:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44489 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIYKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:45:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so2529845pgu.11;
        Mon, 24 Sep 2018 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QDtr3crKTs8CyUfbGKpv9MRx7JT47gN5f+jBXWBNk1w=;
        b=rP9rUXQb50f1FORkkrfV4PUQM+d88U4+3zv7eSEXZ8zmN0RbiEYC2FGysy7N39Pvc5
         Xlo59M4A77V6z5PjvifI0HlDfGbEMjpKrLHUEQChc1lAjHyQBd05B8N4ihRnni4hcL2t
         vCeB9QKhByyzPPFlzLfKTSya9T5mOCoIlpc/34ZPdALRpk52JVZwUQlToBXNP4sIuWZk
         +Lq42Rdd28M+JBScGJ7ff7d/D6GxnKM7tmK3MbFwCqSYd62dzolYY1nxKYoI0o6oIa8h
         EGQje/0yYr0dTe6ISeYxDW/D0+C5e6Rx5JGwJ9Zh/bHsMxzsIv4zi5ITYl8LVVTZmeHU
         EFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDtr3crKTs8CyUfbGKpv9MRx7JT47gN5f+jBXWBNk1w=;
        b=mqRnGndmZpJrG/GreO0oXj6CbjthijH2jJpO69ZhFsbXgkLObR8Dk74Zb0fxT6gMf9
         +YwCCGrcVGl8UeNt2MxH+OQal7bYw9IHJyAyFFtEjJJE7eFWopCjeTVeHCE6iVsjqVBD
         k5kAiyDySCqZxjgshJUm+y7h8at2kZOXapBvZ4hf5pZqt3VuSga0rZ15CAAbnRRX/79t
         BmfScwdqVipBhRY39vBfFroKosEJba8S5VsjETtUkFVu0y5oVhn7++xg+Oe74dfbKuS8
         BS6a7mZV4UAJH8utiU3imhulPSkyBUfLnetfjKp789RmSVJiGWbWQnJjaDblGmGlq2Ky
         001A==
X-Gm-Message-State: ABuFfohfOXrR1KiIfZY5RKy929pSl4w5hMxyg91LJI2YyWPjQqO85Zr2
        i+BpxNRB0n35vOdz8dS5mdhQfAe/
X-Google-Smtp-Source: ACcGV61GSTrk8XuOO3ZUFJQ3WPaQG6JtG475FY7fus8JNj7ibrRBB47B8OpxdaH5AcxLAam6ecwFCA==
X-Received: by 2002:a63:225a:: with SMTP id t26-v6mr1540203pgm.275.1537850383085;
        Mon, 24 Sep 2018 21:39:43 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c85-v6sm1091930pfb.147.2018.09.24.21.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 21:39:41 -0700 (PDT)
Subject: Re: [PATCH] of: unittest: Don't dereference args.np after test errors
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537720412-29919-1-git-send-email-linux@roeck-us.net>
 <837495de-36b9-3bff-e3da-9ee79b9ef125@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ad3b8421-fc73-f4da-a44c-1e47a9d71463@roeck-us.net>
Date:   Mon, 24 Sep 2018 21:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <837495de-36b9-3bff-e3da-9ee79b9ef125@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 09/24/2018 09:19 PM, Frank Rowand wrote:
> Hi Guenter,
> 
> On 09/23/18 09:33, Guenter Roeck wrote:
>> If a devicetree parse function fails, it is quite likely that args.np
>> is invalid. Trying to dereference it will then cause the system to crash.
>>
>> This was seen when trying to run devicetree unittests on a g3beige
>> qemu system. This system has the OF_IMAP_OLDWORLD_MAC flag set in
>> of_irq_workarounds and expects an 'old style' structure of irq
>> nodes. Trying to parse the test nodes fails and results in the
>> following crash.
>>
>> OF: /testcase-data/phandle-tests/consumer-b: arguments longer than property
>> Unable to handle kernel paging request for data at address 0x00bc616e
>> Faulting instruction address: 0xc092437c
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> BE PREEMPT PowerMac
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
>> NIP:  c092437c LR: c0925098 CTR: c0925088
>> REGS: cf8dfb40 TRAP: 0300   Not tainted  (4.19.0-rc4-yocto-standard+)
>> MSR:  00001032 <ME,IR,DR,RI>  CR: 82004044  XER: 00000000
>> DAR: 00bc616e DSISR: 40000000
>> GPR00: c0925098 cf8dfbf0 cf8e0000 c14098c7 c14098c7 c1409c50 00000066 00000002
>> GPR08: 00000063 00bc614e c0b483e9 000affff 82004048 00000000 00000008 c0b36d80
>> GPR16: c0ac0000 c0b4233c c14098c7 c0b13c14 05ffffff 000affff c0b483e4 c0b00a30
>> GPR24: cecfe324 cecfe324 c0acc434 c0ac8420 c1409c50 05ffffff c1409c50 c14098c7
>> NIP [c092437c] device_node_gen_full_name+0x30/0x15c
>> LR [c0925098] device_node_string+0x190/0x3c8
>> Call Trace:
>> [cf8dfbf0] [c0733704] of_find_property+0x5c/0x74 (unreliable)
>> [cf8dfc30] [c0925098] device_node_string+0x190/0x3c8
>> [cf8dfca0] [c092690c] pointer+0x274/0x4d4
>> [cf8dfcd0] [c0926e20] vsnprintf+0x2b4/0x5ec
>> [cf8dfd30] [c0927170] vscnprintf+0x18/0x48
>> [cf8dfd40] [c008eb70] vprintk_store+0x4c/0x22c
>> [cf8dfd70] [c008f1c4] vprintk_emit+0x94/0x270
>> [cf8dfda0] [c008fb60] printk+0x5c/0x6c
>> [cf8dfde0] [c0bd1ec0] of_unittest+0x2670/0x2b48
>> [cf8dfe80] [c0004ba8] do_one_initcall+0xac/0x320
>> [cf8dfee0] [c0b8975c] kernel_init_freeable+0x328/0x3f0
>> [cf8dff30] [c00050c4] kernel_init+0x24/0x118
>> [cf8dff40] [c0014278] ret_from_kernel_thread+0x14/0x1c
>>
>> To avoid this and similar problems, don't try to dereference args.np
>> after devicetree parse failures, and display the name of the parsed node
>> instead. With this, we get error messages such as
>>
>> dt-test ### FAIL of_unittest_parse_interrupts():791 index 0 -
>> 	data error on node /testcase-data/interrupts/interrupts0 rc=-22
>>
>> This may not display the intended node name, but it is better than a crash.
> 
> Thanks for finding and debugging the root cause of the problem.
> 
> As the patch comment notes, the changes do not fix the root cause, but
> instead avoid the crash.  I'd like to deal with the root cause instead.
> 
> I've never encountered OF_IMAP_OLDWORLD_MAC and need to dig deeper to
> understand exactly how having it set leads to the error returns from
> of_parse_phandle_with_args().  Thus my off-the-top-of-my-head first
> observation is likely to be incorrect.  But I'd like to point out
> what I suspect is likely to be a more useful direction for the fix.
> 
> I'll use a bit of artful logic to claim that the root cause is that
> of_parse_phandle_with_args() does not behave as unittests expect when
> OF_IMAP_OLDWORLD_MAC is set.
> 
> If the of_parse_phandle_with_args() calls are not going to perform the
> test that unittest expects to be performing, then it is pointless to
> do the tests.  The fix then is to not do those tests.  For example,
> at the top of of_unittest_parse_phandle_with_args(), simply do:
> 
>          if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
>                  return;
> 

I thought about submitting that as second patch, but wanted to wait
for feedback before doing that. I'll be more than happy to drop this
patch and replace it with the above.

> I did not look to see whether the other test areas you found can be
> as easily avoided, without avoiding tests that are still valid when
> OF_IMAP_OLDWORLD_MAC is set, but I am hoping so.
> 
> While looking at the patch, I noticed that the current
> of_unittest_parse_phandle_with_args() also does not call of_node_put()
> in the cases where of_count_phandle_with_args() does not return an
> error.  I'll add fixing that to my todo list.
> 
> And as you pointed out, of_unittest_parse_phandle_with_args() should
> not be blindly using the contents of args when an error occurred.  I'll
> also put fixing that on my todo list.
> 

That was the intent of this patch, but I'll be happy to leave it up to you
to find a better solution. I did not check if there are situations where
args.np is still usable, or if it makes a difference if args.np is
preinitialized with NULL, so it might well be that a better fix is
possible.

Thanks,
Guenter

> -Frank
> 
> 
> 
>>
>> Fixes: 53a42093d96ef ("of: Add device tree selftests")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/of/unittest.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 722537e14848..5942ddce1b9f 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -424,7 +424,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
>>   		}
>>   
>>   		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>   	}
>>   
>>   	/* Check for missing list property */
>> @@ -554,8 +554,8 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
>>   			passed = false;
>>   		}
>>   
>> -		unittest(passed, "index %i - data error on node %s rc=%i\n",
>> -			 i, args.np->full_name, rc);
>> +		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> +			 i, np, rc);
>>   	}
>>   
>>   	/* Check for missing list property */
>> @@ -788,7 +788,7 @@ static void __init of_unittest_parse_interrupts(void)
>>   		passed &= (args.args[0] == (i + 1));
>>   
>>   		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>   	}
>>   	of_node_put(np);
>>   
>> @@ -834,7 +834,7 @@ static void __init of_unittest_parse_interrupts(void)
>>   			passed = false;
>>   		}
>>   		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>   	}
>>   	of_node_put(np);
>>   }
>> @@ -904,7 +904,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
>>   		}
>>   
>>   		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>   	}
>>   	of_node_put(np);
>>   }
>>
> 
> 

