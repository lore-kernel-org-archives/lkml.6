Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06315C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA865218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWxHV8DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeLUHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:07:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RlPdgJjNIsAafooZk3tQ6HCwEIFyGNum01sKmFB78gI=; b=UWxHV8DEAKzZwOceUPItw3FHh
        QRDX74VJIVWP1AB4tffH6KDVHBKX9dalpaJcgGTn/1bcK9SKS1VzkWRca3d8dOXYifQiHAN53rbOU
        vC5lqRHARGiXfxUFyzFsiVtDekiYT7Gx252ycinQS3PNARQOvWBwaNUji8nRMdS4VEy2okLDlKhk5
        gM4KeTaFn94ZQhcHVmzfQWFISar81t9EDwGeRq+Nx7b1rA0eVbrAR6pWhhD1S4SEGqK0w7WgkfXVg
        fWmQ6NSqyAqtvB7ESENTf6mPO/wsFYg1+x6fMFniCvb82MPzTm81rcFOmckyvIU/RyHrNPsdp+oeD
        D6bQa+8dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaEtf-00017N-Bp; Fri, 21 Dec 2018 07:06:59 +0000
Date:   Thu, 20 Dec 2018 23:06:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rich Felker <dalias@libc.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [GIT PULL] asm-generic: syscall table script for arch/sh
Message-ID: <20181221070659.GA32300@infradead.org>
References: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3iAF3J8X2yj7JaCaTM_BcZ--2LZj32kkDf55mBn_cQ5g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The conversion does not include the old 64-bit sh5 architecture, which
> has never shipped and not even compiled in a long time.

Maybe it is time to drop the code for it then?
