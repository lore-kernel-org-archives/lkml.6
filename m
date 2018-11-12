Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71933C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3361722419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQyjtBlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3361722419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeKMEIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:08:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NsM5+RMQeQTvhBZ57KpyZK+cMdmO6CIALUMjPboMH8c=; b=XQyjtBloNLHkQJyPI3fAUvKnQ
        QuyU+TL0QDs6uxOzNpOJwCNLL8LWI0eZ7y2/FpT68W31BZ0ROU4RiTne+a7dJSGPOMA/BIO1sgmpC
        RN3heh+4znfWszDjqCKuZtvhtina8iw2rdIbCj/Nk0vQA6CQit0K+kZp4h/5ajVol+r+whG8tuDWX
        l+V58EyuDLc2cItr0138NS8XygzslTkZijCJPusMMeRKTtPeh5p8B6UD+aipXDT2CBjfhJl640CjJ
        bsEmenlm2sulxdYocrOJeMRnjKmH4Kz07bIgd0/crH0l+yMggbPuxThXm3QbJluV22ZYiWNX5jI7j
        yppG2x5PA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMGjD-0002nu-SL; Mon, 12 Nov 2018 18:14:28 +0000
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
 <20181111111143.GB4189@1wt.eu> <87zhufvntw.fsf@oldenburg.str.redhat.com>
 <20181111120910.GA4425@1wt.eu>
 <alpine.DEB.2.21.1811121723210.6607@digraph.polyomino.org.uk>
 <20181112175305.GB15484@kroah.com>
 <alpine.DEB.2.21.1811121803520.6607@digraph.polyomino.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a67f4f9c-701f-f607-e708-b8545d80549e@infradead.org>
Date:   Mon, 12 Nov 2018 10:14:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811121803520.6607@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 10:09 AM, Joseph Myers wrote:
> On Mon, 12 Nov 2018, Greg KH wrote:
> 
>> If there are still problems with this, please let us know and we will be
>> glad to resolve them.
> 
> With headers installed from Linus's latest tree, I retried (for x86_64) 
> the case of a source file containing the single line
> 
> #include <linux/elfcore.h>
> 
> which (as previously discussed, and Arnd had an RFC patch) I want to use 
> in a glibc test of header consistency.  It gives errors "unknown type name 
> 'elf_greg_t'" etc. (for lots more types as well) - but even before getting 
> onto those errors, there's
> 
> asm/signal.h:127:2: error: unknown type name 'size_t'
> 
> from a header included from linux/elfcore.h.  So this doesn't seem to be 
> working as I'd expect yet.


Yes, someone from Google (iirc) and also David Howells had some tests
that would point out all of the problems.  I thought (expected) more follow-up
from them with patches...


-- 
~Randy
