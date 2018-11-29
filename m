Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6154EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD5D20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQaCmV4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD5D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeK3Di5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:38:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeK3Di5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6S8T1/ozDfgvj/IZZYEdp1msRrLxjSOc1DfsDdupEQ=; b=JQaCmV4qZuS4WCUvjaMI/tffl
        PzHymh5/4olRWtMgWiiOyUBTAj5fSqQLz+P+tr+ghbE0MOyeHz8N6zllvpYKfK7FwQyxKghye5XBk
        cv3IUUQDSFpgeZT6K5o6NpXLHPWvSTVgw7EtFZ9hL1ImElZAZJy9QCvNNuptLeUUqN0Ojrfjc1xed
        M32g9SibhQ5ZMyx3Dnq8TCGxfwkaEBvE6cbnsVGp1eVWgHNuWs0LX+mFSE3/4HjemxctZ/7gM+0KC
        ua34NyGNqIxi4JBSdY38/hs5cAJmPuxAkmZAVBp3So60tNEMkrPtGU22KqlMkq6EyVSa8jrj+zRTU
        cRWX+5yEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPFL-0000z0-7S; Thu, 29 Nov 2018 16:32:59 +0000
Date:   Thu, 29 Nov 2018 08:32:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
Message-ID: <20181129163258.GA26511@infradead.org>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-4-phil.edworthy@renesas.com>
 <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:54:37PM +1000, Greg Ungerer wrote:
> Hi Phil,
> 
> On 17/11/18 12:59 am, Phil Edworthy wrote:
> > clk_get_optional() returns NULL if not found instead of -ENOENT,
> > otherwise the behaviour is the same as clk_get().
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Acked-by: Greg Ungerer <gerg@@linux-m68k.org>
> 
> Looks good. Do you want me to take this in the m68knommu git tree?
> Or is the whole series going through some other tree?

Any chance we could just get coldfire moved over to the common clock
framework?
