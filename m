Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57769C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BB32081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTM5Fh9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BB32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeKFFcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbeKFFcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:32:10 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0742086A;
        Mon,  5 Nov 2018 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541448649;
        bh=Zv2B+mhtmaoNujKxOuDJSpSGoeGTK5ri2wKqNhmkh3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTM5Fh9rU9Ak4R8/jHEFgnXrwmu1z03sB8hgK4aBMSbkcHNqaQsfusZ+ukLP0Nt7B
         IOcqB3gIVQ1xJtJW1aUwv9vTYfiRW58ZAX5GnWxpbqW+28VGAs04b9IKiJmghhVb55
         dVgOv41xj9L/PnkZ7ud8fEJk3jH0D4MnHon8Ds5s=
Received: by mail-qk1-f170.google.com with SMTP id v68-v6so17101748qka.2;
        Mon, 05 Nov 2018 12:10:49 -0800 (PST)
X-Gm-Message-State: AGRZ1gIBGVHxg+LhxGK2gN5PfvqILAJKTUcST1cyZHK50Ub9HRJs/TvM
        y9MDWFUEe6zC1mRbjdHlbsmL6MwcVk41lRPsOw==
X-Google-Smtp-Source: AJdET5eTsZZoUbc/PRbLnGki8BKzSjnJ5+YGjaPBq5YJcbRH21xxOWRGIYEtr19hjL0j/1Rv2o76l/qdmQbAVl0ngwA=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr21211649qkg.184.1541448648384;
 Mon, 05 Nov 2018 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
 <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
In-Reply-To: <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Nov 2018 14:10:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOxdE=gD4MyKuL5XZ57Z6UdM4_SU4qs26BNz6YcqM76A@mail.gmail.com>
Message-ID: <CAL_JsqJOxdE=gD4MyKuL5XZ57Z6UdM4_SU4qs26BNz6YcqM76A@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, alankao@andestech.com,
        Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 1:39 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 02 Nov 2018 06:09:39 PDT (-0700), robh+dt@kernel.org wrote:
> > On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
> >>
> >> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
> >> But it doesn't need a separate thread node for defining SMT systems.
> >> Multiple cpu phandle properties can be parsed to identify the sibling
> >> hardware threads. Moreover, we do not have cluster concept in RISC-V.
> >> So package is a better word choice than cluster for RISC-V.
> >
> > There was a proposal to add package info for ARM recently. Not sure
> > what happened to that, but we don't need 2 different ways.
> >
> > There's never going to be clusters for RISC-V? What prevents that?
> > Seems shortsighted to me.
> >
> >>
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> ---
> >>  .../devicetree/bindings/riscv/topology.txt         | 154 +++++++++++++++++++++
> >>  1 file changed, 154 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt b/Documentation/devicetree/bindings/riscv/topology.txt
> >> new file mode 100644
> >> index 00000000..96039ed3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
> >> @@ -0,0 +1,154 @@
> >> +===========================================
> >> +RISC-V cpu topology binding description
> >> +===========================================
> >> +
> >> +===========================================
> >> +1 - Introduction
> >> +===========================================
> >> +
> >> +In a RISC-V system, the hierarchy of CPUs can be defined through following nodes that
> >> +are used to describe the layout of physical CPUs in the system:
> >> +
> >> +- packages
> >> +- core
> >> +
> >> +The cpu nodes (bindings defined in [1]) represent the devices that
> >> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
> >> +Simultaneous multi-threading (SMT) systems can also represent their topology
> >> +by defining multiple cpu phandles inside core node. The details are explained
> >> +in paragraph 3.
> >
> > I don't see a reason to do this differently than ARM. That said, I
> > don't think the thread part is in use on ARM, so it could possibly be
> > changed.
> >
> >> +
> >> +The remainder of this document provides the topology bindings for ARM, based
> >
> > for ARM?
> >
> >> +on the Devicetree Specification, available from:
> >> +
> >> +https://www.devicetree.org/specifications/
> >> +
> >> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
> >> +value must point to a cpu node compliant with the cpu node bindings as
> >> +documented in [1].
> >> +A topology description containing phandles to cpu nodes that are not compliant
> >> +with bindings standardized in [1] is therefore considered invalid.
> >> +
> >> +This cpu topology binding description is mostly based on the topology defined
> >> +in ARM [2].
> >> +===========================================
> >> +2 - cpu-topology node
> >
> > cpu-map. Why change this?
> >
> > What I would like to see is the ARM topology binding reworked to be
> > common or some good reasons why it doesn't work for RISC-V as-is.
>
> I think it would be great if CPU topologies were not a RISC-V specific thing.
> We don't really do anything different than anyone else, so it'd be great if we
> could all share the same spec and code.  Looking quickly at the ARM cpu-map
> bindings, I don't see any reason why we can't just use the same thing on RISC-V
> -- it's not quite how I'd do it, but I don't think the differences are worth
> having another implementation.  Mechanically I'm not sure how to do this:
> should there just be a "Documentation/devicetree/bindings/cpu-map.txt"?

Yes, but ".../bindings/cpu/cpu-topology.txt".

And if we need $arch extensions, they can be moved there. (Really, I'd
like to get rid of /bindings/$arch/* except for maybe a few things.)

> If everyone is OK with that then I vote we just go ahead and genericise the ARM
> "cpu-map" stuff for CPU topology.  Sharing the implementation looks fairly
> straight-forward as well.
