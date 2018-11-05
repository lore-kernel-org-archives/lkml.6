Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01151C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B611D2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="euLOe8fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B611D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeKEWko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:40:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54613 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbeKEWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:40:44 -0500
Received: by mail-it1-f195.google.com with SMTP id d6so12567864itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hQtYHU/HGMNCyN6tw8xp5XBVMboODjqhG93dseUJOdI=;
        b=euLOe8fWnGZt0vDqE2aNLpfQD/lwD0MtHJvWi6zZI95FGLPhk+94n4xMRLZdLVWpJ5
         MnHkvYzelpWdU8MYn1vc1ElpZRU+Hl2sD2JdtKVJa/EfREdOhpXtlXd/DFJal4TGCsSs
         w8Jw9uYwflQcQ2QT0AA7O1d4eAkB9P9c6BAMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hQtYHU/HGMNCyN6tw8xp5XBVMboODjqhG93dseUJOdI=;
        b=Mw4c1ihUSX3cFIHM1j6rggUA+L224d9xaxNyKDNdspntfmhenQUCBiZegIgJNaCbf3
         oTDSTlRPshw7HMVtYZ8Qnuk1ZbtGu+NE7enyuFP06kKX5K68STfeN9kSRqktlBkMT8Ub
         ljmQMNABzXkEc9zBhp4+BLTPehHgHsEAtUbC/Z8MIOXIL1OKLMGWX1vW4ZC1PMlsFk2W
         wkZoXtM6hyuU3BkkRH65D3nJBzdUO1MpY93kFGxqJJHksoB5Flav2fq0MxtZBP8p3Dhb
         8xkYXh1Ae84L+55jThoBz/bK3GWJtZM9wfrWTxrt08kwkfUHlsMVFF2uvbRqj40oaTXF
         QLSg==
X-Gm-Message-State: AGRZ1gJdgCFfKwe6ScY33P2D4WFKdYr/w0Um/XW2LOjpl9Ef5cFTHN+y
        rd1oB11Psgdg/ytqgJh4mwpwoUAW/E27ZRR5XV97Cw==
X-Google-Smtp-Source: AJdET5cvXrJdkYKu0n0a35DsiLamjLqzw4E3AoFr2PPBK5zPAOXJc6px/yM8dhTYDQL7+GIaw9JrbuknJh+Cpkg+P78=
X-Received: by 2002:a02:9f85:: with SMTP id a5-v6mr20343714jam.2.1541424060102;
 Mon, 05 Nov 2018 05:21:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 05:20:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1811051419230.1566@nanos.tec.linutronix.de>
References: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_2cPZ5HKo2oDeYsLGAXgnENzWskZOcT_Z509Shbct+2Q@mail.gmail.com> <alpine.DEB.2.21.1811051419230.1566@nanos.tec.linutronix.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 14:20:59 +0100
Message-ID: <CAKv+Gu8yS=Jn1RC_1ZY4oY84p1AnXv7NumjwFdXUZKhpn1J8Ag@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Unmap EFI boot services code/data regions after boot.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 14:20, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 5 Nov 2018, Ard Biesheuvel wrote:
>> On 4 November 2018 at 21:10, Sai Praneeth Prakhya
>> <sai.praneeth.prakhya@intel.com> wrote:
>> Thanks Sai.
>>
>> I have queued these up in efi/next for now, but I'd still like a fresh
>> ack from the x86 maintainers.
>
> I've reviewed the CPA part and for the rest feel free to add
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
>

Thanks Thomas
