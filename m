Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E02620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GlczpNt2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GlczpNt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E02620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGWWhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:37:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGWWhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:37:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A6A060B11; Mon, 23 Jul 2018 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381670;
        bh=8xQullK9wZoW8wzeo1wIYBPufpfhTLbwqnJhOL/vVSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlczpNt2fjaRhXSHnKsZ+/2BalmDh3EFov8HuHNUEj/fgrMTPOWaax3QRIbHjQ/MQ
         2CocbUvWmFhmdDJEticmNDiA8LP1hxbAxvuYwB40dz+RiYjSxd6HDZFgiHkKlcCALp
         lG8AjVFrfYCqgA6Vu/OBArIgfm48E3ahCuoR5QsM=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62E6B60588;
        Mon, 23 Jul 2018 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381670;
        bh=8xQullK9wZoW8wzeo1wIYBPufpfhTLbwqnJhOL/vVSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlczpNt2fjaRhXSHnKsZ+/2BalmDh3EFov8HuHNUEj/fgrMTPOWaax3QRIbHjQ/MQ
         2CocbUvWmFhmdDJEticmNDiA8LP1hxbAxvuYwB40dz+RiYjSxd6HDZFgiHkKlcCALp
         lG8AjVFrfYCqgA6Vu/OBArIgfm48E3ahCuoR5QsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62E6B60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Mon, 23 Jul 2018 16:34:27 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
Message-ID: <20180723213427.GB12771@codeaurora.org>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
 <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
 <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 10:24:58AM -0700, Randy Dunlap wrote:
> On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> > CC hexagon
> > 
> > hexagon != H8/300 != SuperH
> 
> argh.  Thanks.
> 
> > On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
> >> to unsigned long to match the function parameter type.
> >>
> >> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
> >> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
> >> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Rich Felker <dalias@libc.org>
> >> Cc: linux-sh@vger.kernel.org
> >> ---
> >>  arch/hexagon/kernel/dma.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>

Thanks all the same!

For Hexagon:


Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
