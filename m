Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1474382-1528092925-2-16480043891169242660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528092924; b=kXH7NhAV0LaacFWkj7vlmisoC24mGeesob8J5yUUV9QfpDDNMN
    KQoWRA2WPayCWzmnqV4K0UJcIktFeGo3UBuB2dnHBHUlt6IOoHpvCjktRuPMJ3Py
    1zbAXZCKMIpbBWT2XXdvU1iu/fOCJOk4b+GL2wMDn8DTFzWaXL7X2P3CLG57jL2q
    jyBfefc9yfBy+mCjZMuw+mRQiAHa+ea6LxM1tETpTWXP7fmvrJmvHNmkXYeSm7OB
    20HrgJ2nCtr0SmStxV1KD3l7iDWuf5CS6A3hHKUY5PFJlxgOk6aN4xRe2CRVN1B2
    G81KLoP1FmV4hiqw63mmbmFVN3W/21RTtRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528092924;
    bh=bjvz8tHEkgfimNvwEaJQZRtIFV3pffcJ9+5hoFXHbLY=; b=A6gycAZwykat
    9ZrflHgCzY0bkbvEFlzLqJyBA0FQjTUUXM4dmbfQJU3HXGll6BtE/wibObFnSnS5
    cSR50UNsXKNSzkgn/h1p1w06iJ5u88brJzBvQiv4FwVICHOy6mK+4hncxeM3r+1/
    HYtpFEOPC9obPGsADbOfWoK2580eIk5mNLOKTE6QmPcvDn0Y/m6M4ULQ9b9XVsjW
    zK3umKf3euMnRODUc+9NCyFtYOFjOlLuctJImoH2W3+Itq6RLGp8wy5Y19oGsCci
    PKrkhsyGlILkaEJ24uk8fBF0hwcFx1UnmUimD0yOg8Oy2u/RjyXNJCiRAN0ZIj6P
    W3s8Frs+6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sypsDjDq
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sypsDjDq
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
X-CM-Envelope: MS4wfD92ZrzCUk2OzFoFi679MN/zPBP7Vmv5rMT6tO/ra9p/jqNX98/TVSImeaRvPsTc78O8yYt4mHV7btAP+ZxPg0Cj0srMNHL6SlW8CUzZXvME26CNaCgw
    HaLTZI0ROppayNOvrBscFTZXSDDRiO5MUWhPOXF3pSsuy6oj1t61/B2xkZrKNlJ34r4cWrG+Xkh6b2hSKGzUtO3uICUqLSlLo7yI1TSSOwU9MMIpfGhimroI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=vRxgAPkb0unqycyMlv8A:9
    a=CjuIK1q_8ugA:10 a=9fSWNKhx_P4zquqNq3MA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeFDGPW (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 02:15:22 -0400
Received: from ozlabs.org ([203.11.71.1]:43425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeFDGPV (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 02:15:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 16:15:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfio tree with Linus' tree
Message-ID: <20180604161518.4276f5f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nQEGdUeeD31cBy7J7b/EWDC"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/nQEGdUeeD31cBy7J7b/EWDC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Today's linux-next merge of the vfio tree got a conflict in:

  drivers/vfio/vfio_iommu_type1.c

between commit:

  89c29def6b01 ("Revert "vfio/type1: Improve memory pinning process for raw=
 PFN mapping"")

from Linus' tree and commit:

  7b578b0de3d3 ("vfio/type1: Fix task tracking for QEMU vCPU hotplug")

from the vfio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/vfio/vfio_iommu_type1.c
index 3c082451ab1a,2c71508abdd8..000000000000
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@@ -422,8 -434,8 +426,8 @@@ static long vfio_pin_pages_remote(struc
  	 * Reserved pages aren't counted against the user, externally pinned
  	 * pages are already counted against the user.
  	 */
 -	if (!vfio_find_vpfn(dma, iova)) {
 +	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
- 		if (!lock_cap && current->mm->locked_vm + 1 > limit) {
+ 		if (!dma->lock_cap && current->mm->locked_vm + 1 > limit) {
  			put_pfn(*pfn_base, dma->prot);
  			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
  					limit << PAGE_SHIFT);
@@@ -448,8 -459,8 +452,8 @@@
  			break;
  		}
 =20
 -		if (!vfio_find_vpfn(dma, iova)) {
 +		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
- 			if (!lock_cap &&
+ 			if (!dma->lock_cap &&
  			    current->mm->locked_vm + lock_acct + 1 > limit) {
  				put_pfn(pfn, dma->prot);
  				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",

--Sig_/nQEGdUeeD31cBy7J7b/EWDC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsU2PYACgkQAVBC80lX
0GyVTggAnSYrqGw3Tr6MVYuOuvYq9BIGsi+qaDpkvyHTT9IhGCczZwCo4f5sXzYy
e8iRdksAwi+wxTrmH9MCJL6DOtZQ9dMPkzP/sqfJ71fF1/MHVBccOUOryYoSBnXZ
PN52CYBg9yzKXhyb0N/QfMlxt0VWs+EiRH/VyUrdj40DYXQLFBRrsoHnG15UT4v4
XO4X2Ds9/JvIKIZzIUCzR6bo9pDjjxedz9QOT+bij1xF1ki5BoXpyWcGnjQH5UVG
kO3L8XDjcVyEQSYdb3+Pu8NDPKCNsHaYAVhywAj+hAAl8Wj7R5qfqkT7QTrPBR/R
cPId1la64TETMQVgqhDbFuBra4kkeA==
=F0Sa
-----END PGP SIGNATURE-----

--Sig_/nQEGdUeeD31cBy7J7b/EWDC--
