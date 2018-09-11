Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C060C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A83206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q2utruhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A83206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeIKLPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2eG37OC2wnxmCbpj1EI33KsWp564vwH+16wC3j2WKhI=; b=q2utruhc7tqokiS4l7ID0uq7M
        kuxbECaSvGzkg6iZ/VIl6kWALWxYDZLtxrIbMY5kEw7KVn33qxNFGQ00GMvw3/krCODyyRbSNYkqX
        D2WqQ9NjR1KuuQlBp8ht+DtB8AS1mOUu7v4Yakhlf55gGlriJ5CTPfcgrjcG0LbJLfgSWowUSAFj8
        pktQdjxOKlZD1Ijuz9Qvvtfji4e/HfqEnkV+RECkzYBW6PHkCMuVxUsD54ufIQ7xdW+wjM11TpAcj
        Cee0ZF5XNeeOfEJzTjPtzpYAo5rJlouKfCIxKGMD9pv39Wa1JnGgZKvOq/IM8QQ0prNYf9gpkkOQ/
        G3pEc1X8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzbzd-00064j-Sp; Tue, 11 Sep 2018 06:17:45 +0000
Date:   Mon, 10 Sep 2018 23:17:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH v3 06/12] RISC-V: Rename riscv_of_processor_hart to
 riscv_of_processor_hartid
Message-ID: <20180911061745.GB15060@infradead.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-7-git-send-email-atish.patra@wdc.com>
 <20180910112548.GF12979@infradead.org>
 <6acd4eec-bdfb-cfc8-6dca-782eb9ec01b0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6acd4eec-bdfb-cfc8-6dca-782eb9ec01b0@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:36:52PM -0700, Atish Patra wrote:
> On 9/10/18 4:26 AM, Christoph Hellwig wrote:
> > On Thu, Sep 06, 2018 at 01:05:29AM -0700, Atish Patra wrote:
> > > From: Palmer Dabbelt <palmer@sifive.com>
> > > 
> > > It's a bit confusing exactly what this function does: it actually
> > > returns the hartid of an OF processor node, failing with -1 on invalid
> > > nodes.  I've changed the name to _hartid() in order to make that a bit
> > > more clear, as well as adding a comment.
> > > 
> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > 
> > Looks generally good, but it is going to conflict with the dt iterators
> > series from Rob.  Given that this is just a little cleanup it might be
> > worth deferring until the next merge window.
> > 
> 
> Sure. np. I guess the entire series can be parked in for-next until the next
> merge window opens.

Actually more in your series also conflicts.  I think we can defer the
patch from Rob as it is very small and simple and can be applied post
4.20-rc1.  
