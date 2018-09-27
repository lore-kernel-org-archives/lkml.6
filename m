Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F0A2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F0A2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeI0S6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:58:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeI0S6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:58:14 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D980EFE7;
        Thu, 27 Sep 2018 12:40:07 +0000 (UTC)
Date:   Thu, 27 Sep 2018 14:40:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Zdenek Kaspar <zkaspar82@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4.14 64/64] crypto: x86/aegis,morus - Do not require
 OSXSAVE for SSE2
Message-ID: <20180927124005.GB23563@kroah.com>
References: <20180927090249.801943776@linuxfoundation.org>
 <20180927090258.591819886@linuxfoundation.org>
 <CADVatmPQQCaUrMYxP-STbP50HVSr68ngQcYLXcBgX_6B0QZ6Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmPQQCaUrMYxP-STbP50HVSr68ngQcYLXcBgX_6B0QZ6Sg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:30:04PM +0100, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Sep 27, 2018 at 10:04 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > commit 24568b47d48ec8c906fd0f589489a08b17e1edca upstream.
> >
> > It turns out OSXSAVE needs to be checked only for AVX, not for SSE.
> > Without this patch the affected modules refuse to load on CPUs with SSE2
> > but without AVX support.
> >
> > Fixes: 877ccce7cbe8 ("crypto: x86/aegis,morus - Fix and simplify CPUID checks")
> > Cc: <stable@vger.kernel.org> # 4.18
> > Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I am confused with this one. I am not seeing this in the "git log"
> from your 4.14.73-rc1.
> I also tried to apply this from your queue to v4.14.72 and it did not
> apply as it could not
> find some files.
> 
> error: arch/x86/crypto/aegis128-aesni-glue.c: No such file or directory
> error: arch/x86/crypto/aegis128l-aesni-glue.c: No such file or directory
> error: arch/x86/crypto/aegis256-aesni-glue.c: No such file or directory
> error: arch/x86/crypto/morus1280-sse2-glue.c: No such file or directory
> error: arch/x86/crypto/morus640-sse2-glue.c: No such file or directory
> 
> Am I missing something?

Nope, my fault, it was at the end of my quilt queue and should have been
deleted.  My scripts didn't catch the error, which is odd.

Now dropped, thanks.

greg k-h
