Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D188ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1238620866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="hxo9kwdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1238620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJSJtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:49:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37412 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:49:38 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so2820244ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=p+ZSuBErdOwljmXJ7KnwQZ7bAUuiGC3aVZzNtFTAZaM=;
        b=hxo9kwdOExfLTqvfmKid1+to76eOUvx/LfgPcu4Frn1Wc/5Gy2B5XqQp+99FECxMWZ
         XIL2AsvzAwYtDS17Mj/zvAmIqQIm5llIGwcMLzh5oeKEGEeGmxcJuqmb4x9slkTr8abk
         wCtDkWvNxaTg4YKbZKsYq1HndSU//weOdWKa63KiIGcrsPNSIvUoP7yUUoiU5RY2HiWc
         DfKUY875N6WZqQTSX0ynOgzOXNDtrdeEcG80JG9nkgTEV5S5W1PRQLrwLUn2vvD0Hc0l
         5/rYQQ6SEk0WmU/r35oQccoDXxcutXgaKlZETJqrN1o1DZXn8ZU/b+eKW4dfvqXGB83d
         UywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=p+ZSuBErdOwljmXJ7KnwQZ7bAUuiGC3aVZzNtFTAZaM=;
        b=avl6YunrvNdFhelbThnEB2ifGuSeAQQ4oTspqg+nYvGuEYmRkQ/QWbdQlqKB2x67Oe
         RNglnmuLCF8p+eCqxA416/NSnzfvzXm3NL5nwONvCL20Q8VyvbZHBFmj7fSlO9gWl7t6
         aOTHzuQvaeD7ghSKBXQfWoG1ol6O4j+700UbTVl9DqrIjQBBjHdMnpn+l4NHTzVcHoLG
         JK69Iu6O+FK/R9nEAmzJy4uoPBZXb9LMLUXZKXt+2pLyEYsEOkrCwwT21LIlLoBcC98M
         PTAPbPcUQFxkWnECr9k1heTvrkiItiSFmPUO7nKezuXsDliWKDkenu29AVPRbM4OEN2V
         TGvw==
X-Gm-Message-State: ABuFfogwWFZ1ESztkb+mirmBP1ZIiQxM9+XTi07bjMdHpyWlOTwvdFdL
        hGecQAxPrxUGH+nl+eO2iElBDQ==
X-Google-Smtp-Source: ACcGV63cXZDUbOrRsYSWz9xGjbYp474IQwi9O6Qh61wEsXIwlhIK5G4N7uY8+XlqwFNbcvJS5dmmAQ==
X-Received: by 2002:a02:3d8e:: with SMTP id n136-v6mr24714244jan.87.1539913547513;
        Thu, 18 Oct 2018 18:45:47 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k5-v6sm783097ita.14.2018.10.18.18.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 18:45:46 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0D6DD0B3-038B-4B71-9170-9D0B4F3DF3FA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DD612644-90ED-48E1-A7B5-4B1E2963187D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
Date:   Thu, 18 Oct 2018 19:45:42 -0600
In-Reply-To: <875zxzxuo9.fsf@mid.deneb.enyo.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>
To:     Florian Weimer <fw@deneb.enyo.de>
References: <20181018131125.6303-1-mszeredi@redhat.com>
 <20181018131125.6303-2-mszeredi@redhat.com>
 <875zxzxuo9.fsf@mid.deneb.enyo.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_DD612644-90ED-48E1-A7B5-4B1E2963187D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 18, 2018, at 7:15 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
>=20
> * Miklos Szeredi:
>=20
>> #define STATX__RESERVED		0x80000000U	/* Reserved for =
future struct statx expansion */
>=20
> What about this?  Isn't it similar to STATX_ALL in the sense that we
> don't know yet what it will mean?

No, this means that this last bit will be used for increasing the size =
of the
stx_mask field at some point in the future.  IMHO, this is present as a =
reminder
to any developer who is adding fields in the future not to use the last =
flag.

Cheers, Andreas






--Apple-Mail=_DD612644-90ED-48E1-A7B5-4B1E2963187D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvJN0cACgkQcqXauRfM
H+Dw4A//SnFFHram0lK6mF0/fJJR8V/m3TMHlh04irQNChXF2k/K3Km17uIAiKdB
NYf9hl63pjNuUb96hKQwNVy+Q4mvh5hf1WbzRn6E+Sw1mjrjuwLc8L79xd/UoxSP
1tJcetX4SIAvzDFEE4LYaiOykM5FgaoFCalxM7i92bg6vU07QGcfUTYd+Nzc+c8h
GQLHmigmhfKdNaBte+8iQ29V7ZjKK31idulCRkPOXMzbrDINrgmarluiNQh9XSg2
/j/LfcWaaQlwVSWOT50yyK3m9y202RjCKISO7kN7/Nal44iMgAZm575iJmXOUCBg
Db7gLHh55ogjx4jpf0PByL4Iq+0nu+5lRjO2XhzfLQEKu4zoWhCUfelR/SWhbxSv
JqxR0eDPvQW0L34h/7HLH1jAQHnXCeANhjDOyc1ZxB3oSgg8pPNfUmvyTYJ3JF0N
Rhzi9teyZyEP0wM8VSjlsiNo/n2Xqkx2Nsgx18tHy7246PKJmOX867RoleK8YZB0
J3Ak5i6xh6wQpPpIFpZ5X8vdLKmtCM7svukw5jAtLJxPUG+dH4dVDzTpaqu8Ytv7
I9FmDlXciyYVKUiIRJKD3/ZAOW9k1YRTneqVox+ejo79kOmX0Riv+CQVVHnD02x/
jPdRs60BFlHeOKoEH2OFrJB5uSS0+tKA2jDuPf7mTStbgVYl1Kk=
=6UQp
-----END PGP SIGNATURE-----

--Apple-Mail=_DD612644-90ED-48E1-A7B5-4B1E2963187D--
