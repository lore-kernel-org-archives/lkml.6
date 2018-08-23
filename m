Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABFFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931AF2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931AF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeHXAlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:41:46 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:45623 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727944AbeHXAlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:41:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E5C09837F24D;
        Thu, 23 Aug 2018 21:10:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll73_5921ae4914154
X-Filterd-Recvd-Size: 1895
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 Aug 2018 21:10:12 +0000 (UTC)
Message-ID: <e6d223637ee3b2afb83bda2732b197dca7f2e6d8.camel@perches.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, asmadeus@codewreck.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        dwmw@amazon.co.uk, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Date:   Thu, 23 Aug 2018 14:10:11 -0700
In-Reply-To: <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
         <20180823002508.GA822@nautica>
         <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
         <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
         <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 14:03 -0700, Nick Desaulniers wrote:
> One of these days, I'll get frustrated enough to
> rewrite checkpatch.pl as a set of clang tidy checks (so that it
> actually parses the code), but I'll have to learn how to read perl
> first to start translating.

Good luck with that, remember that checkpatch works
on diff chunks and not files.

