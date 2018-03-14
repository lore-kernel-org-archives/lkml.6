Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNMRI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbeCNMRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:17:07 -0400
Date: Wed, 14 Mar 2018 13:17:04 +0100
From: Michal Hocko <mhocko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, sfr@canb.auug.org.au
Subject: Re: + headers-untangle-kmemleakh-from-mmh-fix.patch added to -mm tree
Message-ID: <20180314121704.GA23036@dhcp22.suse.cz>
References: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-03-18 15:49:07, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: headers-untangle-kmemleakh-from-mmh-fix
> 
> security/keys/big_key.c needs vmalloc.h, per sfr
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  security/keys/big_key.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN security/keys/big_key.c~headers-untangle-kmemleakh-from-mmh-fix security/keys/big_key.c
> --- a/security/keys/big_key.c~headers-untangle-kmemleakh-from-mmh-fix
> +++ a/security/keys/big_key.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/scatterlist.h>
>  #include <linux/random.h>
> +#include <linux/vmalloc.h>
>  #include <keys/user-type.h>
>  #include <keys/big_key-type.h>
>  #include <crypto/aead.h>

My build test battery says we need also this one, m32r complains
otherwise for allmodconfig.

>From 5c3f7a041df707417532dd64b1d71fc29b24c0fe Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 14 Mar 2018 13:15:49 +0100
Subject: [PATCH] headers-untangle-kmemleakh-from-mmh-fix-fix

m32r allmodconfig complains with
security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
  vfree(data);
  ^
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 security/integrity/digsig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 6f9e4ce568cd..9bb0a7f2863e 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
+#include <linux/vmalloc.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 
-- 
2.16.1

-- 
Michal Hocko
SUSE Labs
