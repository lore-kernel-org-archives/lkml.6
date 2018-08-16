Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FACC2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swjp3n+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FACC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeHPVbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:31:15 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:35602 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeHPVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:31:15 -0400
Received: by mail-lf1-f53.google.com with SMTP id f18-v6so4115009lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ktzv3kTKY5QCj7GNk1fGI62IU2SEdP82ENqEsGHgJk=;
        b=swjp3n+JtFrKnBooaEMmjQ2n001MmLlo5kJE81KAicqyh2s2oLmvgake3tTBxVzp/0
         X17wqfRftW9+fZ61e+VOIJIAfXvsJ8AuBllfLvyA6jLrVBLu62Dg78/DFUFZu2MgDyPn
         KwZNxmTPI/Scm1MT7ga3wSXJXPhcexFxSLUTumoOEowAtvRTTr0ss13lNeUCDtFhZA81
         /43o3pnF45+JQwUK+zEl2KAt3NaYaGnDd3adqPNSXltlsxMOM34kk9/+/waslnjYDvwj
         qfty0gTSGluH7i+H0Q1nvqCt+C4ycDdFpiAXOuz8Z27bo2TgSt+0WhF9sxQoXjZXOC5C
         ZKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ktzv3kTKY5QCj7GNk1fGI62IU2SEdP82ENqEsGHgJk=;
        b=FhjOMrZ5S+8cmhw5HbqOpLhkEdBTKBGwsW3/E20dESTytG/GSn+ntxD6Yxa5ualLpM
         vsK9OFhgyqUiBDHN8XUfe+VMOM+9Ws3xzrslJHzGF+jRWa0uJfaH3NGQ7BDAjS3a1f4s
         ITet2t6N0UqIfrY4dTiRiAM1F6d/20sXwRXJgiIZ9NaN/+cBXg8tAZ7hxX9ftQ3A71hu
         kSsg2boqQeoIIHkGHKTh/cEmLEzTVayNAgoF1FSSyag9y26/YziSrk7F/5efZ7xtkmnK
         XpBY+BjuBcIWZOI4NeGEx5XSSgrwXqkYnzmPeumgA7Fu1KhW0IxC7NlpADRmlMor9A6E
         zhqQ==
X-Gm-Message-State: AOUpUlGxqI1FBWY7JON0a4P2gw9xD7DStet9EKLk/59AfVpYmUfyGFqz
        leaRdXx/IheBVdQBCJnYO1Jfxcnyaao=
X-Google-Smtp-Source: AA+uWPxN60nTx6c119jPjMx+gQcQ+SyWzhx6n+aiKZaW7seEzmmNOoKDM+mabub6PizpTUZhM43xlg==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr20720445lfc.59.1534444269194;
        Thu, 16 Aug 2018 11:31:09 -0700 (PDT)
Received: from [10.112.23.205] (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2370lfs.44.2018.08.16.11.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 11:31:08 -0700 (PDT)
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Message-ID: <66fdd8a7-22ed-71f8-f0a0-119f9b495a94@iki.fi>
Date:   Thu, 16 Aug 2018 21:31:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180816102219.GF31093@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/16/2018 01:22 PM, Will Deacon wrote:
> Hi Tuomas, [+John]
> 
> On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
>> Booting Linus's master of today with the usual arm64 defconfig fails for
>> me on the Hikey960 board. I've bisected it down to:
>>
>> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Jun 19 17:55:28 2018 +0100
>>
>>      arm64: insn: Don't fallback on nosync path for general insn patching
>>
>> Here's the boot log with earlycon enabled after which the boot hangs:
> 
> Thanks for the boot log, that's really helpful. Please can you try the diff
> below?
> 

Thanks for the quick response, that indeed fixes it. If you need more tags:

Reported-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Tested-by: Tuomas Tynkkynen <tuomas@tuxera.com>

- Tuomas
