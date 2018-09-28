Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08DDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13D2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE13D2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeI2Bol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:44:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37913 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2Bok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:44:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id 204-v6so3884407qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 12:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZOy/tAJthGPa8dXT6OqDvHNXzBlN6/EmVfr6cB88wE=;
        b=U8aQe7L3BUFIH61Pekxo/NdfgdQyQs0YYmgCa2Zo8yvC2Pvs+5j9R6tjIsJ6FyfOiP
         ubomhi66/VJsp50kLHD2LVnqIeNTUvFbSE3J8dIiJz9wbQ/ZE0xNScplKu22HLV2n06T
         qpW+bGJF6cd2z6vDFySva0pgJK1uJafReQLDKPF1aNJD4iJAOdCHlLvx+Z4ThrxuVzP7
         PKk+D4RkkgoAL8aTlDw71GIP1tHD52wjDGBs+POcMGe9j5hOEM0w77owwwo2+3dGuB8N
         xdSeiiQmCHt5khwbKwbc058NnyCub+KsbQ2fs0MpJelwGmiLHNdZFSoIREr0VFHvFTjr
         OQ0A==
X-Gm-Message-State: ABuFfojtDmtZkS+943a2cQYuScwlvjIxnrAoR+WMRVAaVTFgPBZv7Lss
        Tv0ghhXv5/6iPqAmTT/oREBhsbxUEWmnunuvroxPkg==
X-Google-Smtp-Source: ACcGV63xi4QFed2rBb5LWj3zE55gxId6hIcF16WIlG03t74Gymxu+9bXjvTqxsr61UfDhD7qUvUEXjPhWKq/t/f+nDQ=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr14790qkc.107.1538162368718;
 Fri, 28 Sep 2018 12:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180926135110.13061-1-Jason@zx2c4.com> <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
 <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
In-Reply-To: <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 21:19:12 +0200
Message-ID: <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
Subject: Re: [PATCH] arm: support big-endian for the virt architecture
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 28, 2018 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Applied for 4.20 with subject line changed s/arm/ARM/, thanks!
>
> Thanks.
>
> > I think most people just build a 'defconfig' kernel, which includes
> > multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.
>
> Right, that's what it looked like. In my case, I'm doing CI on some
> homebrewed infra, where I'm building lots of kernels for lots of
> architectures and testing them in qemu with various tests _for each
> and every commit_. Not having a server farm as impressive as Intel's
> 0-day infra, getting compilation times down is rather important.

You can probably work around it by enabling ARCH_HIGHBANK,
which is a minimal platform with no other requirements, so it
should only add a few milliseconds to the build.

Another option would be to do the testing on top of linux-next,
which should have your fix starting on Monday. Testing on
linux-next carries a higher risk of running into unrelated
regressions, but also lets you find out about conflicts with
other patches early on.

       Arnd
