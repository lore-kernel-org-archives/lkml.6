Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DED12081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RIEWumvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DED12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeLDOs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:48:27 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:43099 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:48:27 -0500
Received: from penelope.horms.nl (96-64-203-130-static.hfc.comcastbusiness.net [96.64.203.130])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B515B25B7C3;
        Wed,  5 Dec 2018 01:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1543934904; bh=9c0VKMlr4G0qlS81aEtR0YhJxfiJsuSOyDVDXo0NivY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIEWumvwAZ+JJTZR51F0Vel9B+UV1kGQndX0l6Jr85CQh2s2WzeAQaW1XcjVha5BB
         N7cglLcBiKn8Z36+8WhbJbgBpmrZkm/LWI8CsCSLJpXOms4I/uPI8WFJ7WoTkiblqK
         5ISgdIbQh18D+Kb4xm5ehr2ei67xTbZApYFc6kMM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id BD81FE217E3; Tue,  4 Dec 2018 06:48:22 -0800 (PST)
Date:   Tue, 4 Dec 2018 06:48:22 -0800
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181204144822.uqonsto45u7ysdu5@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-27-robh@kernel.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
>  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
>  2 files changed, 218 insertions(+), 151 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml

Hi Rob,

what is this based on? I get a conflict when applying the .txt change
and if I knew the base for this patch it would be rather easy to work
out what has changed.

Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
