Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B68C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF54F208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF54F208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHUAF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:05:28 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:52564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbeHUAF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:05:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 458A2837F243;
        Mon, 20 Aug 2018 20:48:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: place26_e5314867fc01
X-Filterd-Recvd-Size: 2181
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Aug 2018 20:48:18 +0000 (UTC)
Message-ID: <744af111abe22c4dfda58b4a0759609bcd2eb8f2.camel@perches.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org
Date:   Mon, 20 Aug 2018 13:48:17 -0700
In-Reply-To: <20180820144206.4e42c9fc@lwn.net>
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
         <20180820144206.4e42c9fc@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 14:42 -0600, Jonathan Corbet wrote:
> On Mon, 20 Aug 2018 13:15:26 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > +#if GCC_VERSION < 40600
> > +# error Sorry, your compiler is too old - please upgrade it.
> > +#endif
> 
> It seems we could be a little friendlier here?  "Kernel compilation
> requires GCC >= v4.6, please upgrade" ?

This is unchanged text, it's just moved around, but sure, trivial...

Wordsmithing should likely be a separate patch though.
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 250b9b7cfd60..5d95cabd13b3 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -11,7 +11,7 @@
 		     + __GNUC_PATCHLEVEL__)
 
 #if GCC_VERSION < 40600
-# error Sorry, your compiler is too old - please upgrade it.
+# error Kernel compilation requires GCC >= v4.6, please upgrade your compiler
 #endif
 
 /* Optimization barrier */


