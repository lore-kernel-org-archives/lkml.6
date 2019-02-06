Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BCBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDAB206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bE4q1vPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBFSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:47:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41729 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBFSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:47:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3479904pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=KvKr862sWMd/Gvg3+sFqt/IYClo/w4CyIdlzhe0fDFw=;
        b=bE4q1vPhK1ux1FN0ErvuDbpbeshiR5NMqE2tQhqEA8mPOQTJ9yjacwgcbuqO9OcFvh
         BZI9/1qYdH6mVMICBdsTZx7+YVBS6iAwHxWeW/N7vYSrM4oMmE3kFQnwAU2Y5CAaRoKK
         fFapdNUuSzXP2YQOdmM7C+Cwfp3EJ0671TOvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=KvKr862sWMd/Gvg3+sFqt/IYClo/w4CyIdlzhe0fDFw=;
        b=fBtf9t/XF1diPpG6I6nkbOOCGkqeWjIW6D8RpYsmGgibyASxKBVJBEq/0WuNfs+Suo
         8aeSRt3a5YVfu7GECuDVcJ1YzOnkY8tKJhkw7vSkafBlnQR1q2NfUhkTjk8S1FguLFjE
         s+v7TT2eOslnujzbyizf4KXe8qFL6ZXuMTJOuHp0+EVFsYwzIr6QW/2743BPnNW3HLZX
         w890crtSRg5kqnzbiWCMxjJdT8ePDayzHwtwQmRg6t5cJGjsncCmc3Q1QdALPSYg45Ps
         eNhbijNqelzTcClIe+rXrMxCFkRKaOVU6LOpWEE3QpfO/+orTjKyoLjr38pd5Jcd6HWj
         Aang==
X-Gm-Message-State: AHQUAuaSWViSqPVZx3lp/+ENdCzWoWyKkW4pxN7OFWKBW++IdtVSOS/I
        nQSkFBKUmzO+49TD4gyE4c84eg==
X-Google-Smtp-Source: AHgI3IbOHeMrE8mJIre94W5RL8OEjo+egh+5pkaQrYbX1iNtisM6zcTLkGbSH3giAGo08pUF0Ej94g==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr12039936pfd.56.1549478869504;
        Wed, 06 Feb 2019 10:47:49 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c9sm16572917pfc.92.2019.02.06.10.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:47:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
In-Reply-To: <20190206170730.GA16254@codeaurora.org>
User-Agent: alot/0.8
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
Message-ID: <154947886779.115909.17337770809316468217@swboyd.mtv.corp.google.com>
References: <20181219221105.3004-5-ilina@codeaurora.org> <20190107185113.GH14960@codeaurora.org> <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com> <20190109173111.GB22547@codeaurora.org> <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com> <154724884881.169631.9705938789464714812@swboyd.mtv.corp.google.com> <154827672955.136743.8509585166504871320@swboyd.mtv.corp.google.com> <154897162267.169292.1911486544543857784@swboyd.mtv.corp.google.com> <154900498906.169292.1193422735086292701@swboyd.mtv.corp.google.com> <20190206170730.GA16254@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 06 Feb 2019 10:47:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-02-06 09:07:30)
> Thanks for the patch Stephen. Sorry, it took a while to get to this and
> understand how this works.
>=20
> On Thu, Jan 31 2019 at 00:10 -0700, Stephen Boyd wrote:
> >Quoting Stephen Boyd (2019-01-31 13:53:42)
> >>
> >> I'm prototyping out some code to do the remapping based on this type of
> >> DT property, because it will make the irqdomain::alloc function a litt=
le
> >> simpler to implement by passing in a struct irq_fwspec and getting out=
 a
> >> parent irq_fwspec and it will make the patches to add these mapping
> >> tables in C irrelevant. Plus, I think Lina will be happy that the
> >> pinctrl driver will know if some pin maps to the PDC or not without
> >> having to see if it fails to allocate in the parent irqdomain. But the=
re
> >> will still need to be a property for 'wakeup-parent' unless we do
> >> something to expose irqdomain tokens into DT.
> >>
> >
> >And here's the code to do this remapping idea, heavily based on the
> >phandle remapping code. I didn't properly fix up the irq alloc function
> >for the pinctrl driver here, but it should work out properly without
> >much more diff. I realize now that the pass-thru mechanism will fail
> >horribly when a specifier changes size types.
> Could you explain?

The pass-thru code maps an incoming specifier directly to an outgoing
specifier, so it won't work well if the incoming specifier size is
different than the outgoing specifier. For example, converting a GPIO
two cell to a GIC 3 cell specifier doesn't work well.

	incoming: <GPIO# flags>
	outgoing: <GIC_SPI SPI# flags>

And the pass-thru and mask properties can't "shift" or swap a u32
element of the specifier. All they can do is copy from the incoming to
the outgoing specifier. Furthermore, we only copy over how ever many
cells there are in the incoming specifier so we don't do anything with
the last cell. So if GPIO32 corresponds to GIC SPI 14 we can't copy over
the flags.

	<32 IRQ_TYPE_LEVEL_HIGH> becomes <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>

but the code only sees <32 4> and needs to copy each element over one by
one to <0 14 4>. One solution is to match on the incoming flags and then
remap them to the outgoing flags, but then pass-thru property is
unusable and we have to list all possible flag combinations on the
incoming specifier side of the mapping.


> >I guess we'll need to keep
> >that in mind if we convert the PDC driver to this too. Or we can leave
> >the PDC driver as is and not worry about listing out the individual
> >pins.
> The PDC pins are more sequential and it looks clean as it. I would
> prefer that it be left as is.

Sure. I don't see any problems keeping the status quo in the PDC driver.

> >
> >-----8<-----
> >diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/=
qcom/sdm845.dtsi
> >index a2241dd9c185..6b3a4227f433 100644
> >--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
[...]
> >+                                      <122 0 &pdc_intc 97 0>,
> >+                                      <123 0 &pdc_intc 98 0>,
> >+                                      <124 0 &pdc_intc 99 0>,
> >+                                      <125 0 &pdc_intc 100 0>,
> >+                                      <127 0 &pdc_intc 102 0>,
> >+                                      <128 0 &pdc_intc 103 0>,
> >+                                      <129 0 &pdc_intc 104 0>,
> >+                                      <130 0 &pdc_intc 105 0>,
> >+                                      <132 0 &pdc_intc 106 0>,
> >+                                      <133 0 &pdc_intc 107 0>,
> >+                                      <145 0 &pdc_intc 108 0>;
> >+                      irqdomain-map-mask =3D <0xff 0>;
> >+                      irqdomain-map-pass-thru =3D <0 0xff>;
> Where do we document these bindings?

In the DT spec itself or at
Documentation/devicetree/booting-without-of.txt I guess.

> >
> >                       qspi_clk: qspi-clk {
> >                               pinmux {
> >diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> >index 02ad93a304a4..b37f4cdfda53 100644
> >--- a/drivers/of/irq.c
> >+++ b/drivers/of/irq.c
> >@@ -274,6 +274,130 @@ int of_irq_parse_raw(const __be32 *addr, struct of=
_phandle_args *out_irq)
> > }
> > EXPORT_SYMBOL_GPL(of_irq_parse_raw);
> >
> I would think this would be a separate patch and I presume, I can add
> you as the author with your signed-off-by?

Sure, but I'd rather see if Rob has any views or opinions here.

>=20
> >+int of_irq_domain_map(const struct irq_fwspec *in, struct irq_fwspec *o=
ut)
> >+{
[...]
> >+      while (map_len > (in_size + 1) && !match) {
> >+              /* Compare specifiers */
> >+              match =3D 1;
> >+              for (i =3D 0; i < in_size; i++, map_len--)
> >+                      match &=3D !((match_array[i] ^ *map++) & mask[i]);
> >+
> >+              of_node_put(new);
> >+              new =3D of_find_node_by_phandle(be32_to_cpup(map));
> >+              map++;
> >+              map_len--;
> >+
> >+              /* Check if not found */
> >+              if (!new)
> >+                      goto put;
> >+
> >+              if (!of_device_is_available(new))
> >+                      match =3D 0;
> >+
> >+              ret =3D of_property_read_u32(new, cells_name, &out_size);
> >+              if (ret)
> >+                      goto put;
> >+
> >+              /* Check for malformed properties */
> >+              if (WARN_ON(out_size > MAX_PHANDLE_ARGS))
> >+                      goto put;
> >+              if (map_len < out_size)
> >+                      goto put;
> >+
> >+              /* Move forward by new node's #interrupt-cells amount */
> >+              map +=3D out_size;
> >+              map_len -=3D out_size;
> Nit: Could make this a bit simpler to understand if you broke out the
> loop on match instead of continuing the loop.

Instead of just doing that in the loop condition?

> >+      }
> >+      if (match) {
> >+              /* Get the irqdomain-map-pass-thru property (optional) */
> >+              pass =3D of_get_property(cur, pass_name, NULL);
> >+              if (!pass)
> >+                      pass =3D dummy_pass;
> >+
> >+              /*
> >+               * Successfully parsed a irqdomain-map translation; copy =
new
> >+               * specifier into the out structure, keeping the
> >+               * bits specified in irqdomain-map-pass-thru.
> >+               */
> >+              match_array =3D map - out_size;
> >+              for (i =3D 0; i < out_size; i++) {
> >+                      __be32 val =3D *(map - out_size + i);
> >+
> >+                      out->param[i] =3D in->param[i];
> >+                      if (i < in_size) {
> >+                              val &=3D ~pass[i];
> I don't get why the mask is inverted and reversed here again?

The mask is inverted to clear out the bits in the outgoing specifier for
whatever is there on the incoming side, per what the pass-thru mask
indicates should be copied over from incoming to outgoing.

> >+                              val |=3D cpu_to_be32(out->param[i]) & pas=
s[i];
> >+                      }
> >+
