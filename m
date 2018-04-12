Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeDLWZB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:25:01 -0400
Received: from www.zeus03.de ([194.117.254.33]:40150 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbeDLWY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:24:59 -0400
X-UD-Smtp-Session: l3s3148p1@sPHBOa5pLOcgAwDPW8pXAAId4P/+oMhl
Date: Fri, 13 Apr 2018 00:24:57 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sam Hansen <hansens@google.com>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Documentation/i2c: sync docs with current state of
 i2c-tools.
Message-ID: <20180412222457.x4jdwt27ylgi74o3@katana>
References: <20180412213342.138010-1-hansens@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xyhj5lz7qyzg2fau"
Content-Disposition: inline
In-Reply-To: <20180412213342.138010-1-hansens@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xyhj5lz7qyzg2fau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 12, 2018 at 02:33:42PM -0700, Sam Hansen wrote:
> Currently, Documentation/i2c/dev-interface describes the use of i2c_smbus=
_*
> helper routines as static inlined functions provided by linux/i2c-dev.h. =
 Work
> has been done to refactor the linux/i2c-dev.h file in the i2c-tools proje=
ct
> out into its own library.  As a result, these docs have become stale.

Thanks for fixing this!

> This patch corrects the discrepancy and directs the reader to the i2c-too=
ls
> project for more information.  Additionally, some trailing-whitespace cle=
anups
> were made.

Minor nit: Having the whitespace changes in a seperate patch is a tad
easier to review.

> -  /* Using I2C Write, equivalent of=20
> +  /* Using I2C Write, equivalent of
>       i2c_smbus_write_word_data(file, reg, 0x6543) */

Maybe change to Kernel coding style comments while here?

> -  Not meant to be called  directly; instead, use the access functions
> -  below.
> +  If possible, use the provided i2c_smbus_* methods described below in f=
avor
> +  of issuing direct ioctls.

Why this change?

> -The above functions are all inline functions, that resolve to calls to
> -the i2c_smbus_access function, that on its turn calls a specific ioctl
> -with the data in a specific format. Read the source code if you
> -want to know what happens behind the screens.
> +The above functions are made available by linking against the libi2c lib=
rary,
> +which is provided by the i2c-tools project.  See:
> +https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.

This is fine with me. Maybe Jean has a comment on this?

Kind regards,

   Wolfram


--xyhj5lz7qyzg2fau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrP3LQACgkQFA3kzBSg
KbafSA//bfGWw4Tu3sUBmg3CjkvJpwQVshlWs8U79QwAhOndThWZjDLA0dnd21lS
dYOy3CSmpIjkG3c0UWAsrtMgljQ3AoAa69HVug1c579Y6bCEFiD03MxbJ5Vvg9jo
215joz1Srm6gDpHQ0gPZQLkDaYXJIjjG/BRxAqthK57MPDBwg0tRJWIHlrPgRcKg
uFIwXteMS+7XMzAfqDpU8D2Ul+5CyFU5eFEw3H+WPoUbNMTecxyJKBSLD/e/rDxJ
JbXGnH9KSSCyWY9MTMSJvc0Wa4dyb4Vjf5+a0WBynXV7h9vxD9xFbSJyxvmtH1Bx
Vv33YYkxl1P/hdRRY3d4Rsc/jqbWHF7IEQoecObA0eU+S92cfjxUe5mDw9mEmael
/jtoP5soSANy/Wd3sFqoo44t7OAk/1PKMNmNunnnQfjbvRbWU2FTIPCE4L5Nezf5
ODd7EgXsn7SO3NrLDo3m/cQHwgnAby0/6ST3c5ywyw5LmY1jH/ypY+lejIeCrU1p
PsoeIOlQD9dZpez7QmC5CV1fwqT9GKSA7dimSDRrd9Dati7E9u/EIDxHOEdeAUBy
jYe0i/1aL8CRrIMW4/7PhJ9cAYSa9d7BovOtqQ9qWEmlFE5a6oSiDzsjdUElr5p4
iRVzdJuQNW1wfND6HlhyjXtnT64D4LKq30JU0zy9Oi4iz5CgbUw=
=Rhxr
-----END PGP SIGNATURE-----

--xyhj5lz7qyzg2fau--
