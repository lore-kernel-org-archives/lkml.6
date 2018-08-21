Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F21214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="po6S1S3x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFZqbf+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F21214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHURBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:01:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39275 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbeHURBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:01:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CCDF6220B8;
        Tue, 21 Aug 2018 09:40:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 Aug 2018 09:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2C731JKeMnPKjUjS7F8NA1HnhlXVkQHiMtH2XQiIsec=; b=po6S1S3x
        61dpYep/Y3Uu40lLAuNRcUYIP30hHIA1iHxu6rozt3m9seAU5LLSRtc5S7+ROn5l
        N5Kzfl01zc3af2yq6HqMCX14r/wgFl37Bla38W6/xUOCM22RlsVEpKwj0ZfsxPCP
        Voh0+imW07QHPDAGg4Xvly3NqjmvFn34bL3xrqplyUWztP6RkK50yOBnBvsWOKN+
        1Tms79y2N0OKLLSbh6D+DxVPRUOgf+VM4YMU1HJZR5lE0zS75+OKlLtnQUvmvifK
        V8RQe9TaPbowcTK0ZcSax2lRymiDfQTycmKybQu3qgpbrZhjX471VLCVcgkEZv5M
        jwHiCTMFaff+5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=2C731JKeMnPKjUjS7F8NA1HnhlXVk
        QHiMtH2XQiIsec=; b=tFZqbf+pzuY/aibEMvPJLTgvnudLxTN5P4aWvALthRrFG
        JHFBU+lrTSMBP0+wtT01Af0/EX5PY4y2qdL0uNekLhq5pJSk+3OmYQgT1ZxGxLQk
        TvY8pODk1aEzLHBMfSw+IhJ6vQD7/jhRAIItRHKEI4fL05vHNtp0KeQHMGWSlvdH
        XbtiDsMTBIh20W+g0mzzEC6tNATx2QJgy7qtluqFQpVlS9PuDmhxQEIO/i2uKjKv
        R0kmkDtpyEcWmMMuvSz49GdPonn2fr2vNMJXDwaz0ONgJvf+MXr9zVJgastVxuzd
        KSSKYIp3oWUUgyIVksDkCSRJL++8Zx4+woWuTyFLQ==
X-ME-Proxy: <xmx:YBZ8WzOFm7zgVZkMmwb7TMRIJugad4pbOE05MSqE7A0UpCQBqd-KwA>
    <xmx:YBZ8Ww6n6BzSlDrSoLmzBmYJupKeKEoDI8GC0nD1oZQU7fVkzjCwYA>
    <xmx:YBZ8W6cJ1tZ_kcTtAFGW_dHsU6LYkMoTpIIlJL2ftVWJoCwUIPIdMA>
    <xmx:YBZ8W2jKuxoSpd3A7xjca3-mPK5JkCAAjIRlKMLwOc18MaLhxA3GuA>
    <xmx:YBZ8W6P7gf4hBjaILpGVJSapNWEc6FqwL28aTvJE4QxbTFdUDOT5DA>
    <xmx:YBZ8W_BZMkZTe1-5RAPSq6qudg_4ojeFcN4kX7SbJxZqEb670Q9nMA>
X-ME-Sender: <xms:YBZ8W8slD6K2wymvXq4LpPiq6HMX-6gekshP0QGMbTUoNWkBD244Ng>
Received: from localhost (ip-213-127-46-227.ip.prioritytelecom.net [213.127.46.227])
        by mail.messagingengine.com (Postfix) with ESMTPA id 831A91028C;
        Tue, 21 Aug 2018 09:40:47 -0400 (EDT)
Date:   Tue, 21 Aug 2018 15:40:44 +0200
From:   Greg KH <greg@kroah.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Kirill Kapranov <kirill.kapranov@compulab.co.il>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Message-ID: <20180821134044.GA18693@kroah.com>
References: <20180821095303.27664-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:53:03AM +0200, Geert Uytterhoeven wrote:
> If the SPI bus number is provided by a DT alias, idr_alloc() is called
> twice, leading to:
> 
>     WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
>     couldn't get idr
> 
> Fix this by moving the handling of fixed SPI bus numbers up, before the
> DT handling code fills in ctlr->bus_num.
> 
> Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
> ---
>  drivers/spi/spi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
