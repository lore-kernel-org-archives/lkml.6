Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC9C2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAV1Alqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC9C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeKGTUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:20:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41739 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:20:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so20164400qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BJq84/a5/nkl9JGGExc2GPSH9U5Gl2mha1VX6NO2L/w=;
        b=TAV1AlqaVMHwg/Znw/UHeL6gRqNkTUmfRxzmOq3vs1+ngjUDYo1uTnmAnjTzc2Bolm
         BnOjTkqQla/cL0XXWp17S0rPAEwhB+MvwXzCcYP0FAFYMVt7pPJb0zVbiGUizI5EaXoj
         9xLE9vfTHCR0F6OLRZd1xLoAy5n9HyrpcLDXh42VnGV+FijlCDuHekCyHA6c6nuNPpZU
         a2dwWwIU5NnXtcK1tm3rRrmKjmemD5EQv0vEPDqJQaLT8L/n4MrlKxfsmtzT6mkLfTif
         cz0lQlpRtizdSl1fBoRX1SoLes7uEfX/NwOHMYGLWwL1bmcvGZ91OhVXgDHM3suVFM8r
         qauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BJq84/a5/nkl9JGGExc2GPSH9U5Gl2mha1VX6NO2L/w=;
        b=rPFHLZlTJV4eywMVtx8N04pof2P69qRqH5Pu7DUi7RpaF3xsB4MpVCyQpcxGzbYAjs
         0KeFpI/mCZdXlf8LSF4EUjzDRXCdbrSdTFcNy+E41i7sivgFq68AdN73UPjQ5JlOHUlQ
         A8teatqHMcHFHjE8qK32Rm4NglQVk/sz/pgzMv7O/WHJA/IbZvqNLoWe4AI+HiCbqlAi
         +t/3d4J0gGgaVXJyhQQNNrg63pLV9A/lDmH8YDc2M1ZBvxT5/HsvyAKLugCanlHWnylW
         TxtHugqoPDzZsqzt6z9qeitaH5TC1GqElFe7obghxHp7PXgNJCNlsL7cNitaDC86HZYF
         3k9g==
X-Gm-Message-State: AGRZ1gLSjWW9uwMY2oK7iNsccTtlbYWQJroL5RP21diYBs3ftaneMkJl
        1CTexhnBd3sa5doXwQhCwhY5u+UlIgC4y+F7fSk=
X-Google-Smtp-Source: AJdET5e5iMMqrY432W6dIKyI8anemN5g31txn1Sp+2R557iBjNI0tUDKiR1MgTkPzzRgLmN3IutQJhQ9JCuYoNmwUEY=
X-Received: by 2002:a37:324a:: with SMTP id y71mr916649qky.291.1541584271725;
 Wed, 07 Nov 2018 01:51:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 01:51:11 -0800 (PST)
In-Reply-To: <mhng-19511b81-9f89-4a15-8b2f-d63779074fb4@palmer-si-x1c4>
References: <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
 <mhng-19511b81-9f89-4a15-8b2f-d63779074fb4@palmer-si-x1c4>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 10:51:11 +0100
X-Google-Sender-Auth: HIqzNzdoQ7BmDvG7NETbjR9Vl-w
Message-ID: <CAK8P3a1He1B2UHLEinzuPF2WvDbt=gwmTkz7-XoMwvpHhBDiuA@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, vincentc@andestech.com,
        aou@eecs.berkeley.edu, alankao@andestech.com,
        greentime@andestech.com, linux-kernel@vger.kernel.org,
        zong@andestech.com, kito@andestech.com,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Mon, 05 Nov 2018 00:52:52 PST (-0800), Arnd Bergmann wrote:
>> On 11/5/18, Christoph Hellwig <hch@infradead.org> wrote:
>>> On Mon, Nov 05, 2018 at 02:58:07PM +0800, Vincent Chen wrote:
>>>> Many thanks for kinds of comments. I quickly synthesize the comments
>>>> and
>>>> list them as below.
>>>> 1. The kernel image shall include all vendor-specific code.
>>>
>>> I fundamentally disagree with this=E2=80=A6 and think it should be the =
contrary.
>>>
>>> 1. The kernel shall support no vendor specific instructions whatsoever,
>>> period.
>>
>> I think what was meant above is
>>
>> 1. If a vendor extension requires kernel support, that support
>> must be able to be built into a kernel image without breaking support
>> for CPUs that do not have that extension, to allow building a single
>> kernel image that works on all CPUs.
>
> Yes.  I don't want anything that won't compile with upstream GCC, but I a=
lso
>
> don't want to have a Kconfig that says "make the kernel only work on
> $VENDOR's  implementation".  I think this can be achieved, at least for t=
he
> cases I've seen so far.

I think over time, the implementations will diverge. Ignoring the question
of vendor extensions for the moment, you will definitely have to deal with
combinations of (future) standard extensions. I can see two ways of
doing that: Either each extension is a separate Kconfig option and you
have to know which one to enable or disable for a particular target,
or you list each platform separately with one Kconfig option, and
have Kconfig/Kbuild work out which features to enable or disable
based on that to get the fastest and most featureful kernel that still
works on all enabled platforms.

       Arnd
