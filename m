Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-529228-1520473085-2-9528428173852735473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520473084; b=VcfM7KE4z8t2zul+3/T6PJ+X4Q/Wa8H2nrazNjemmpP+Yv+
    MnFMLa1HSJQ8CWEW5VYrGR1kEJXBzZXC2NTFSSNyXXXxH6CC61pyUo+p49+DtQAt
    F5sgIRXFw/+8ufKFEIY+fTGNPfqwBz3ceIwNxsbkpOPg8+qcXqZqDvsvtSmiOYUo
    ldUbWyiwHB599ZH3GbH1yQcW97ViSOSqtVnXq3g4wuHzPBSjjf+6Pfz9YOIQuhib
    8EQExWsUhn1dd1qwYC8ogOXYxLhWAjoLTAkbvthquyvKhBvN2/jtzF8cqM31MMPu
    pcqC+hC9TJLIcVW0n+nnqCAE/NCnWGdr1CENPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520473084; bh=ytvEdm4vIlzRTg4NhLj+oCe2wK
    U5iDfi2SzXHBeU3pk=; b=TfWwx+djdMqPiBACPfrcR6C4tAEO5mgqnVWXXJAH7Q
    A5e1wmf0/ZEftqlIlYFUUBr9PvUnzxnrDK3HHI/tPqXqggUsGSbX4OYAsAuwjKz5
    QUYb7ViNk5ds9DLJhf2XzX8Vk4XC4BRpIU8ta8v+qcgLSSCc4H1UEp6q8qMaprEJ
    NzeE/3k67kpxzELlgSrBHVDZc5FMVqu1Wa4HbulFxneBV3DTuWTYUQn0wq6as7Sh
    5/Ll5mfoRh2XMwoylB+WFpiWSyKzIdwScVIkkR+0qTb6/rX8dWiMBvUowytdvPcS
    ma7HPFvg+8LuFMnyxlliIyeDpN3xe300cOqXoI+tCyaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JB26HMwQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JB26HMwQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeCHBhs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 20:37:48 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40524 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHBhr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 20:37:47 -0500
X-Google-Smtp-Source: AG47ELslkxUB6atygZGanBv+kG3Y8Z7CZo5F2pfTVIHMjav4N3PJ0hxaDrbZ5CODkZJggXMbxjYq6A==
Date: Wed, 7 Mar 2018 19:37:45 -0600
From: Rob Herring <robh@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
Message-ID: <20180308013745.xaqiwoyaytu56rfq@rob-hp-laptop>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306085911.5930-2-ran.wang_1@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 04:59:10PM +0800, Ran Wang wrote:
> Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
> When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB controller
> can use the length less than or equal to the largest enabled burst length.
> 
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms:
> around 3% improvement (from 364MB/s to 375MB/s).
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
>   - update ls208xa support according to code base change
> Changes in v4:
>   - change definition for this property.
> Changes in v3:
>   - add new property for INCR burst in usb node.
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++
>  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
>  7 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 44e8bab..d1779b2 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -59,6 +59,11 @@ Optional properties:
>  	fladj_30mhz_sdbnd signal is invalid or incorrect.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> + - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> +	register, undefined length INCR burst type enable and INCRx type.
> +	When just one value, which means INCRX burst mode. When more than one
> +	value, which means undefined length INCR burst type enabled.
> +	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.

I don't understand the multiple values for undefined length burst. Why 
do you need burst length if length is undefined? Looking at the driver, 
it looks like you only care about the largest value.

Rob
