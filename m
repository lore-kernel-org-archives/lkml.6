Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-2085551-1520914994-5-15765407159326785494
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
    t=1520914993; b=Kube/65SStHA8R9zfusmU5XDH7SxKCxpOyEioWxguE29eua
    M5Vc38v4Pkc1BTZFIjv75jFaCLYDvO6u8USPMNOrB6zWvhb3IiPn5/PmqMr961av
    PjKVKh5XbKssBgYz2uAQeUC2ZAloVDYoeOwShBnOKb90Up52WoCEP3csrR8sQntM
    4QV9x+VprCYok4U0PZGNT5IMSlFl0kEU+swgzowii/d6TNukf0nqSm5RNmgupwo4
    k/4dl2aLCWqkX9aZ8X66W/akDvHQG8sqIxdf2m8z1F6kt/p+cYaawcc6/CIG7JoL
    TZl8xJR0D/mq60rEnjZMEy7ZknFOvWb1y3xxwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1520914993; bh=uUGLBvsj
    H35fphPlxNpkfGehXUhhoeO9LWRAPbPrM+g=; b=q6Y36/Cf1a8McnK6HK//sfmF
    N0m3CoBI4pZk4Th/y10on0L+rMtmv/rNiiL4IjD15XEyTWQVOlM/UcOWnncKxeSp
    wk7tyNjElLjKullO/j/Yr8nL2St4bS8hlJPLQhDCmUyA+dL9hFsmjttP8NCGR7sC
    QpQK71PbJtW/NLbonKsNSqpjNvclVuA40xQhRhur3jnZgCQ+hbmEoZs3Ue0zQ0Ck
    MWn3FvKmvvg6X15xEV4KENUpf9+7fyePPLmFj2qv7osckr8OeiajkXv2lZQpZ0jc
    oMAMjPMvihtoOgcXF08HZm2kXibW/yoihrCK134gZx7lCRDTad+LTeBbhxtkNA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=opLh0RA1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=opLh0RA1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
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
Date: Tue, 13 Mar 2018 15:22:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>
Subject: linux-next: manual merge of the staging tree with the vfs tree
Message-ID: <20180313152240.3a64e0c9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KdvKorGuRcP1CaxidPbpYGc"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/KdvKorGuRcP1CaxidPbpYGc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c
  drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c

between commit:

  304ec482f562 ("get rid of pointless includes of fs_struct.h")

from the vfs tree and commits:

  37d3b407dc14 ("staging: lustre: remove linux-curproc.c")
  6b7936ceefa7 ("staging: lustre: make signal-blocking functions inline")

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

--Sig_/KdvKorGuRcP1CaxidPbpYGc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnUhEACgkQAVBC80lX
0Gx8Xwf+LX35efVZ2lyRoHIQJ50G6oQo64JOXhp44sFq3qYPxeZ66kO73KTB6pXG
PhP5bqsAjceuAwFYT09pPzB7Bbar02fIMXmJOZPIgrY2nPGp2Dg1ydlBwbUxIPAp
hCKpp+onwPVjcIv6C9K9+byQ4SYdFv+6GbJhg5an0IMeBlvI2qxPtQVQKxNYIT4C
Gekv43sM8tDzJ2sx3+h9ZsFC+nbwNIynU0PzwadlFMQHcVySE27LP7sL2BDIlfxC
M6005QBj487QseDI8Qvz8u7qiw9omKLfXcyNtTComi5OITBn01m6IH/jBCjp3xzb
3qII7H9SWjmbBZjMbgq6QdthX8elBQ==
=P9uI
-----END PGP SIGNATURE-----

--Sig_/KdvKorGuRcP1CaxidPbpYGc--
