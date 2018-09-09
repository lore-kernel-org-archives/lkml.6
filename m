Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B0C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F6720854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 18:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F6720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeIIXJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:09:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:37924 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeIIXJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:09:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E33A6D9;
        Sun,  9 Sep 2018 18:19:03 +0000 (UTC)
Date:   Sun, 9 Sep 2018 12:19:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 12/13] Compiler Attributes: add
 Doc/process/programming-language.rst
Message-ID: <20180909121901.5a36d0fd@lwn.net>
In-Reply-To: <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
        <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Sep 2018 23:24:58 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>  Documentation/process/index.rst               |  1 +
>  .../process/programming-language.rst          | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/process/programming-language.rst
> 
So I have some overall thoughts on the documentation; my apologies for
not getting to this until you got to v4...

1) I think the document is mistitled.  It's not really about the language
   that the kernel used, it's about compiler attributes.  So I would make
   both the name of the document and it introduction reflect that.

2) This is an ideal opportunity to document what all of those attributes
   actually mean.  I would guess that is the information many developers
   will come here looking for, and they'll go away frustrated.  The ideal
   thing to do, IMO, would be do say what each attribute means (rather
   than just which compilers support it) in a DOC section in the new
   compiler_attributes.h header, then use RST directives to pull all that
   information into this document.

Thanks,

jon
