Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F139C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959DA20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP+Uk910"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959DA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeIZOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:15:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:15:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so5984413pgb.2;
        Wed, 26 Sep 2018 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rGbUd2Gzec9Iy/4XEX2Lh9OIg9u/UmsPyRp2sTEo05w=;
        b=qP+Uk910KIw0MFu2O8txxOcfNbC93awvsoCYAqZMyjUTK5DNrSGnUeMg/IiA+X1Xr7
         MDb/hZ/vpK69dZ/QKVThkxkRryWk+ecBcb39IbRFdTWZanU1AV3llPSKYPHglP/ziZ7x
         a/QjEwiOnoMp2/CJ48kyq1PbudUQefjC9XPUC9AuvRQJC8bLU0jyeih4b+p1RccLV+zs
         P6qoArIZVDErV+sloYCjp8W04A7e+y0MXJJrT4xthzZHPsWdUzmBabldY+sNTTVdWdVm
         rftn3bvFXrpL/5zRrIh+ITi07H5MU3CZtz6WHHJMM1irG7PHmVRv/Di+28nAoIiGQ4QQ
         4Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGbUd2Gzec9Iy/4XEX2Lh9OIg9u/UmsPyRp2sTEo05w=;
        b=oeibedumCaqmQc8411oyPz2to8jUQGYwMrusfZktbky81CfZpt3SSSSoYAhm8vs1xg
         rpm8eft62Msaokeev253gY3eWvlqsCmqEOTxmu6vAvTfnq6XJQsbELBZB222MxfIppvr
         0ea7QhXacAUnKQ+q0uH7NvcFRtjYOFi+alRaO8Hf6m1QxxoNomHf70Z4HHn81OhWsrP9
         +T3fS30Y5ETe8symQQwLGG/QhFn1KZIN5KWsDVGgElkWKKJJA6dtYBwL/LsgPwgo8hUM
         DnkXyLmIpk2Ltb/Y3mWQJy9geWfgYYzahCzJjs9W8jkTLoIqRM3JZGa5ae9xcbES93XY
         Tk7g==
X-Gm-Message-State: ABuFfohIA6UuA4o2vjDJc/qzlin3XMqXfhmTx0flw5Yx8Q9mpr8HXNMd
        H9LW7ndogEHLmHJsFE3edU8=
X-Google-Smtp-Source: ACcGV60PQCLp/yi/o/OFTxIdgH+/yHeE7IUZW2M5SyZVbA6/TOAZcswvhzpFw+BUvm5s7HyJlz6puw==
X-Received: by 2002:a62:5950:: with SMTP id n77-v6mr470827pfb.0.1537949044929;
        Wed, 26 Sep 2018 01:04:04 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id t1-v6sm5692663pgp.32.2018.09.26.01.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:04:04 -0700 (PDT)
Subject: Re: [PATCH v2] of: unittest: Disable interrupt node tests for old
 world MAC systems
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537934784-19819-1-git-send-email-linux@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <765f518c-0f49-058a-600c-ae7070785ff3@gmail.com>
Date:   Wed, 26 Sep 2018 01:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537934784-19819-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/18 21:06, Guenter Roeck wrote:
> On systems with OF_IMAP_OLDWORLD_MAC set in of_irq_workarounds, the
> devicetree interrupt parsing code is different, causing unit tests of
> devicetree interrupt nodes to fail. Due to a bug in unittest code, which
> tries to dereference an uninitialized pointer, this results in a crash.
> 
> OF: /testcase-data/phandle-tests/consumer-a: arguments longer than property
> Unable to handle kernel paging request for data at address 0x00bc616e
> Faulting instruction address: 0xc08e9468
> Oops: Kernel access of bad area, sig: 11 [#1]
> BE PREEMPT PowerMac
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.72-rc1-yocto-standard+ #1
> task: cf8e0000 task.stack: cf8da000
> NIP:  c08e9468 LR: c08ea5bc CTR: c08ea5ac
> REGS: cf8dbb50 TRAP: 0300   Not tainted  (4.14.72-rc1-yocto-standard+)
> MSR:  00001032 <ME,IR,DR,RI>  CR: 82004044  XER: 00000000
> DAR: 00bc616e DSISR: 40000000
> GPR00: c08ea5bc cf8dbc00 cf8e0000 c13ca517 c13ca517 c13ca8a0 00000066 00000002
> GPR08: 00000063 00bc614e c0b05865 000affff 82004048 00000000 c00047f0 00000000
> GPR16: c0a80000 c0a9cc34 c13ca517 c0ad1134 05ffffff 000affff c0b05860 c0abeef8
> GPR24: cecec278 cecec278 c0a8c4d0 c0a885e0 c13ca8a0 05ffffff c13ca8a0 c13ca517
> 
> NIP [c08e9468] device_node_gen_full_name+0x30/0x15c
> LR [c08ea5bc] device_node_string+0x190/0x3c8
> Call Trace:
> [cf8dbc00] [c007f670] trace_hardirqs_on_caller+0x118/0x1fc (unreliable)
> [cf8dbc40] [c08ea5bc] device_node_string+0x190/0x3c8
> [cf8dbcb0] [c08eb794] pointer+0x25c/0x4d0
> [cf8dbd00] [c08ebcbc] vsnprintf+0x2b4/0x5ec
> [cf8dbd60] [c08ec00c] vscnprintf+0x18/0x48
> [cf8dbd70] [c008e268] vprintk_store+0x4c/0x22c
> [cf8dbda0] [c008ecac] vprintk_emit+0x94/0x130
> [cf8dbdd0] [c008ff54] printk+0x5c/0x6c
> [cf8dbe10] [c0b8ddd4] of_unittest+0x2220/0x26f8
> [cf8dbea0] [c0004434] do_one_initcall+0x4c/0x184
> [cf8dbf00] [c0b4534c] kernel_init_freeable+0x13c/0x1d8
> [cf8dbf30] [c0004814] kernel_init+0x24/0x118
> [cf8dbf40] [c0013398] ret_from_kernel_thread+0x5c/0x64
> 
> The problem was observed when running a qemu test for the g3beige machine
> with devicetree unittests enabled.
> 
> Disable interrupt node tests on affected systems to avoid both false
> unittest failures and the crash.
> 
> With this patch in place, unittest on the affected system passes with
> the following message.
> 
> 	dt-test ### end of unittest - 144 passed, 0 failed
> 
> Fixes: 53a42093d96ef ("of: Add device tree selftests")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Do not use goto to skip tests.
>     Provide test log in commit message.
> 
>  drivers/of/unittest.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 722537e14848..41b49716ac75 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -771,6 +771,9 @@ static void __init of_unittest_parse_interrupts(void)
>  	struct of_phandle_args args;
>  	int i, rc;
>  
> +	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
> +		return;
> +
>  	np = of_find_node_by_path("/testcase-data/interrupts/interrupts0");
>  	if (!np) {
>  		pr_err("missing testcase data\n");
> @@ -845,6 +848,9 @@ static void __init of_unittest_parse_interrupts_extended(void)
>  	struct of_phandle_args args;
>  	int i, rc;
>  
> +	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
> +		return;
> +
>  	np = of_find_node_by_path("/testcase-data/interrupts/interrupts-extended0");
>  	if (!np) {
>  		pr_err("missing testcase data\n");
> @@ -1001,15 +1007,19 @@ static void __init of_unittest_platform_populate(void)
>  	pdev = of_find_device_by_node(np);
>  	unittest(pdev, "device 1 creation failed\n");
>  
> -	irq = platform_get_irq(pdev, 0);
> -	unittest(irq == -EPROBE_DEFER, "device deferred probe failed - %d\n", irq);
> +	if (!(of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)) {
> +		irq = platform_get_irq(pdev, 0);
> +		unittest(irq == -EPROBE_DEFER,
> +			 "device deferred probe failed - %d\n", irq);
>  
> -	/* Test that a parsing failure does not return -EPROBE_DEFER */
> -	np = of_find_node_by_path("/testcase-data/testcase-device2");
> -	pdev = of_find_device_by_node(np);
> -	unittest(pdev, "device 2 creation failed\n");
> -	irq = platform_get_irq(pdev, 0);
> -	unittest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
> +		/* Test that a parsing failure does not return -EPROBE_DEFER */
> +		np = of_find_node_by_path("/testcase-data/testcase-device2");
> +		pdev = of_find_device_by_node(np);
> +		unittest(pdev, "device 2 creation failed\n");
> +		irq = platform_get_irq(pdev, 0);
> +		unittest(irq < 0 && irq != -EPROBE_DEFER,
> +			 "device parsing error failed - %d\n", irq);
> +	}
>  
>  	np = of_find_node_by_path("/testcase-data/platform-tests");
>  	unittest(np, "No testcase data in device tree\n");
> 

Thank you Guenter.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
