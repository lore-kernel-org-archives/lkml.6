Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1DB64C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71C42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HXY3FJRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71C42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbeFLTiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:38:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34753 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754181AbeFLTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:38:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so69223pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Tg30631c7VsW83EyQ4zCQyWRcvmxf/UhwcvkSz+5aHw=;
        b=HXY3FJRw0mLWgEwY+STnQSmPBtb9POdAYK9Vgz5BH5Fzx1aukt/TuwLw8HWcRWjc84
         G4lxcDPx6yt9EYex0V3vqxGr2BkxpXflX8a5h+qJ4zLvwy7Mk+KvVQzFb9UgtKdstIwr
         QgTKIPPTdkeBmXda9/1JcMxOvD5kZiDDzLMmI5kII25LGSmjJMWZuqdD8CuH0o8ZgnDN
         tbByA85oPj08G41kZVNahl0f0e3VlEQqq2iDXmv/eTcRfZUq9yWK/C80vnF2OxW9U92j
         uQQqRXrVV1tPlYzsR3Glv7WzgEPmnGmxFZoC2lAY0dXt/KjR7jMnXdA84jeLrrnwOtpG
         DgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Tg30631c7VsW83EyQ4zCQyWRcvmxf/UhwcvkSz+5aHw=;
        b=ZJ8aUvwU9iHiLGp2n6r6vbNAMqd/trohH8za26lGX9ceqgw1phsYM92ALpNOf8Dazw
         eViJWEIPKD19VrSe4Nz4mfMFbxw8K4ocKBnsPa/ya137dnlDxHJZEwi1T0f0TJvOWXQY
         J2X9D8LLib2PllW0vnIVhrH6kC+4Kjc0PAiXWp9z93Yk8IjdJBiGzxKXXDKOqpGqj6Nf
         bmTSwrY3W0lDVTYLPJ5a1rTtyYPZAqGAjgTgFpJ8Mo6TGDVyYESGzdM3NldpW7u3tAQc
         idW3+zdN/lQGVy2mqcsL9csgBB6CY7RvSO5/w9Y+fTQGyYFXi/rWqtVT8H1WNubYCyPx
         JZ6w==
X-Gm-Message-State: APt69E0wj8bXKuzN+KZ0LPEem7n6fuwRO4f4BTNVZnRVlftvA8d4ZAMa
        R1o6Cx5GGG7zUp99r61hszwnsg==
X-Google-Smtp-Source: ADUXVKJeiicEm4k9xBtIZS01upIk+DlkyMnohRWl310hhfnh+I0Rp0uu0PcRcMofLBp/9KsQmj2f/A==
X-Received: by 2002:a62:234a:: with SMTP id j71-v6mr1707174pfj.221.1528832292205;
        Tue, 12 Jun 2018 12:38:12 -0700 (PDT)
Received: from localhost ([73.93.152.169])
        by smtp.gmail.com with ESMTPSA id k129-v6sm890796pga.94.2018.06.12.12.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 12:38:11 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:38:11 -0700 (PDT)
X-Google-Original-Date: Tue, 12 Jun 2018 12:36:54 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <CAMHZB6E3Jcvni=nsxvOB-+g8sDGCvEV2G2q2+3XrJJy7f__-eg@mail.gmail.com>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luc.vanoostenryck@gmail.com
Message-ID: <mhng-8a2f58a2-6c49-43bb-a7dc-51f2f8ff8e8f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 11:19:57 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Tue, Jun 12, 2018 at 7:12 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Mon, 11 Jun 2018 20:00:08 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>>> On Mon, Jun 11, 2018 at 12:01:37PM -0700, Palmer Dabbelt wrote:
>>>>
>>>> OK, I'll try and figure out what's going on.  We've had a handful of
>>>> headaches trying to get things like '.align 2; .align 2' to actually
>>>> produce
>>>> no NOPs for the second alignment directive, which is surprisingly
>>>> complicated due to the aggressive linker relaxation we do.
>>>
>>>
>>> OK. I imagine indeed but note that no linker is involved here so,
>>> if the problem is still present, it must already be in the assembler.
>>
>>
>> Ah, OK -- in that case then it's just not a bug.  In RISC-V land we handle
>> alignment as part of relaxation in the linker, so if you're looking at the
>> output of the assembler then you'll always see a bunch of NOPs for every
>> alignment directive.  If you 'objdump -dr' you should be able to see the
>> relocations that get emitted, there should be a R_RISCV_ALIGN that points to
>> the run of NOPs.
>
> Ah OK. Indeed I see the R_RISCV_ALIGN.
> Thanks for the explanation.

No problem.  There's heaps of info about this in some blog posts I made a while 
ago if you're interested.
