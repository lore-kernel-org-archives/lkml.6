Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B835DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71221206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DeJkwDbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfAHCjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:39:10 -0500
Received: from ozlabs.org ([203.11.71.1]:46603 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfAHCjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:39:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Yc082ZjJz9sD9;
        Tue,  8 Jan 2019 13:39:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546915147;
        bh=Iy+GW6lMSyQYMAIzYRM2zLRZnNI7DE8YoPLu3cXX1zQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DeJkwDbouZKtmROiZUstpuAvDM9XQm+JdiIoqgKa+qFYWF6fOBTKtAHThxpiPw2ry
         biXyKdbg08LzRsZJW63nIXy/Q1q5rcwQfrqks9vGcR37L0UFS9YKxeo1i/I0sZnofM
         +Uy9LAWE16CM+RHULcwr5zEpENch4ePj1ZwRjBDzBHZLrN0wS/luYIwF6plEZR8VpE
         0AaaLRALMmKVU99/OWHK93+TShdsFSip/CXnumxpA7fkcEGxRqVB+gGF7KmuNI6My4
         KiqgEoAEGwdhq33WMagCLMH1H66ZyoKhBtkpAV+bVfaGqie4+1/+vLPRsDxM4njKtv
         58sZkaqsoKMzg==
Date:   Tue, 8 Jan 2019 13:39:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: linux-next: manual merge of the ubifs tree with the fscrypt
 tree
Message-ID: <20190108133855.03ac5cce@canb.auug.org.au>
In-Reply-To: <20181211102425.7019f0a7@canb.auug.org.au>
References: <20181211102425.7019f0a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 11 Dec 2018 10:24:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the ubifs tree got a conflict in:
> 
>   fs/ubifs/Kconfig
> 
> between commit:
> 
>   6956097c429a ("fscrypt: remove filesystem specific build config option")
> 
> from the fscrypt tree and commit:
> 
>   1341551f1e2a ("ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on UBIFS_FS")
> 
> from the ubifs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/ubifs/Kconfig
> index ff7ea6f04555,bc1e082d921d..000000000000
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@@ -65,9 -60,20 +62,9 @@@ config UBIFS_FS_XATT
>   
>   	  If unsure, say Y.
>   
>  -config UBIFS_FS_ENCRYPTION
>  -	bool "UBIFS Encryption"
>  -	depends on UBIFS_FS_XATTR && BLOCK
>  -	select FS_ENCRYPTION
>  -	default n
>  -	help
>  -	  Enable encryption of UBIFS files and directories. This
>  -	  feature is similar to ecryptfs, but it is more memory
>  -	  efficient since it avoids caching the encrypted and
>  -	  decrypted pages in the page cache.
>  -
>   config UBIFS_FS_SECURITY
>   	bool "UBIFS Security Labels"
> - 	depends on UBIFS_FS && UBIFS_FS_XATTR
> + 	depends on UBIFS_FS_XATTR
>   	default y
>   	help
>   	  Security labels provide an access control facility to support Linux

This is now a conflict between Linus' tree and the fscrypt tree.

-- 
Cheers,
Stephen Rothwell
