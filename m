Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056E22150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VbntoMxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056E22150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeITXgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:36:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeITXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:36:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so4697693plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6CZbYqTbxdKa59K3nelLw+EiTs5wbUXsOJYv7jnS90A=;
        b=VbntoMxdNdiLIJEa8QUwq21B3wLFGQKYrOhZHRf1V0NBmCQtuAx5MRXCfj4C1ZXf4S
         rrBN2riq59+GIHNXSeR90Cdp8dxiEOZ+JTlrVNnJvJrztT/MBllH8f5hU/HZHtJvK1ar
         t+hQApeMloDGk/ZjWUquloTPdLchMFQo1N0e5JIGDjDblVlJUAcB3uPxg+jdwszmRpRi
         mF/DQtB/JQj/SxTrQFD0Tpyfx5jl9DTWGLacrCMz42UTEucrPFkkgd1wZhvsBqJYf1Hc
         DUJgyPPPUQtyWKx/zUMfIbG6uQyUOzPiVMuC6BaG+OVIOppXtHM+Clvg4xPAUp0oheWP
         +3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6CZbYqTbxdKa59K3nelLw+EiTs5wbUXsOJYv7jnS90A=;
        b=e+m05wRzl8wGcL065YlPyUeMn83wQ4TRiahlzRCMUlozKSZJ9FqcwCNmFkqRL/fY4H
         CoM95CJlA2aZsX0K5Ja82B0RBY+F8e/Zd19W7BaVtIm8itUtsZzRByZDjOxSXqTlTHeZ
         xAGCIMhDiY+g5Rbo10wrNoEMnE0PUrvthQTICGN5BI2mQyxlIicfNSi0MVgSi5IsdGDc
         OsBQssYjOMJxAC0cq9FW2kDPu+E6U0FaWUi/eFMWIPwLYWgloGL+usyn4R6Vfl3HEa89
         o956GMmzU86Jdc0EfxrrB6s/VT+0+vCnGXzPt6g+kDtXqNK6jzrEMnjMhliWegT56890
         fwJg==
X-Gm-Message-State: APzg51DRctp9Se7BUL3zGdX8MRwOK4WAhtabGAXyl35LYr9T6NA+YiAP
        rVKPRSbnEevTCa2g/bRQmFDFvA==
X-Google-Smtp-Source: ANB0VdbeYfIOXtijDXaHPIZj+CGpx+tvyOzwHBXMxZl2bKaNkftZP7zqDBd2fOcj2Mh+n6bjPGTNbg==
X-Received: by 2002:a17:902:7205:: with SMTP id ba5-v6mr1515883plb.15.1537465933284;
        Thu, 20 Sep 2018 10:52:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b21-v6sm54277847pfm.97.2018.09.20.10.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:52:12 -0700 (PDT)
Date:   Thu, 20 Sep 2018 10:52:12 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Sep 2018 10:52:10 PDT (-0700)
Subject:     Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
In-Reply-To: <20180914143719.GA27689@guoren-Inspiron-7460>
CC:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net,
        devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ren_guo@c-sky.com
Message-ID: <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
>> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
>> >
>> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
>> > Thanks to everyone who provided feedback on the previous version.
>> >
>> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
>> > CPU cores and the patches are based on linux-4.18.4
>> >
>> > There are two ABI versions with several CPU cores in this patchset:
>> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
>> >          SMP ...)
>> >
>> > More information: http://en.c-sky.com
>>
>> This looks good to me overall. I think a good next step would be to get the port
>> included in linux-next, by preparing a git tree with all the patches and asking
>> Stephen Rothwell to include it there. Further comments on the architecture
>> port itself can be done on top of the existing patches. I would suggest you
>> base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
>> rebase again.
> Nice :) I'll follow the rules.
>
>>
>> You have included a couple of drivers in the submission: two timer and
>> two irqchip drivers. Please leave those out for the moment, and either have
>> them merged through the respective subsystem  trees, or get an Ack
>> from the maintainers to merge them through your tree.
> Ok.
>
>>
>> I notice that a lot of the patches have no changeset comments on them.
>> You should fix that and make a habit of describing every single patch
>> with a few sentences, even if it seems obvious to you. Have a look at
>> the changeset descriptions for the nds32 and riscv architectures when
>> they got merged.
> Ok, I'll fixup them.
>
>>
>> One big question for me is what to do about time_t. Deepa and I are
>> in the process of finalizing the system call ABI for 32-bit architectures
>> with 64-bit time_t, but we are not done yet and it won't be complete
>> for 4.20. If you target 4.21, that could be a chance to make csky the
>> first architecture to only need the 64-bit time_t interface, with the
>> corresponding user space changes.
> y2038 is very important and csky32 has the issue. But 4.21 is too late for
> us, we really want to get into kernel.org as soon as possible.
> We could remove 32-bit time_t in future.

I don't want to hijack this thread, but in RISC-V land we were hoping to have a 
user ABI free of 32-bit time_t.  Our 32-bit glibc ABI hasn't been finalized 
yet, and when I talked to the glibc guys a few weeks ago they were happy to let 
us wait until 32-bit time_t can be removed before we stabilize the ABI.  We've 
been maintaining out-of-tree glibc patches for a while now, so I'd really like 
to get them into the next glibc release.

Mapping out the schedule more explicitly, as I'm terrible with dates:

* 4.19-rc4 was 2018-09-16
* 4.19 should be 2018-10-21
* 4.20 should be 2019-01-13 (skipping 2 weeks for the holidays)
* 4.21 merge window should close 2019-01-27
* glibc 2.29 is scheduled for 2019-02-01

That's very tight, but assuming we at least have a prototype of the API so we 
can get the rv32i glibc patches in much earlier it might be OK.  There was some 
talk of being able to use some workarounds to do a 32-bit time_t user ABI 
without the cooresponding kernel ABI, so we could always go down that route to 
start and then decide to deprecate or not deprecate the 32-bit kernel ABI at 
the last minute -- not something I'm fond of doing, but an option.

How close to done do you think the 32-bit time_t will be by the end of the 4.20 
merge window?  If it's close enough to start our glibc push then that might be 
OK.
