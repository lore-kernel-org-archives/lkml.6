Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156E92054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LTWVg3J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156E92054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeKAFmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:42:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39414 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbeKAFmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:42:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so8181324pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tNw4+GQDoI+QM0z6JRCy7TPp3efbz9Gf3KD2w8i/67w=;
        b=LTWVg3J7Zj0OilUrMPMl/KAotZUGSib/8cbljjkSKDAymWi2vXIrIY3uuKdOeQX8bA
         io1GuRvN+zmQJxDfrXgdcg4i6Clr7OU5LT6BIX5piwd6Uu7sJddot82KRAwFYzczjuJ/
         PGOWBVMX4NaXc9qbaZCB0RLQ35YYs3XRQDZrPZyEjcwblSJoYQQ98zGfzpwvzrSKIpCh
         O/6yLTgNBKo+uItqyNDOn0KT+IMLWr7P83P8t4B2BOQNxinTexZj2ddqsyZWiAD6cZDZ
         ODqN6TdK3ru6mVRrjF2ShOks+810hWr1UHZVxXZ9uK1GUrDwT+47uiAp+JIzDfpW90RI
         e21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tNw4+GQDoI+QM0z6JRCy7TPp3efbz9Gf3KD2w8i/67w=;
        b=km9zv11qgMaHFYqMhcAiGM1pcgpEDGF7wiyXmq25TMr1+sEpxbRhuHPLvLKDm4jndp
         erEm/HfCVZjiGXioH+9pZXsxHKgLG3zCCavA245lxEqfbPlFs9RhJ5qFCRplzfdREC3D
         VEVhB0NwzXzgBLOki18V/aX/IvGwqbL2vy1r7BsMnp4FyabH8wjVOTwZeZbOcTNCpJSC
         xRRC44p0oLmjbGXCXjcHOadyqly0F9/t1uIToNAVYXqXjlK1r/zvNENBAMhBTPkOQxwb
         yUSCdx2dLpF3C3W3jm3frE8CEqVs7IvjJoz3KmghOlNlTUy+50ebdViu/ugFmIlnO8qH
         4FeQ==
X-Gm-Message-State: AGRZ1gIIXWwrOV+TA74C5JQqBxAlkTB7R6fra7InsG7m6oVwtL5ysQwF
        I1VuojCgDcn7sjMX2Cqcn236iA==
X-Google-Smtp-Source: AJdET5dEk5vIhWJb+nT1PKgOqAKSCzVQCgcC7HazjWXIZzmxVPxF3qQNEJpQUGDsbZIEIAQshAOm3Q==
X-Received: by 2002:a63:1013:: with SMTP id f19-v6mr4620144pgl.38.1541018560320;
        Wed, 31 Oct 2018 13:42:40 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1699840pgi.44.2018.10.31.13.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:42:39 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:42:39 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 13:42:26 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: defconfig: Enable printk timestamps
In-Reply-To: <CAOesGMjXZNURZ4SdKjssYCcFv3=4MYLBpBpzvvb1rNM-fo=QHQ@mail.gmail.com>
CC:     anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Olof Johansson <olof@lixom.net>, davem@sunset.davemloft.net
Message-ID: <mhng-111820e6-59c0-479a-a10f-f3729007ba70@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 12:20:40 PDT (-0700), Olof Johansson wrote:
> On Tue, Oct 30, 2018 at 5:37 AM Anup Patel <anup@brainfault.org> wrote:
>>
>> The printk timestamps are very useful information to visually see
>> where kernel is spending time during boot. It also helps us see
>> the timing of hotplug events at runtime.
>>
>> This patch enables printk timestamps in RISC-V defconfig so that
>> we have it enabled by default (similar to other architectures
>> such as x86_64, arm64, etc).
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> For next time: doing a re-format of the defconfig (to shuffle config
> order), plus changes in the same patch, tends to be a bit fragile. For
> cases like these, I'd recommend hand-pruning to just flip the one
> option if needed, and then have Palmer or Andrew refresh the defconfig
> during a merge window if needed (usually quite rare).

I poked around and it looks like most architectures have this enabled for at 
least one defconfig, with the big architectures having it enabled for all of 
them.

I decided to do a bit of a case study here to try and figure out why some 
architectures have this enabled for some defconfigs but not for others, and as 
far as I can tell it's just an oversight.  Specifically, looking at sparc32 (# 
CONFIG_PRINTK_TIME is not set) vs sparc64 (CONFIG_PRINTK_TIME=y) I can't find 
any reason for the difference.  sparc32's setting can be traced back to

    commit 216da721b881838d639a3987bf8a825e6b4aacdd
    Author: David S. Miller <davem@sunset.davemloft.net>
    Date:   Sun Dec 17 14:21:34 2006 -0800
    
        [SPARC]: Update defconfig.
    
        Signed-off-by: David S. Miller <davem@davemloft.net>

which changes everything in the defconfig, while the sparc64 version dates back to

    commit 3ebc284d52757cf39788731f8fddd70a89f7fc23
    Author: David S. Miller <davem@sunset.davemloft.net>
    Date:   Mon Jan 9 14:36:49 2006 -0800
    
        [SPARC64]: Update defconfig.
    
        Signed-off-by: David S. Miller <davem@davemloft.net>

When we first submitted out port upstream we had an empty defconfig, with the 
theory being that we should just pick whatever the default in Kconfig is for 
everything.  That's obviously the wrong thing to do because most of those 
options are bogus.  At the time I didn't care enough to look because I just 
wanted something to work, but now I find myself asking the question "what goes 
in a defconfig?"  Is it:

* What I, as the maintainer of arch/riscv, want?  That's essentially what it is 
  now, as we have things like "CONFIG_R8169=y" in there because I happened to 
  have one sitting around when we needed to plug in an Ethernet card to test 
  out PCIe.
* What distributions expect?  There's a major element of this in there right 
  now, as half this stuff was just selected because the Debian and Fedora guys 
  suggested we do so because adding things to the RISC-V defconfig made it 
  easier to put together their build scripts.  For example, we ended up with 
  "CONFIG_EXPERT=y" because some setting necessary for the distros was hidden 
  behind it -- that seems like an odd default.
* What users expect?  I'm not even sure who users are in this case, as from my 
  understating most people use distro kernels and don't twiddle Kconfig 
  options.
* What is necessary to work on RISC-V hardware?  This seems like the most 
  reasonable use for an arch-specific defconfig, and subsumes things like 
  "CONFIG_SIFIVE_PLIC=y" because without the PLIC driver nothing will work (but 
  the PLIC driver shouldn't be enabled by default for all architectures, as 
  it's useless everywhere else).

Maybe I've opened up a big can of worms here...  It just seems silly to have 
most of our current defconfig be RISC-V specific.

Anyway, I'm happy with the change because it meets my "what I want" criteria 
:).  I'll split it into two parts, though, as that way when someone else has to 
go to some archaeology on our port they'll be less likely to get lost.
