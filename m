Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6183D217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550510887;
	bh=CgcRDF7C52Vlc3zAtIroXHdRj4RLCb0jPxPrN/wbtdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UUgxoaxeI6vYm9Ko61MbiIIXtAxMsbEGF2w5NEfR4CcSopl0fgcZ1JMf+HUcbnT3P
	 oqKQe6IxkGejNKU7k14F6t1bdiK0bw7pbdHcb/58UwGwQeHWf3gxJQVNVu4SqOmSVG
	 YMucLnfT72AwLt/YGdrEeZrh29qLzUsPPDtiiOB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbfBRR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:28:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41957 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfBRR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:28:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so13160187otk.8;
        Mon, 18 Feb 2019 09:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mp0Y4/w1Ryp7+w4aXGtF4QaXIIN4inc1wWBkogoPt20=;
        b=GlWlWt3O4R+K5G7BLFpM11/EUOwmv/VeLmvHLj2tQ8Z5oVuYnTj4ZrjgWFIAKoY4w4
         vynf+guAN1nep/iXRmFM/bzzBzxr8sDapzycS5VVJrtyRZAjwSZ3uglGQrHuPCSVa4AN
         TjzQBOTISYFjbJTsS3TyJa3kIKAjfBwNWh0KMfROYo78YHR3PhoIUmpRKYSWqrc0At/9
         RgefBWiO0LVwnfRakkqmiTH2+MwoCIFfXWxIhVpiExYnYZ5Dhd+V/H1T0T1IZDKc10ma
         ACJgSS4Y/3W9DSQKDPuvUo8p6gyybw92B+68Sl0UgC40QFOgOFu2eOL7J5J99CL1jKqy
         OZiA==
X-Gm-Message-State: AHQUAuayntAWj9nyHVwOxWTlQi2T0Z5Hx41I0K7tn24/IxzAqV2SyL3Q
        iBkXQp9p4xXwKSNqL85jpg==
X-Google-Smtp-Source: AHgI3IYNhY/rHEG0QCkalZy8YHsvnTFQ8ijleNLOx9z6vuriu0Ed8PLtefIglZXBUKUTWoc6kgdZmQ==
X-Received: by 2002:a05:6830:1357:: with SMTP id r23mr8269912otq.265.1550510884179;
        Mon, 18 Feb 2019 09:28:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d65sm6751376oih.13.2019.02.18.09.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 09:28:03 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:28:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     atull@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190218172802.GA1376@bogus>
References: <20190211161736.23844-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211161736.23844-1-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:47:36PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.

I thought I was told in the review of the firmware binding that is went 
away...

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Removed "----" separators.
> Changes for v1:
>                 -Created a Seperate(New) DT binding file as
>                  suggested by Rob.
> 
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
> 
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 0000000..1f6f588
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

There's no DT resources here, so there's no need for this in DT. Just 
have the parent (the firmware driver) instantiate the driver.

Rob
