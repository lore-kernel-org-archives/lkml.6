Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A665C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A1820840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmgIz1HC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A1820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeKACcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:32:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeKACcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:32:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so108364wmd.0;
        Wed, 31 Oct 2018 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZ12E055JCqj1MgnClY22EyaDaqCyPp7Wq1FaEXkFFk=;
        b=fmgIz1HCtn915UwKz85pPFrslyhF5cgmSucIozwaRqRZfRjOlUkN5RtXX4rCbg+iV9
         JQdeONoZkIACWu+jbxdOpCFpAgh5GzCnoyrJewe43sjvvsURe3WiNpZvvzJLXtngQxeb
         m+GLUcgeuyZk9gy/ywILkcP5WJ/v9f2kOFUEW+6urctFRS7WLA/7zhp5KO06jvcrTP9V
         uqPgTGe1khJoZwkj711wdSKTaW7b0OiESXCsBhGXB7moYtSa7dPanuPxLOIAw/S0RwvJ
         1wL3ta9UXHukWXErmaL/tK47/LxVszkFkaYyil8d41rGd+UazWaNJ7Chv1xmnbzpNi7/
         1gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TZ12E055JCqj1MgnClY22EyaDaqCyPp7Wq1FaEXkFFk=;
        b=URHqNthBtIyJJRINYlIhf/tZ2fX6afAlQibQ5l4rxo/1JaD3oRxwbt4AxbNAd83DnA
         rDaLzcSHYapl7a8eOyb9dayvILkCfa1kKOfrCfzyU1VZoU6O5RWjfwIA5vKGc7NXmMts
         VKDhyZonsX0H2QVVE4TkNpej/UTOzaO+STNJLaOi3PErNLjET57F/In/p7MXUeF85q+F
         zABg8cBO/SDGmJEseKGRT0iygoU86kWk1lxr4lo9NvrNBy3BKcKsB6N55KdxEdJ7Cfrp
         ccW1vSaSwXuSHja0+aIuq3Y9LRCdZG2Z56GxtKANXH3bQ+P5lEpwFCAWhO0T5RjTuANU
         mMTw==
X-Gm-Message-State: AGRZ1gINTQw3yHw0oX1kNwFtl4quWIS11nYO588CXtTKU3kF3n+I3qfP
        YLEXdVuxvXgWYSSI81FkJ/A=
X-Google-Smtp-Source: AJdET5e7d3epgTrad6Oqx2Wgdll9c/oA2ekmK9FMWzG7lEqNb90W8TNgaJ6XsWc1XGPhhs80+sCkSw==
X-Received: by 2002:a1c:6:: with SMTP id 6-v6mr3077760wma.126.1541007201733;
        Wed, 31 Oct 2018 10:33:21 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id o15-v6sm387739wrw.47.2018.10.31.10.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 10:33:20 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
References: <20181030230721.28429-1-f.fainelli@gmail.com>
 <20181030230721.28429-5-f.fainelli@gmail.com>
 <20181031070350.GA12503@rapoport-lnx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ae4cfe6b-8df8-7737-e7e0-9471bd131a67@gmail.com>
Date:   Wed, 31 Oct 2018 10:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031070350.GA12503@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 12:03 AM, Mike Rapoport wrote:
> On Tue, Oct 30, 2018 at 04:07:19PM -0700, Florian Fainelli wrote:
>> ARM64 is the only architecture that re-defines
>> __early_init_dt_declare_initrd() in order for that function to populate
>> initrd_start/initrd_end with physical addresses instead of virtual
>> addresses. Instead of having an override we can leverage
>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>> populate those variables for us.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm64/mm/init.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 3cf87341859f..e95cee656a55 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>  	if (*endp == ',') {
>>  		size = memparse(endp + 1, NULL);
>>  
>> -		initrd_start = start;
>> -		initrd_end = start + size;
>> +		phys_initrd_start = start;
>> +		phys_initrd_size = size;
>>  	}
>>  	return 0;
>>  }
>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>  		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>  	}
>>  
>> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>  		/*
>>  		 * Add back the memory we just removed if it results in the
>>  		 * initrd to become inaccessible via the linear mapping.
>>  		 * Otherwise, this is a no-op
>>  		 */
>> -		u64 base = initrd_start & PAGE_MASK;
>> -		u64 size = PAGE_ALIGN(initrd_end) - base;
>> +		u64 base = phys_initrd_start & PAGE_MASK;
>> +		u64 size = PAGE_ALIGN(phys_initrd_size);
>>  
>>  		/*
>>  		 * We can only add back the initrd memory if we don't end up
>> @@ -460,13 +460,10 @@ void __init arm64_memblock_init(void)
>>  	 */
>>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> -	if (initrd_start) {
> 
> There may be no initrd at all, so the condition here would rather become
> 
> 	if (phys_initrd_start)

Or use phys_initrd_size, which would be consistent with how other
architectures typically test for this.

> 
>> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
>> -
>> -		/* the generic initrd code expects virtual addresses */
>> -		initrd_start = __phys_to_virt(initrd_start);
>> -		initrd_end = __phys_to_virt(initrd_end);
>> -	}
>> +	/* the generic initrd code expects virtual addresses */
>> +	initrd_start = __phys_to_virt(phys_initrd_start);
>> +	initrd_end = initrd_start + phys_initrd_size;
>> +	initrd_below_start_ok = 0;
>>  #endif
> 
> I also wonder what is the reason to keep memstart_addr randomization and
> initrd setup interleaved?
> 
> What we have now is roughly:
> 
> 1) set memstart_addr
> 2) enforce memory_limit
> 3) reserve initrd
> 4) randomize memstart_addr
> 5) reserve text + data
> 6) reserve initrd again and set virtual addresses of initrd_{start,end}
> 
> Maybe it's possible to merge (3) into (6) ?

That's kind of orthogonal to this patch series, but it's a valid
question, not sure I would want to tackle that just now though :)
-- 
Florian
