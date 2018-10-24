Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63150ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CA420833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CA420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJYCBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:01:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35974 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYCBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:01:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so5860286otg.3;
        Wed, 24 Oct 2018 10:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5eK/ys7qQlVoNj6YzRGQKlOu50hpT9TYqptst3BzI6w=;
        b=WZV7jacpgKGR5J1+9uVJVOp5bgT2lcBQzZZoOTVDB8iUiYxfJLEg8oPGUEKXgjt2SO
         ouD+t9AcKegmJk4+DMuzdJgrgy2XYiSsDKQsjZg2t4NXor6ibvkLIrG76hzl96XvJlX9
         ZK9NBUSbPYlTLe3Ri3djx651+76hfVEDzt0jZ1E2DJ8ZTHeoBht5o72PXOBPCkC7NNjo
         Px40f57OHI6tAWIgO3abThpyix5vraPGz6eiar7V0cUwLOkvqyuz6Ak0YNf4VJWYhIlW
         0YWB8TZEngeA3EfCy7iFqXQ1J01XFsExweaCnHxbAzuutgwqiIEWco/ohRj365GJJitm
         81bg==
X-Gm-Message-State: AGRZ1gKcjteF5WzLvWVszSCBArs5kocrwJB2ureIlJcdCAeaJcsQKTMa
        o9B87Cx6SbKgL7p4aAorBru6fnU=
X-Google-Smtp-Source: AJdET5e4ZDG1ZrIAdc/aWVV2PG76YYa2QCWXEC7CQMpPM3R8sG/EbEWtdsIMqb+D5MC8gAQ01fB9Ew==
X-Received: by 2002:a9d:7455:: with SMTP id p21mr2053108otk.247.1540402354631;
        Wed, 24 Oct 2018 10:32:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p6sm2015763otc.43.2018.10.24.10.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:32:33 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:32:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
Message-ID: <20181024173232.GB5652@bogus>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com>
 <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
 <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
 <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
 <6571bb0e-b36a-1196-4d90-8aa62d8a2a90@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6571bb0e-b36a-1196-4d90-8aa62d8a2a90@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:05:40AM -0700, Paul Walmsley wrote:
> 
> On 10/20/18 7:21 AM, Rob Herring wrote:
> > On Fri, Oct 19, 2018 at 5:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > > On 10/19/18 1:45 PM, Rob Herring wrote:
> > > > On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > > > > Add DT binding documentation for the Linux driver for the SiFive
> > > > > asynchronous serial IP block.  Nothing too exotic.
> > > > > 
> > > > > Cc: linux-serial@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Cc: linux-riscv@lists.infradead.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: Palmer Dabbelt <palmer@sifive.com>
> > > > > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> > > > > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > > > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > > > ---
> > > > >    .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
> > > > >    1 file changed, 21 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > > > new file mode 100644
> > > > > index 000000000000..8982338512f5
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > > > @@ -0,0 +1,21 @@
> > > > > +SiFive asynchronous serial interface (UART)
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> > > > > 
> > > > As I mentioned for the
> > > > intc and now the pwm block bindings, if you are going to do version
> > > > numbers please document the versioning scheme.
> > > > 
> > > > 
> > > > Will add that to the binding document.
> > I don't seem to be making my point clear. I don't want any of this
> > added to a binding doc for particular IP blocks. Write a common doc
> > that explains the scheme and addresses the questions I asked. Then
> > just reference that doc here.
> > 
> > Maybe this is documented somewhere already? Otherwise, if one is
> > creating a new IP block, how do they know what the versioning scheme
> > is or what goes in the DT ROM?
> 
> 
> Seems like there might be some confusion between IP blocks as integrated on
> an SoC vs. IP blocks in isolation.  It's not necessarily the SoC integrator
> that sets an IP block version number; this can come from the IP block vendor
> itself.  So each IP block may have its own version numbering practices for
> the IP block alone.
> 
> 
> For SiFive IP blocks, we at SiFive could probably align on a common version
> numbering structure for what's in the sifive-blocks repository.

I thought you had that from what Palmer said and what I've seen so far. 
You have at least 3 bindings so far it seems.

> But other IP blocks from other vendors may not align to that, or may not
> have version numbers exposed at all.  In those cases there's no way for
> software folks to find out what they are,  as you pointed out earlier.  This
> is the case with most DT compatible strings in the kernel tree.
> 
> For example, we've integrated the NVDLA IP block, from NVIDIA, on some
> designs.  Any NVIDIA version numbers in that IP block will probably not
> follow the SiFive version numbering scheme.  I'd propose the right thing to
> do for an IP block compatible string is to follow the vendor's practice, and
> then use the SoC integrator's version numbering practice for the
> SoC-integrated compatible string.

Experience has shown that using compatible strings only specific to 
vendor IP blocks (with or without version numbers) is pretty useless.

For licensed IP, I'd suggest you follow standard practices. A genericish
fallback is generally only used when there's lots of SoCs sharing a 
block.

In these cases though it needs to be clear what bindings follow some 
common versioning scheme and which don't. That's accomplished 
by referencing what the version scheme is. Otherwise, I'd expect I'll 
see the versioning scheme copied when in fact the source IP in no way 
follows it.

> In effect, an SoC integration DT compatible string like
> "sifive,fu540-c000-uart" implicitly states an IP block version number:
> "whatever came out of the fab on the chip"[**].   I'd propose that even in
> these cases, there's an advantage to keeping the "0" on the end, since it
> uniquely identifies an SoC-independent IP block, rather than just the type
> of the IP block.   But if the "0" on the end of the SoC integration DT
> compatible string is problematic for you, we can certainly drop that last 0
> from the SoC integration DT compatible string, and only suffer a slight lack
> of clarity as to what version was integrated on that chip.

Personally I'd leave it off, but I'm fine with either way. It just needs
to be the way you document for SiFive IP blocks.

> But for IP block-specific version strings like "sifive,uart0", I think we
> can address your concern, at least for these public IP blocks. Since the
> SiFive UART and some other peripheral IP blocks are open-source, the public
> can have a pretty good idea of what DT version number corresponds to the
> source RTL, since the RTL is public.   The version number identifies a
> specific programming model, without tying that programming model to any
> SoC-specific workarounds, etc.  So for these cases, I think there's a pretty
> good case for having IP block-specific version numbers in DT compatible
> strings, and I hope you'll agree.
> 
> 
> The advantage for all of us is that there's then no need to embed
> chip-specific DT match strings in these drivers, for the most part.  We just
> match on "sifive,uart0" and that's it, assuming no chip-specific workarounds
> are needed.
> 
> 
> > > >    Where does the
> > > > number come from?
> > > 
> > > It comes from the RTL, which is public:
> > > 
> > > https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> > I'm not going to go read your RTL, sorry.
> 
> 
> There's no need, but you did ask where it came from.  Sorry you didn't like
> the answer.

I only meant that in context of reviewing the IP block. My questions 
were meant to be what questions should a common document answer.

> Please let us know what you want us to do.
> 
> 
> Thanks for your review
> 
> 
> - Paul
> 
> 
> ** The caveat is that even with SoC identifiers in the Linux DT compatible
> strings, there's not enough information in many of the existing kernel DT
> compatibility strings to uniquely identify chip versions.  Taking OMAP and
> Tegra as examples, there are several different chip versions for a given SoC
> generation that came out of the fab.    OMAP chip version strings usually
> began with "ES"; Tegra version numbers, as I recall, were a letter and two
> numbers.  For the most part, those versions were never specifically
> identified in the upstream kernel DT strings or in DT file names. (There are
> some exceptions with OMAP where we did identify specific chip version
> numbers, because sizable numbers of folks had boards with early silicon, and
> we were committed to supporting them at the time.)    Sadly even adding
> these additional chip version identifiers to the DT strings wouldn't be
> perfect: I've seen at least one large vendor implementing metal-only ECOs
> without incrementing public chip version numbers. The point here is that
> we're already not uniquely identifying IP blocks with our current Linux DT
> compatibility string scheme.

Yes, I'm certainly aware of this aspect. We have to draw the line 
somewhere between enough information to distinguish differences and 
having a sane number of compatible strings. I mainly expect that the 1st 
versions of SoCs are short lived and ECO changes don't affect 
compatibility. That's obviously not always the case, but hopefully is 
sufficient in most cases.

Really, I'd just like to see folks get better at putting version and 
configuration information into registers. We only need DT for what we 
can't discover.

Rob
