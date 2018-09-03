Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B1C20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLwx2t/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B1C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeICX54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:57:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeICX54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:57:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so519331pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Kwt6wKBYtuIpq7OrcClb/r76N64a1fTMJK3dhzkGxk=;
        b=fLwx2t/qmZhFVlZMcauI2unimQMFvqSqyeGTUT4CbEfLTO9XO3IE8BW9Wkh+a+4oMF
         cZXHLjWdXwoHGijE7MAhcRDroNKy9oBwE30UaBZCBh1W7TFks28vaPlphkWy1YPzuUJ8
         kiMyr/6mRBvBHmHBhAArDUy11N9cjJNIbTeOHAwLfvvZdRTaE4SD1dzlt9fREQiIKdVs
         e5oRfTt2O2gwFDBYhzxvUe4rphb8Afbj1zJdHp0ySaD+UozjzkVqBHBYeow69GeeOQdr
         DudnUyYh4bVuL0VaQvVCe2K4Bo3NAqR8K5IkNXEPSsiLFOsOzdZVnWwVsrXm7rVLI74a
         EAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Kwt6wKBYtuIpq7OrcClb/r76N64a1fTMJK3dhzkGxk=;
        b=TOr/k8BxjSZPUh36TMofjSWmiOOWCteWL4TcTOJaLbCrkeiiOy0N0jA5X4T6yMePBZ
         Kau5Q6GG7Z1oLu+Bve3ByVN5JGq5/YOM2G8KxVo01NGrH/YGkTapy31JYbGLGYhwjRPx
         0gRuNx1OPyacCR7vUyNoNqLGYF6nRxtib8uulOmaih2a8q2u91Il3yxC/Y/UF+TsQWA8
         Ny6z6pRLwGNRheNbwQ5HqzSG3lLiTLqtWGTNONGYd+cgCrgtZOGuBt1ge6RkYIkw7iHW
         H6YTEWn0h7ZYZqEK8m3uqwwT80RIXP7p0lnPucMIvjxNbG1MY5GmMCZ79PScQeKcwfqZ
         OOgw==
X-Gm-Message-State: APzg51BBfbh91H0jKtiNxSPhQTP21qCFzGWl0vcFWtrfUR0qeYwUNmYl
        PTZ7qsAXiEK4c20p08nbTmMk/CgV
X-Google-Smtp-Source: ANB0Vda4RqACOoT/rpPdGAiC+S6g26sGlQRZMHKpxYSX3udQsCaHtJg/FM8Du5TjOMXHoybQ8vJeCQ==
X-Received: by 2002:a63:cc4f:: with SMTP id q15-v6mr27282349pgi.217.1536003377343;
        Mon, 03 Sep 2018 12:36:17 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 1-v6sm37276124pfk.134.2018.09.03.12.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:36:16 -0700 (PDT)
Subject: Re: Linux 4.19-rc2
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
 <20180903182202.GA14258@roeck-us.net>
 <20180903.120910.2227273252885975717.davem@davemloft.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <236bb7e7-2f9e-880d-a30e-9acf9bdc9bcf@roeck-us.net>
Date:   Mon, 3 Sep 2018 12:36:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903.120910.2227273252885975717.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 12:09 PM, David Miller wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Mon, 3 Sep 2018 11:22:02 -0700
> 
>> The sparc32:allmodconfig build problem is the same as last week.
>> David - any interest/plan to get this fixed, or should I just drop
>> the build ?
> 
> I didn't see it, please give me a reference to the details.
> 

arch/sparc/kernel/head_32.o: In function `current_pc':
arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
arch/sparc/kernel/head_32.o: In function `halt_notsup':
arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5100): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
arch/sparc/kernel/head_32.o: In function `leon_init':
arch/sparc/kernel/.tmp_head_32.o:(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o
arch/sparc/kernel/process_32.o:(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/process_32.o:(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x28): additional relocation overflows omitted from the output
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

The most recent log is at
	https://kerneltests.org/builders/hwmon-sparc32-master/builds/1024/steps/buildcommand/logs/stdio

Build history is at
	https://kerneltests.org/builders/hwmon-sparc32-master

Guenter
