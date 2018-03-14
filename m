Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCNOu6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:50:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeCNOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:50:57 -0400
Date: Wed, 14 Mar 2018 07:50:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au
Subject: Re: + headers-untangle-kmemleakh-from-mmh-fix.patch added to -mm
 tree
Message-Id: <20180314075055.353f2d975defb2af34f65d2b@linux-foundation.org>
In-Reply-To: <20180314121704.GA23036@dhcp22.suse.cz>
References: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
        <20180314121704.GA23036@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 13:17:04 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> > --- a/security/keys/big_key.c~headers-untangle-kmemleakh-from-mmh-fix
> > +++ a/security/keys/big_key.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/err.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/random.h>
> > +#include <linux/vmalloc.h>
> >  #include <keys/user-type.h>
> >  #include <keys/big_key-type.h>
> >  #include <crypto/aead.h>
> 
> My build test battery says we need also this one, m32r complains
> otherwise for allmodconfig.
> 
> >From 5c3f7a041df707417532dd64b1d71fc29b24c0fe Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 14 Mar 2018 13:15:49 +0100
> Subject: [PATCH] headers-untangle-kmemleakh-from-mmh-fix-fix
> 
> m32r allmodconfig complains with
> security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>   vfree(data);
>   ^
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  security/integrity/digsig.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 6f9e4ce568cd..9bb0a7f2863e 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -18,6 +18,7 @@
>  #include <linux/cred.h>
>  #include <linux/key-type.h>
>  #include <linux/digsig.h>
> +#include <linux/vmalloc.h>
>  #include <crypto/public_key.h>
>  #include <keys/system_keyring.h>

hm, current linux-next.patch already has this change.  What happened here?
