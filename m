Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E462148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="M7PV4fly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E462148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeHVSuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:50:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56196 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbeHVSuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:50:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so2376444wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wo9xG0UBWHk5NFaTYsnfHS8sP2S/uxHW/ydPSM7LQCw=;
        b=M7PV4flyxrx9UDKpH8ORluyNhpVoOXh6VSkoT0FmB14myqJWwgMrKcKsP2VqVmDG/3
         0N6+yvWxIcrt8/oYOlW0gIwmRt3cz9hLBMCwj0jh/nETCPibl4+p4F57ckmWJggjcMDT
         /evZLk5S/I6c6+8DIAWbm//VBTWPEkgreBNzA6gJWwG2WqCLfw1+rkrurtq+27mktzdZ
         lrrmWab1suy7hU939g7qfeMJBNFIULo4juZ3StytOFuyaYh6mdcs1Mu/NEOb5wRsxlm0
         LfAZavO0WWtFgVuTX/W353cdeuctmPWao6f0p6uq+vG/x9iwdZ9S+C8lqMSyE1178dIR
         mYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wo9xG0UBWHk5NFaTYsnfHS8sP2S/uxHW/ydPSM7LQCw=;
        b=aeyNwpzO9WTTttBkChQA0xfd15o206pOZfVVLHLHyqeDFoZc616QHMPpXZhkdAsaUG
         zEC0ZC/Nl0xeNE4mVrgde4BzTkDqre9D2vsfiK3WkhQV6xs1r51ekWYQYVT5HvBeWCZW
         5GjYNWEQrsP9AZQ4S2RNCPnyizgobCM+wdL6+RmYQfBvKIBdgcjSLtaU83K/Xf+VZ9CV
         1BRQK5Q84yRhBWpddmZaJ88ajV+rpGPSHS4mB2nCbpb7nxmSsC88rXAQl5DY33Q4K3Gw
         ZgkeKPQqHnSyrv+gE3ENRSp/0QDtwqHPuDjKvcMpoiiWDvANx2O+IdS43KAQ2sfVVhno
         ylDA==
X-Gm-Message-State: APzg51DPdn/BW0qgKDChpaE3EdEJfVtiD4ZU2oRQr168dk4Gc5S+/gZP
        VhYl48rIX9QN4LTjz/cJHTk1N44m89lMPRjOw+9Ldw==
X-Google-Smtp-Source: ANB0VdZeWk25Gg5slOoAQDaVWsjX+vN3ksVxHFsUPK3q+s4gKPOaGAhx9ZjnF7LVU7sqQG9YrzP9xEDDRHNzmNLsLuk=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr2826639wmf.89.1534951492046;
 Wed, 22 Aug 2018 08:24:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 08:24:51
 -0700 (PDT)
In-Reply-To: <20180822060353.GA27106@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com> <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com> <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
 <20180821074826.GA28079@infradead.org> <CAAhSdy2NP4raXXPVvEJyAO127=J9jR3NNEHLF=vigBz=v-Qqkw@mail.gmail.com>
 <20180822060353.GA27106@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 22 Aug 2018 20:54:51 +0530
Message-ID: <CAAhSdy1jdn7OS1AxwXYZqejUw-qto-5Afbb6o034ahH26E+vyw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:33 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Aug 21, 2018 at 10:34:38PM +0530, Anup Patel wrote:
>> The cpu_operations is certainly required because SOC vendors will add
>> vendor-specific mechanism to selectively bringing-up CPUs/HARTs instead
>> of all CPUs entering Linux kernel simultaneously. In fact, we might also end-up
>> having CPU ON/OFF operations in SBI.
>
> Your forgot an essential part in your analysis:  Right now we only have
> one single way to deal with cpu on/offlining, and that is the dummy WFI
> kind.  Once other ways show up we can build proper infrastructure, but
> until then this is just a white elephant as we have no idea how these
> abstractions will look like.
>
> And my hope is that we'll just see new SBI calls, in which case we'll
> just need SBI and dummy version and can avoid all the indirect calls.

IMHO, rather than waiting for new CPU ON/OFF methods to come-up we
can keep the cpu_operations ready. Also, we are not re-inventing anything
here which we might have to discard later because cpu_operations are
already tried and hardened for Linux ARM64.

I agree with you that in long-term SBI-based CPU ON/OFF will be widely
used. Most likely we will have at-least two CPU ON/OFF methods:
1. Existing lottery based spinning
2. New SBI calls

Regards,
Anup
