Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9232FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865B2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544190969;
	bh=9U0OX/5xeDsbOuEsPWWOkrNikvceTJpvJOYWI9L/Cmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yc2hWwfWgDdJBO6GhE9+sNhzbijKA6IH1SIkoRPlwZnOAdyFSwLWmO/f2AcU0eR3B
	 2GVl6PygcLsa8lxMipUESiH5PCa6RLStnJaszbvi4j+oKocXdvneROGjdRhq+ahUpG
	 KxS6YhPtVLEZ/U33cLEytHCnsS2aioMKdZHKo5C8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5865B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLGN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeLGN4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:56:05 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEF22146D;
        Fri,  7 Dec 2018 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544190965;
        bh=9U0OX/5xeDsbOuEsPWWOkrNikvceTJpvJOYWI9L/Cmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s00IBoPVv0ha+owBExjnNoUX7pEsYgeLqhWH/mZv8kXEI1lQ9vnQmcZ6BJUfF1E46
         bmyJssXcqDp7r3B0Relrx0G1NgKg7/MLonWiqo725dKqXTrEOg4O4WsFV5I+yQ+4LF
         vXXUywzRFE7Ux/pJof7L5E+KGacB+KpfFO3njo2E=
Received: by mail-qk1-f175.google.com with SMTP id q70so2441275qkh.6;
        Fri, 07 Dec 2018 05:56:04 -0800 (PST)
X-Gm-Message-State: AA+aEWa81a7CCsC/Exbwll1+M0cAsoWC2lerI4JiIPR7WFrCSQEPGLlT
        H0Co6viiBA9xNj7adSiIw/1vux4PWJ0JitblDw==
X-Google-Smtp-Source: AFSGD/VwL9rISYKulfb3/dajjR5ko5f5mSBBHnBCon5WCu2Jlh8hS3hsvSMHqqEmFkgv/fGosEkLBhj94YKLlCdS8Mk=
X-Received: by 2002:a37:b646:: with SMTP id g67mr1908938qkf.326.1544190964068;
 Fri, 07 Dec 2018 05:56:04 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
 <20181207000104.GA10814@bogus> <alpine.DEB.2.21.9999.1812061645070.29609@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1812061645070.29609@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Dec 2018 07:55:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgt3VxHLcxY54Ojpqz_bLwGSySZ9meowgy6pnLPdXuLQ@mail.gmail.com>
Message-ID: <CAL_JsqJgt3VxHLcxY54Ojpqz_bLwGSySZ9meowgy6pnLPdXuLQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
>
> On Thu, 6 Dec 2018, Rob Herring wrote:
>
> > On Wed, Nov 21, 2018 at 05:06:56PM -0800, Paul Walmsley wrote:
> > >
> > > For IP blocks that are generated from the public, open-source
> > > sifive-blocks repository, describe the version numbering policy
> > > that its maintainers intend to use, upon request from Rob
> > > Herring <robh@kernel.org>.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Palmer Dabbelt <palmer@sifive.com>
> > > Cc: Megan Wachs <megan@sifive.com>
> > > Cc: Wesley Terpstra <wesley@sifive.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-riscv@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >
> > > Hi Rob, please let me know if this document works with your
> > > requirements, or if some changes are needed.  - Paul
> >
> > Looks pretty good to me.
> >
> > >  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> >
> > Use the path that was suggested.
>
> Could you remind me which one that is?

In this thread: bindings/riscv/sifive/

> > > +
> > > +An example is "sifive,uart0" from:
> > > +
> > > +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> >
> > That's nice, but will be out of date as soon as someone adds or removes
> > a line above it. Can you point to a tagged version?
>
> Will do
>
> - Paul
