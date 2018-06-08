Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pmERMUcEG1soLgAAmS7hNA
	; Fri, 08 Jun 2018 22:34:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF5D96089E; Fri,  8 Jun 2018 22:33:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QvN2/Fwk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 380E7601B4;
	Fri,  8 Jun 2018 22:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 380E7601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeFHWd4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:33:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41440 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeFHWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:33:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so7300674pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VpGdfL/yVNmPGPalESPmJER/HpMk9feRIIX49+mVX68=;
        b=QvN2/Fwk0Vj44AAFiOordN8yMJkvc9sSN04j0aR2is1K7Oo3NICVNo0sunhP9OD5iC
         /9scNaSqkLX0zES3zw5ds4DdNj+z7rV5jELJfoWzjzfjtN5+1Z4WvAbMiFjsTzKu4bXD
         7Bo5/s0TGkRepGsSgU9xFkERfJzEqOJMWu3bjzN69goJRkt2jrKxIJmmQnP08b84Yp+H
         M0dhK/GbaDBAlhkJa4eW75vypDD42YmCXpvoiFZroi+hKuZsgegLa1b6ikVx4KyiYQs2
         0L3SO7XOleS9EGFcrhJbsccEVFC4SKkCanXZyh32S3MbMJr0ZW1055TBrcThBzm8cfr8
         touw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VpGdfL/yVNmPGPalESPmJER/HpMk9feRIIX49+mVX68=;
        b=qrq+d+tRXulfEi2fojshoLFZZ6gz44dzc6cck2ErxeYiP/yjGPGgBd5Jiz7OfKp/Y7
         sZQGOp5CrKJCX8onDYa1rBpRueIDhlMNmH74GqAP/PKapahSm4xVEGnLBcXXAfYXoUqF
         37iMpKbbnOyQH3TuBP//ZNiPWYX5r6NabKXN4vO869pzn1WfUvkWLj8SB9G5njOt/0ro
         tjLAUOZ6CYQkqPtzKkt/TqFEqWf/FBMfvyWtZ8VX9IRfWdJqDYwgsnKmELd5WnQV2pRD
         6xHAkQ2z3jHUY3Vqy8jZhdgVvkfjwEdpLKIyEk3QYSZSS18kU+/ZSoprm57YRR5gFTW8
         tGSQ==
X-Gm-Message-State: APt69E0Lgm22P+6co2CU19sRzByW3VN5Knyiz8vWi3LbnGUrQqNDHIOk
        L3RgUujX6Ft+fi5k5sZnE40rLw==
X-Google-Smtp-Source: ADUXVKIWSGMDlZ1/KpO4nw8tXxcBmR1BZMDHgavhutySZ0oKPDTFHCYaUs9B9O7ts4KpaAXLGzN6bw==
X-Received: by 2002:a62:d388:: with SMTP id z8-v6mr7849437pfk.8.1528497232329;
        Fri, 08 Jun 2018 15:33:52 -0700 (PDT)
Received: from localhost ([73.93.152.77])
        by smtp.gmail.com with ESMTPSA id z82-v6sm40348662pfk.30.2018.06.08.15.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:33:51 -0700 (PDT)
Date: Fri, 08 Jun 2018 15:33:51 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Jun 2018 13:22:15 PDT (-0700)
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
In-Reply-To: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
CC: ynorov@caviumnetworks.com, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, szabolcs.nagy@arm.com,
        heiko.carstens@de.ibm.com, philipp.tomsich@theobroma-systems.com,
        joseph@codesourcery.com, sellcey@caviumnetworks.com,
        Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de,
        bamv2005@gmail.com, geert@linux-m68k.org, Dave.Martin@arm.com,
        kilobyte@angband.pl, manuel.montezelo@gmail.com,
        james.hogan@imgtec.com, cmetcalf@mellanox.com, pinskia@gmail.com,
        linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org,
        maxim.kuvyrkov@linaro.org, fweimer@redhat.com,
        Nathan_Lynch@mentor.com, james.morse@arm.com,
        ramana.gcc@googlemail.com, schwidefsky@de.ibm.com,
        davem@davemloft.net, christoph.muellner@theobroma-systems.com
From: Palmer Dabbelt <palmer@sifive.com>
To: catalin.marinas@arm.com
Message-ID: <mhng-e1922456-a05b-46f9-8644-d45ad70a55e5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018 10:32:07 PDT (-0700), catalin.marinas@arm.com wrote:
> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 76c0b54443b1..ee079244dc3c 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>>  	bool
>>
>> +config ARCH_32BIT_OFF_T
>> +	bool
>> +	depends on !64BIT
>> +	help
>> +	  All new 32-bit architectures should have 64-bit off_t type on
>> +	  userspace side which corresponds to the loff_t kernel type. This
>> +	  is the requirement for modern ABIs. Some existing architectures
>> +	  already have 32-bit off_t. This option is enabled for all such
>> +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
>> +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
>> +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
>> +	  unicore32, x86_32 and xtensa. This is the complete list. Any
>> +	  new 32-bit architecture should declare 64-bit off_t type on user
>> +	  side and so should not enable this option.
>
> Do you know if this is the case for riscv and nds32, merged in the
> meantime? If not, I suggest you drop this patch altogether and just
> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> "all new 32-bit architectures should have 64-bit off_t".

We (RISC-V) don't have support for rv32i in glibc yet, so there really isn't a 
fixed ABI there yet.  From my understanding the rv32i port as it currently 
stands has a 32-bit off_t (via __kernel_off_t being defined as long), so this 
change would technically be a kernel ABI break.

Since we don't have rv32i glibc yet I'm not fundamentally opposed to an ABI 
break.  Is there a concrete advantage to this?
