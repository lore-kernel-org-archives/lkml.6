Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEQJq2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:46:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeEQJq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:46:27 -0400
Date: Thu, 17 May 2018 11:46:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the integrity tree
Message-ID: <20180517094624.lycmqeibd7un5ehe@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180517165110.6a014e12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517165110.6a014e12@canb.auug.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> Hi all,

> After merging the integrity tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:

> security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> In file included from include/linux/kernel.h:14:0,
>                  from include/asm-generic/bug.h:18,
>                  from arch/powerpc/include/asm/bug.h:128,
>                  from include/linux/bug.h:5,
>                  from include/linux/seq_file.h:7,
>                  from security/integrity/ima/ima_kexec.c:13:
> include/linux/printk.h:288:0: note: this is the location of the previous definition
>  #define pr_fmt(fmt) fmt

> Introduced by commit

>   3dea0d93d257 ("ima: Unify logging")

thanks for reporting.
Reproduced, working on fix now.

Kind regards,
Petr
