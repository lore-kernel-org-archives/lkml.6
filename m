Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E4E21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsMXxXPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E4E21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403770AbeHGQzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:55:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39362 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeHGQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:55:18 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so23256684ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UX8XBZRvhUz86zxdM656EB6rA/52yupBdC9TsQt3l8M=;
        b=EsMXxXPQt8LhRjSnWsa4mEaZgnUCUnGP5Ryir1PGG8LCLAw9zkEPVXVQhVeSNmO8qV
         UVcsn/7JtymH55tIV8prMDwEF96r1FK5rwS47jwGwt479hmXQcLvRhe+POQyZ32qaeG7
         zzuvMTNMXcNXaprQzfCAbr4t7/2q7Y/uqlA/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UX8XBZRvhUz86zxdM656EB6rA/52yupBdC9TsQt3l8M=;
        b=rhkNOG7kGi2mwsWgAaoTNFksMlthAHDjB1rHo8zz5P54t7Kcxzwqair5VfrZkvD5ja
         XebI0XqtJ+CZ9Xll2XAllWHynI/ejqL2qk4YWK1+h8cB7zik6SI9WuBO34Is/b/xYCJU
         Pa5bO+vD6xipxFszECaV7gUFYzWJCCcyHpZKhhHi3ZXfB2vbUNepTJt77sSiTvIl/weJ
         6Q7pdEDESfFVNlkGdC6U6id7qOxzUotHC+lR3bRfekjCYGHYUhbi8lHlExcIhhCyHRV6
         qgES6C0reRx62EQgmWA2V+tKSj/K8Np8hLEBMCjrJ8n1OZZpjl7r7hX6BYhrPcQdz6rm
         q75Q==
X-Gm-Message-State: AOUpUlF/EkapWG6sPODAWCs5yXdceu0KGja1809Px/FhwQQu7W0Hu+16
        lnRmV9DDmqwfpCjRvdHBUybFBbPItEj0Lc6FTj8d7A==
X-Google-Smtp-Source: AA+uWPwq3efqIcK2XtPpG8pPazatIJa6doltiCPddJrjN4QicAjuxG3KEmYBSP5OaTnrR8Ryqs0OW4Lv7S8j1pnYjlw=
X-Received: by 2002:a24:148c:: with SMTP id 134-v6mr2150990itg.50.1533652840170;
 Tue, 07 Aug 2018 07:40:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 07:40:39 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808071010240.11209@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
 <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com> <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_y6La77sWOSROrwfRy65jrFVYVvRZt+ewNheYhdhHCkQ@mail.gmail.com>
 <alpine.LRH.2.02.1808060626060.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu87YqLM=FFZ6V8rHhuhskDdsBUuXFpqNKVbXWqdnuNEyA@mail.gmail.com>
 <alpine.LRH.2.02.1808060639200.2986@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8HyHX8qjg1qHV2M9Re+RGQJigjdAFVC_yR4niGkk2ikA@mail.gmail.com>
 <alpine.LRH.2.02.1808060700070.10220@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8384LZwL898wJ8BKjmJNzvd+-cSFUp4X4OpfmRDCP4Ng@mail.gmail.com> <alpine.LRH.2.02.1808071010240.11209@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Aug 2018 16:40:39 +0200
Message-ID: <CAKv+Gu_h6DDW4tvECrj3rGUaii4-2audYpYYiJQXfbEMch2pDg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 August 2018 at 16:14, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 6 Aug 2018, Ard Biesheuvel wrote:
>
>> No that works fine for me. VDPAU acceleration works as well, but it
>> depends on your chromium build whether it can actually use it, I
>> think? In any case, mplayer can use vdpau to play 1080p h264 without
>> breaking a sweat on this system.
>>
>> Note that the VDPAU driver also relies on memory semantics, i.e., it
>> may use DC ZVA (zero cacheline) instructions which are not permitted
>> on device mappings. This is probably just glibc's memset() being
>> invoked, but I remember hitting this on another PCIe-impaired arm64
>> system with Synopsys PCIe IP
>
> DC ZVA can be disabled with the SCTRL_EL1.DZE bit, so that neither kernel
> nor userspace will use it.

Of course, but only the OS can do that, and only system wide unless
we're eager to create infrastructure for managing this per process.

But it is also beside the point: I mentioned it to illustrate that
even use cases like libvdpau that don't operate on the 'framebuffer'
abstraction make assumptions about VRAM having true memory semantics.

> If the mapping didn't support unaligned writes,
> it would be worse.
>
> Mikulas
