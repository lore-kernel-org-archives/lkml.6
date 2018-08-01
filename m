Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB03BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F10020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh3+TLg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F10020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeHAUBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbeHAUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:01:52 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16E5208B0;
        Wed,  1 Aug 2018 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533147295;
        bh=9j0Y8LdezauvE+PECb8yRjqoq9KpJiRLyHl4Y2CY2ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dh3+TLg4lPIfgJuwafHqz7LARgMU134dsqSAyt/zpVI9/q37BYpTj1wY/OvJ9ecLq
         igOgN0xkAUFIrwFeOM/CW4RnzwQuHyIj2tFKjXkjyHkaohVD0fxn5zAScu1U7NP10z
         MJRblbCgHBqMj9LNPrFhb0gaMA0YsfIBOsh4LLl4=
Received: by mail-qt0-f170.google.com with SMTP id q12-v6so20927075qtp.6;
        Wed, 01 Aug 2018 11:14:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlGd/2Cm+IcqsZEIW4qOqzKEADo4BfwV20TrsQKg5yjGQ2RIrxmo
        LXXSfLg4VWodH4JfPc6JzoQ4DOfRT2WUKqZTgg==
X-Google-Smtp-Source: AAOMgpfGA5ZDswN47xX4X5jefwMUPuZ5bS3r0UDCdLQg3ysq38GI1LuI6xXCfPi9OqYgJiye6cVrbTv6hrCjoUhtTAI=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr25974280qtp.22.1533147294004;
 Wed, 01 Aug 2018 11:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-5-hch@lst.de>
 <20180731223714.GA12168@rob-hp-laptop> <20180801071307.GA20224@lst.de>
In-Reply-To: <20180801071307.GA20224@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Aug 2018 12:14:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdMuWVrPu+eNvVtui-Regs4FBi_5tk2-V1YrDyj9jB9g@mail.gmail.com>
Message-ID: <CAL_JsqJdMuWVrPu+eNvVtui-Regs4FBi_5tk2-V1YrDyj9jB9g@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: RISC-V local
 interrupt controller docs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 31, 2018 at 04:37:14PM -0600, Rob Herring wrote:
> > On Wed, Jul 25, 2018 at 11:36:47AM +0200, Christoph Hellwig wrote:
> > > From: Palmer Dabbelt <palmer@dabbelt.com>
> > >
> > > This patch adds documentation on the RISC-V local interrupt controller,
> > > which is a per-hart interrupt controller that manages all interrupts
> > > entering a RISC-V hart.  This interrupt controller is present on all
> > > RISC-V systems.
> > >
> > > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > > ---
> > >  .../interrupt-controller/riscv,cpu-intc.txt   | 41 +++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> >
> > My questions and comments on the prior version from Palmer remain.
>
> Can you point to these questions please?  I don't even rember when this
> was last posted as it must have been a long time ago.

It was just a month ago[1], but in googling for the links some
comments from the 1st posting a year ago[2] aren't addressed either.
That applies to the PLIC too.

Rob

[1] https://lkml.org/lkml/2018/7/3/1001
[2] https://lkml.org/lkml/2017/6/27/24
