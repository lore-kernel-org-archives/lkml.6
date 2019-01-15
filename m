Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C91C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925FF20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZA5/7RN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfAORWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:22:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfAORWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zf02zyUAZy9qYRpn7J2k3vi7Owzge1mjj387QTnPyng=; b=ZA5/7RN2tiFLeYOpc149IM2rj
        vldvlIsanPpNV3rmnYnqMkzRNespkw1wMM+zyin2kHRib8BM27PffrIGI/PIHjOQ69CukTkc6NXRN
        BVmJ/ZwevmBfB0zhISkhpxGQbaoMjQ6dehezOaJWvgXHQHlKDdtxSMmsH6Yi5Jw9a/xQYJAZ1Qs0j
        dGghQYvUwyost6N1/GWvsiOWyy2cyYrkM0eSabiji8r7+XumH9XTIjyAe5bCFWN+fATboAQz/Rvnj
        uc0W8Niba/7HGKqS9wO8nfi8YtbQ5dAW6DjLddJZXwSNtDSMAoOBUZH/jPu1+9oIAYQ2K/8odjFwg
        WCsZ4SoAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjSQ6-0000Jw-7z; Tue, 15 Jan 2019 17:22:34 +0000
Date:   Tue, 15 Jan 2019 09:22:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: Make CONFIG_FRAME_VECTOR a visible option
Message-ID: <20190115172234.GA991@infradead.org>
References: <20190115164435.8423-1-olof@lixom.net>
 <20190115170510.GA4274@infradead.org>
 <CAOesGMg4hd8z=2FVDTYMiuKzHnobNLnncV37j77BA+gQGg=heg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMg4hd8z=2FVDTYMiuKzHnobNLnncV37j77BA+gQGg=heg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:17:30AM -0800, Olof Johansson wrote:
> I'd argue it's *more* confusing to expect users to know about and
> enable some random V4L driver to get this exported kernel API included
> or not. Happy to add "If in doubt, say 'n' here" help text, like we do
> for many many other kernel config options.

It is just like any other library function - you get it with a user.

> In this particular case, a module (under early development and not yet
> ready to upstream, but will be) worked with a random distro kernel
> that enables the kitchen sink of drivers, but not with a more slimmed
> down kernel config. Having to enable a driver you'll never use, just
> to enable some generic exported helpers, is just backwards.

Just develop the damn driver in a kernel tree and let people pull
the whole branch like everyone else: problem solved.
