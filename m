Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461FA2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuNLPd8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfBZUPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:15:25 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:34837 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfBZUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:15:25 -0500
Received: by mail-pg1-f174.google.com with SMTP id e17so4681092pgd.2;
        Tue, 26 Feb 2019 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WP6DvkVKwOLwO6Tw1PILQXbrpy/q83TaLNSLgLd6DC4=;
        b=LuNLPd8oWeP3D04NhZt30G5aPfktxfEOqFsIie/GmmoSu/92unFx1MbHleYUws5ToU
         vaC/H7IOXBjnyiUqkQgbpoeUq3JN2Mp9/wuxOfJvcBudD6gUtFk2ZvdHuHd+O6R5PIfI
         j6jfPosTppNHVEHCUypdlDldguVXoyWjeGbrpFbf983f49/Jft1xbT33EoJH/M4Zximu
         jz2xdffX3hD3tYyKtNir+s3viwhgCGQzcrBXlumW4W5Vuv/KrmNNXRht1mO4IbNXuI9G
         ZXHqBu5PsKACIdiOGTi/EuMv3j/imD4CAZQjq/23wcIY4MpgIRhIgiPIhxtWUeCX8xuL
         9a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WP6DvkVKwOLwO6Tw1PILQXbrpy/q83TaLNSLgLd6DC4=;
        b=AbDB8tVj4VBY/ngk5mckIR/H5jzDR3NIGwthZDifEy3P5xKrSmp5FDKfsBxlc7a5K7
         MzNPOuXry8uc5iPn0MaFraixuCcVL1aXQ3Hrzbxe/Y3qsbEVILnSHSsj/fV4UxqU+5DF
         6zsKvn6jYT1UGWGWp2NdgTKoHQ9zL+DZ/8vBGz80ztFc6f8wdwMxoJv5ntn17iZCW4w4
         ixGQZ0EAUuBBdwdo71xSPT/XLWQVC3t0kTqrIAob8O/iUfYoi+LkAg3fwPNQXYz2+Qtg
         kyXOgAM3CFJl60jQXFQxsnZayIoHCjCuMLhH1RHnU37QT2ZLbTl/dTMx8rCkuV32l8eW
         jL/w==
X-Gm-Message-State: AHQUAub+WA9KqIgTkv/6K+VdonpcAb1kIC7hLGV4qmrjNKta/DV7vr1l
        hWwxPsBNW8q1SJe/KI65t3k=
X-Google-Smtp-Source: AHgI3IZ2MGPXHPrrZe4U2HmrXm+GtnQDOaSL0PvfMzLMtUP9E5cXZcktAc89IjLw8UfBeeWGqQbcNg==
X-Received: by 2002:a65:6491:: with SMTP id e17mr25935585pgv.418.1551212124431;
        Tue, 26 Feb 2019 12:15:24 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q86sm36539802pfi.171.2019.02.26.12.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 12:15:23 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:15:19 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: Regression in Linux next with dma cma changes
Message-ID: <20190226201518.GA3205@Asurada-Nvidia.nvidia.com>
References: <20190226200155.GE39872@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226200155.GE39872@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:01:55PM -0800, Tony Lindgren wrote:
> Looks like commit d222e42e8816 ("dma-contiguous: do not allocate a
> single page from CMA area") caused a regression at least for
> omap dss where we now get the following error on init:
> 
> omapdss_dispc 58001000.dispc:
> dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Any ideas what might be going wrong?

It's probably because the dma_alloc_from_contiguous() call in
this path doesn't rebound to allocate a normal single page.

And I guess we should have left the change within dma-direct.

Christoph, do you agree?

I am submitting a revert first.
