Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64520645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ZPFADis7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE64520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeIJVaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:30:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50821 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeIJVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:30:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so22245723wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LtEVNMYXuH9Tfuc/2myhioMYZ8+l6i78docegJAa92I=;
        b=ZPFADis79vI4yVTqlt/BUWNZZXn0hu/xz4WiAIRGGOcS/+E4N1Y7wRrK/7XW7jVeD5
         CNwwiIEV4o1zxGU6k8j8AyT2fxlqp9bfbj1LUhABtD+oJGc0n969m2y/zyFkEbPNQVYj
         zbP16zFUSy8yeZwIP98RIBKLHMBTcE9eIUhfJ1uJFrJpzLaq1oqIYKLaIiyJFupxHXb8
         DH1t5zRcoBcSyx03OgWtBjae1aIHx16csLmfqkOhg/1OmyvmuMvGqhMCW60j6vK+n0OH
         ViycsKG40cBWkdL9HzFY5VyqxYEnocaQV+pK+xWkTMU/YX1uO84gFI6DB6cakCVZj/Vv
         U8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LtEVNMYXuH9Tfuc/2myhioMYZ8+l6i78docegJAa92I=;
        b=KepUUc9K7lvowye4bMBhDTQOj4Z+mQA0ixtCFTI6K2ytIYlWGVTZax3PZxt16XqY7U
         OOWvs9mIIUR4vYSBuz55wb9GymhBMK+Xbfm/cu8bD69UbeQQLypsIssTs4DJKAs9q1Iz
         uj1RsRpjbD51Z3uBEY39P124/GLhhtzOpQFo9dARdsgwOoYE5EnST94cs2/QliKi+mPz
         ozM2JzDmvFNtHCMT+JRWqxnkLYSLg5kIia5JEwRrPUFqdcPLkDSMnq1VfZbL5SK8lAAU
         YjtCpddZVqn1ccO+Z4K+mQFVBoWNul6Dn2ArhAbywe1lFwuQ7E4aMT78zx3O6ZFlxIQs
         CMkw==
X-Gm-Message-State: APzg51Aczp07Cc2bMWTzBzNRVrhQhVKclRN3KxNW0rulu6lpAk2G/Zrn
        JgQonLLNCQ4sJLTh9Hit1uRKASRxeqj5diiYyz/pZw==
X-Google-Smtp-Source: ANB0VdaCZV3tJX9KnXc3dvSuOb7lLP5Ls8EwDUh58uDqiRT8tQ4fJCIr1S9SH4PWlhPa1pI9oLXDJSHLE3sSb2hZRq8=
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr1376237wme.51.1536597343065;
 Mon, 10 Sep 2018 09:35:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:35:42
 -0700 (PDT)
In-Reply-To: <20180910161143.GA1053@infradead.org>
References: <20180906140628.GA10580@infradead.org> <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de> <20180910161143.GA1053@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 10 Sep 2018 22:05:42 +0530
Message-ID: <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 9:41 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 06:07:12PM +0200, Thomas Gleixner wrote:
>> > Considering above, it is better to have a distinct irqchip and
>> > irq_domain for all local interrupts (just like this patch).
>>
>> If that's the future usage
>
> It's not, at least there has been no proposal for that so far, and I
> don't really think it is how the architecture was intended.
>
>> and that's what my impression was, under which I
>> changed my mind, yes, then having a domain model is certainly of advantage
>> especially when those things end up being different per SoC.
>
> And even if we went down the way of using the other bits it would
> be architectureal in the RISC-V spec - these are not available for
> vendor specific uses.

I am quite sure RISC-V spec does not restrict the use of other
local interrupts. Different CPU implementations can have their
own local interrupts.

Regards,
Anup
