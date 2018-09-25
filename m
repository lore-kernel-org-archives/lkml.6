Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97D120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsxVwae3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97D120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeIYKfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:35:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37796 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIYKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:35:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so3528364pgq.4;
        Mon, 24 Sep 2018 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxir31SpyhfLQEMMEnha7CW0tgQe3Pi3DiA/t/wKtB0=;
        b=GsxVwae3K5ohk0dJeVuynCJB53gG2PExoFYMcfP1sIpU5ggwjePxYdxXyKus+klgOg
         1wM0gHWFLQnixKiSvB+v+hmAhZhLBLe2ghSXui8FWa45KBPGRi/YiENNTbVMDlAiHOmu
         Ct7je+YbYr6PLHUdDZkpcgzbkr8ko1vqEs9knKZB+e9MwLMa5yjB0Q60vwoJ5MJOaI0q
         5/FG/F/+dH9oTelXm4c7S0Ei662JyGKPnzk1rNuK2dUItuK9rcpOGszKmP4+F5o0ly87
         5tCdyCs8C0y/J5DDNLISmJo6XBk9u9keJiCaf2YLjf4TCRiLb0YKek3QbMwLwCUq2cfD
         wzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxir31SpyhfLQEMMEnha7CW0tgQe3Pi3DiA/t/wKtB0=;
        b=RUMASxKBf8BHiatsRn3U/nJOEuSxrZmqEbUh6BPCLltcgB6QH3OiIVZEsNZN/V+VpY
         lAMc6OAoBzYTh+UTATGaUOYobFTgrrcIbEjPOkcRo1w4vQTkTJqhe8Eoc9uPWAtvx0nK
         ssknUtcmxBT36dJdR+NomWNFHOLAdC83dEcAgE/8ZU1q02G0pnTUudZlNh8R9PnCBweO
         Ldy3TPb663ml2f+q80/uo77hA0sbYryApQE08FDYo0XMxBevwcS/Q+Yj6G2vpNA/rP2k
         glxMfIYO9U5dDh5TnWFJL2Z/ahTx7BpIuzGbbjhXXG37JET6rpcAQ3CeZq6IyAYfBMt+
         eWfg==
X-Gm-Message-State: ABuFfojal3Xpkf6nnO/jdlbMhYnXqE3nnHUbT8zjhD+VS71O10VGAnKx
        Zoab31aBIySLNdBXIEk10Iw=
X-Google-Smtp-Source: ACcGV60Q3wdzCmcitrgn9Qmcs2siZDgnR2YXYBPmQKvXGLDtk3JszJjBJItPBIht3bOZxeoAz4+gPw==
X-Received: by 2002:a62:da1c:: with SMTP id c28-v6mr1712247pfh.68.1537849762932;
        Mon, 24 Sep 2018 21:29:22 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1167634pfk.76.2018.09.24.21.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 21:29:22 -0700 (PDT)
Subject: Re: [PATCH] of: unittest: Don't dereference args.np after test errors
From:   Frank Rowand <frowand.list@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537720412-29919-1-git-send-email-linux@roeck-us.net>
 <837495de-36b9-3bff-e3da-9ee79b9ef125@gmail.com>
Message-ID: <b846194e-d50c-e152-2f1d-f5d444ade8f8@gmail.com>
Date:   Mon, 24 Sep 2018 21:29:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <837495de-36b9-3bff-e3da-9ee79b9ef125@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/18 21:19, Frank Rowand wrote:
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
>         if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
>                 return;

I forgot to mention another rationale for this approach.  This will result
in the number of failed tests to remain at zero.

-Frank


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
> -Frank
> 
> 
> 
>>
>> Fixes: 53a42093d96ef ("of: Add device tree selftests")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/of/unittest.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 722537e14848..5942ddce1b9f 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -424,7 +424,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
>>  		}
>>  
>>  		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>  	}
>>  
>>  	/* Check for missing list property */
>> @@ -554,8 +554,8 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
>>  			passed = false;
>>  		}
>>  
>> -		unittest(passed, "index %i - data error on node %s rc=%i\n",
>> -			 i, args.np->full_name, rc);
>> +		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> +			 i, np, rc);
>>  	}
>>  
>>  	/* Check for missing list property */
>> @@ -788,7 +788,7 @@ static void __init of_unittest_parse_interrupts(void)
>>  		passed &= (args.args[0] == (i + 1));
>>  
>>  		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>  	}
>>  	of_node_put(np);
>>  
>> @@ -834,7 +834,7 @@ static void __init of_unittest_parse_interrupts(void)
>>  			passed = false;
>>  		}
>>  		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>  	}
>>  	of_node_put(np);
>>  }
>> @@ -904,7 +904,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
>>  		}
>>  
>>  		unittest(passed, "index %i - data error on node %pOF rc=%i\n",
>> -			 i, args.np, rc);
>> +			 i, np, rc);
>>  	}
>>  	of_node_put(np);
>>  }
>>
> 
> 

