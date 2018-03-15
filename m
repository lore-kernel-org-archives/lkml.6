Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-3833266-1521097155-2-18038426891898226466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='103.22.144.67', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521097155; b=Djbcj3bvdA+7UhnRGmh68qp7uVMBPoS4hkmjbVLBlYbX573
    rs04mWOoBLG230plPtEtsT0FUIS2AK3ooCYB2OyL86irEkMXjHBhS+OceRxKorj1
    uZOMc1RCDU4FPFVtz2TDlz0sew/1AeMk5Ra1f9FbOK63YmCLuxBKWzxzJKgsu44a
    FLNMSOyx1/r+5tIUOEw7i0LfrkUmZdz3U9pl0mzg7Tnq5/kRynw5NJpAmAYFcDkr
    x1iLjqY+FTMLduRvpHqbJrXfRziS39NEtDCJGZx01p7CBf487ChKe2bc0yTtpaXn
    6PLxfOgUjzPMssTkDJ0GV+Dwb5RwSc0/4+yd+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1521097155; bh=Wb/kjgXn
    y6w3GIDAQDQlZsuNfbaS4VA4wKPxNPl5Cdc=; b=FE3kRevVIf8TN33oj4y3s/7l
    JAht29Of+hV16stHp6SN5YudJVoqZllnpu60q7WdPhs2sCmTtB01FJcnsQ6pvX8L
    sBDKovOC6Phzk2fA33fD8nkiuwKc94kcvfPdWqcpX66CTCkcInBM9WxfCkugwNxq
    WdEazVjW6dapjoQf7++VmEXHJK5yRn3Cyd98pQ46I2ss+Ob/OUSTMEeHlBt8YWHD
    HvcBpp4h0cJd+iItq0oKNV2CsTpzE8QEpYymsd94jTTmrnOBi/DQupCw8xugy6iR
    V/glBEdwrp3dpB88KS71Gi1UWH6uGgr5VHCsWNICWIkMSf4FC4IrJtDlit71hw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KIuOxYhX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KIuOxYhX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 17:58:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Gilad Ben-Yossef
 <gilad@benyossef.com>
Subject: linux-next: manual merge of the staging tree with the crypto tree
Message-ID: <20180315175841.5c3de18d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K52V4NaoQ0ltlVX35WfriE3"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/K52V4NaoQ0ltlVX35WfriE3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/ccree/Kconfig
  drivers/staging/ccree/Makefile

between commit:

  e294ca1cca3a ("staging: ccree: rename staging ver and mark as broken")

from the crypto tree and commit:

  8b0217965418 ("staging: ccree: remove ccree staging driver copy")

from the staging tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/K52V4NaoQ0ltlVX35WfriE3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqGaEACgkQAVBC80lX
0GyX0wf/YOb5rCX8ND3YA+qaCuEpZ8bdjwBni/eYAeCv3v5CVjbmxTBnrETZALRh
2jgadtl2p6VcWZWchHRaiQXeu30+t4GO1GhKkS6hDPtEHaudP0ucS2jnzp38xZhe
JCx5P6YYcS6kFqUcISIxA6Rd+ab+s19uLAx/Ft9p/OMxdkZkTeUlGzeNSgzJR6eI
3u7E8/MmHRruyxbmzWTu+J55toJAFm9DwNcA6LmBLeSoIYFZ4V+GKJQz/tl5i1og
evdy8wRf1Jg6OJteiYyCFC1vG7tkwqxPhlsCtGwRuJmP35aGNpdAM2QXZRYLpo89
AMO7nowe7gx+PjgXzRIZrPIZPEe+Qw==
=6k7/
-----END PGP SIGNATURE-----

--Sig_/K52V4NaoQ0ltlVX35WfriE3--
