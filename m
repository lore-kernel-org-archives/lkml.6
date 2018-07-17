Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF85ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA04820C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8sg+/dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA04820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGQNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:31:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbeGQNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhsM5wvq1NSxUss5zPq3aSAgeF0ShODsQvEZ6CP1ZD8=; b=W8sg+/dZxVNgNo/N/YSSy95Of
        097BmjtqiyWHgbs+4G99PAcz+1zx2q+O8rnx+w9WVik2ywAaKv7I3J3AlfiPzMT7OvQFBfjhkQgwI
        oLPLa9HPxNxZjfWoOEHnkmSmTNmzURVqhC34W1HExdeDnhU3cYKR7LWimwfJ8kWEY/5a9E+b6gxT7
        qPIFzBqMHf392RfKSILDGD+VG3EAfxSdpG/WTSAFzy0B0JQgJqlHEHdu7q/7YOoVX54PcjBIKm5W0
        bY8JaxWUVuZY39qbjM+n+cw1+X06zjeCnw4TXtyjXLtEg5Nldso8WREFTohfc/73vop2mSzbk6sAZ
        GhI+e62nA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffPZ9-00033Y-Pf; Tue, 17 Jul 2018 12:58:55 +0000
Date:   Tue, 17 Jul 2018 05:58:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
Message-ID: <20180717125855.GA3681@infradead.org>
References: <20180713133204.3123939-1-arnd@arndb.de>
 <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
 <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:11:53PM +0200, Arnd Bergmann wrote:
> I don't think it makes a big difference whether we change it now or later,
> but if Christoph feels that it addresses his concern about the compat_
> namespace being reused during the transition, doing it earlier would
> enable us to finish the remaining syscalls.

Yes, I've been looking at your new series and the reuse of compat_*
is really confusing
