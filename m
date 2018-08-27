Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFA2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E507D208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQavkR6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E507D208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeH1Ctn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:49:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42170 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeH1Ctn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:49:43 -0400
Received: by mail-io0-f193.google.com with SMTP id n18-v6so521657ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bhkX9BVgN1BJlsxm3QVXZJ7U3zluf/nG4Hj+kDzZpoU=;
        b=KQavkR6d2JxFwZH9+syItRFChAoH1TguU9X0BBykPEaP2wufnZ1gAs0NvfKt7g+Z96
         NjM8H7ZTm08Ml3VHrpq/OW38SVpPfVLgN9wOtbrO+p4SKdW7UtYVEMaQKJ0ECpQFN3iL
         ZkNgBXX8VkFAADmtF02XJU43QWwQU0scyoyAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bhkX9BVgN1BJlsxm3QVXZJ7U3zluf/nG4Hj+kDzZpoU=;
        b=h7/Qy9FXIMfUtI/pZWDFCTs6Xo/9MUQ9RaPziul/At86/XIWYCajt1NAtgQPf5twNK
         iccv27vLgNiXopsz7f2v/m0AXxHo/HCl4nNUbq8ZFfHyGaea6ulacMW8puoj+bOwfvh0
         0yXI6fUHzijlAU+xuzJwvZNfzfEum5oH1rXmMoTzQ9cM1I/YYWE2VX7LMLuWGhTgLDQU
         xqm5PcbrYvYRU+vBTIqm+3uMuSXmhSv9bvj3zF4Z7EXglbScq1MVfRnYsaVBdT0HDStO
         bvGCLtwbNb1eO05/RDr1CMQ1Xa9ch4nJmY7LdLn0jmcpuxSaNredLVjPzERGwVh5pA9V
         H07Q==
X-Gm-Message-State: APzg51AZ1t0EUUpgznLRrL0DA4BirMpQMxdzUy77e5dn5DuQ/fnaWjJI
        ZJod4Xx8U3KwhnmzZCQGDMt8H1QdoKqE+8ogvvu8BA==
X-Google-Smtp-Source: ANB0VdZ5/YYODdqlcJRaGyEV4k9XZ/rbrRp+TSoktsOzdz6yBrVij9H86iQw/YbedU/qW4y2598p1DqPxXso18nrbQ4=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr3215805ioa.60.1535410860674;
 Mon, 27 Aug 2018 16:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 16:01:00
 -0700 (PDT)
In-Reply-To: <1535411336.3516.2.camel@megha-Z97X-UD7-TH>
References: <00000000000072d64d05737b6b8c@google.com> <20180820073119.GA14931@sol.localdomain>
 <CAKv+Gu9Y0TLOuMba43HPihYqy-kk0nttBfPj1_UukiYy1cBcFw@mail.gmail.com>
 <20180822062036.mdq4q5o5zdzuxh7s@gondor.apana.org.au> <1535411336.3516.2.camel@megha-Z97X-UD7-TH>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 Aug 2018 01:01:00 +0200
Message-ID: <CAKv+Gu_oZ0Z37WV1h4opi-cYZT5FWU_bmrkBjx8LXpvKpPoZNA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sha512_ctx_mgr_resubmit
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot <syzbot+d5455bac3ba1ee9114e5@syzkaller.appspotmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 01:08, Megha Dey <megha.dey@linux.intel.com> wrote:
> On Wed, 2018-08-22 at 14:20 +0800, Herbert Xu wrote:
>> On Tue, Aug 21, 2018 at 02:43:56PM +0200, Ard Biesheuvel wrote:
>> >
>> > I agree. The code is obviously broken in a way that would have been
>> > noticed if it were in wide use, and it is too complicated for mere
>> > mortals to fix or maintain. I suggest we simply remove it for now, and
>> > if anyone wants to reintroduce it, we can review the code *and* the
>> > justification for the approach from scratch (in which case we should
>> > consider factoring out the algo agnostics plumbing in a way that
>> > allows it to be reused by other architectures as well)
>>
>> I agree too.  Could one of you guys send me a patch to remove
>> them?
>>
>
> Hi,
>
> We are working on a fix to solve these corner cases.
>

Great. thanks.

But it would also be helpful if you could try and answer the questions
raised by Eric:
- in which cases does this driver result in a speedup?
- how should we tune the flush delay to prevent pathological
performance regressions?
- is it still safe in the post-Spectre era of computing to aggregate
hash input from different sources (which may be different users
altogether) and process them as a single source of input?
