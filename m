Return-Path: <kernel-hardening-return-13074-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48fPOYoKmcaWoeWfJOjmnTvVF5nMgo63O8NOO3LDHg8Xuc40r3wcK6xkZHziz3GZA6misDX
ARC-Seal: i=1; a=rsa-sha256; t=1524384343; cv=none;
        d=google.com; s=arc-20160816;
        b=xpEuGeDP1lAR9OY9VbmOnVoSOevL45GefgNWLDS+XOXB9jDEUNMkibf6Bk03FmpIlj
         qjEo6FW2BJTluBchW7Aknfao+WfZsm8CCiYwGcfcef1NuTNBK1o/fBKv2mdFcr4vgXXh
         gzNges94/cnPJbk/pzVEi5YuGfoT3iL+kHCI47sYo8EiFkbNy0r0gqXg2kZ2AE0Ny5H4
         kCKzdlMTy0IqMLyiprxkTspQ+wvx0ne/zEQHrJg7pBK3UuBn/cf2Am6VP5SExaG79PJO
         Ee+rIrBnAkgO6/1AhVu/cHnOmNz1Sr9kwwJnk5B7wZSIcDp7vKlTPUAFPpMFZHv8o7WD
         dXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=rweEv+YlnyoBQxSoGC7+QSnS18h18Y54x/KaM+ZK12U=;
        b=W0BxNAirQSj2vKCMKAvN0TMngxDVcGp66gacyyFyZ29kDY6oaC5peTPFMSj8RD3iWD
         4OftSmeK9oghgJGLslnhNUWO7VwHcivlF96Tg1IA0Q4B91iXB0f/vNTozxtV2Jw52Hup
         bOfQYHr+LZ0lVMGptzIfG5UsJUHVrwm6H1gdz+S71lvmY193SnaOjWuYb2CjwITQIfIo
         /eVxIRna97sstpYaIoA4a2MXsuC/q1RCo4EUOk8rldhUNEY2nxjnlLIgsJHqNcsBq6ea
         6ML3HgxocnMcCZOINe7qjDl9wTvAaQVJzGWwEvs6E5NUeHrswKJlYSlE1r/zxQHnz6JV
         9I3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13074-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13074-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13074-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13074-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 22 Apr 2018 10:05:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	catalin.marinas@arm.com, cdall@kernel.org, drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
	marc.zyngier@arm.com, ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCHv3 11/11] arm64: docs: document pointer authentication
Message-ID: <20180422080520.GC17875@amd>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-12-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <20180417183735.56985-12-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019791270913018?=
X-GMAIL-MSGID: =?utf-8?q?1598432836939710312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -205,6 +205,14 @@ Before jumping into the kernel, the following condit=
ions must be met:
>      ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
>    - The DT or ACPI tables must describe a GICv2 interrupt controller.
> =20
> +  For CPUs with pointer authentication functionality:
> +  - If EL3 is present:
> +    SCR_EL3.APK (bit 16) must be initialised to 0b1
> +    SCR_EL3.API (bit 17) must be initialised to 0b1
> +  - If the kernel is entered at EL1:
> +    HCR_EL2.APK (bit 40) must be initialised to 0b1
> +    HCR_EL2.API (bit 41) must be initialised to 0b1
> +

0b1 is quite confusing way to write 1.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcQkAACgkQMOfwapXb+vKlSQCeNU0RERVJm4ZqVsCIP89svUq/
RK0AnR1nYiaJQ9ICHmunce6TL5rFZM0O
=7Aq9
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
