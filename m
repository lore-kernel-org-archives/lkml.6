Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGt3Q1as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CC32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeIZBkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:40:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZBkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:40:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so14669268wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ql9pVet2eun9Mn9AWv9RhcECS2xztA7i3bnKEiMZGLE=;
        b=PGt3Q1as+F+pJr9RREZ4/P20w7bSdYAblkqJnXKmKOhrzzvFX1SkFdDuxqWb0AwQrk
         zSYt9oCu2gnL+Y1sNeKW8WL3sI4iOUBDZBBnxwqNyVh8WTDNeKkyHvhw4Qr6O+ghFwST
         /6K19UMQRq6Aj6FNVLJkTf/8mu6lqfg94RrFEq+FEy/xOoVq7Y+mzEB8MPafAtpzcw1u
         So+2DJBc4c4T+5/T6xYI7Vg3JmMKEeZHLqUo1OkIqo8UXdVJirvabL3yem1ylAfhnuGS
         CDVsljo4R3g8LeTbUS/guwmNoqM4fY2k64Gfi/vhJS26pUTaTjvG3CciojyqFl5ykNze
         kiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ql9pVet2eun9Mn9AWv9RhcECS2xztA7i3bnKEiMZGLE=;
        b=ewytJFILsNIkgcE3VqAHHS2aLMNsJXJ0+7E/xygOYV1bgb2yox0rfliBbyo2UW1P8B
         mg4QJOSPtN3oGzKQ/UllW/t8RRgyrpWseG/O9iLqDLsgXTgYfowXKMKTTI8GRvYueNb7
         Ophu5z9uHV8O6i8ssyy96TZAz2AqDO4VLqBQF12qUvvPEB3G2Z/vPyHCfIY5oF5CJDOn
         QJJGPJ0rzGfcZqKxLboLxnbUHrSg77eOcgSN0LYYT65YqOinKjrE1PUzAmfBH9bcDqcP
         1vgWn/5xGe4YZCIdONy6DiM5bHKWCxPhywYZNkExSQHjFkesYB96IS4QxztLHrAtkUnm
         ltlg==
X-Gm-Message-State: ABuFfoj3rg5UFew3JWQLWK00uxIjPIZ329jvNVmGrz+u5xdM9/dTurbF
        bUlIrOsJ98HNfHFMz6YPZdfxsjYuC6g=
X-Google-Smtp-Source: ACcGV62dJhWbz8defye/tcdE5LSEKxWuWA+zArm/zfBqrG1YC7sTHQD0jBmmvvrerBeBFAKg/bdGbA==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr1948045wmj.130.1537903854838;
        Tue, 25 Sep 2018 12:30:54 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id c12-v6sm3353630wrr.6.2018.09.25.12.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:30:54 -0700 (PDT)
Message-ID: <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Sep 2018 22:30:52 +0300
In-Reply-To: <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
         <20180920170306.9157-2-yasha.che3@gmail.com>
         <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 2018-09-25 at 17:45 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Thu, Sep 20, 2018 at 08:03:06PM +0300, Yasha Cherikovsky wrote:
> > MIPSR6 doesn't support unaligned access instructions (lwl, lwr,
> > swl, swr).
> > The MIPS tree has some special cases to avoid these instructions,
> > and currently the code is testing for CONFIG_CPU_MIPSR6.
> > 
> > Declare a new Kconfig variable:
> > CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE,
> > and make CONFIG_CPU_MIPSR6 select it.
> > And switch all the special cases to test for the new variable.
> > 
> > Also, the new variable selects CONFIG_GENERIC_CSUM, to use
> > generic C checksum code (to avoid special assembly code that uses
> > the unsupported instructions).
> 
> Thanks for your patch :)
> 
> I think it would be cleaner to invert this logic & instead have the
> Kconfig entry indicate when kernel's build target *does* support the
> [ls]w[lr] instructions.
> 
> It would be good for the name to be clear that these instructions are
> what it's about too - "unaligned load store" is a little too vague
> for
> my liking. For example one could easily misconstrue it to mean
> something
> akin to the inverse of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> whereas
> in the MIPSr6 case many CPUs actually handle unaligned accesses in
> hardware when using the regular load/store instructions. They don't
> have
> the [ls]w[lr] instructions, but they don't need them because they
> handle
> unaligned accesses more naturally without needing us to be explicit
> about them.
> 
> How about we:
> 
>   - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and
> select
>     it for all existing pre-r6 targets (probably from CONFIG_CPU_*).
> 
>   - Change CONFIG_GENERIC_CSUM to default y if
>     !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.
> 
> That would avoid the double-negative ("if we don't not support this")
> that the #ifndef's currently represent. It would also mean any future
> architecture/ISA targets beyond MIPSr6 automatically avoid the
> instructions.
> 
> Thanks,
>     Paul

Thanks for your feedback, I'll start preparing v2.

Looking in arch/mips/Kconfig, some CPU options start
with CPU_SUPPORTS_ and some with CPU_HAS_.
Which perfix should we use here?

Thanks,
Yasha



