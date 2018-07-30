Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C32083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmQx0bOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeG3UPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:15:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3UPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W3QduvDaLU+4yAWpcdGF5lrvtkktdZ5TVEt/V4ezlds=; b=KmQx0bOSBTSrygvZFA5Bjw+VL
        xkf78jrsAr2oHf6C8icCB+mAU6dZ7kgp8ZHU8lPEaZLEv4aEPt00Yg9B3w8SI4jxZkkMeUFVOG4Qs
        sP0KkUFCDHeVuGknNdQTDToPmM6LJuGja9tzc82P+9nmvM0nssUDrzN25MnQgsxT9q0OpZUdTi02/
        21TBS78frRl6so8sCjdW2+ThwyT3p1WWaSqfonUepU713/Ul8VyZv93Su9rn60JD34kbPZqfBEfQj
        G861Rhnal5Ykx9vRoT+PzBiWlviL0N0BF++xzGLc8lmliri9csxih/5sUEZ9hmm7xlPr2cCqkshzf
        vu1zwggTA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkD4C-0008JT-3x; Mon, 30 Jul 2018 18:38:48 +0000
Date:   Mon, 30 Jul 2018 11:38:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730183847.GB5544@bombadil.infradead.org>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
 <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:18:53AM -0700, Linus Torvalds wrote:
> On Mon, Jul 30, 2018 at 11:08 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Have you looked at how gettext() works?  It uses the english text as
> > a search string and replaces it with the localised string.  This is
> > a very common design!
> 
> I absolutely refuse to have anything to do with gettext in the kernel.

I wasn't proposing putting gettext in the kernel.  I was reacting to
Pavel saying "You can't return English strings from the kernel, you have
to translate numbers into any language's strings".

If somebody wants to use gettext() in userspace to translate the string
they got back from the kernel, that's fine.  But it won't produce very
useful bug reports.

