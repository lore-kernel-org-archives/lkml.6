Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550867453;
	bh=7bLM5+3IQujF98X0zL8N6k213Vu2WBiNhmN2ZhN2wn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fzHJRGNp31cFcxPvC+oHHxiH/yifGBj1UGuyZnMadZPgmhnn9VblqoZK4fc3rnr8O
	 3LPcXFsqn0ltKth0bvhlme5m3Zm4XodD3xM04oJUcHTq6LX30EOAhPyV77zIlchKrg
	 R932w0yjfz/3HEwqO8T07anMJFbkI6b3GAX93sGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfBVUaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBVUav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:30:51 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430D72075C;
        Fri, 22 Feb 2019 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550867450;
        bh=7bLM5+3IQujF98X0zL8N6k213Vu2WBiNhmN2ZhN2wn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0a/odKRCAEfajT0phPV6BkT7Egdgtv/TrdEu5463Gz4xuckzFiw2IO108Fs38K2ae
         8VSrPlcIfzLZXhF0jOYljDCrGUelFHRzqgIdFE7+q8ZuisL6tyQRz59zR2YbKlalfd
         nqheEZi/lECELl0vWMNzVFdv9NkcTfD+Zp6iJVso=
Received: by mail-qt1-f180.google.com with SMTP id p25so4050269qtb.3;
        Fri, 22 Feb 2019 12:30:50 -0800 (PST)
X-Gm-Message-State: AHQUAuZ6yyT05Ofpa/Ua4gN68zCF5L+XbdQSadNHUDue0y0NouovSpLx
        VrW7bvmILHATtnv35HJzNvxnQVdVYlTec+Zocg==
X-Google-Smtp-Source: AHgI3Ib2ygTqf6/bY+f2UWbd+u3M2r8MVsTsfDmAWX6MvaBdPfE00UfFfdLsGD/MxmRGH5xMlXX6Ue3e9ZYRN82KZkA=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr4692215qtd.144.1550867449490;
 Fri, 22 Feb 2019 12:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20190121173835.21173-1-nava.manne@xilinx.com> <20190121173835.21173-7-nava.manne@xilinx.com>
 <20190121154928.GA32129@bogus> <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Feb 2019 14:30:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
Message-ID: <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:46 PM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
>
>
> Thanks for providing the comments...

Please fix your mailer to send plain text emails to mail lists.


> > -----Original Message-----
>
> > From: Rob Herring [mailto:robh@kernel.org]
>
> > Sent: Monday, January 21, 2019 9:19 PM
>
> > To: Nava kishore Manne <navam@xilinx.com>
>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
>
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
>
> > <JOLLYS@xilinx.com>; chinnikishore369@gmail.com
>
> > Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
>
> > driver
>
> >
>
> > On Mon, Jan 21, 2019 at 11:08:35PM +0530, Nava kishore Manne wrote:
>
> > > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
>
> > >
>
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>
> > > ---
>
> > > Changes for v3:
>
> > >                         -Removed PCAP as a child node to the FW and Created
>
> > >                         an independent node since PCAP driver is a consumer
>
> > >                         not a provider.
>
> > >
>
> > >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
>
> > >  1 file changed, 13 insertions(+)
>
> > >  create mode 100644
>
> > > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > >
>
> > > diff --git
>
> > > a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > new file mode 100644
>
> > > index 000000000000..1f6f58872311
>
> > > --- /dev/null
>
> > > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>
> > > @@ -0,0 +1,13 @@
>
> > > +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC
>
> > > +controlled using ZynqMP SoC firmware interface For Bitstream
>
> > > +configuration on ZynqMp Soc uses processor configuration
>
> > > +port(PCAP) to configure the programmable logic(PL) through PS by
>
> > > +using FW interface.
>
> > > +
>
> > > +Required properties:
>
> > > +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
>
> > > +
>
> > > +Example:
>
> > > +      zynqmp_pcap: pcap {
>
> > > +                     compatible = "xlnx,zynqmp-pcap-fpga";
>
> > > +      };
>
> >
>
> > There's no need for a DT node. Just make the firware driver create a platform
>
> > device for pcap.
>
> >
>
>
>
> This driver being used by the FPGA manager framework(fpga-region) to apply overlay's so this node is needed AFAIK.

The binding says nothing about child nodes and what they are. Please
define that.

Rob
