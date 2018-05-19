Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1852109-1526758981-2-17516936893654037750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526758980; b=cXzRo3KOQbKD6Qr9U13FFAhfrx2LUpUP6zb1k+pWIcdTSnHABA
    AK1ICQsGJVKuhK+FlhlHblKCAvgxcvpXLunSfQUlD3k7vDu9Cdn8OSStpWhXpgSZ
    lF/rWNfW+4WfMzAc8TZ3AskMDQ1utCLLCD8WfcjL+rXhE74cdhM+qGNS9G96Hmv1
    a2Chzca9R2g8G0T6LSvFOK5k7B5Uvu9pnSznN6kwf+3xSoOtVGss89w1nYY4Yzkr
    Mr7ey6EfKJp5bkfFK5Mp1bHDK0V1rpvKEZCJ38frYiSlzo2o+hgtZfxhMnJiUkw5
    w3lYUBU3kfBor4fAQ3mKClkC4p6ljgK6jyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526758980; bh=frawXDJ8G/oIeUAAKghmGBfQv+qARZ
    wXaXYy+0boQPg=; b=Vni9uSBxTaj7nMXuEFa9hVQLYHZ62rUtmaVUyhVvPfQDlG
    RiahdpIoM6kAbmj4qCsGj7YZj68RFsUQ5aW6S4LbvmBklz3GO6mMg41PIEyudWPZ
    Jnfk2QE1RpAcgqavx7zXdByTUkSiNdzW8i/7gD1L+YM9fShx8B8YxO2AIP8H79cj
    yVxE9G2LXx+81sX7OyDEe0Yu28tlMasD9JZxNiOCGhaSr/RmNeXH1kiel0ixibG8
    os1XxMxdnfkoHygleRHYAw7mpBbGYXzZ/GtEg2z7hy5mkZVu/HJT8/iLZSpIMUDi
    D/tiv4ueu/morNvxUvySSNrbm+5xUdxovnE4yu1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB/it1G3RyHMtdiIQiUCUPRdfJ9lm65oM12GgtNwZetJKIq/b5d5m44raZJIma964qdFq7h8lIkCiG7F9Yj3T0eT2rOrNkYI06MwUQwF+dqvDQGObDLa
    50nggdDRkGRZT49tkO4tVr1xVwUWC6jSxIFrTCF0U8/eolDdYft9u5jJeB+tpmenhnaIQCADu5ea5a+6tCk/ukMk0qMkVataacB62Z6IMVFm38kICfYAE1I3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=p-nOP-kxAAAA:8
    a=QyXUC8HyAAAA:8 a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=fX9NJa7i2POBIqeuZDwA:9
    a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
    a=eJpRVcqsjGphjstwKMgA:9 a=ONNS8QRKHyMA:10 a=XN2wCei03jY4uMu7D0Wg:22
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeESTm5 (ORCPT <rfc822;linux@kroah.com>);
        Sat, 19 May 2018 15:42:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58096 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeESTmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2018 15:42:55 -0400
Date: Sat, 19 May 2018 21:42:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 03/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20180519194252.GB3058@amd>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20180518091721.7604-4-jslaby@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-05-18 11:16:56, Jiri Slaby wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsAfjwACgkQMOfwapXb+vIlcwCfYo968n8UL3BKY9XiJ9tEe76z
LmQAoJxc6Ygb55pjIpQ2Vi6xxx09Dgax
=FTtg
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
