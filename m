Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14FE223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14FE223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeKOTkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:40:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45277 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKOTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:40:07 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gNE1E-00009T-DG; Thu, 15 Nov 2018 10:33:00 +0100
Message-ID: <1542274379.4915.3.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] ARM: socfpga: dts: document
 "altr,stratix10-rst-mgr" binding
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Nov 2018 10:32:59 +0100
In-Reply-To: <20181105200549.17159-3-dinguyen@kernel.org>
References: <20181105200549.17159-1-dinguyen@kernel.org>
         <20181105200549.17159-3-dinguyen@kernel.org>
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

Hi Dinh,

On Mon, 2018-11-05 at 14:05 -0600, Dinh Nguyen wrote:
> "altr,stratix10-rst-mgr" is used for the Stratix10 reset manager.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  Documentation/devicetree/bindings/reset/socfpga-reset.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/socfpga-reset.txt b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
> index 98c9f560e5c5..38fe34fd8b8a 100644
> --- a/Documentation/devicetree/bindings/reset/socfpga-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
> @@ -1,7 +1,8 @@
>  Altera SOCFPGA Reset Manager
>  
>  Required properties:
> -- compatible : "altr,rst-mgr"
> +- compatible : "altr,rst-mgr" for (Cyclone5/Arria5/Arria10)
> +	       "altr,stratix10-rst-mgr","altr,rst-mgr" for Stratix10 ARM64 SoC

git grep '\(altr\|intel\),stratix10'

currently only shows "intel,stratix10-clkmgr". Should this be
"intel,stratix10-rst-mgr"? I think keeping "altr," is fine for
consistency, just wanted to point it out.

>  - reg : Should contain 1 register ranges(address and length)
>  - altr,modrst-offset : Should contain the offset of the first modrst register.
>  - #reset-cells: 1

regards
Philipp
