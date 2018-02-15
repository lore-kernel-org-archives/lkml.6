Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AH8x226s/eaAIpcivzeTDJL1sZ2z4IgdolCjnGLYMS2PkqTvzlGRgxcFGhpzDcxt32BIN5ejwxeQ
ARC-Seal: i=1; a=rsa-sha256; t=1518700803; cv=none;
        d=google.com; s=arc-20160816;
        b=HX7VAi1dwwSF+Alm6ShjvHDUyg0foAZwvQWC+WdaQxFBnB9BlTMJGI70Eg6y1LBUMb
         HmPC8pHdXrfPCHMwSvP0SJJf9yYDMget09SHMKRulwRuSvWhYOPNtjafbEIqQXWhp4t6
         XYMFucQKZGJaLLGWaEmxgN7skuEgmjzFAfemsAYSONyul2u7YnMsMhOVXCtS0yr/3b0z
         J6GqE5+Lw+XDqq6GakqzAJTlfNSaOvA+eERy2VCTilgpdg5vwLEkt7O3vVgkFg9+712A
         0uRG0cRhplL66Cyo+K66XgW+inCI4wqdj3zWMfyMJaIZ/FLSmcnRrpY+y2ho5UvfRp0M
         8RPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=M8LbuuuwqrELAvATq/xMS7rDoU4qXg6W8my5rdDOeAY=;
        b=KOiB9K5w1OfUrVgwLNtlaU2+unNxOSMgp8LKT4AgD023OZ9G/YQzSIGTLv3Y/l5ISf
         CPqmNLPPXr42GaSoR/W/k4bUnsIzjA56wbVb5I/GNrRJrbZjFxobYRco+yiGffh842oV
         f4/EDgRBkWHQiWljGRXr9aMaqeuzH9ldTpJ2PdWQx2Fpv1YUe/Ui71NVCKJNNY30Tu2I
         XIaJUwBubt29K/vqS53TQIZ/QYjQXbbD75fXp3sbVlO8ZYEPsNtdN29zkVniPnKz3O3j
         i6wcrwzZGapwQ4BJTZ3GSfutDTNmG0d25sF69fKucdb1TLvQzGXaFnaCqfnDddfFa+Xj
         u/yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="asc'?scan'208";a="201364583"
From: Felipe Balbi <balbi@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 6/6] Treewide: Remove depends on HAS_DMA in case of platform dependency
In-Reply-To: <1517912092-15470-7-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org> <1517912092-15470-7-git-send-email-geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 15:19:28 +0200
Message-ID: <87inay8k67.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591646200462529986?=
X-GMAIL-MSGID: =?utf-8?q?1592473213495008475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>
> This simplifies the dependencies, and allows to improve compile-testing.
>
> Notes:
>   - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>     which does not exist if HAS_DMA=3Dn (Do we need a dummy? The use of
>     set_dma_ops() in this driver is questionable),
>   - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>     dependency on HAS_DMA, as they are selected from
>     SND_SOC_APQ8016_SBC.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

for drivers/usb/gadget/:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqFiOAACgkQzL64meEa
mQa2SxAAlW7lfUK0u4wYfEIEW/sDVDlt29tyJK/30ID1+B19bg9EdnpVFrWhOHj4
VdVg82aK/45YbuAxQKzlZIZcoR0eURUQRJqxFoBNkodNjwY8R90bhrFW4SaQc0zA
kjYCQAvRdA7qSEQay5sztWYaS+0GGotISvA33R0vvZVi8V+r6oOkLVPLH5B6UVPe
AR4pB3o+Fwis8tPxeRF6+nSFhoVCVPjSmGPiXDjm8MWdPs0gbzkfkANvIgt3G+Sd
lzCyf2wgnoKC1rOG7UuYH2179+7RlhezvXhcu4NCpm2wuq1CsU5mIR5CjyyuY6m3
M9q1/AS6+5e/GatadYanyCCy070sqls81cx66UEROgsMTXVw8wal/O39rjHp2+8L
rbAGQ7KmcxfSFi+Kk8+6G0eOrgWr7Q1ykego9Hd2PPIG0jD/Z/g2n97yTlUydCUo
0WR9PQO+QqjGJ1wku66da03oD7VuvZoDAKJeuriJo1Ipm9tiJVfsW6hAvfWzf5Md
SvX/jwxzMk6/ackrcvf9lSjNh50794AUurx3Rpz6QzJaaheXCfAhzGyaykQZuwSj
+wY0omxCN/ywb70XUPZNHhhCfoa7Fnq9EqlbW2HU1jodS7I0Tu2Lr69ZKN7vMlcN
0qCcIKPDR/xug7mpYXISyToppKjn+uCb8EUkSTb/IUVBER9h4ww=
=988a
-----END PGP SIGNATURE-----
--=-=-=--
