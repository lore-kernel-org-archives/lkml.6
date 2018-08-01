Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06271C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB312083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZl7Dt1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB312083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbeHAUNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732853AbeHAUNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:13:44 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867FE208B2;
        Wed,  1 Aug 2018 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533148003;
        bh=pVM4BKnqPi2fTlZ24OtIL8k403Y3Tzpvs4BzktUQv8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZl7Dt1J964KzSAnbqbENXnqCuHcco4A/BX1iqS8qd5U5ckrJBugZmqIxq5oMBZZ2
         xi2IhBQ8AvVQeTlipu/356C3pvzO5Z4Jeh/oLEMXhpyjqYebwbCaTGfwTBMSdGUWA9
         FN0oGe9w6UNOE7lFxqrhaFaqkJ+zc5KokWEXHjzg=
Received: by mail-qt0-f180.google.com with SMTP id y5-v6so20956795qti.12;
        Wed, 01 Aug 2018 11:26:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlFpF7J28w14BN9usBV5GFE7ylZ4svsgLUV6qTU/SX6uv2mkNSQo
        29JVRz1m0sUlBMLRU1d+Lw8BY/vmuVqPwMlT8g==
X-Google-Smtp-Source: AAOMgpfbveaOBEqO4hnRviQDBecN9z7SCh2rVrgPjpeVRtsBJj3N6iNf1i0bwvFPNhjpeP1kWhedFAYSKTGzqMnGApA=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr27572573qta.60.1533148002668;
 Wed, 01 Aug 2018 11:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-7-hch@lst.de>
 <20180731224630.GB12168@rob-hp-laptop> <20180801071635.GC20224@lst.de>
In-Reply-To: <20180801071635.GC20224@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Aug 2018 12:26:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com>
Message-ID: <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC documentation
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

On Wed, Aug 1, 2018 at 1:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 31, 2018 at 04:46:30PM -0600, Rob Herring wrote:
> > Perhaps this should be 'sifive,plic0'
>
> Excepet for the fact this the old name has already been in shipping
> hardware and release of qemu and other emulators it should.

Not really my problem that they didn't follow the process and upstream
their binding first. But this alone is just a string identifier, so I
don't really care that much. If things are really a mess, then the
next implementations will have to have better compatible strings. More
likely, I'll just see folks trying to add various properties to deal
with all the differences.

You could always define a better compatible and leave 'riscv,plic0' as
a fallback to avoid breaking things.

> > Normally this would have an SoC specific compatible too. Sometimes we
> > can get away without, but it doesn't seem like the PLIC is very tightly
> > specified nor has common implementations.
>
> It is a giant f***cking mess to be honest.  Adding a highlevel spec
> to the ISA but not a register layout is completely idotic, but if you
> look at the current riscv-sw list this decision is still defended by
> SiFive / the RISC-V foundation.  The whole stale of the RISC-V platform
> Ecosystem is rather pathetic unfortunately, and people don't seem to
> be willing to learn from past good practice nor mistakes in ARM land.

Interrupt controllers are where the differentiation is. ;)

Rob
