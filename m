Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1391C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A921770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FV3sxoMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548A921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeHGPqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:46:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeHGPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zJX7uleA7Ys4e1s8zHRCqcE5wV2dVB+tyObZUJ2N5as=; b=FV3sxoMkVcIoGozagKI4RiZwJ
        IVqIy4oi849OlsgqnhVUz4U7THZJkP144/VGC0G5PdPF011MNyLfovi3ESnDAcJ510aBNwLL+QBcn
        DUOcepHztRybfnp5AdgfEnMKomsG45V/8SxFGTLDnyuOLK/Y6On3xCnPmY+ydgYfwZABFnBmTK/7X
        ix3MpYUDs3dz6oNhPxaSbXMjNF3A42hs+oN7+NNNSRjPzbi31/14AVoXv5I6SiLidf2WGYQa31pne
        mxrVM0JYo0NwNDMTvMzustGZohPFpADPBFx4cPkHmU+gGi7UKHZ53KpfyppIR59d+sDH+I/TWj6gv
        A6cav6s3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn26A-0000Jk-NG; Tue, 07 Aug 2018 13:32:30 +0000
Date:   Tue, 7 Aug 2018 06:32:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tty/serial_core: add ISO7816 infrastructure
Message-ID: <20180807133230.GA26577@infradead.org>
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
 <20180807130049.5957-2-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807130049.5957-2-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 03:00:48PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the ISO7816 ioctl and associated accessors and data structure.
> Drivers can then use this common implementation to handle ISO7816.

It would help a lot of you'd explain what ISO7816 is.  Without that
the changelog is rather meaningless.
