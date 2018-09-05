Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF8CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2377E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2377E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIEOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:39:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:39:30 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fxUkv-0001rl-Jp; Wed, 05 Sep 2018 12:09:49 +0200
Message-ID: <1536142188.4084.1.camel@pengutronix.de>
Subject: Re: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 12:09:48 +0200
In-Reply-To: <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
         <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Corrected Commit Msg. 
> Changes for v2:
> 		-Moved reset node as a child to firwmare
> 		 node.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index 1b431d9..351b1bb 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
[...]
>  -------
>  Example
>  -------
> @@ -25,5 +163,9 @@ firmware {
>  	zynqmp_firmware: zynqmp-firmware {
>  		compatible = "xlnx,zynqmp-firmware";
>  		method = "smc";
> +		reset-controller:reset-controller@0 {

I think the label should use underscore instead of hyphen, and the unit
address part should be removed from the node name. There is no unit
address, as there is no reg property inside the node and the parent node
doesn't have #address-cells:

		reset_controller: reset-controller {

> +			compatible = "xlnx,zynqmp-reset";
> +			#reset-cells = <1>;
> +		};
>  	};
>  };

regards
Philipp
