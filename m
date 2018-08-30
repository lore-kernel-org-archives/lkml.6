Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE792C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6867C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="jVyq1Rpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6867C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeH3SkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:40:02 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40261 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeH3SkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:40:02 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 68A9625B74E;
        Fri, 31 Aug 2018 00:37:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535639853; bh=TPJM2CLNnYxqZcNE4Za2XQ3XcuY2CAQCC7EnYhRneqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVyq1RpaQirYp5TuxmLXObdeyxH/QuXgaq0BP3c/M15qT02LuDYsNZ5a3N+QwseL8
         c/KtJyXieXR5kRLUymtps1wCI+XYL9qJGnrGZ4hxsxQwzKN0kymyhHAfsNq39eZ6Aj
         VtQPlYV9LySv+SSEQWIvfgBH6leLN8DVU3TNnh0E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 58E1C9403D6; Thu, 30 Aug 2018 16:37:31 +0200 (CEST)
Date:   Thu, 30 Aug 2018 16:37:31 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: shmobile: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180830143730.dw26fj6dldfeajjn@verge.net.au>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-2-robh@kernel.org>
 <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:24:20AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 28, 2018 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Rob, thanks Geert, applied for v4.20.
