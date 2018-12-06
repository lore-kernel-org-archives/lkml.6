Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D01C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12813214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544063636;
	bh=QHDR3CFRFcSosA4IuEN+ynPYl35JtgdHv8oGMb13cAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BfAroiiEES2oEHuR6m07d/7B82zQ6kBOprg7tUgOV4Nb12kUx72h+mBBaBbH0FSke
	 XpvqJfAyvEBtAYxEcu7176kRUkBmrm1C+WsG4Ofv04wGrmmEbYtJ3+LrTyXkVAenzJ
	 X1a3WX7dkd1kqeVu/17W7qcVCxHEo4OdzgwGILvk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12813214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeLFCdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbeLFCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:33:54 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B842082B;
        Thu,  6 Dec 2018 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544063633;
        bh=QHDR3CFRFcSosA4IuEN+ynPYl35JtgdHv8oGMb13cAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bcj8ej3DaEYkobdBOAnXnL/kuzoqqMbweEK5vb3vM1YP1KIGgQzGMtJ2V9+IySOJD
         DTY18VUAkcqJQnyAWOxiZ1jMWaPQVOcwZOtf7yj95OVKK7hOZb6Y/URt49nmWPXSUl
         J2ea1nEo85L8BJF9zDN/1valavhKvoel9VY9JcUw=
Date:   Thu, 6 Dec 2018 10:33:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Jun Nie <jun.nie@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 34/34] dt-bindings: arm: Convert ZTE board/soc
 bindings to json-schema
Message-ID: <20181206023311.GA3987@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-35-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-35-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:32:23PM -0600, Rob Herring wrote:
> Convert ZTE SoC bindings to DT schema format using json-schema.
> 
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/zte.txt | 14 ----------
>  .../devicetree/bindings/arm/zte.yaml          | 26 +++++++++++++++++++

I do not have any changes on bindings/arm/zte.txt in my queue, so please
you take it.

Shawn
