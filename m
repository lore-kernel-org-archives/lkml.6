Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73FA214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iltV4oQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73FA214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHULIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:08:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeHULIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Li3f/2LTZ8whdy4Jc34rk7eH/mkgDrVvLujkSs+678=; b=iltV4oQ/kNegI0o6LcDJFA8HP
        kjbKvlfUJPOSdgY/4nHbeuj1OXFSWinpF9nSFpapwuChMQsvymKOVWwHADfXYmRH5Roenw2B2bCYe
        gW3Q5tGfdmKzEFuAvoikEoQZuChE21QIHQBZzUOMuwW96jGU+yfoas5S8u8wXhy4YvpW7H0bgxD28
        E3aSCc3BE5bkTtCDpXyDz+BsPu/Bnyz8vRS0beU/FNtmI/3FehfoLyXBooKaoOF//JA+DlbXAyMn+
        DJJP8Cjr33TzZ7CcWd3nyy+HaLhCIO+i34OKsoOwT1eLyv1noR1GclML+jX2TkgrOpbM03Jyngklp
        19Osz79WA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fs1PW-0000GU-UY; Tue, 21 Aug 2018 07:49:06 +0000
Date:   Tue, 21 Aug 2018 00:49:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org,
        tglx@linutronix.de, Damien.LeMoal@wdc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] RISC-V: Move interrupt cause declarations to
 irq.h
Message-ID: <20180821074906.GB28079@infradead.org>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-5-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534377377-70108-5-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 04:56:16PM -0700, Atish Patra wrote:
> CPU hotplug code in smpboot requires interrupt cause
> to identify the cause of cpu wakeup.
> 
> Move the IRQ cause declarations to appropriate header
> file.

asm/irq.h is a header indirectly included by just about every
driver.  This is a very bad place for such internal definitions.
