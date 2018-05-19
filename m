Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1852109-1526758965-2-10809828528283507208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526758965; b=dwhJwDgyuhINY0IsUmDtMWrZzQUWpxAjzGCmkzPTBjVI5bd0fd
    Dk2HuAbQwVYwxi8XI/K6wQY8M46Cdf2q5JE49I0zzjwGdBZ2juIBT5jPgiI08bx7
    kFjrThvV/zcWdHl24eWosHeSGHhsNw/0R9Wj7HJXUhKDgCiUm95L4j71BhYMHmbo
    OiGtloO3KMK88F0j8T4D/qynB1FF3axgr7G7ksiBRLB/InJUm0N+Ua9VOxXfLRJm
    18KfrnNLkhHwmV5S+VpqtkGMJ871j7S0VK/49VZfdLG8nTq/8jB0B6bI5UUm33v0
    g1n7fJ7VP/CscCeRdnuAzAlTCMQn2osG/mNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526758965; bh=sKh+6j20ehXFRKQBLuLK6Xm53iQR+R
    /ta57djx52NNc=; b=OGm6fPdYi9yft5t7WAzXCs4DDRvOrl36LDdcbYtobs7KoB
    F3RHpA7u5xklX5jkbZ4jj98OFoEBSbkZlNnkHVncoLklgQZgM8Ib8VkfgXE5YGpX
    3BuzTBSgqZUL4f/H46vpjeQI8iLZgy33szcvWHBR5B6RzaG7cclGp40xlWTJXSYm
    kWmdThkkEUGDpD7rRfpwx7fzriP8IdqdahKd6ycWbzlh7EFfEo6NEmrRqjW40wPt
    P0FSIdv3Qs+cZ8uR+WhOUnZccdM7xomBH00WL8S1aCRTs5+zjNcgJ8KyY0hxdgJo
    tBJ1PC1u9D1C5UcSs1w/B4Xy+EqBHESFxe6v2yGA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfA7PhitVlPdEnSHoOxw+HbiS2LQ7bk9VzUaFeoRAnnyL93aOugHQ7mmnudIXkTZZMMaFCxIF6r+gCfSuhvwpSeRO77bH9omvsvi6A6q2Dv35fHJ/lCFl
    hSNTO/U5CGySRxcpKMsGPhBT0MRbr9rdN++245lfjQkBCgaNbcfFvAYopnbiESrtj9fxEKBIBcW9hno1g4XCMchn5OvpSoCuIxoVwG4ixIIVBHCpUpNqURsu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8
    a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8
    a=de9RDGvtYYbL8uG3PuQA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=3aiDBLmjz74z7XeKxJ4A:9 a=ONNS8QRKHyMA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=XN2wCei03jY4uMu7D0Wg:22 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeESTmk (ORCPT <rfc822;linux@kroah.com>);
        Sat, 19 May 2018 15:42:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58086 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeESTmk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 May 2018 15:42:40 -0400
Date: Sat, 19 May 2018 21:42:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 02/28] x86/asm/suspend: drop ENTRY from local data
Message-ID: <20180519194235.GA3058@amd>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180518091721.7604-3-jslaby@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-05-18 11:16:55, Jiri Slaby wrote:
> ENTRY was intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
>=20
> So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
> as these symbols are local only.
>=20
> We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
> earlier [1].
>=20
> [1] https://lkml.org/lkml/2017/4/27/244
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsAfisACgkQMOfwapXb+vJN+gCgi6w02foFsu6Vm9cdugbPgdVl
5fUAnijCvo6E28F8/GTFkRTmPKy031TJ
=AUDI
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
