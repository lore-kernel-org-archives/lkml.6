Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21CC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDBB214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544063546;
	bh=MxhCiFQatjxOMgz+1rqbchlQdGtrqo0NSsYG5FYWZ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/dtOqF2rhpN5FjyGA0bwVgomrJuYONABRISOpodAZTxjr4ZMIMRH/0Y5dqiz9yvm
	 XytqCJsIiX3WqPxhzYZQvDb8cT6KhZEaAVbH2EIu2iZWpDHfO8ajZDIX4jAPkw726G
	 LCV1KMG5OEKCr6dBKkaU2EmGHKSnUoS+fzZB8Law=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDBB214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeLFCcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbeLFCcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:32:24 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C742082B;
        Thu,  6 Dec 2018 02:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544063544;
        bh=MxhCiFQatjxOMgz+1rqbchlQdGtrqo0NSsYG5FYWZ6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO/WafPMZrb+EAztsrjxaORgNQ7gzJjtHZcTqVxc+J/O4V4tgZLQHDchsJgFwnEbU
         cl3vKj9Dufw7NpaM9XGFPGkF9cXJd0aLl8yC7fTGaenzs/1JM0I+g9M/EfcjWCTD4O
         wV2XcNOBlG1bOpEqr71/pgDECRwouF7S888ccBR4=
Date:   Thu, 6 Dec 2018 10:31:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20181206023140.GZ3987@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-19-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> Convert Freescale SoC bindings to DT schema format using json-schema.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/armadeus.txt      |   6 -
>  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
>  .../bindings/arm/compulab-boards.txt          |  25 --
>  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
>  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++

Rob,

I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
tree, so please send it via your tree.

Acked-by: Shawn Guo <shawnguo@kernel.org>
