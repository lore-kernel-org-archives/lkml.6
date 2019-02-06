Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D10C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B474217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YohOJKiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfBFR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:56:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbfBFR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:56:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so3439156wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9K77dtj/H5E1d6eBcuvAME5hWkpBH0E7hyAQxJ7wVDg=;
        b=YohOJKiIo3RLBbI2kH0lra50GZjR1P3Oqp3rY+49iiVE96fXdNNsPIcXLQjQHQNgwE
         Png2CbZWUl2uTVxwEesj9wIC3x2n6R5z6i/vuHSd2eomc8bhJOT/Vf/x09wnGduN2Sdy
         nY0+LwcizpsqkFBLzgvC1o7P4/tTbkUbX4Ay1OWRw9lISlYRkVpitGTK7Hbplk8VqVYs
         xvV3z3AxkrX/Xh2tm77U9KyDdbAguwoMoY2YhZySeDJKON+EqzEYBW+V730bT1c2P5w6
         qa+CU3deZQ3VzI2yHTBILvFs1sPWG4eXUYcPauPU8JqVHfMlAJpFY7DIUy+Z9Ba0PipS
         T1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9K77dtj/H5E1d6eBcuvAME5hWkpBH0E7hyAQxJ7wVDg=;
        b=ncOqo6wq5gczJOQa/7qnxbfTnBO2ox7fPHLT+OSI8vQT+H4tp2pkVhGaaAFuYHeBgU
         ABCXi3WUbgOY50zSd9G2DYe5M8m9s1xWTdFj7VSoxRPrdRqR8YE8gueZIyfxndOc6/Kx
         AA+xoX374TJSl0gVW9k7Ijj+q1duAQKGZC4VSSBDNWxxjE9tLQwhg0cDsNd6W6TiIzLN
         jMY4y5OcEq5Qg7dKwutM/NjPiyh0pf6t2yU4n1rdOJg8GiEGOqstWXm3QubXAhvojxjK
         loOYChOpVeNvSRixDPvYfPqzcxWfjkSfyw3J73aPuf46UPPdSDXPb6W9wjspJkaKg9En
         t7Cw==
X-Gm-Message-State: AHQUAuYXKcQObODc0Rvw4/9AJPiYabfxhpvBWvKxZevV7iYV4HV3wEjg
        5q7G6sTo5XLkTJfhztoWWDE=
X-Google-Smtp-Source: AHgI3IZGAIS1N6kkkXFV28rR/DjIWB0WfjV7etBXV9QGpigLVbcgx3gl2CXyWgJ91wy9vW9a/o5XQQ==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr4020699wmf.111.1549475801860;
        Wed, 06 Feb 2019 09:56:41 -0800 (PST)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id f139sm3811877wmd.19.2019.02.06.09.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 09:56:41 -0800 (PST)
Date:   Wed, 6 Feb 2019 18:56:27 +0100
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] include/linux/module.h: mark init/cleanup_module aliases
 as __init/exit
Message-ID: <20190206175627.GA20399@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target.

In particular, it triggers for all the init/cleanup_module
aliases in the kernel (defined by the module_init/exit macros),
ending up being very noisy.

These aliases point to the __init/__exit functions of a module,
which are defined as __cold (among other attributes). However,
the aliases themselves do not have the __cold attribute.

Since the compiler behaves differently when compiling a __cold
function as well as when compiling paths leading to calls
to __cold functions, the warning is trying to point out
the possibly-forgotten attribute in the alias.

In order to keep the warning enabled, we choose to silence
the warning by marking the aliases as __init/__exit.

Note that the warning would go away marking either the extern
declaration, the definition, or both. However, we only mark
the definition of the alias, since we do not want callers
(which only see the declaration) to be compiled as if the function
was __cold (and therefore the paths leading to those calls
would be assumed to be unlikely).

Link: https://lore.kernel.org/lkml/20190123173707.GA16603@gmail.com/
Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
Tested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
The new version I pushed for -next.

 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 8fa38d3e7538..1b5e370f1bc0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -129,13 +129,13 @@ extern void cleanup_module(void);
 #define module_init(initfn)					\
 	static inline initcall_t __maybe_unused __inittest(void)		\
 	{ return initfn; }					\
-	int init_module(void) __attribute__((alias(#initfn)));
+	int init_module(void) __init __attribute__((alias(#initfn)));
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
 	static inline exitcall_t __maybe_unused __exittest(void)		\
 	{ return exitfn; }					\
-	void cleanup_module(void) __attribute__((alias(#exitfn)));
+	void cleanup_module(void) __exit __attribute__((alias(#exitfn)));
 
 #endif
 
-- 
2.17.1

