Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999B52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeKBQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:59:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55291 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKBQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:59:06 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B246B60002;
        Fri,  2 Nov 2018 07:52:46 +0000 (UTC)
Date:   Fri, 2 Nov 2018 08:52:45 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH resend] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops
 build warning
Message-ID: <20181102075245.GR15991@w540>
References: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rzwkXnKuCXxoL5m"
Content-Disposition: inline
In-Reply-To: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Randy,
   thanks for the patch.

On Thu, Nov 01, 2018 at 04:38:30PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
> <mtd/onenand.h>, and doing so causes a build warning, so drop
> that header file.
>
> In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
> ../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
>      struct mtd_oob_ops *ops);
>
> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")

Not sure if this is worth pointing out, but this commit only resorts
headers. The one introducing the warning is actually 33893d7aa.

I felt like reporting this, as introducing a "Fixes" line for that
commit too would help backporting maybe?

In any case:
Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/boards/mach-kfr2r09/setup.c |    1 -
>  1 file changed, 1 deletion(-)
>
> --- linux-next-20181101.orig/arch/sh/boards/mach-kfr2r09/setup.c
> +++ linux-next-20181101/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -25,7 +25,6 @@
>  #include <linux/memblock.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
> -#include <linux/mtd/onenand.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/platform_data/lv5207lp.h>
>  #include <linux/platform_device.h>
>
>

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb3AJNAAoJEHI0Bo8WoVY8AsIQAJETDari2XU4nzfJKl9tbQxZ
KdRZxRp4fzLI5VfzlJWOjY2IK7VtSf2mJ3yd9lXcXAT8OmbuoXXaomtYBxKhlmKP
mMxNzOfhl7zn+UUOpN70XIaVtb791OA3TEB1Ohx15gUQj9wd7kB6g5V/coXgzdpP
e2lkpZ1x5yWdye3eJto0D7HBi2fXFj+zaElNhpg2l+CyfkuovspJUjeZ9bfRVisf
O+BwoeNNpP++U1KnS29YvonIU2b/dQfCl9sep3/kKF72IX8eQKWMR9fej4FXpEh4
0c8HLrfalc2dKJwQYlLeuCpSzMC0MDVviISKvsF/+OtMJsg3kCFx4oCyg1ZTTdT/
yMTDS2PjHa6OvBPnnDyel+qQSnPU8UkIfHCfyRxyZ55Nj/11cz2NKfgbliNeVbdb
bqxJFsnPeFDvhhbIjvX+ri6wUamcKD6jP1Fs8GRXrZYeAbbyKKAFs1ypZQKNuICh
YhWDvITQcQPoVdJcMY4E331lmI/4sQDku96oW9wDykw9gwVYI+NlbQsnLbuaY092
pkCENu6UO+az/uOzgx2ZZzTN80CaWXJrQOJ3UL00RDEEZzreAypLzws1s4AB0uPk
As+ozwwmlBJjuf4fFn2liyapFQgwBbe2EfQRSXF6dnassMghFhQc6vyHK0HOGm7Y
Y6ejWsgxCgB9fiW+AmqQ
=O2GC
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--
