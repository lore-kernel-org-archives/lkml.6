Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745ECC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FB820831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1EGTIqaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FB820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKCGRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCGRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:17:14 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7C520862
        for <linux-kernel@vger.kernel.org>; Fri,  2 Nov 2018 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541192911;
        bh=okCr7TtU05t1jfc0bpOXfrSTGbI/hRDPuk9ZzZjNq3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1EGTIqaMnZ20WvwhrK5HJyKVXq+8oGrclAwcKwhe6KGPk/tWCDuXruwFjHJMHl/mC
         zec748CUpp6hh3JnYmZikYdQslK3KRiciR4vtCM2g06v1I8yLGkzTPOSrH8/Tra/wr
         AXGhHX6wcfzkqRuZ67Blfq0324kiMHAonhgX0+4E=
Received: by mail-wr1-f42.google.com with SMTP id y3-v6so2982337wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:08:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIdyMrDNljV7fHZkX9pNH/l4USjkIH+GFIPQ86R55L6GdbhgA3L
        tGmEYKzRn76JY4AohT89xg/4Tl3IbROkndH3NuCx+w==
X-Google-Smtp-Source: AJdET5e7Yccl7fKvI7Tx3fYJeOCwlXKiHRRXThPjUIIWEMgfJ3Y2vHTkvYMlscJuR+Hpjo+pS0Aj4GjdMlg9Ea+NhUE=
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr11379896wrp.61.1541192909398;
 Fri, 02 Nov 2018 14:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <1541113468-22097-2-git-send-email-atish.patra@wdc.com> <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
 <20181102133100.GA13130@e107155-lin> <CAL_JsqLO+cOcHkr41ebPtONwrzOWGhksH1ypph+tihsuOVDOug@mail.gmail.com>
 <20181102155038.GA21067@e107155-lin> <0c94f752-cc18-ae0c-36e7-7e0dd6b1d307@wdc.com>
In-Reply-To: <0c94f752-cc18-ae0c-36e7-7e0dd6b1d307@wdc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Nov 2018 16:08:17 -0500
X-Gmail-Original-Message-ID: <CABGGisyMM1hrRp5Cv5UPx6U+m5cQGYmDUTHJ0PeA9nE7vLqyLQ@mail.gmail.com>
Message-ID: <CABGGisyMM1hrRp5Cv5UPx6U+m5cQGYmDUTHJ0PeA9nE7vLqyLQ@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     atish.patra@wdc.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        Anup Patel <anup@brainfault.org>, hch@infradead.org,
        Damien.LeMoal@wdc.com, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, alankao@andestech.com,
        Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:53 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 11/2/18 8:50 AM, Sudeep Holla wrote:
> > On Fri, Nov 02, 2018 at 10:11:38AM -0500, Rob Herring wrote:
> >> On Fri, Nov 2, 2018 at 8:31 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>
> >>> On Fri, Nov 02, 2018 at 08:09:39AM -0500, Rob Herring wrote:
> >>>> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
> >>>>>
> >>>>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
> >>>>> But it doesn't need a separate thread node for defining SMT systems.
> >>>>> Multiple cpu phandle properties can be parsed to identify the sibling
> >>>>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
> >>>>> So package is a better word choice than cluster for RISC-V.
> >>>>
> >>>> There was a proposal to add package info for ARM recently. Not sure
> >>>> what happened to that, but we don't need 2 different ways.
> >>>>
> >>>
> >>> We still need that, I can brush it up and post what Lorenzo had previously
> >>> proposed[1]. We want to keep both DT and ACPI CPU topology story aligned.
> >>
> >> Frankly, I don't care what the ACPI story is. I care whether each cpu
> >
> > Sorry I meant feature parity with ACPI and didn't refer to the mechanics.
> >
> >> arch does its own thing in DT or not. If a package prop works for
> >> RISC-V folks and that happens to align with ACPI, then okay. Though I
> >> tend to prefer a package represented as a node rather than a property
> >> as I think that's more consistent.
> >>
> >
> > Sounds good. One of the reason for making it *optional* property is for
> > backward compatibility. But we should be able to deal with that even with
> > node.
> >
>
> If you are introducing a package node, can we make cluster node
> optional? I feel it is a redundant node for use cases where one doesn't
> have a different grouped cpus in a package.

Certainly not. A common doc can make every level optional and each
arch can define what's mandatory.

> We may have some architecture that requires cluster, it can be added to
> the DT at that time, I believe.
>
> >> Any comments on the thread aspect (whether it has ever been used)?
> >> Though I think thread as a node level is more consistent with each
> >> topology level being a node (same with package).
> >>
> > Not 100% sure, the only multi threaded core in the market I know is
> > Cavium TX2 which is ACPI.
> >
>
> Any advantages of keeping thread node if it's not being used. If I am
> not wrong, we can always use multiple cpuN phandles to represent SMT
> nodes. It will result in less code and DT documentation as well.

It's more consistent to make each level a node IMO and we've already
discussed and defined it this way. I don't see how it's really less
code or documentation.

BTW, powerpc defined threads with multiple reg entries in the cpu
nodes. You could do that if you wanted.

Rob
