Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9126C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A329F21A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404897AbeLVRBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:09 -0500
Received: from ozlabs.org ([203.11.71.1]:57379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbeLVRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLT217xxz9sPZ; Sat, 22 Dec 2018 20:55:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e213574a449f7a57d4202c1869bbc7680b6b5521
X-Patchwork-Hint: ignore
In-Reply-To: <20181102004455.10157-1-joel@jms.id.au>
To:     Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jinsong Ji <jji@us.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [v2] raid6/ppc: Fix build for clang
Message-Id: <43MLT217xxz9sPZ@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:55:01 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 00:44:55 UTC, Joel Stanley wrote:
> We cannot build these files with clang as it does not allow altivec
> instructions in assembly when -msoft-float is passed.
> 
> Jinsong Ji <jji@us.ibm.com> wrote:
> > We currently disable Altivec/VSX support when enabling soft-float.  So
> > any usage of vector builtins will break.
> >
> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > I guess this is currently a limitation.
> >
> > Removing -msoft-float will make it work (and we are lucky that no
> > floating point instructions will be generated as well).
> 
> This is a workaround until the issue is resolved in clang.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e213574a449f7a57d4202c1869bbc7

cheers
