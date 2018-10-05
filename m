Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67256C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE1F20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOIregMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeJFCFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:05:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeJFCFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:05:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so5116176pgc.8;
        Fri, 05 Oct 2018 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3HTBvu58ZNyGkfrsmTNBqBt87evYFmC8Rpuq9N1D3wI=;
        b=EOIregMKQu+33n0sHNY0wCTHcKHvhocE1w1Clno0FS5JSGGHKXgxesfvYdkhsvHT2a
         Pvoiv0t7UPsdqUo4UFJrZipdhe1ltgScYhG5OV3tXacLtK6NKozL6PMam2qC64QOYwPk
         ZhfGyh4Ueqw1VcPsta7JaaTg8QgcCFtlUIGBmqdnPYORwPKn3p1We6TtFzWwyByhtOF/
         +sfXLPbVAi6qhS2tyUHWuaOYBdV1IUEGrldgBpe0t4X4uuWEUhsPDxGyxL7nQC0Y3Ogd
         OGF/tAsjn6jQOZOlixopkwLbbAhv0nfRJm+Im5oHkfoFzxKu/xz8P7Gd13TFYyz35IH/
         3QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3HTBvu58ZNyGkfrsmTNBqBt87evYFmC8Rpuq9N1D3wI=;
        b=VIpO4WlXsBNx0/Dv4S88ahooht1vWhqpLfwfP/jnhMtYar4P6CeOHAgKmeLGnYgItd
         gg3z56qSeu8c5oY9igA0z7gZxVnBn916lfh060YqMnMfI4QXlkbdefvcF2vKyM4Lnjda
         JJij4Ho9b88eFbToAiTOMF2hG2WOlthi3NhUMlTY8i/EKW+uC0wrNCM2qrz8KcF3BUgw
         70R2gzvHB6zu7nMCQOE7NG7J4n9ix3klypuilJIZFZQiHXzwtPRCmxAQmWu+cgCVJL0o
         yTok9FeA/n4VRkh4yCi88ys120rs3PIhgnRR9esMa+T2vCl7CBQjz3/AYzKzo4XsljG5
         nAmQ==
X-Gm-Message-State: ABuFfoj3W0vQ7L1A9qtgQAEvpRTjJo7MhxKp4yMQvLA4a4POR+NCmh3T
        sR9PbjX6KSWfwn8ThHOfMg4=
X-Google-Smtp-Source: ACcGV61FJ6xqpXrddVBWkJLzNtHUb6mKo53sYqHxng4McHJV1oqV83LZXwTst57IUhp2+ExTW/Q6Ug==
X-Received: by 2002:a63:d749:: with SMTP id w9-v6mr11186265pgi.415.1538766319166;
        Fri, 05 Oct 2018 12:05:19 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n79-v6sm18760638pfk.19.2018.10.05.12.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:05:18 -0700 (PDT)
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
 <7fc4b9da-5fdf-11c9-e168-ccb2d960adea@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3c6fe77f-5fe6-0289-9480-7c98cdf81a43@gmail.com>
Date:   Fri, 5 Oct 2018 12:05:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7fc4b9da-5fdf-11c9-e168-ccb2d960adea@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 06:26, Guenter Roeck wrote:
> On 10/04/2018 09:12 PM, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Callers of of_irq_parse_one() blindly use the pointer args.np
>> without checking whether of_irq_parse_one() had an error and
>> thus did not set the value of args.np.  Initialize args to
>> zero so that using the format "%pOF" to show the value of
>> args.np will show "(null)" when of_irq_parse_one() has an
>> error and does not set args.np instead of trying to
>> dereference a random value.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> The same problem exists when of_parse_phandle_with_args() reports an error.

Thanks, I'll add a fix for that.

-Frank

> 
> Guenter
> 
>> ---
>>   drivers/of/unittest.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 6d80f474c8f2..b61a33f30a56 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -780,7 +780,7 @@ static void __init of_unittest_parse_interrupts(void)
>>       for (i = 0; i < 4; i++) {
>>           bool passed = true;
>>   -        args.args_count = 0;
>> +        memset(&args, 0, sizeof(args));
>>           rc = of_irq_parse_one(np, i, &args);
>>             passed &= !rc;
>> @@ -801,7 +801,7 @@ static void __init of_unittest_parse_interrupts(void)
>>       for (i = 0; i < 4; i++) {
>>           bool passed = true;
>>   -        args.args_count = 0;
>> +        memset(&args, 0, sizeof(args));
>>           rc = of_irq_parse_one(np, i, &args);
>>             /* Test the values from tests-phandle.dtsi */
>> @@ -854,6 +854,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
>>       for (i = 0; i < 7; i++) {
>>           bool passed = true;
>>   +        memset(&args, 0, sizeof(args));
>>           rc = of_irq_parse_one(np, i, &args);
>>             /* Test the values from tests-phandle.dtsi */
>>
> 
> 

