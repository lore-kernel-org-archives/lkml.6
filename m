Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321CCECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBE92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzw8xPuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBE92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJaUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:43:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40437 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeJaUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:43:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id k12so11369584qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+oC7J1e9wI7RTc5L631+Zq2WRCq00Xs6YvFyANbXVDw=;
        b=Zzw8xPuFr4bo3gzt2c4iqucxUf66fjZkPeKoNaoXIfl2dTIkfGtCTXYU6s0iIu4gir
         q1kZvZz/NHWR+RQ9UEWf6zGwT6bwN9b5X+NEg+FK7VKDjPF5C46/xfxQlQeX3yV2KhtB
         PUO+tuG6/QHGdr/58yOaj3jO052gFv7FHZcmPTP0Hp+DR3RxlNssNphZHAkHNMVCetCU
         pzKuUnhGR2ILCdXKM3vIDUvdz/srF27kvxAVDlmlGqP3j+AkFPlAbYV/1P7jRfKl/+Dx
         LXWFbq3mXOYsIYsrd8uc5zXxEH985QQZVnxHqOPg5eFbOXFDu4ORTFZCYpdmMRvsmlYC
         QsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+oC7J1e9wI7RTc5L631+Zq2WRCq00Xs6YvFyANbXVDw=;
        b=dt/oEoX66ZqbE1m56+T2WQfdWK4pkN7PrhGlmqwEUrkeUrylb1IsY6X26PGRgs+ajy
         6v57hR1k9qfzvatICfQw7aY/Lb4yEsLa52gbghJ1qdz+vmw/7xuRlRMYb07gR8ZEpPbF
         /kbEoGwHOlhCj+GpW3+wHrTXSw6ibi4/FjHJFqOvsHkvkP4b7WNiV7Hk4EQkkauMTZTq
         fWp9ApsixXEKFDfnFFmERaFj1UYJdHbPleI74pLqkrPWV2V6cnbuu7TCCB/v1PeS6xdt
         0n4oCbT+IPuqVU1FVOd9pozt+MCdj/aH/NFy1AK7Fr/i7mrwvn7BokHd2Gf9ZjriL7+J
         CWyA==
X-Gm-Message-State: AGRZ1gLDtoRWjyKGZgtnY8ZhTpaAS1T9Je3hwGU3LeQJxm2zpPKu5kPe
        6r7gyIiLZhfdD60PccCQQKCkDbcbf5UjoRoT2gE=
X-Google-Smtp-Source: AJdET5cvoP1jw8j3prxyFQMQZJ1shIqE7H4SQZ/lG7T9nYCF1j0/9pdNx4naVEm5G8VNWJtn4H7LiGQbWGiwEgqBusU=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr2308393qvj.161.1540986348246;
 Wed, 31 Oct 2018 04:45:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 04:45:47
 -0700 (PDT)
In-Reply-To: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com> <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Oct 2018 12:45:47 +0100
X-Google-Sender-Auth: iGJj1ieP5_77ZVQnSCzEBXI6mEw
Message-ID: <CAK8P3a125hSg5cK_bt_4w2iLrxCETnPLHvHpFmYyRYXhjC9Bjg@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     Anup Patel <anup@brainfault.org>
Cc:     vincentc@andestech.com, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong@andestech.com>, alankao@andestech.com,
        greentime@andestech.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18, Anup Patel <anup@brainfault.org> wrote:
> On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com>
> wrote:
>>
>>   RISC-V permits each vendor to develop respective extension ISA based
>> on RISC-V standard ISA. This means that these vendor-specific features
>> may be compatible to their compiler and CPU. Therefore, each vendor may
>> be considered a sub-architecture of RISC-V. Currently, vendors do not
>> have the appropriate examples to add these specific features to the
>> kernel. In this RFC set, we propose an infrastructure that vendor can
>> easily hook their specific features into kernel. The first commit is
>> the main body of this infrastructure. In the second commit, we provide
>> a solution that allows dma_map_ops() to work without cache coherent
>> agent support. Cache coherent agent is unsupported for low-end CPUs in
>> the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
>> need this solution to overcome the limitation of cache coherent agent
>> support. Hence, it also can be used as an example for the first commit.
>>
>>   I am glad to discuss any ideas, so if you have any idea, please give
>> me some feedback.
>>
>
> I agree that we need a place for vendor-specific ISA extensions and
> having vendor-specific directories is also good.
>
> What I don't support is the approach of having compile time selection
> of vendor-specific ISA extension.

Agreed, we did this on arm32 in the past, and it took us a long time
to change all the modern platforms (ARMv6/7/8) to be usable in a
shared kernel. It's better to avoid that and keep everything together
like we did on arm64 from the start.

One thing we do on arm32 is to support combinations of different
instruction set variants in a combined kernel through callback pointers
that turn into direct function calls when the kernel is configured for
only a single CPU type. This might be something to add later on
riscv, but I probably wouldn't do it right away.

      Arnd
