Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14240C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDBA2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbaEznUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDBA2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeI1R4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbeI1R4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:56:07 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E212175C;
        Fri, 28 Sep 2018 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538134366;
        bh=erkh5YvxpWAvhwh/ahNznXGQANLp3Nam5E42Vsi608M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbaEznUFmRWxAwyFkOJG1sATrAyzhWLV2bCF0qeyln3vVhIyQjIIHndsGjnZAgSnU
         es7rWlZteDMMWJnwfTOZ2lsj2XQaL8Kqur4Q4gzIfiPa5OiSmt3PLLwd0WT4MMePHB
         oXTq0IFANQNjxuWDyOL12ZwtMLPhc4UB/QUEIBME=
Received: by mail-qt1-f182.google.com with SMTP id c25-v6so6183820qtp.6;
        Fri, 28 Sep 2018 04:32:46 -0700 (PDT)
X-Gm-Message-State: ABuFfohOXoeV0JrUW6FyJj/pA28M5ln8+qbH4wGyxfLtAkOF0UzxW0xB
        NDAyKMZU1nkxBaPR+aFtYM9jL8TAjKSm4xKJnA==
X-Google-Smtp-Source: ACcGV6178ZjO9bDEDJTA7hWY5yGhr2xFrh2WSSJ8vGfnTLuGCkMqcOHsXwR/Klj5XTuUzuM0lTBnUrOMtrzQUxe7+Ds=
X-Received: by 2002:ad4:404a:: with SMTP id r10-v6mr11594967qvp.246.1538134365259;
 Fri, 28 Sep 2018 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537789736.git.ren_guo@c-sky.com> <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1537789737.git.ren_guo@c-sky.com>
 <20180927164317.GA8427@bogus> <20180928010312.GA4179@guoren-Inspiron-7460>
In-Reply-To: <20180928010312.GA4179@guoren-Inspiron-7460>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 06:32:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNPzTy_vE3HjdKhsXq+jtsCMS8RyWvppSB8sJaV1WZ9A@mail.gmail.com>
Message-ID: <CAL_JsqJNPzTy_vE3HjdKhsXq+jtsCMS8RyWvppSB8sJaV1WZ9A@mail.gmail.com>
Subject: Re: [PATCH V5 18/30] dt-bindings: csky CPU Bindings
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:03 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Thu, Sep 27, 2018 at 11:43:17AM -0500, Rob Herring wrote:
> > On Tue, Sep 25, 2018 at 07:39:21AM +0800, Guo Ren wrote:
> > > This patch adds the documentation to describe that how to add cpu nodes in
> > > dts for SMP.
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > ---
> > >  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
> > >  1 file changed, 70 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> > > new file mode 100644
> > > index 0000000..ee3901d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> > > @@ -0,0 +1,70 @@
> > > +==================
> > > +C-SKY CPU Bindings
> > > +==================
> > > +
> > > +The device tree allows to describe the layout of CPUs in a system through
> > > +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> > > +defining properties for every cpu.
> > > +
> > > +Only SMP system need to care about the cpus node and single processor
> > > +needn't define cpus node at all.
> >
> > We've generally found this is not true. Even for single core, you can
> > have power domains, clocks for DVFS, etc.
> Ok, I'll remove it.
>
> >
> > > +
> > > +=====================================
> > > +cpus and cpu node bindings definition
> > > +=====================================
> > > +
> > > +- cpus node
> > > +
> > > +        Description: Container of cpu nodes
> > > +
> > > +        The node name must be "cpus".
> > > +
> > > +        A cpus node must define the following properties:
> > > +
> > > +        - #address-cells
> > > +                Usage: required
> > > +                Value type: <u32>
> > > +                Definition: must be set to 1
> > > +        - #size-cells
> > > +                Usage: required
> > > +                Value type: <u32>
> > > +                Definition: must be set to 0
> > > +
> > > +- cpu node
> > > +
> > > +        Description: Describes one of SMP cores
> > > +
> > > +        PROPERTIES
> > > +
> >
> > You need a compatible property for cpu nodes.
> Our cpu is defined in defconfig, not in dts. I could put a comatible
> property in here, but it's no use in code.

It doesn't matter as that could change. Most arches do run-time
selection of cpus within a range of compatible cores.

And read the DT spec (devicetree.org) which says compatible is
required for cpu nodes.

Rob
