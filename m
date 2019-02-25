Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2363C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC362084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWbMTxTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBYGPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:15:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40752 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfBYGPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:15:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so6534963eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 22:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V62Uz4EHki/THwMW+97zKf5gjJc9H9jlASqKmiHBVkg=;
        b=MWbMTxTclmA/hcJq2w9uXz4jmf010tHXyINMRP7ukx0HuCFxS6lU2CrER2Yrx1ThvX
         1skBLrB6ta4zxMfvGAFXOPTeccUiPXHT2Z8ER7AMMi3OLePQ7bqRdW0fBtV4r6+IwcKl
         wR6RhB24wXW3trY4B17nhkb4yBD5aSJM7QeHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V62Uz4EHki/THwMW+97zKf5gjJc9H9jlASqKmiHBVkg=;
        b=OWpvhVRvWoqvIWV8oby3Ox5VJwh/+057r81YP1ZxDFKV5ks04AiARJC+MRbare9qkN
         MMIOhc5VBA30/1r6RWiJBeWry5oSNtOwm78TGhgcL33yI3UyQi2ps3ZRkVfxW72LPGd6
         PZM/Q2X5piEUX1FRIX3apOPPfJooafrbxlw10wN1KQNQQ1CE65kW1yPJ+DSCM2i5MHxK
         H3MOD+h8kK4EuuYpocT2McCyTerQWeS7u/L5MENWPKI5pEtyvbfZxRWrjgUvIMtAccbT
         wsQQwWB0n6ZhIIdu/+d6WfkY7AhjHrKbnoVgJYt2AI8KAMKv96vNXO9ZTMs9mdom6UOP
         y31g==
X-Gm-Message-State: AHQUAuZLszmLGT5hVwp94dFtZaJIWduw6I1NkPaRNlhVpHPnMpfIpeYN
        2Y5wucyvgEsO/wM4Vxvwn9/qY17wuAKOypsi6Rpf/g==
X-Google-Smtp-Source: AHgI3Ia1q9a83hP7aUcZN36LVMzgN7MUNtrPt2RuRyjCrdlDygHJ2nc8vTLwHR9HEOSk76pB2TLPzYBL6tTSIpSO9dw=
X-Received: by 2002:a17:906:561a:: with SMTP id f26mr11885639ejq.167.1551075350868;
 Sun, 24 Feb 2019 22:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20190221084729.101784-1-pihsun@chromium.org> <20190221084729.101784-2-pihsun@chromium.org>
 <20190222144316.GA19284@bogus>
In-Reply-To: <20190222144316.GA19284@bogus>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 25 Feb 2019 14:15:40 +0800
Message-ID: <CANdKZ0d+2CqbVEwruW+pbqUeRMBwzXV7tFC7Cp7i+98CWiB_4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
To:     Rob Herring <robh@kernel.org>
Cc:     Erin Lo <erin.lo@mediatek.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:43 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> > From: Erin Lo <erin.lo@mediatek.com>
> >
> > Add a DT binding documentation of SCP for the
> > MT8183 SoC from Mediatek.
> >
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> > Changes from v4:
> >  - Add detail of more properties.
> >  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> >
> > Changes from v3:
> >  - No change.
> >
> > Changes from v2:
> >  - No change. I realized that for this patch series, there's no need to
> >    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
> >    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
> >    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
> >    created by SCP name service.
> >
> > Changes from v1:
> >  - No change.
> > ---
> >  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > new file mode 100644
> > index 00000000000000..8cf8b0e0d98a4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > @@ -0,0 +1,37 @@
> > +Mediatek SCP Bindings
> > +----------------------------------------
> > +
> > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > +Mediatek SoCs.
> > +
> > +Required properties:
> > +- compatible         Should be "mediatek,mt8183-scp"
> > +- reg                        Should contain the address ranges for the two memory
> > +                     regions, SRAM and CFG.
> > +- reg-names          Contains the corresponding names for the two memory
> > +                     regions. These should be named "sram" & "cfg".
> > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +- clock-names                Contains the corresponding name for the clock. This
> > +                     should be named "main".
> > +
> > +Subnodes
> > +--------
> > +
> > +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
>
> Bindings can't depend on kernel config options.
>

What's the recommendation here if the subnode only has effect when the
config is enabled? Should I just skip the sentence "When ... is
enabled"?

> > +devices. The names of the devices are not important. The properties of these
> > +nodes are defined by the individual bindings for the rpmsg devices - but must
> > +contain the following property:
> > +
> > +- mtk,rpmsg-name     Contains the name for the rpmsg device. Used to match
> > +                     the subnode to rpmsg device announced by SCP.
>
> I don't think this belongs in DT, but without some examples I'm not
> really sure.
>

This is similar to the qcom,smd-channels property in
Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt, a example DT
for this:

scp {
        compatible = "mediatek,mt8183-scp";
        ...
        cros_ec {
                compatible = "google,cros-ec-rpmsg";
                mtk,rpmsg-name = "cros-ec-rpmsg";

                cros_ec_codec {
                        compatible = "google,cros-ec-codec";
                        ...
                };
        };
};

> > +
> > +Example:
> > +
> > +     scp: scp@10500000 {
> > +             compatible = "mediatek,mt8183-scp";
> > +             reg = <0 0x10500000 0 0x80000>,
> > +                   <0 0x105c0000 0 0x5000>;
> > +             reg-names = "sram", "cfg";
> > +             clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > +             clock-names = "main";
> > +     };
> > --
> > 2.21.0.rc0.258.g878e2cd30e-goog
> >
