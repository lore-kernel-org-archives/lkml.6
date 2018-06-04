Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1599531-1528107926-2-8956314758735177699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528107925; b=AbpnAWMNoP1+RzqbMDZhbKIULUVbGsFn4pF7Qxe5UIU6+u2QQt
    taJTo0G8a+pgFwgWMUL2ZDOhauPe6h1TU3s8163Hzt37vawlxAe2uo3uj6+lwXLh
    zHObOk8e4EbAq8UZTn23UMdKWCat1eGL8Z2SVpTFreVW9hPUg4FemMgi2fLEtDwz
    ESZ8lmtnWUZrGZvMzkZCaySGKeFqwhicl1VBMxMLGnuHGDHfnlqNP+ZIS9P4rGrB
    qIp4PqC2cmPgW4N6ZeCXamTZN6wFWq8jn3obwUbw5+tbT/SpehnT1/o+mZGJgUMc
    yTHbuR1JlQgULdRzLtZUTll7ThItyyst3Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528107925;
    bh=oiURD17cUCQXPalfFMLBrp8y4VKbSluoquRSiJ0f5Vw=; b=SwEctI4wvE6z
    Rpvdl6DLiKXAyO4fB5U4tNR7qp+zhoMTZ8d4amkaHEoySv8bo0ryASCFa1d2Ym5i
    FDzjYp/kc3mfoFMXIuGVj+wtgFUN56SkYDV+DZpExgRGrr5OQsqb6hXtA5q3gfAO
    Z2nqg3jQs2wSY/BxihhIJWkOkEG2QQoxaHxncKDFx2wpPfOygkMwsBqW5ELIHT1w
    VYn0Z6qZBTcczfx9IZVguSzbrpOlZYZSpUBsf5viXStaA4SfdytCUGyWmDuZrbXZ
    SRWg9ldUhhFu1aeTokcmYLMpz5+9xe0UAcQ9o09vuBTGf2CbepiheXn0+ovBu6W6
    vbqMVh9p1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dVSENY9k
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dVSENY9k
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBbZ7aZkLqmZmIbCLSGKJGF06K1df5yZyxcFjFEKI8X9D4VUcNY22iS/gkzNH1yj60XXtEYbW4x3vlBuO6ESwL7WnfXhMAhtfFTn4e9f0t9gnEdRtMBu
    IoKCIjurd+nV21Gdh2jBR7SlsBRi/sZZmrKnzXLBQGgWZpX+hrmBjI5Ak4XYmImVbpvjW6attKLupJzddMT4Sve383onDJemaZRpzuJMide2AWLq1dgFSauF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=s1KdiLZHpe0tL8jrSE4A:9
    a=CjuIK1q_8ugA:10 a=85-6iHOC23GYr-7KuP4A:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeFDKZW (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 06:25:22 -0400
Received: from ozlabs.org ([203.11.71.1]:32979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeFDKZV (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 06:25:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 20:24:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: linux-next: manual merge of the akpm-current tree with the nvdimm
 tree
Message-ID: <20180604202453.77342f89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TZk9mjDh4uUYDCplwBFdHU_"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/TZk9mjDh4uUYDCplwBFdHU_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/dax.c

between commit:

  cc4a90ac816e ("dax: dax_insert_mapping_entry always succeeds")

from the nvdimm tree and commit:

  aa726309bde7 ("fs/dax.c: add new return type vm_fault_t")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/dax.c
index d6b01de7f881,821986c61f7e..000000000000
--- a/fs/dax.c
+++ b/fs/dax.c
@@@ -1017,8 -910,9 +1017,8 @@@ static vm_fault_t dax_load_hole(struct=20
  {
  	struct inode *inode =3D mapping->host;
  	unsigned long vaddr =3D vmf->address;
- 	int ret =3D VM_FAULT_NOPAGE;
+ 	vm_fault_t ret =3D VM_FAULT_NOPAGE;
  	struct page *zero_page;
 -	void *entry2;
  	pfn_t pfn;
 =20
  	zero_page =3D ZERO_PAGE(0);
@@@ -1028,9 -922,14 +1028,9 @@@
  	}
 =20
  	pfn =3D page_to_pfn_t(zero_page);
 -	entry2 =3D dax_insert_mapping_entry(mapping, vmf, entry, pfn,
 -			RADIX_DAX_ZERO_PAGE, false);
 -	if (IS_ERR(entry2)) {
 -		ret =3D VM_FAULT_SIGBUS;
 -		goto out;
 -	}
 -
 +	dax_insert_mapping_entry(mapping, vmf, entry, pfn, RADIX_DAX_ZERO_PAGE,
 +			false);
- 	vm_insert_mixed(vmf->vma, vaddr, pfn);
+ 	ret =3D vmf_insert_mixed(vmf->vma, vaddr, pfn);
  out:
  	trace_dax_load_hole(inode, vmf, ret);
  	return ret;

--Sig_/TZk9mjDh4uUYDCplwBFdHU_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsVE3UACgkQAVBC80lX
0Gyafgf8CcqimsaErJyvfatf91bE+Nzma8jdtaTr6F3tghRyL5hnCr7i3tGJXrX4
1P2tAVgehWg5txNVsfYjggfXexnfemZnWk3lYawCiC7DQVKfC7+Y5Xh/sUA4LGeZ
QsydgOLJF8Vu726XC6+3qkO3baMllNI798x5+p2Em+nu4daQEuVbLFe53wWOEJGA
H/qcPgq+jxvespKLtG732/1jw6Pn3oRQg3Kf49jFq6eKVOLO93LUQFPGq8BmY/Ds
Mby1WH3PBQ672GGGbjUhQEBUvs+DCB4pp+sdFJFcXnVYZ73BuRqZRpGJOmFCo6Ld
K/zTV3QGnt+AIOmX9sntQ527ctRZew==
=YFF2
-----END PGP SIGNATURE-----

--Sig_/TZk9mjDh4uUYDCplwBFdHU_--
