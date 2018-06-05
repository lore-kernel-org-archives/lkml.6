Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2079613-1528157885-2-3572360270616278806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528157885; b=AaXwU6KS1Alolbd6G8efUVzlAYw3e3hPTUhSa60IxaLBzTSUec
    8OuDbpLFSlOL+kbcOPPTToCM2z0BkNVFeGKLG07l30dTeXaSu9DbCB32KeWCeEjc
    YWqjKIABq4aK5kz/IVxr6hlQCf8oQwoV/tv9pvRIEVN7klqNU49S5pDpI1M4pgPa
    Y0oruo5co1xqfRgPFCx9bRWbGsZX7yt3SSVpFL9E0A0AOj/tyw6EOWZ4L/K9puEY
    4WvpjF8DMVsAtuFaVGCjjaybT+ZFkmaZrpmljsU/rx6kqPaiFMfb/3JQ65yzEQsZ
    k9GM7o9/oQ57I0gbP3VDxS9fbQl9xuNmfdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528157885;
    bh=waw47zheNwkoS7dx/sKJzu9W50MtR00lPfTV5BUnrk4=; b=cdq3A74molN+
    Ea8AEifYFsT+C8DKUmZaQuv4iD0LnWYyVcabxofpnDhMSiDXVsMnkOH2ErHu3LcK
    zXOvA8/LAHxB016NaSstNTv4YUf5zdqcDAkI0687o+9DYFnzBWCi9fkznUK0rQxs
    i5azytpGY5tRiVawNLyX+KF18K7sUTDGz0RaSaE7Snb+pmQRAEivsPPbvl7C3SD4
    sV6tHoQkK0544tOJ1qgBQ4EVSkioAICw/3Z6a0nViYLMrCrgMPB3iJwopdMyt6lq
    O6SROXlsvD7utBDGVwNTRdNTGHLiPYL43MDlGRN9Tdvhe9sFaDqy2azhN5BcHGYr
    EAdCpv2Whg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NFMGUCIv
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NFMGUCIv
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
X-CM-Envelope: MS4wfMSZC43rCrQb4RufWVRZ+SoJAm+bsjBPc68zJRCL2YH666w8S0gdKc1TQL8P+jDyM1gkck2933jo+VmFI56AdLT/7yJoY4AW0Wf4PWgohlGS3fAl9Kmv
    5mE7Bym7KFrlAm/GUi5fM9dX5+Bhx/MOxE4bc8hwBpB5Wt9ZOOg1CAf5JJoklxMduSEnlwu3gZgZOnAllwBy8s/uzzWEs7C3Nlu4dofa9YGviyYb/y0fPXjS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=ZfKkRxCrd0Kd0y71gVoA:9
    a=CjuIK1q_8ugA:10 a=AyGQUss9LGL0DZyyh3YA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFEASB (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 20:18:01 -0400
Received: from ozlabs.org ([203.11.71.1]:39467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeFEASA (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 20:18:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 10:17:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Isaman <fred.isaman@gmail.com>
Subject: linux-next: build warning after merge of the nfs tree
Message-ID: <20180605101741.658efe5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dRvnpcJT_E3eB/vTtZiW6ih"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/dRvnpcJT_E3eB/vTtZiW6ih
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Trond,

After merging the nfs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/nfs/nfs4proc.c:910:13: warning: 'nfs4_layoutget_release' defined but not=
 used [-Wunused-function]
 static void nfs4_layoutget_release(void *calldata)
             ^~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  30ae2412e90f ("pnfs: Fix manipulation of NFS_LAYOUT_FIRST_LAYOUTGET")

in combination with

  2409a976a299 ("pnfs: Add LAYOUTGET to OPEN of a new file")

# CONFIG_NFS_V4_1 is not set

--=20
Cheers,
Stephen Rothwell

--Sig_/dRvnpcJT_E3eB/vTtZiW6ih
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsV1qUACgkQAVBC80lX
0Gym6wf/VCrXzrjESxb5fUTzfcbVAb/hFYug9kVBdzMhl2024Hl9DNemMDzkK/QD
Fj/MvPzsU8+fHF66XpTSLfgL9ElT81q9mm2pbcQqnSJHoyVzO+yWfzJwTpCxCpog
iNvinm+giTsdDkgoWA/pxR62HTF1nrz5QGtiKk9QFn2KOChAYFk7ke6gnOu5xL3i
4w37NcIJveBMohoYedtlPL/ypVjDINWuOqyIDE1MrCnpOXqWpBy6crQP37gsh2LF
rcMXMkBHWjHfieSPkkbH31UQnkwP94K1W1CkPoNMKNkTEEJVwnG1w4257C016sWE
VQVs2+7MKGNG0B9nU5Mcf3QpSDI09g==
=/wG2
-----END PGP SIGNATURE-----

--Sig_/dRvnpcJT_E3eB/vTtZiW6ih--
