Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1980C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FC520870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085771;
	bh=lSkzQdzEcToFEUwE6ygqdrdsmRY2OKPCipuvoOdEYRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qal6ffTu7E0CBZFEL+ywriBk3wwKew5c94w9+GuOvP5jXyR1vtf+niEiNt3TJ/Vyg
	 Y/NlsFnQW7TRdtq+0gyRRRf5RgHEBNOp4vvGj12uVBqfYuJ650dZmUIvszNxSOpZ+R
	 DMvjcNS4nswiBXke6Ozz5mVIMWBWIReEbzHLkIz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfAUPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:49:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38147 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfAUPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:49:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so20907424otl.5;
        Mon, 21 Jan 2019 07:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nvnhEXcuhP3OmdqvOdrSFnY6N5HEGpiOmg3bXkrs2eU=;
        b=Db1L49AXOVMedWTJsDPhpehFxu7MQgu1EbIwDAm4OJj9xXoe+o38S4PSiFILCeb3aM
         sDFOXXX3m0duOWndwk7zslVzccAWRSTUUE7jPlMVz12VukbiValPjqKUnC6f1j1+yHK6
         OzESnRAQpmOprOmvwR9TbVWuXdFvJb+TBeBxCi6rbOSj+1fT8qGnCwJSCyp0xAv0t53R
         RUsp5EOmIKI77koVUzxL9uBWWud3MOlGhFoEDfQSI+0ObCNasUP2QXs3fTMupATR0Nij
         E+gLekIVNI2VVblj/N3XEbyNVZ6Nc9cv9eDeSCTf/Vy6Bx/mgooDnMObp5FkUiHUivK8
         hycA==
X-Gm-Message-State: AJcUukcbdoY4VSLasVYzhstQEMDMqViWePAc573/8FEpsPyJj4vArF6Q
        xyndWoM7g8GE7PpAT5cM5w==
X-Google-Smtp-Source: ALg8bN7APw3eXU3AmWu0TV7lozUCJ9u4nJffqFs2O5AuRhXh30YdEzlNFdykmbSuTcaN5dpHM7JWPg==
X-Received: by 2002:a9d:1982:: with SMTP id k2mr18981973otk.197.1548085769003;
        Mon, 21 Jan 2019 07:49:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h25sm6004941otj.27.2019.01.21.07.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:49:28 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:49:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michals@xilinx.com, RAJANV@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, JOLLYS@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190121154928.GA32129@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-7-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:08:35PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Removed PCAP as a child node to the FW and Created
> 		an independent node since PCAP driver is a consumer
> 		not a provider. 
> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..1f6f58872311
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,13 @@
> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface
> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};

There's no need for a DT node. Just make the firware driver create a 
platform device for pcap.

Rob
