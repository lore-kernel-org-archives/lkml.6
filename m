Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB03920880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="hDM5PxA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB03920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLJLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:47:56 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41218 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLJLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:47:56 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7CD1C25BED1;
        Mon, 10 Dec 2018 22:47:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544442473; bh=LKIeaLmdOqi4nzjknhWOEiBc61tzs+nV98+LQa+pTnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDM5PxA9h6jexWUVfpcjWElJY0u0yiNdixHOMCeayZH/NbZlso95QroxpkWfSdF0+
         zwBAxr9eIzgLo19/XSVHP5XKW+2HiCnrlEpHeQGmXm95jtBKiyWJRRIjig3DogFhXZ
         Er/wIrSrbir5eUscxy/oeZrHYeepc4/JIFG/lsYQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id F1C9C9402E1; Mon, 10 Dec 2018 12:47:51 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:47:51 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] soc: renesas: rcar-sysc: Miscellaneous fixes and
 cleanups
Message-ID: <20181210114751.65amaa7b7tjtcp5w@verge.net.au>
References: <20181205153945.13767-1-geert+renesas@glider.be>
 <CAMuHMdU89s997JhFpWOaDTFohcy4+Ym5deUUuv1EO7EybdJrkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU89s997JhFpWOaDTFohcy4+Ym5deUUuv1EO7EybdJrkg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:02:07AM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 5, 2018 at 4:39 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This series (against renesas-devel-20181204-v4.20-rc5) contains
> > miscellaneous fixes and cleanups for the R-Car SYSC driver.
> >
> > This has been tested on R-Car Gen2 (H2 and M2-W) and R-Car Gen3 (H3
> > ES1.0, H3 ES2.0, M3-W, M3-N, D3, E3, and V3M) (without 3DG).
> >
> > This not been tested on R-Car H1 and R-Car V3H.
> 
> Now tested on R-Car H1 (Marzen), with no ill effects on secondary CPU
> boot and CPU hotplug.

Thanks for following-up, good to know.
