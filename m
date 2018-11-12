Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06ED22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvcU4lcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06ED22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeKMG16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:27:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMG15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:27:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id u5-v6so5553934wrn.9;
        Mon, 12 Nov 2018 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UEUxBCUBBKLzz/inVtNPgSNGob4HsvbDhQ191EPFvA4=;
        b=OvcU4lcKNtd+Z+IJWyTsKIjCvHFobmzxItn4jBpQH+40IAOdaGVfF6biWwOVzXLr3I
         zpEd4l7Isqc6iy+1uuQ1ZKy3rKQX3BuqfFg5UGnvBpO19c1Qil6rf/2zw3k4wxVUyCwR
         Fy1+Ls+z/g9leTzxL8AxtepLKen5oVUWD+uPDvOgL9cPqiyVaY+VmvOyqbiAKf2Lfs7M
         wYYF5tpa3Eh50j4PdhxLgilyMz9Quq8kmkubTzuT/m2QIufCfYycChHvEuDi65YxTYWQ
         8Qm918TsuKGYpvbObJ6WmspNS5cSP74iZtlpnJ7QLFF9x9MZ+0hMHQGZs7epAn7RCS69
         buwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UEUxBCUBBKLzz/inVtNPgSNGob4HsvbDhQ191EPFvA4=;
        b=bxcIjaU3AfEE0mlbYfuofITfUEdcTTHDgLFPHT9/xjP2vAhzjImZv+/esLTybalVct
         /cB5AZ6UJKUJfX6co48ZKkLt6OGrUUKebvCkI5Y/J19+rmF6q2l/NIBh8OgVKjmtEU0S
         L3WCVU45uMMpBKDlrxi0TZFNtVv6BBzzqDFcvBTjI3RCww0+fID5YB5jy/qQhmut1Tk1
         K4XdpgQE5Kq8r3wjToEKXvCKOU4IH41Wf2e1Pjij5ExI6LScuIZWO1+DX7uujTFmzJbh
         FVLOtltO3NCjC/wDP0wBHbpD2Cvu9H5QlNRQEtzxGvcB8LQYvtTN3+8HNywtcA41xM6e
         29aw==
X-Gm-Message-State: AGRZ1gLOnsLuHFsaICqGdgCAg629qwfIcVMWvVJb5HAYniQNK4W9uzl+
        rFLnFmjkxhU3WR068FLFp/Y=
X-Google-Smtp-Source: AJdET5d2YZRjeOJmaHZB1RvQ2exKkBrcHn1y85J8n6NqfpL3tO7zTztUHL8wgmiKVyRzNCvGSY/Jug==
X-Received: by 2002:a5d:4f08:: with SMTP id c8-v6mr2119257wru.310.1542054784132;
        Mon, 12 Nov 2018 12:33:04 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z8-v6sm23963502wrr.94.2018.11.12.12.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:33:02 -0800 (PST)
Subject: Re: [PATCH v4 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
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
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181106140642.GA19280@rapoport-lnx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <68b32163-85ff-45f7-8887-60273da7c6e2@gmail.com>
Date:   Mon, 12 Nov 2018 12:32:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106140642.GA19280@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 6:06 AM, Mike Rapoport wrote:
> On Mon, Nov 05, 2018 at 02:54:25PM -0800, Florian Fainelli wrote:
>> Hi all,
>>
>> Changes in v4:
>>
>> - dropped initrd_below_start_ok assignment in ARM64, not necessary at
>>   all (Ard)
>> - replace #ifdef CONFIG_BLK_DEV_INITRD with if
>>   (IS_ENABLED(CONFIG_BLK_DEV_INITRD) for consistency with other parts
>>   of arm64_memblock_init() (Rob)
>>
>> Changes in v3:
>>
>> - use C conditionals in drivers/of/fdt.c
>> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
>>   whether initrd_start must be populated
>> - fixed a build warning with ARC that was just missing an (unsigned
>>   long) cast
>>
>> Changes in v2:
>>
>> - get rid of ARCH_HAS_PHYS_INITRD and instead define
>>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
>>
>> - make __early_init_dt_declare_initrd() account for ARM64 specific
>>   behavior with __va() when having CONFIG_DEBUG_VM enabled
>>
>> - consolidate early_initrd() command line parsing into
>>   init/do_mounts_initrd.c
>>
>> Because phys_initrd_start/phys_initrd_size are now compiled in
>> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
>> we need to be a bit careful about the uses throughout architecture
>> specific code.
>>
>> Previous discussions/submissions list here:
>>
>> v3:
>> https://www.spinics.net/lists/arm-kernel/msg683566.html
>> v2:
>> https://lkml.org/lkml/2018/10/25/4
>>
>> Florian Fainelli (6):
>>   nds32: Remove phys_initrd_start and phys_initrd_size
>>   arch: Make phys_initrd_start and phys_initrd_size global variables
>>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
>>   arm64: Utilize phys_initrd_start/phys_initrd_size
>>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
>>   arch: Move initrd= parsing into do_mounts_initrd.c
> 
> For the series:
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks Mike, Rob, do you want to merge that series through the OF tree?
-- 
Florian
