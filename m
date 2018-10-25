Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D88C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A602083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scIOzfpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A602083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJZC1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:27:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39340 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeJZC1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:27:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so9345498wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nayb9YKm+CcpdX85dekwriIkRn3Uc7TlJumxM/+zS+A=;
        b=scIOzfpPuIMwe9TlH8pLBRQf5xPb5w3pfcMtOoxsUUO3aOjhWWFF6RHEhaUOxdzmBK
         fVjEz22K3gBIdnbjJtm8KonqyGtenZbPtqRq/L0BAZxgN7XfuvpbAW5yGYHyTDrgNUhZ
         absnlEvYqrMhw+izVztVpJbGekiqUGeJ/5HPgY4n5BjdgC06oThjwcYe2UpVYfJQpRxy
         eju4sFWMjM0PQRvkuVrAIqgWje2IshtQAosoyTSQTflCGT9ilZDmuTxdigxjpI0cri9G
         Tj/wWHFCIRodGFOEbcIlH6vsX1S20OWOr8Oy0N2xAH2Ye6jittK2//iMjUOtV4mGcvKk
         CmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nayb9YKm+CcpdX85dekwriIkRn3Uc7TlJumxM/+zS+A=;
        b=R15W0fqrILePlyAXChq0jTdLjfzSmhbxw2UbQ4HW32UdU7go6mZzNMspcHGYRtokRN
         9ueCefbxKjt07Ejpa4m4STCIBf/Bji6H9/13QdPJnluBn9xX6Zg6oOFmrQGH0DCZIekl
         kxra4xv4BIiVUR7FtSAwpoSKZHvxLcJj0gfCJmfhl9tkRT3bzAtTqvg1RUd95yz3VYpY
         QPHJAHWnv8tQBQ8Uvx5I1OTK9DqPOGSnuBozQQY3zNJp4Fb5pCVl8FZwCEVkQHg2bvE9
         +TKiPv+WduVq3rUPSPhEL/ivf8VeZes2zLDnz1XwjYgig+JxoQu0rTLnzkbl3S5FtA/v
         dzOQ==
X-Gm-Message-State: AGRZ1gK1SFjETIHiD08KTjedkipuAcdfbEXmMXgziV9MZrTdlm8qw+Sm
        duyr1aFNL5WfvXDDlGMRcIc=
X-Google-Smtp-Source: AJdET5fHjjK2ofStax4WP7AukrDrfIAd3m84jO92eYOR60bKVSBZ4sALkz5+ppLZA441x9+kWO+Rrw==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr2854952wrx.114.1540490006442;
        Thu, 25 Oct 2018 10:53:26 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c24-v6sm13332746wre.44.2018.10.25.10.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:53:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, l.stach@pengutronix.de
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com> <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
 <20181025173242.GC30658@n2100.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
Date:   Thu, 25 Oct 2018 10:53:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025173242.GC30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 10:32 AM, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2018 at 10:19:54AM -0700, Florian Fainelli wrote:
>> On 10/24/18 7:10 PM, Andrew Lunn wrote:
>>> On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
>>>> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
>>>> independance with respect to the ARM CPU being used. Add a test which
>>>> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
>>>> turned on to help asses the system's health.
>>>
>>> Hi Florian
>>>
>>> I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
>>> segfaults give little clue as to what is going wrong,and gdb is not
>>> much use either.
>>
>> If you have a working backtrace, you can typically see the virtual
>> address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
>> is not particularly helpful.
>>
>>>
>>> What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
>>> fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
>>> ARM?
>>
>> Sure, sounds reasonable, thanks for taking a look.
> 
> An alternative would be rather than adding this to user programs, to
> have the kernel detect it and print a warning itself.

Something like this below? It does not have to be an alternative
solution, I would find it useful for perf to make sure the vectors page
is present in the virtual address space by having an explicit test. perf
maintains, what do you think?

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f4ea4c62c613..b045b48d368d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned
long addr,
                show_regs(regs);
        }
 #endif
+#ifndef CONFIG_KUSER_HELPERS
+       if (((addr & PAGE_MASK) == 0xffff0000) && (sig == SIGSEGV))
+               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at
0x%08lx\n",
+                      tsk->comm, addr);
+#endif

        tsk->thread.address = addr;
        tsk->thread.error_code = fsr;


> 
> BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
> updated.
> 


-- 
Florian
