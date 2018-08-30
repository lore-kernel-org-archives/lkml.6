Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5462C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A442073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X05bmN+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A442073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeH3SBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeH3SBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:01:48 -0400
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA86520837;
        Thu, 30 Aug 2018 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535637571;
        bh=NwGv5MOMEk/kYncyPUzRRk51uQVcYw9bZA/AB2YpLYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X05bmN+3h6e9UGvMXL+0c5NVbxo3Sej0hUS0QE5cycFopTm28NxVLt6mkoI/w3FpY
         Q+cqIY+mPQCs/zjqW1bcb3X2HYBoMocN3vsHoocsSx/leK19sNVxC8l2CwvVxusjnP
         ybvdHKqaNFx7pha+GBmFj/1RFE/pgSBe1vuhRJ2Y=
Received: by mail-qt0-f178.google.com with SMTP id n6-v6so9897268qtl.4;
        Thu, 30 Aug 2018 06:59:31 -0700 (PDT)
X-Gm-Message-State: APzg51B//shgz/GTO1InDr8j356TErsjPR5GA/FugvJ5Bf4LcMrpppNn
        40tNbk9MgGX0t01m3ZKbTJgpcDBCQ4Ik3yoWuA==
X-Google-Smtp-Source: ANB0VdbRm86gD+sjO4NX2UAwgzMSeb9yHMUol68u7Lkw/jLenHnT94UXozMpoKbAJOpVns3CnMlpq+PkWY0fKf3Hya4=
X-Received: by 2002:ac8:148b:: with SMTP id l11-v6mr2131416qtj.27.1535637570855;
 Thu, 30 Aug 2018 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
 <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
 <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com> <20180829004122.GA25928@bogus>
 <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
In-Reply-To: <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Aug 2018 08:59:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJPzfp1OimYXa26tEqTexyiuKMeKszveobHN3rKP8+RYQ@mail.gmail.com>
Message-ID: <CAL_JsqJPzfp1OimYXa26tEqTexyiuKMeKszveobHN3rKP8+RYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 2:37 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
>
>
>
> On 2018/8/29 8:41, Rob Herring wrote:
> > On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
> >>
> >>
> >> On 2018/8/24 16:22, Jerome Brunet wrote:
> >>> On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
> >>>> From: Yue Wang <yue.wang@amlogic.com>
> >>>>
> >>>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> >>>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> >>>> controller.
> >>>>
> >>>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> >>>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> >>>> ---
> >>>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
> >>>>  1 file changed, 63 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >>>> new file mode 100644
> >>>> index 0000000..8a831d1
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >>>> @@ -0,0 +1,63 @@
> >>>> +Amlogic Meson AXG DWC PCIE SoC controller
> >>>> +
> >>>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> >>>> +It shares common functions with the PCIe DesignWare core driver and
> >>>> +inherits common properties defined in
> >>>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> >>>> +
> >>>> +Additional properties are described here:
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible:
> >>>> +  should contain "amlogic,axg-pcie" to identify the core.
> >>>> +- reg:
> >>>> +  Should contain the configuration address space.
> >>>> +- reg-names: Must be
> >>>> +  - "elbi"        External local bus interface registers
> >>>> +  - "cfg"         Meson specific registers
> >>>> +  - "config"      PCIe configuration space
> >>>> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> >>>> +- clocks: Must contain an entry for each entry in clock-names.
> >>>> +- clock-names: Must include the following entries:
> >>>> +  - "pclk"       PCIe GEN 100M PLL clock
> >>>> +  - "port"       PCIe_x(A or B) RC clock gate
> >>>> +  - "general"    PCIe Phy clock
> >>>> +  - "mipi"       PCIe_x(A or B) 100M ref clock gate
> >>>> +- resets: phandle to the reset lines.
> >>>> +- reset-names: must contain "phy" and "peripheral"
> >>>> +       - "port" Port A or B reset
> >>>> +       - "apb" APB reset
> >>>
> >>> The above description is not coherent (phy <=> port)
> >>>
> >>
> >> Yes, this should be port and apb here.
> >> We'll integrate phy driver into ctrl driver, and move phy reset to here also.
> >
> > Why? That's the wrong thing to do if they are separate h/w blocks. You
> > can do whatever you like in the drivers, but the DT should reflect the
> > h/w.
> >
> > Rob
> >
> > .
> >
>
> We have the dedicated phy driver which only process reset job,
> and we consider that it's too overkill to do just these things .
> So we will integrate phy reset job into the controller driver int the next version.

What's in the separate register space you had for the phy?

Rob
