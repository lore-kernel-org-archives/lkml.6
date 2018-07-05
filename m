Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24D4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712C2401B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akp9tPq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9712C2401B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGEHvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:51:42 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41004 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:51:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so15077547oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pyrdzAFIxotjKzkoHqh34v/9FEJT9ksPQdxWc/3HYVc=;
        b=Akp9tPq62nhjfblwxRvqmwT8NITZMLtvkJ2h3nZXLRl7sa+cdW9sRl3z+y0iQv+V1L
         RughbG4LmpqbEmmGgv44LVV59hgkVJeI5Gc8WxMu1xa36m8GuZMCrlArvrQ4dtveLD1y
         +cuz27u3Yv3HQ/U98JoTuAqVySIK/XoP4jAEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pyrdzAFIxotjKzkoHqh34v/9FEJT9ksPQdxWc/3HYVc=;
        b=qiwwvWWFkLq+eXjaa5meH04EV9GvnFFEcen2PKtNK/kdF4+Lw7FdRnMKyNNMpW4Chy
         CJ+QwfjKThXkR9blo+NgCXe0BMWiCB4JSEFQ1PE07K3tad3W0F1+KEMJ0hAn25/4N4Lh
         qApUVo/6hZj/vvIT4FGXFEltQLdbnXlTLh+5AbnJr7bTTbRgfigrbBR8i7NeGPI3hrX0
         pbpkEh74KYGrz7Zo1gkhOKnRpnky33nio/h7h1AqWwE0W/Ko2NRBprsEli7lCrl2f6Pb
         QXcI03QFdHImaa2/0bCtdawzdMEJZUOf1cHRG2O5lOy656iB5MZV4xa/l81Ee5/wdzX4
         9j1w==
X-Gm-Message-State: APt69E1n1cHkHLUS9AlbwX/KmYNLzhsV13UlsC0EqPJmgM3UIsIx3ldD
        Ft+GgPiVeIhy7HL0B+ff1Z0Kuhhc/NRmYBlU7tVwlw==
X-Google-Smtp-Source: AAOMgpcpSGoWQOlonlrfNK6lufv4tP0PtrIwRMx04/nxWLizC7823PFldn4cHUC47gWpEhLe36LMXHtYPBjJd+Df244=
X-Received: by 2002:aca:ce0f:: with SMTP id e15-v6mr5831200oig.13.1530777099835;
 Thu, 05 Jul 2018 00:51:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:554d:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 00:51:19 -0700 (PDT)
In-Reply-To: <20180704155123.GO4828@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
 <20180704142241.GG4828@arm.com> <8636wzysfl.wl-marc.zyngier@arm.com> <20180704155123.GO4828@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 5 Jul 2018 08:51:19 +0100
Message-ID: <CAFEAcA9wgnbK8PHMvksezHqgN1BQZd_+sxXCe85AW+E+cfrcXg@mail.gmail.com>
Subject: Re: [kvmtool test PATCH 24/24] kvmtool: arm: Add support for creating
 VM with PA size
To:     Will Deacon <will.deacon@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        kvm-devel <kvm@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 16:51, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jul 04, 2018 at 03:41:18PM +0100, Marc Zyngier wrote:
>> Not really. Let's say I want my IPA space split in two: memory covers
>> the low 47 bit, and I want MMIO spanning the top 47 bit. With your
>> scheme, you'd end-up with a 47bit IPA space, while you really want 48
>> bits (MMIO space implemented by userspace isn't registered to the
>> kernel).
>
> That still sounds quite niche for a VM. Does QEMU do that?

Not at 47 bits, but we have RAM up to the 256GB mark, and
MMIO above that (including a large PCI window), so the general
arrangement of having the top end of the IPA space not
necessarily be things we've told the kernel about definitely
exists.

thanks
-- PMM
