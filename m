Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8682C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A80217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbeLTSBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:01:10 -0500
Received: from namei.org ([65.99.196.166]:52612 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeLTSBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:01:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBKI0hEP029738;
        Thu, 20 Dec 2018 18:00:43 GMT
Date:   Fri, 21 Dec 2018 05:00:43 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Subject: Re: linux-next: Tree for Dec 14 (security/integrity/ima/)
In-Reply-To: <20181214222802.GP11670@windriver.com>
Message-ID: <alpine.LRH.2.21.1812210500010.29474@namei.org>
References: <20181214181826.5775b958@canb.auug.org.au> <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org> <1544815174.3681.16.camel@linux.ibm.com> <20181214202650.GO11670@windriver.com> <20181214222802.GP11670@windriver.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Paul Gortmaker wrote:

> >From 31081a8b46e84d64e2fbda8d0d82ba26d56cc468 Mon Sep 17 00:00:00 2001
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Fri, 14 Dec 2018 16:48:07 -0500
> Subject: [PATCH] security: integrity: partial revert of make ima_main
>  explicitly non-modular
> 
> In commit 4f83d5ea643a ("security: integrity: make ima_main explicitly
> non-modular") I'd removed <linux/module.h> after assuming that the
> function is_module_sig_enforced() was an LSM function and not a core
> kernel module function.
> 
> Unfortunately the typical .config selections used in build testing
> provide an implicit <linux/module.h> presence, and so normal/typical
> build testing did not immediately reveal my incorrect assumption.
> 
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-ima-devel@lists.sourceforge.net
> Cc: linux-security-module@vger.kernel.org
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index adaf96932237..616a88f95b92 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -21,7 +21,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/file.h>
>  #include <linux/binfmts.h>
>  #include <linux/mount.h>
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


-- 
James Morris
<jmorris@namei.org>

