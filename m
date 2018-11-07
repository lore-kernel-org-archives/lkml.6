Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KRzKI5XJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeKHESp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:18:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHESp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s654LG8/P3ZFtNmW599hqPGUY7c10mxU4vsU98iQ31g=; b=KRzKI5XJfg+AWUOIOuJqY4GvA
        22HseoiUo57jf9QqSdWJbYjOFi6A1gcHGU2ovmggqshn5gtaBhkdSWESZfPwRHdBn117VOCDL8VcY
        XqusTyAHZslzWWXXgJgJerahy97mQRDD0t5T4JGmryNnCLNsfpRUOe/fOxLSuQz8i/VKmOhNzBhEZ
        LYdO0bALaIW96SUXSEu2U54Yi2o75KCJ2Owfuzi5pPiKoQJ7jclNA/nlF/P79dwuczlncrtnDUxI0
        ngEBtqgwUV6lgzkx9QhNqR5fxKtKlrH9+L54EiJBFMtNKqVG7MwD9hP0FjbKiDvmXOTgBQNfCQi9f
        9qaCTNtDw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKSr4-0006zj-T6; Wed, 07 Nov 2018 18:47:06 +0000
Date:   Wed, 7 Nov 2018 10:47:05 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
Message-ID: <20181107184705.GA95239@fedora.eng.vmware.com>
References: <20181102114119.23859-1-anders.roxell@linaro.org>
 <CAK7LNARda14b9_8Yh7vC2PFa_w=yw+qD0YTriAVQ_Aw5PoXkNw@mail.gmail.com>
 <CADYN=9L2kEVJMiVRBUBU7z4B4_YrvkNefCE5FO3qjACgm=FugA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9L2kEVJMiVRBUBU7z4B4_YrvkNefCE5FO3qjACgm=FugA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 02:57:40PM +0100, Anders Roxell wrote:
> On Mon, 5 Nov 2018 at 09:35, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Anders,
> >
> > On Fri, Nov 2, 2018 at 8:41 PM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > In today's merge_config.sh the order of the config fragment files dictates
> > > the output of a config option. With this approach we will get different
> > > .config files depending on the order of the config fragment files.
> > > Adding a switch to add precedence for builtin over modules, this will
> > > make the .config file the same
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> >
> > I think this patch makes sense.
> >
> > Just in case, could you please provide me the context of the discussion?
> 
> For instance we don't want to force X86 from DRM=y to DRM=m, when
> enabling selftest, that would surely break somebody's setup and you also
> don't want to force ARM64 from DRM=m to DRM=y, that seems
> unnecessary for a big subsystem like DRM.
> 
> >
> > Does the real problem exist in the kernel tree,
> 
> Not that I'm aware about.
> 
> Cheers,
> Anders
> 
> > or for local fragment files?

This is really about ordering of fragment files and not "making a symbol
'less'", I think were Arnd's words.

So, doing something like:

$ make arm64-selftest.config drm.config

where arm64-selftest.config defines DRM=y and drm.config defines DRM=m, the
result should be "DRM=y".

So the first step is to make merge_config.sh support it. A follow up step would
be to integrate this into the kernel Makefile system if we determine this is the
correct behavior, or to provide a parameter if we don't want to change the
default behavior.


-- 
Darren Hart
VMware Open Source Technology Center
