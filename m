Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AB8JxZpm1MPU7C9hZyAok9nYRwv8ID75pKzqq9/i7vWkZYiD1K12kaD9l7S8z50dNq4CyEyLeu+Q
ARC-Seal: i=1; a=rsa-sha256; t=1525819525; cv=none;
        d=google.com; s=arc-20160816;
        b=srCHKcf/TK/6dOfZM75wJZKoMmjNjokv5inrlzIXZ0NsMw3cQeXRPhMIEgLtXfwO4g
         hfXIh5oBH+n/jB1dfkD7jGxS7b+sWBrhZFwdV6J+cNXl4Xu9ynzu+sUfOIPNASKvMYq9
         J7NoyaQGO+IsRi90h7Wi1YU52tSGyFeBrMmBjHY34p6+N2EWY+2CTteB+gmXbDnXMVbr
         YaBE4l7HK/VARpF1krfZJmrvhTjLrvhJM/KAbiXRzwflhEnBMVDhL1sZGXQ0/3kkgWXv
         LDyJWAHAy9w2KBke7R6rvrHoAvBM1X8v8s6h6TyBXhuT3746XbD8bQiu7U++YCFYweYP
         OdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=bWzQB5Pav3J3AR4KDRiDYlErkM3fc1Ngu1YdgM2oPyI=;
        b=XmZy0aaYKIUNauO4GkFEaSZYoAmGl8Md9xklx0jrG3EIKYVwvh7tpn8wpscjvYSzE4
         S/jZlG/8XY7ycdxa3iVxVsAS4MWJsvwbgaeHu5w8gXg+9HbRoQfjNQOK7nK/ArvSRC0D
         sCTqIBw9XqEqnLDcWapP4lUaGe6EEP/sXlgtG3yMM6MQjGGhBWZUt8Xv8JcDD07r69bR
         E0uvDQ7tZkT1YCyHfl/nwGvWadDVI40ThUrRTPA/7Rx1bAQyVuldvCUv9gepesQcYtUJ
         ni7MWZ6GzMug4bR/X1MFGHLw+FgXZ0rK8/b260/HSy8cKWSBiZaqr+UVr/WxKSb/ZwyS
         k1rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vbqLFbBY;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vbqLFbBY;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 23:45:19 +0100
From: James Hogan <jhogan@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: macro@linux-mips.org, ralf@linux-mips.org, chenhc@lemote.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, pombredanne@nexb.com, arnd@arndb.de,
	broonie@kernel.org, paul.burton@mips.com, heiko@sntech.de,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] MIPS: Convert read_persistent_clock() to
 read_persistent_clock64()
Message-ID: <20180508224519.GB14903@jamesdev>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525682212.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797073537984267?=
X-GMAIL-MSGID: =?utf-8?q?1599937735045488334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 05:28:27PM +0800, Baolin Wang wrote:
> Since struct timespec is not y2038 safe on 32bit machines, this patch
> converts read_persistent_clock() to read_persistent_clock64() using
> struct timespec64, as well as converting mktime() to mktime64().
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks, both applied for 4.18

Cheers
James

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvIofgAKCRA1zuSGKxAj
8lCAAQD2Yqz1A+LNvd4Ccu6BSMvg/mBzTF06itJxvH2+d8GIlQD5AX+UDPiQGbvE
iLK9CKDHu1wilodh7gUJsbZfVfdF5wQ=
=O4XH
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
