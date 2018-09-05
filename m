Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A39C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E62075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnPSWYFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeIEXeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:34:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aTwInINxLnYpoqcJ3VC+KFTNmLJ0g4rfFd7VojpoWW0=; b=ZnPSWYFogv4cE5rp6tPljmgZA
        7cRmwEjSZY0YogMtNNIXxnf/R4IsDKARKEMRzbkATFWQYMZDtv/rJKMmwZyf8XHgWSnsnzLwiq3jh
        u/QmNX3qg/msDwRUALtYBJ1rK+w0PPBc00e1ij5ORKyId2OchMvrn5fI+QTZaFjXMBMdt2/PbaiLb
        bETK1Aqpbbe79WDjsB81Vg0QH414NuWSX7aRn2OAuOKCtKDeKI6iZg1TTdxvO0q6dwOUIVIN493tA
        bTxQh34bcufdkG/btSu0w8wjfUXcjbjGK/T7ggG9VujEJ7gXgTaMXmHxc0MfbijMBdIApDN3KFVNJ
        aLT9QEAdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxd4x-0000Ry-P9; Wed, 05 Sep 2018 19:03:03 +0000
Date:   Wed, 5 Sep 2018 12:03:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] RISC-V: Request newstat syscalls
Message-ID: <20180905190303.GA1420@infradead.org>
References: <1536158166-3397-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536158166-3397-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:36:06AM -0700, Guenter Roeck wrote:
> Fixes: 82b355d161c9 ("y2038: Remove newstat family from default syscall set")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I would suggest to merge this patch with the offending patch.

Yes, that would be helpful.
