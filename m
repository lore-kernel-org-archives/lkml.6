Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F7AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D354D20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OR+dtauK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D354D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeIJV1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:27:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50478 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeIJV1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:27:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so22234400wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y8o8dFPM6zwrUbeVMshpaO9zSXnOweyOOT+vxSZ/GYw=;
        b=OR+dtauKFWxaJfE77Q0R9bxq/ais8PQHhdA5HW03RqlcTAG7voCCAdUzlbleUfUT+S
         eez50CAf/LuLJxegL2XG08Mxvx9eQhFFSWmFMj1eTOHqAMSjFBKv5prnsKOyS7xVNJfa
         ih6FPc7Gmtgfj6fiZ+95r4ssLMwrjOtkjEDqmcJHyECuwCjoYajRuhxbkIcj3XJ3OyIW
         mFIFb19/hcXh1U16NKu7efQiWaiBFc7YPY5/Ur1EnNWbcf+mPmvMpAGY/vmA5qNwQ5Sr
         HBUauHebcbTSHCH/NyCpFK40pjd9tdVc9aKYtUWuLWzPIH5rfZcQtqvMupfLvTXHdiOJ
         kbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y8o8dFPM6zwrUbeVMshpaO9zSXnOweyOOT+vxSZ/GYw=;
        b=XrTwLNkpj4ikpcflga8VXmtSIZw6QdLdh5V01yZjcXbEFtXoRoUb2pOP+V60aelNFh
         xH9vc1O7ZZ7veG9uSW72cP+WJMAvOp6hWRknujH01haZQqxDULHI6snSKTWmRa4HJKms
         hapeCRrjr8onAsA14Jczd4yCnRjbq5wvrM1ZWsp/HWscJe54a/0M4wuDFSYvJ4Y8cKa1
         pvfJl/2Zwx2XCgUWF45PqneA2L7RBhFrgvydUAi53LKRghQjwVEM/3/kF9BydQE479Hw
         8wIjqJSNdK+jNlVU64IqeBgwKro0IRY2cv3qiyf0GnO7oh9jjpNcKSsWMhDor6DC7t6d
         27PA==
X-Gm-Message-State: APzg51CgwX6j9+PkoYVmlO+kcsakQmIfx4VWv4bpg4pfkBb5V82iZUd0
        ReedBOCgHm7LQiuxhYUNSMkO17pv+AYLgpwcGszwzw==
X-Google-Smtp-Source: ANB0VdYIKzbbEfziFLAWmrPEpe3k93KVhpGw1f3VGLN9phl2JVyRi/7p5ml62VER4wYLw6eyI70QyvZBGhJHggzL6ug=
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr1365809wme.51.1536597130197;
 Mon, 10 Sep 2018 09:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:32:09
 -0700 (PDT)
In-Reply-To: <20180910161328.GA13171@infradead.org>
References: <20180906123651.28500-4-anup@brainfault.org> <20180906140628.GA10580@infradead.org>
 <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <20180910161328.GA13171@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 10 Sep 2018 22:02:09 +0530
Message-ID: <CAAhSdy2Y-XTZ12i5aV+SzraMZP1YQBhAArpER-YssPcBJNOPOA@mail.gmail.com>
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

On Mon, Sep 10, 2018 at 9:43 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 07:59:15PM +0530, Anup Patel wrote:
>> > Yes.  external is chained and IPI is still handled explicitly.
>>
>> On riscv64, there are 64 local interrupts (i.e. per-CPU interrupts).
>
> There aren't.  There are 9 right now, which are your three below:

You are thinking very much in-context of SiFive CPUs only.

Lot of SOC vendors are trying to come-up with their own CPUs
and RISC-V spec does not restrict the use of local interrupts.

The mie/mip/sie/sip/uie/uip are all machine word size so on
riscv64 we can theoretically have maximum 64 local interrupts.

>
>> Three of these local interrupts have clearly defined use:
>> 1. Software interrupt (inter-processor interrupt)
>> 2. External interrupt (interrupt from PLIC)
>> 3. Timer interrupt (interrupt from per-CPU timer)
>
> multiplied by 3 for machine, supervisor, user.

Yes, 3 per-CPU interrupts for each CPU mode which
makes it 9 per-CPU interrupts.

In fact, initial intention was to have these separate for
each mode but there is not restriction as explained by
Andrew Waterman on ISA-DEV:

"One key point is that UIRQ, SIRQ, and MIRQ are just names; the letters
U, S, and M don't actually connote anything about privilege.  UIRQ,
SIRQ, and MIRQ are three different interrupt lines on equal footing.
The prefix letters merely reflect the intended use case.  So only one
version of this description is necessary.  I'll try to rewrite a
version with a few corrections."

>
>> Other local interrupts are available for future use.
>
> The others aren't even defined as other interrupts, but just reserved
> fields.  And only one bit per privilege level would even fit into the
> encoding scheme used right now.

That's how it is implemented on SiFive CPUs.

This does not mean we will not have more per-CPU interrupts
in-future.

Regards,
Anup
