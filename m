Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FE427AF4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="cSccd8yZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FE427AF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967682AbeF2Czy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:55:54 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51688 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966362AbeF2Czx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H1psoK6Fku72k2JMWMFUIRmElud7NnvXvIGIydP0d70=; b=cSccd8yZcceCwZYI7J0UGGMla/
        LuxsgUD5A7m/cIe4WiuFxkeQrDiWZ3qab6Ml6aXOuML3IHllBxJJVlWC1y0Xe0ZbO48oPYa+Xadi0
        f1pZVV3jPydBhVXX8wsv8x8FccdYEdTDN7qyOUrTEvYXLqZo0CyN4LzRRM2/SphU0OndP+v1nYI0Z
        IeS4mbtnjv+4k1p0v+WXLP9w8vkFHdFWFB0VPkRzqxmIoO9zYvu9B/h7RmDSt5GvBY1CRtVP5rMCT
        VZg+kMjCoG8llOuekoA45QTixKTLVEOscHxpM3yUDWZWqUPcJnOAyW/JXTNJsol+C7gQm2JaoG0P5
        jTsQJiBA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49400 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYjZg-007tNP-Gw; Fri, 29 Jun 2018 02:55:52 +0000
Date:   Thu, 28 Jun 2018 19:55:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [v4, 2/6] Documentation: DT: Add optional 'timeout-sec' property
 for sp805
Message-ID: <20180629025551.GA28627@roeck-us.net>
References: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:01:33AM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> index 0fa3629..bee6f1f 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> @@ -19,6 +19,8 @@ Required properties:
>  
>  Optional properties:
>  - interrupts:  Should specify WDT interrupt number
> +- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
> +               default timeout is determined by the driver
>  
>  Example:
>  	watchdog@66090000 {
