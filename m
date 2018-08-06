Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85527C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE10219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JGciRXfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE10219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHFKM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:12:26 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:41671 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeHFKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:12:26 -0400
Received: by mail-ua0-f172.google.com with SMTP id h1-v6so11127368uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qDiEAsd4sD7TfPwTQq1ZenGDEl1JnbBUz+7ehXskaI4=;
        b=JGciRXfE0hLp3JNumr6zehoaYKdQgpltCYrKA/lUoLOix0Qc39XGdi8fqNaH8BZg2l
         ZzSdI20Vww6wAG5Yh7vpXa0x4bku4BOQCLHhrOidFRF7MZsk4jwR/Tc7xcrWanMFrLYf
         4Y9ZbMAw4P//yfADifsRpRAnOM66zN1g36jCTycKp7hA7X9yzEI2dSQKDaZDTvfbCj5G
         oozK1MW4KWWSSBbK3CtT27z2+eo1SeHxhpDxAugN1InJHlu4b3bG4UWAcx7noVE0F5M8
         MNlXHHGuTReWAS3ArFww5Q3IRZOarlhPSws/CwEYCCn6ytc/bZthEVKr3oscvcevj2BT
         ECoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qDiEAsd4sD7TfPwTQq1ZenGDEl1JnbBUz+7ehXskaI4=;
        b=TvKdz719e0Nj054zSerQP7iVKD16yNs8ZFBgGGe0J1o6S6VaNS7Q2pq9EViw7dqV7x
         FVM+hujVhgP36NbDdM8Tp5HEhpHieLeiVuyt/u4Io4bFbmGmZBiRmxL+NLX85gAOHEIK
         WedFGohijDXn5s5hzy7NH8zPkJfmCpo+TEgGldlA8OTEUJiUVBtaGA3Jyy5yXg6zfoEN
         mrHa95dxvshATLEhCSOjuvKe3ggwyKBTf2CyLWkqhXRmGxm6FSKIAX0sPAifu7KzybFa
         dX1IEekzdQmn8Cl46oUoc2cFHQH1LQrB9UQlXIfdnQKTxotXBiStrtjqkhu4EjiEu6Cq
         1qFA==
X-Gm-Message-State: AOUpUlFiNUqX158CYUP4RPyFED9UopyEMAuLFDkzYJRAQMDKYaWnWEQy
        pOGck6yp9Xs0NKoCeFN143Hx5mK2cSdNQI/VRvh2XrSU
X-Google-Smtp-Source: AAOMgpf8DPecInfqzCttHcIRle0iEZpbct04cRM5LDYo1rn7uxgDc9l7HbQKm+483qMbAQUd92z2LOj9mSNrAJ9F4xw=
X-Received: by 2002:a1f:6307:: with SMTP id x7-v6mr8660864vkb.111.1533542674455;
 Mon, 06 Aug 2018 01:04:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6044:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:04:33 -0700 (PDT)
In-Reply-To: <20180805213615.GA1862@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <20180805213615.GA1862@amd>
From:   Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Date:   Mon, 6 Aug 2018 09:04:33 +0100
Message-ID: <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Pinski <pinskia@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
>> > strange problem.
>> >
>> > When I use the links browser in graphics mode on the framebuffer, I get
>> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
>> > on the framebuffer - nothing else.
>> >
>> > I found out that the pixel corruption is caused by overlapping unaligned
>> > stp instructions inside memcpy. In order to avoid branching, the arm64
>> > memcpy implementation may write the same destination twice with different
>> > alignment. If I put "dmb sy" between the overlapping stp instructions, the
>> > pixel corruption goes away.
>> >
>> > This seems like a hardware bug. Is it a known errata? Do you have any
>> > workarounds for it?
>>
>> Yes fix Links not to use memcpy on the framebuffer.
>> It is undefined behavior to use device memory with memcpy.
>
> No, I don't think so. Why do you think so?

It is undefined behaviour in the architecture.


Ramana
