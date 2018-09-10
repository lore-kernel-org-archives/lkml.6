Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346C420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QbQL5KBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346C420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIJQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:19:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeIJQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gaaxpSo21p2ivkJ6nDCm5NzBF46EFNIfHwc7zjQ0irA=; b=QbQL5KBsrn6nc/C/Z1r/+QTME
        ajNyuC5tcD+X5+FYU8uDXKv0eG2oO+PN7T2hY676tBsHaU6CA4QfN9nnqX+B0HqqDvIiOSAZ42RmI
        BYzpVL8B8y+Pz5h4zK45NHLUWX6SfU4CQ9n0vVdSNK6YCWaypJwk8jJLYKfnyq+zd/iw0Yy52j8/X
        V5LmwA+VcB2YbO0bhmQRG0w5b5yNJ5UNSXc0V4++6Jlv0sbYHZE80xim80gL4iS5Fl/TviTNHjrW4
        sJxqSXEqPD89XgwiBnvlO4AVUrgZo1EWF+CYgGtZoLRo5EfqnVtKuFTvUgWP8gIAArqTncLYieGc8
        l+MtP0wnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzKKC-0006y5-AC; Mon, 10 Sep 2018 11:25:48 +0000
Date:   Mon, 10 Sep 2018 04:25:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org, mark.rutland@arm.com,
        Damien.LeMoal@wdc.com, jason@lakedaemon.net,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 06/12] RISC-V: Rename riscv_of_processor_hart to
 riscv_of_processor_hartid
Message-ID: <20180910112548.GF12979@infradead.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-7-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536221135-182613-7-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:05:29AM -0700, Atish Patra wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> It's a bit confusing exactly what this function does: it actually
> returns the hartid of an OF processor node, failing with -1 on invalid
> nodes.  I've changed the name to _hartid() in order to make that a bit
> more clear, as well as adding a comment.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Looks generally good, but it is going to conflict with the dt iterators
series from Rob.  Given that this is just a little cleanup it might be
worth deferring until the next merge window.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
