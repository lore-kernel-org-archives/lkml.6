Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FB420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHaVgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:36:31 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:53289 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbeHaVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:36:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2D0A1837F24D;
        Fri, 31 Aug 2018 17:28:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake29_4585098e58d45
X-Filterd-Recvd-Size: 1771
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Aug 2018 17:27:57 +0000 (UTC)
Message-ID: <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 10:27:56 -0700
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 19:05 +0200, Miguel Ojeda wrote:
> __optimize and __deprecate_for_modules are unused in
> the whole kernel tree. Simply drop them.

Nice series, thanks Miguel.

It'd be good to have a cover letter for the series.

And I believe there should be the equivalent of:

#if GCC_VERSION < 40600
# error Sorry, your compiler is too old - please upgrade it.
#endif

for compiler-intel.h and compiler-clang.h so that
each supported compiler minimum version is checked.

Is it clang > 13 and icc > 3 ?
