Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A1FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77DF20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5DQXF8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77DF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeICFi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbeICFi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:38:28 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C56720841;
        Mon,  3 Sep 2018 01:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535937642;
        bh=TFIvgR3bhA7AIPZP47vHucpuCBtvjD450D1yUsYhpCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5DQXF8wYql3PvYeoDvtxTd3MPr+FIjJnqinKeBff8qCyXn7hmuC1f8TRyMIL05B4
         ehcZ4dVpQVYKb+vaGj4WEtYEFxxXxx2x5oFCffOsbwkCbrb/78BDQs6Uob1n5T1HQU
         Nq91jVrN1KzCOjUUGILdP8SJldR+X/mx6FAvNQms=
Date:   Mon, 3 Sep 2018 09:19:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, xiaobo.xie@nxp.com,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: Re: [PATCH v1] arm64: dts: dwc3: Add description of
 'configure-gfladj'
Message-ID: <20180903011931.GB3850@dragon>
References: <20180829073324.36866-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829073324.36866-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:33:24PM +0800, Yinbo Zhu wrote:
> This patch is to add description of 'configure-gfladj' to binding
> so that configuring devicetree
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Ah, okay.  You just started documenting the binding.  So please send me
dts patch only after the corresponding bindings and driver code are
accepted.

Shawn

> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 3e4c38b..40c6568 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -101,6 +101,7 @@ Optional properties:
>  			When just one value, which means INCRX burst mode enabled. When
>  			more than one value, which means undefined length INCR burst type
>  			enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
> + - configure-gfladj: determine whether frame length adjustment is required or not.
>  
>   - in addition all properties from usb-xhci.txt from the current directory are
>     supported as well
> -- 
> 1.7.1
> 
