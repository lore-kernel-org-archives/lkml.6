Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF76C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49425208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49425208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeGITVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:21:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754528AbeGITVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA3B80401B6;
        Mon,  9 Jul 2018 19:21:36 +0000 (UTC)
Received: from treble (ovpn-120-114.rdu2.redhat.com [10.10.120.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEF771C596;
        Mon,  9 Jul 2018 19:21:35 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:21:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] objtool: move libelf detection to Kconfig from Makefile
Message-ID: <20180709192134.vhd4lh443fymthfs@treble>
References: <1531043982-13325-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531043982-13325-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 19:21:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 19:21:37 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 06:59:42PM +0900, Masahiro Yamada wrote:
> Currently, users are allowed to enable STACK_VALIDATION regardless
> of the compiler capability.  The top-level Makefile warns or breaks
> the build if it turns out that the host compiler cannot link libelf.
> 
> Move the libelf test to Kconfig so that users can enable the feature
> only when the host compiler can build the objtool.  The ugly check
> in the Makefile will go away.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for cleaning this up!

> I am sure about this patch only from the build system point of view.
> 
> Please review this from x86 and objtool point of view.
> 
> In my understanding:
> 
>  - UNWINDER_ORC _requires_ objtool,
>    so I added 'depends on STACK_VALIDATION'.
>    ('select' would end up with unmet depenency)

Correct.

>  - RETPOLINE _wants_ objtool, so I added 'imply'

Yeah, I think this is fine.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
