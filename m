Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72819C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B12151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eKGcVeVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85B12151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeIZVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:52:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:52:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so13635093pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ryMq0n4NXyX3k8D/c32IFSadA4m4EEH+Y5xbYnB+Hc0=;
        b=eKGcVeVIyRSSDYdqH72gislg/jVrDS7Ln7ETE+jMIRL8MP+gLI6hMO6Agf0lBpWvNz
         Bks5wjj1woObolUKiPq6SvvcwVaDlt4H6JX2JB8D/glol8uidqiOUUvaHumrQMWynfx7
         VOz/AiYS/I6G5hhjkG76gxG2sCtBhnSNRdpd8IqV1HtgRWEV1FDtz3stmjvjTbmWxbXa
         xRQ3v0nDVRIrR1oYrNG2deJzLCreV8oMOMsLQynE29Vz7YXdcx1myKtE7gxFDdGdxCJK
         jvgU31KI67d0VZqPf7qmRzDeUVvF6F9Ip2KN2K9IFUx868b6ThhtD2DTRAbJ/tG9GrQQ
         xdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ryMq0n4NXyX3k8D/c32IFSadA4m4EEH+Y5xbYnB+Hc0=;
        b=alq7dknC5CIeez33o/c9ve7osS+Hu99DzbcA3rKiga5EaXB8q5bzp/yzLbDF1HIfZ3
         leq9GhYc3QSC5Z4Y7wgaBMWfZbb5A3XTCXYhmYm+hXck9Z/rIS+JE56kH6SoPRZQnNSE
         AtP/DipVcb44zRqc5Uqn7ZbUZrRoz+pgLGZz4u09mHrw/2aPpi+CJIh8WR7OcGOUfZIK
         uc6juy8wMvO1nzWRxCq+bCB6N61AP70mIuwU0ODg4RiV3330fQKftWiutXFHdtRbWgGu
         AMQenm7jpE7/XkQ3yhqavqvN7wYt6oVaowa2zzZQd6nisScVD0eszU5iMqLbxFrfdW7v
         hZIg==
X-Gm-Message-State: ABuFfojHvJu8vBMa82cQzP7hmCrrZBEHkINg9z9Vf6iZiSWhpWbp3wui
        zViUmfNmsUAHs867pf8n+GkW4Q==
X-Google-Smtp-Source: ACcGV637AqhV98vrITMlEZ53kM9fM9VzELlYiskQSudBqu63ymmnGczPqNu9xvmS4nu6xx8rCDpf5g==
X-Received: by 2002:a63:2441:: with SMTP id k62-v6mr6329727pgk.26.1537976334660;
        Wed, 26 Sep 2018 08:38:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f13-v6sm7660662pgs.92.2018.09.26.08.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 08:38:53 -0700 (PDT)
Date:   Wed, 26 Sep 2018 08:38:53 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Sep 2018 08:19:44 PDT (-0700)
Subject:     Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <CAAhSdy3unGBSS9Xgozwt4so_RBOr1WSugiP-4J49q-GOub2mDQ@mail.gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, atish.patra@wdc.com,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-0d0ee718-944f-4798-a6d8-e14f6ad51c37@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 22:54:48 PDT (-0700), anup@brainfault.org wrote:
> On Mon, Sep 17, 2018 at 7:58 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Mon, Sep 17, 2018 at 7:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>> >
>> > On Mon, Sep 10, 2018 at 10:08:58PM +0530, Anup Patel wrote:
>> > > > They could in theory IFF someone actually get the use case through
>> > > > the riscv privileged spec working group.
>> > >
>> > > Their is no point in having each and every possible local interrupts
>> > > defined by RISC-V spec because some of these will be CPU
>> > > implementation specific in which case these local interrupts will
>> > > be described in platform specific DT passed to Linux.
>> >
>> > Again, to legally have implementation specific local interrupt types
>> > you'll first need to convice the spec to change the status for those
>> > fields from reserved to implementation specific.
>>
>> I agree, this needs to be first clarified in RISC-V spec. May be this is
>> a good topic for discussion in any upcoming RISC-V meetup.
>>
>> Until then anyone can try these patches from riscv_intc_v2 branch of
>> https://github.com/avpatel/linux
>>
>
> I released that CLIC is going to be available for both M-mode and S-mode.
> Software can choose to use HLIC or CLIC based on it's own preference.
>
> If we are going to support both HLIC and CLIC in Linux kernel for per-CPU
> local interrupts then we should definitely have irqdomain and irqchip for
> per-CPU local interrupts. The selection between HLIC and CLIC will be
> based on which driver gets probed via DT.

Yes, and note that the CLIC is actually an extension of what is currently 
available.  Thus we could produce a single driver that supports both, with 
features selected based on a DT entry.

I'm not sure if a native CLIC driver buys us anything in Linux, though, as 
IIRC there aren't that many CLIC features that will be particularly useful in 
our space.
