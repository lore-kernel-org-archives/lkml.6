Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 868FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9AD208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3PRtQvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9AD208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935967AbeFMVGU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935899AbeFMVGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:06:18 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A75208C4;
        Wed, 13 Jun 2018 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528923977;
        bh=Fh8lD1+cH6l73tS5bQbFh/xvuz+JZ7ouKETZ25IZEKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3PRtQvHyfOwh+4ezxKhdTviSf8bigs3+i7iUf7amq0mP6Wltl5e6HXvy2CwCFAUx
         DLpRgIndiddj8uKAq42H9O7JPAC74WuemQTQYXNsYWA3XNFWDhza5B74/ihMy/H5zf
         Juy09TAXtx4iwEAH5JqoosuFHa4vg00bO5FrzsTE=
Date:   Wed, 13 Jun 2018 22:06:13 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] nds32: Fix build error caused by incomplete
 configuration flag rename
Message-ID: <20180613210611.GA16086@jamesdev>
References: <1528919032-4874-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1528919032-4874-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Thanks Guenter,

On Wed, Jun 13, 2018 at 12:43:52PM -0700, Guenter Roeck wrote:
> GENERIC_ASHLDI3, GENERIC_ASHRDI3, and GENERIC_LSHRDI3 were renamed to
> GENERIC_LIB_ASHLDI3, GENERIC_LIB_ASHRDI3, and GENERIC_LIB_LSHRDI3
> without making the matching changes in arch/nds32.

Well, thats a little misleading. The commit in question was applied
based on 4.17-rc2 a month *before* commit aeaa7af744fa ("nds32: lib: To
use generic lib instead of libgcc to prevent the symbol undefined
issue.") raced and overtook it and was merged in time for final 4.17, so
technically it was only when the two recently came together in merge
commit 763f96944c95 ("Merge tag 'mips_4.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux") that it was a
problem.

Incidentally, is anybody building linux-next for nds32? (I could have
asked Linus to fix this up in the merge commit had I known).

> Fixes: e3d5980568f ("lib: Rename compiler intrinsic selects to GENERIC_LIB_*")

Perhaps this would be more accurate?:
Fixes: 763f96944c95 ("Merge tag 'mips_4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux")

> -	select GENERIC_ASHLDI3
> -	select GENERIC_ASHRDI3
> -	select GENERIC_LSHRDI3
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>  	select GENERIC_CMPDI2
>  	select GENERIC_MULDI3
>  	select GENERIC_UCMPDI2

These 3 were renamed also.

Cheers
James

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyGHQQAKCRA1zuSGKxAj
8vmKAPiOMlQvFT8ixEdDaGoMe/MOg+4c0W4jAFBKC/X+CxrPAQCZR1E7hXDToN2c
IwwHtlK/1kWhPmuft0NmAocEwdlXDQ==
=MWG8
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
