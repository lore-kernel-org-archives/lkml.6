Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70335C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D96921534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0H+dFP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D96921534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJTWce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeJTWce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:32:34 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791B621547;
        Sat, 20 Oct 2018 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540045314;
        bh=+40t+JokEkPKqjA0ZzxhopmJPSulcQLzupa1A3k6mn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j0H+dFP/92P57M9unZq3GMC4bFqGbY3BJzIsL/pIq8AL02ZmLry9U8Lr+tX8UMJCO
         0YddfIRN9VSjXCjN3ilhx2oLHmlOD0PEqoDVy2gT8GV1XfRTnNGEklE4GBRHZtoJ05
         6GRGrW9SINyVZTHdUit0ZPeLvp37xpsuPs+3FvV8=
Received: by mail-qt1-f172.google.com with SMTP id x24-v6so9985434qtx.11;
        Sat, 20 Oct 2018 07:21:54 -0700 (PDT)
X-Gm-Message-State: ABuFfoiWJY+j22hnRQUPay7WNqwfFddRjeyq59B0+DdM8d5fXxhHxf3b
        UiIy4ht7BCOHJkAr4WpjXSTOyYAOMLxKhJ7e/g==
X-Google-Smtp-Source: ACcGV61df+RWMC8bsOb3xGtJVPKx/CBY/H1zZXHSGDssuM6/+Bm1ERhEOT+HlpvxupU4JSClLLL3ussaiaMgroDiV10=
X-Received: by 2002:ac8:1701:: with SMTP id w1-v6mr4831981qtj.76.1540045313584;
 Sat, 20 Oct 2018 07:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
 <20181019184827.12351-2-paul.walmsley@sifive.com> <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
 <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
In-Reply-To: <4317548d-f831-29ba-3be9-35f080587db9@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 20 Oct 2018 09:21:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
Message-ID: <CAL_JsqLagTgjDhZ02X=wPFDB4WF2bR7=LyzSW9D=ooo_XB_zOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:06 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> On 10/19/18 1:45 PM, Rob Herring wrote:
> > On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >> Add DT binding documentation for the Linux driver for the SiFive
> >> asynchronous serial IP block.  Nothing too exotic.
> >>
> >> Cc: linux-serial@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Palmer Dabbelt <palmer@sifive.com>
> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> >> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> >> ---
> >>   .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
> >>   1 file changed, 21 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> >> new file mode 100644
> >> index 000000000000..8982338512f5
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> >> @@ -0,0 +1,21 @@
> >> +SiFive asynchronous serial interface (UART)
> >> +
> >> +Required properties:
> >> +
> >> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> > I assume once again, the last '0' is a version?
>
>
> Yes.
>
>
> > Palmer mentioned the
> > compatible string is part of the IP block repository?
>
>
> It is, but there's no guarantee that the compatible string from the RTL
> will make it into a ROM for any given chip.  For example, a customer may
> want the UART, but not want to take the DT ROM to keep area down.

Optional? Well, that's pointless to have then.

> This is one of the reasons why we'll likely switch to the usual
> software-maintained DTS files for Linux, just like the rest of arch/arm,
> arch/powerpc, etc.

Then you should probably just follow normal conventions.

I don't think DT in the h/w is the best strategy anyways. Ideally,
what the h/w should have are version and capabilities (assuming there
are configuration options) registers which aren't optional and can't
be forgotten to be updated. The version should probably have a vendor
too.

> > As I mentioned for the
> > intc and now the pwm block bindings, if you are going to do version
> > numbers please document the versioning scheme.
>
>
> Will add that to the binding document.

I don't seem to be making my point clear. I don't want any of this
added to a binding doc for particular IP blocks. Write a common doc
that explains the scheme and addresses the questions I asked. Then
just reference that doc here.

Maybe this is documented somewhere already? Otherwise, if one is
creating a new IP block, how do they know what the versioning scheme
is or what goes in the DT ROM?

>
>
> >   Where does the
> > number come from?
>
>
> It comes from the RTL, which is public:
>
> https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43

I'm not going to go read your RTL, sorry.

Rob
