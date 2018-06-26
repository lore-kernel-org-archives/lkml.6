Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5926C14
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC5926C14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbeFZUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:21:42 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:55620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754177AbeFZUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:21:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 861A9181D3368;
        Tue, 26 Jun 2018 20:21:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cast51_484f7692f8a0a
X-Filterd-Recvd-Size: 2234
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 20:21:36 +0000 (UTC)
Message-ID: <46d20fac2dc15d842ebf23c62372ecdb892d7efd.camel@perches.com>
Subject: Re: [RFC][PATCH] Makefile: globally enable VLA warning
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kbuild@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jun 2018 13:21:35 -0700
In-Reply-To: <20180626174013.GA41617@beast>
References: <20180626174013.GA41617@beast>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 10:40 -0700, Kees Cook wrote:
> This is the patch I've got prepared now that fixes for all VLAs have been
> sent to maintainers (some are still under review/adjustment, but there
> aren't any unexplored cases left). My intention would be to have this land
> at the end of the next merge window after all the pending VLA patches
> have landed. I just wanted to get any feedback here, since it touches
> a couple areas in the process and I didn't want anyone to be surprised. :)
[]
> diff --git a/Makefile b/Makefile
[]
> @@ -778,6 +778,9 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  # warn about C99 declaration after statement
>  KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
>  
> +# VLAs should not be used anywhere in the kernel
> +KBUILD_CFLAGS += $(call cc-option,-Wvla)

I'd probably spell out what a VLA is here.
# VLAs (Variable Length Arrays) should not be used anywhere in the kernel

Beyond that, seems sensible, thanks.
