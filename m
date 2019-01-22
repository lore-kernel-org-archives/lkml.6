Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B508DC282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B8D20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548125737;
	bh=9jX+hExG7Z/VsPHCaZ4+xU/CGWwSntX6wiyeWXQPH0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08HJ6Q1YMDlElNm5SLiAkxzvngl9jmcrHv3+1/HzH7BGYT/dPlD5iGSX22RCGpD27
	 BjT4MgfUam0a7r4zRGIF7g4GLgGvZfWGv0Di/z4nixWU2x6Iyndlqqt9tOGx66fxYm
	 Cr88sGv0yE3CFI4Hn7uZ3nAH7CaHCnkdY+4vabfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfAVCz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfAVCzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:55:25 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7455920861;
        Tue, 22 Jan 2019 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548125725;
        bh=9jX+hExG7Z/VsPHCaZ4+xU/CGWwSntX6wiyeWXQPH0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6wpTH0z8KUoRLq8TKHHvc5tmbK2flUrWDjELSLiWxLxsezfClVWEz57zNpeBnV5s
         D3EsJZT7+eTQMMSItEOVKyIxen+upLcrPytEQ8PFhPlkH9QEXvuPC5cFZjgBiLrYdg
         R1BhIwJ9NxBvmZdSmd4Tnwg7Z9pVneR8y7FMhRsw=
Date:   Tue, 22 Jan 2019 10:54:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Message-ID: <20190122025441.GB19233@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 03:31:11PM +0000, Ioana Ciornei wrote:
> This patch adds a devicetree binding documentation for
> FSL's DPAA2 console.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
>  MAINTAINERS                                              |  1 +
>  2 files changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> new file mode 100644
> index 0000000..f4e16b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> @@ -0,0 +1,11 @@
> +DPAA2 console support
> +
> +Required properties:
> +
> +    - compatible
> +        Value type: <string>
> +        Definition: Must be "dpaa2-console".

Why this doesn't need a vendor prefix?

Shawn

> +    - reg
> +        Value type: <prop-encoded-array>
> +        Definition: A standard property.  Specifies the region where the MCFBA
> +                    (MC firmware base address) register can be found.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b76a80..229d4fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5969,6 +5969,7 @@ M:	Li Yang <leoyang.li@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/dpaa2-console.txt
>  F:	Documentation/devicetree/bindings/soc/fsl/
>  F:	drivers/soc/fsl/
>  F:	include/linux/fsl/
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
