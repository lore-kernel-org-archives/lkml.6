Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13425C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C254F2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Etj0mYAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C254F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeLFCas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:30:48 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36251 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFCas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:30:48 -0500
Received: by mail-yb1-f196.google.com with SMTP id w203so6114072ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zC2S0O8x2BqWz4XPnEW4Ujvl3xqsv0EQz+TgQBAGvqQ=;
        b=Etj0mYAwVdBYrcofq7zlhfWwMYxhR27yRzX0cBNo0gdVyU2pi1xDziRB8gdXpG8/5T
         OdGgjt0dC7/OtfyXcbQVCjpeOwIi7lRgTtscFT1P0sLVW0V2t6PZ7MXplrW2eee2xg7a
         dkjmZvYtI5hRzVppALjkx5MM/6IiOt7Di/v8ejmXTyT93Fewskg8o4ipQSi4PXD28DGd
         pzKVJIfO9ku1Eso27+iaLAx8ysjtjd93Wb68joEgSNEawcdmu+zuLMDyRIzOlXzMSAJV
         AoHpAK0AEN/n/fnFEFYrAsaU2v5ZElOh4NUke/dEs2y5QhfgMD5RxonJMQtaOCG9Z9L2
         HBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zC2S0O8x2BqWz4XPnEW4Ujvl3xqsv0EQz+TgQBAGvqQ=;
        b=CfpcjyaeaV5K85bCDtEjB+CDShxQfKJDRgY0EzxjCc4Nry4TBzNsC/D5pMtba/iTIe
         hsfl0rW5FIMHE2SyPpao1pK81BZlT5mFaCQB8fufyCbX0uX5wQozdFRSa7oXJeRrknyp
         38H3e2GS/b6Ldd/ZTzL/XRaw1HxuRVyUmmF7yzlSaXT2EUi/3LLWAIVg4sutNmgmhZOK
         v8+fNZQwXwOOfnR3aaauY7VHGQTCjFXoNmDlazsXOFZNwlwJNeTduSzFSZwY76a2hDu1
         cMrF5iaBBwbCFMsx8aqqfVpaD6+n8BTd0Qm8vWZEQ+uc6zEd/81z7w3c4hN7BvyfZ56p
         EHKw==
X-Gm-Message-State: AA+aEWYUVefp4tq3K8/+1szk7R12K7ahRnK2oh68ouIC++q5ievbBzUH
        3SPOagF5KPtP0RhE+3L1eH6YVA==
X-Google-Smtp-Source: AFSGD/XcxfBMFrH+0mgfQpJ9Qmc09m/hfdAIEMJLv+SvslB7cNNw5+7d+QRT4wGK1co3Kky6spXZSQ==
X-Received: by 2002:a81:a109:: with SMTP id y9mr26779268ywg.269.1544063446990;
        Wed, 05 Dec 2018 18:30:46 -0800 (PST)
Received: from localhost ([208.115.86.73])
        by smtp.gmail.com with ESMTPSA id w77sm9229093ywa.9.2018.12.05.18.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 18:30:46 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 5 Dec 2018 18:30:45 -0800 (PST)
To:     Atish Patra <atish.patra@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "paul@pwsan.com" <paul@pwsan.com>, Megan Wachs <megan@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wesley Terpstra <wesley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <eda63b4a-4371-7d34-38a0-d7136dfc417f@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1812051829540.16511@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com> <eda63b4a-4371-7d34-38a0-d7136dfc417f@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Wed, 21 Nov 2018, Atish Patra wrote:

> On 11/21/18 5:07 PM, Paul Walmsley wrote:
> > 
> > For IP blocks that are generated from the public, open-source
> > sifive-blocks repository, describe the version numbering policy
> > that its maintainers intend to use, upon request from Rob
> > Herring <robh@kernel.org>.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Megan Wachs <megan@sifive.com>
> > Cc: Wesley Terpstra <wesley@sifive.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> > 
> > Hi Rob, please let me know if this document works with your
> > requirements, or if some changes are needed.  - Paul
> > 
> >   .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > new file mode 100644
> > index 000000000000..b899e5c6e00c
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> 
> It should be be under
> Documentation/devicetree/bindings/riscv/sifive/sifive-blocks-ip-versioning.txt
> ?

These IP blocks could be used with any CPU architecture - ARM, x86, MIPS, 
etc. - so it probably makes sense just to keep them under sifive/, rather 
than associating them with a specific CPU architecture.

> > @@ -0,0 +1,38 @@
> > +DT compatible string versioning for SiFive open-source IP blocks
> > +
> > +This document describes the version specification for DT "compatible"
> > +strings for open-source SiFive IP blocks.  HDL for these IP blocks
> > +can be found in this public repository:
> > +
> > +https://github.com/sifive/sifive-blocks
> > +
> > +IP block-specific DT compatible strings are contained within the HDL,
> > +in the form "sifive,<ip-block-name><integer version number>".
> > +
> > +An example is "sifive,uart0" from:
> > +
> > +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> > +
> > +Until these IP blocks (or IP integration) support version
> > +autodiscovery, the maintainers of these IP blocks intend to increment
> 
> /s/autodiscovery/auto discovery

I've changed it to "auto-discovery" per your request.  Let me know if it's 
not OK for you

> > +the suffixed number in the compatible string whenever the software
> > +interface to these IP blocks changes, or when the functionality of the
> > +underlying IP blocks changes in a way that software should be aware of.
> > +
> > +Driver developers can use compatible string "match" values such as
> > +"sifive,uart0" to indicate that their driver is compatible with the
> > +register interface and functionality associated with the relevant
> > +upstream sifive-blocks commits.  It is expected that most drivers will
> > +match on these IP block-specific compatible strings.
> > +
> > +DT data authors, when writing data for a particular SoC, should
> > +continue to specify an SoC-specific compatible string value, such as
> > +"sifive,fu540-c000-uart".  This way, if SoC-specific
> > +integration-specific bug fixes or workarounds are needed, the kernel
> > +or other system software can match on this string to apply them.  The
> > +IP block-specific compatible string (such as "sifive,uart0") should
> > +then be specified as a subsequent value.
> > +
> > +An example of this style:
> > +
> > +    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > 
> 
> Just for the sake of completion, should this document also specify what should
> be the style of any possible closed IP as well?


Let's handle those separately, as Palmer discussed.

Thanks for the review,

- Paul
