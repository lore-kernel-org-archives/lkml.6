Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661DD208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKPWpRLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661DD208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbeHAPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:01:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40331 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389256AbeHAPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:01:46 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so9217727ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QRwr3HK7nt0hGQKlW4/QGEnnlhLebhT7hwSbjCz6vh4=;
        b=dKPWpRLewCctKBhIttr1QfDzsKcsCU0zg+NuzxJYqUtJf6MiU8Eg8BHnqJFHoVaST1
         PU2ToXuTUrgNfuuZ+te4D/NROVLpcNGv/Gx9F4OqhRy8QdqH/Acsc+20MsBNaOPEvZIK
         AIkqJvjC7m5DEYt9na5ddnMgswoL32EIscetle05S4cHYOaW7cVaFsbQqxC5y6OMcZ2h
         ovnI9206Wvma/v4DLcQrJr1MPviL9plg0pdrCbzwpfXiXaCsKxVBeqtJ0cag0pyYGnQj
         saLNNLsGPJEu1rXMK5qMNjPlG2olktPh0VY1ermoMniu5QkSaLVBfkNNXRzMGm/51SXa
         iVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRwr3HK7nt0hGQKlW4/QGEnnlhLebhT7hwSbjCz6vh4=;
        b=BMDgcG7UvF92eKuTivZnDNAMJIBKkH+VoZmh15b1rkRr5Wu7jeWN7x+se7qIJgRzF7
         vfLTw4lTeqisD8lSGevv62whaZy68xFzRo/xGqqB1uGE0HU68s8T/ZsuvKnAtHsSm5qZ
         PrCkncRkAlyDNuOdRGuHdDkBySj0PuYSL6/9g/xTRXEPz9rRyPgKrrSZLU80prTQrzQO
         rbwGNqOdjzp21Y1eq9OhvNCQLY5545ZXJpQVC5YW3M/jWhYzb0azM/01kHX8DsiXvjjp
         EOdD9wYTi0XcJnmqHXGEDQDUDBM/mcNk652VRF5zoghynbLIDelDI5xZQ3eqoR3R3+7g
         O86g==
X-Gm-Message-State: AOUpUlEIXh29qauuIDmGWi5xqYEmMKrKpJR8BvdXBxUlCCP9sWCCP7Cj
        u2CyNO/ohKUcQmmCEP27Tt5vIckdmJA=
X-Google-Smtp-Source: AAOMgpcSAivVEyJEXin2WtTYvPcsVGH8NRW5xKI+GQvpyXnTtTXDztv2XiVnCT+nK8nUOg5XvKddew==
X-Received: by 2002:a02:b468:: with SMTP id w37-v6mr23179683jaj.18.1533129361070;
        Wed, 01 Aug 2018 06:16:01 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id i9-v6sm5194147iom.19.2018.08.01.06.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 06:16:00 -0700 (PDT)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Christoph Hellwig <hch@infradead.org>,
        Alexei Colin <acolin@isi.edu>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
Date:   Wed, 1 Aug 2018 09:15:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801095404.GA17585@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
> 
> As said before, please include it from drivers/Kconfig so that _all_
> architectures supporting PCI (or other Rapidio attachements) get it
> and not some arbitrary selection of architectures.
> 
As it was replied earlier this is not a random selection of 
architectures but only ones that implement support for RapidIO as system 
bus. If other architectures choose to adopt RapidIO we will include them 
as well.

On some platforms RapidIO can be the only system bus available replacing 
PCI/PCIe or RapidIO can coexist with PCIe.

As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or 
"Bus Support" (ARMs) sub-menu and from system configuration option it 
should be kept this way.

Current location of RAPIDIO configuration option is familiar to users of 
PowerPC and x86 platforms, and is similarly available in some ARM 
manufacturers kernel code trees.

drivers/Kconfig will be used for configuring drivers for peripheral 
RapidIO devices if/when such device drivers will be published.


