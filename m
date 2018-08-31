Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EKl7XUgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D4D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeHaK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:26:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V3elkUccPjf1N+YFY7nrFI2ujMhuAVXKqojzom4dfTE=; b=EKl7XUgtC465wO8TrRyBB8z0T
        IYJsmCs8VjkWa3+IxfZL+shKaqk+k7Hi7/QIDrT7ZBl22Zw7ZarLlEBX770Y/uGQmXZOAH37l4MIU
        FE/5MoOMP768nstOwO6T/tTREBbfqiw8dzmL2grflziwl5baLF+LQ2rrITU9RIBFToe0zw8tPxX5o
        Jhw/754CwW1duB+EyjdZ/HybI+0VdouEZHx1kpStm1u+smglDZ1ti9v+W4o/4VPTQP0yF8Xb6KMVR
        exjDV89s28Xk/0yxkXDuj04GSFLCQ6vp9WQG4pO6AVR1Gstsxkpd8WWWkCp7+wrFHECzLcZVRWeKT
        f/BLea3BQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvcms-00055G-Nz; Fri, 31 Aug 2018 06:20:06 +0000
Date:   Thu, 30 Aug 2018 23:20:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        schwab@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Do not overwrite initrd_start and initrd_end
Message-ID: <20180831062006.GA18424@infradead.org>
References: <1535502826-23856-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535502826-23856-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:33:46PM -0700, Guenter Roeck wrote:
> setup_initrd() overwrites initrd_start and initrd_end if __initramfs_size
> is larger than 0, which is always true even if there is no embedded
> initramfs. This prevents booting qemu with "-initrd" parameter.
> Overwriting initrd_start and initrd_end is not necessary since
> __initramfs_start and __initramfs_size are used directly in
> populate_rootfs() to load the built-in initramfs, so just drop
> that code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
