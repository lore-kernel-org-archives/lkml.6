Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD02C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAC020856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBc6qDvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAC020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeJ0Q0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:26:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0Q0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mqaUCOFBFYJYsnLY7OQxGoPDOvQJyr8Y2RrHnFs3nHM=; b=HBc6qDvgNerNICCAI+jpfcQoj
        DR8fmcCa79QQR6UASNtNdfEiFkI9LPI+4CjPya1ecLaNorIiVLiaEjJzocTzzvxFyqz1PLSZLd/RY
        EAzZh3b3GeZW5DtKEcfqtwv4E0u+uxiJCKcduyTFGcowGxmM+Q5rKhe3tAjqPggcPLuZKslmixxC/
        KoO7lupH7THemSZBV9LuVH9xpnQ60tIdCtkqUwmFCx4e80WdutySfhmm+2Q0BFGxM2GKGNITFw9OZ
        w/8/eCUDKdckQkPhvjbJ9/ZOt8ywM3vfjNsg6aIFxieJ5JrGf7scVv+lAvyTSKuO0zOZcC9Pbf+Jk
        utqt7kXFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGJIT-0003YZ-Iv; Sat, 27 Oct 2018 07:46:13 +0000
Date:   Sat, 27 Oct 2018 00:46:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, david.abdurachmanov@gmail.com
Subject: Re: [PATCH 1/2] Move EM_RISCV into elf-em.h
Message-ID: <20181027074613.GA7868@infradead.org>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com>
 <20181024204036.8799-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024204036.8799-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 01:40:35PM -0700, Palmer Dabbelt wrote:
> This should never have been inside our arch port to begin with, it's
> just a relic from when we were maintaining out of tree patches.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Looks good, and probably harmless enought that we should pick it up
for this merge window:

Reviewed-by: Christoph Hellwig <hch@lst.de>
