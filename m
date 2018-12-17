Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2CE206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbeLQTd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:33:57 -0500
Received: from namei.org ([65.99.196.166]:52214 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387846AbeLQTdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:33:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBHJXj01029677;
        Mon, 17 Dec 2018 19:33:45 GMT
Date:   Tue, 18 Dec 2018 06:33:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
cc:     linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: Remove references to module keyring
In-Reply-To: <20181213013909.25737-1-bauerman@linux.ibm.com>
Message-ID: <alpine.LRH.2.21.1812180633290.29218@namei.org>
References: <20181213013909.25737-1-bauerman@linux.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Thiago Jung Bauermann wrote:

> >From what I can tell, it has never been used.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Mimi, can I add your acked-by?


> ---
>  security/integrity/digsig.c    | 1 -
>  security/integrity/integrity.h | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index c5585e75d5d9..1ff8eab7bc8c 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -34,7 +34,6 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
>  	".evm",
>  	".ima",
>  #endif
> -	"_module",
>  	".platform",
>  };
>  
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index aafa1266e3d5..26c415c3f879 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -152,9 +152,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1
> -#define INTEGRITY_KEYRING_MODULE	2
> -#define INTEGRITY_KEYRING_PLATFORM	3
> -#define INTEGRITY_KEYRING_MAX		4
> +#define INTEGRITY_KEYRING_PLATFORM	2
> +#define INTEGRITY_KEYRING_MAX		3
>  
>  extern struct dentry *integrity_dir;
>  
> 

-- 
James Morris
<jmorris@namei.org>

