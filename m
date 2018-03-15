Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-3865743-1521099365-2-5087457533208131063
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
    t=1521099364; b=sQpOFXL5dPo3WkOrezLiwMK/930CWnGJYXp3dY/7H8LKLE3
    1o3TaKRZ8v51ppc9oFiS0a2qzY6tivqsb8mM4ce9dmOmBq/JL3mQ4feNfr7u3aBt
    6rXrmV19AXHTz/kVG4nRe4sG6HAI84MSbayehkr8y5RPleXlIq4DswCMQlqeyOBp
    nhBDNjl0NwlIKS7FiWBuSqnjQYlQIrb1J2qvztj/+VoFs52kpaILbRls4MYV64+m
    g8dt4jPkj+d/dKlkUFEUlGD/jKPlqbInZ93lLhX4vchRQIlxVrmhBkQXOWeRKeUM
    sT9x5uRNu3Cej/g9q5Io2anLKO6/XhbGOrxmE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1521099364; bh=qxQIj0EG
    GmBkZ9q2gOfWKhJXs6uXu9OrRfGKOO9ieDs=; b=og5u3N9HWR6/HX3OD1mJAkdz
    pJIYGDE4www7GYs7MNZRy1tpvg/XInhHWZkz/VGoGrOOH2sVvTlVm5pEfh3LxtzJ
    rStIqDKuazUzCs5VcPROJevibTfcekmeSq6wmsqvRiYIvpGjpi/lgiaMyiDmxZLf
    p/WZ/GCNaEb4CpcdljvLH/mAboXbwq92zfxYaS9YIGpQvX85zrWNRfhkwZRMKK05
    nxVZ/TQkx9/uQuPkXFjKlQuIa5TrbZKW+gK9bmrtR5CENOuGbqle+PeNrbMBM5J4
    phumAsdTNWfzRHkDPFJ4H8gAnpM+ksSu4AuyTnqNZ1BeNeEuz7EAHBHp81q7WQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lheOTRJn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lheOTRJn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
Date: Thu, 15 Mar 2018 18:35:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>, Networking
 <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Denys Vlasenko
 <dvlasenk@redhat.com>
Subject: linux-next: manual merge of the staging tree with the net-next tree
Message-ID: <20180315183531.0e987f82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DH7i9N3rfEpuhujVBpBjLDd"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/DH7i9N3rfEpuhujVBpBjLDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/irda/net/af_irda.c

between commit:

  9b2c45d479d0 ("net: make getname() functions return length rather than us=
e int* parameter")

from the net-next tree and commit:

  d64c2a76123f ("staging: irda: remove the irda network stack and drivers")

from the staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/DH7i9N3rfEpuhujVBpBjLDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqIkMACgkQAVBC80lX
0Gx97wf+My6j91q7HyvMD6sBNz7Tml29Q8ibMCk/b5NcXZVWB99HeVPR/yuOEkGl
F6OYC+n5DDYNLStrOQnqnm1m8pWpsSTmly6xdX1DV+vfKMC1Po9adc2UWftdfKXM
dBfAaLwXOwHyZ69YKlJ7JXmZCVS97FCVPpef3OAS83tzV5GzyLgE2lKL2xMCQAdV
Er5hxuUnPuLxv9Bfgulg9V9VK01vTP5RO2wJqh5bJCQ08Ox01CIfFlClqY2yNSN8
4BLleYzaTxxoOQERRTFl/CAfBZ6Njay1xTtYmE7QhO6jv+7oye7WEdiluDEQ23lQ
yjSzeNj/ToRN7RITIuP8W9PrKTI23Q==
=5jAI
-----END PGP SIGNATURE-----

--Sig_/DH7i9N3rfEpuhujVBpBjLDd--
