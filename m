Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE71A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aQjAoeZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE71A208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbeGQG7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:59:46 -0400
Received: from ozlabs.org ([203.11.71.1]:55565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbeGQG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:59:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41V9Mw1yLKz9rxs;
        Tue, 17 Jul 2018 16:28:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531808924;
        bh=XvoWbTnDo1qYvfQXwF1NyX8NUJY1+go58lOxZrciYe8=;
        h=Date:From:To:Cc:Subject:From;
        b=aQjAoeZPK7s7wf0ylTbJ1GCaQ3bo+m089kOQSV0zRrd8BeMESlmN5c6PFw79dJMY2
         CqnzWr0PlV/+i+XDfYgFeFr5/F5U1Af5io3v3ZH7qINBHUi3+syeAL/ahnDTfV2g9x
         OQEZqhCVgYQPvDRLdd4amSY9jhePpUYydosdWYCtRYd+3UIBpxT0DtF7lIoKIq4hAa
         zLFYe6iaVd8XCnakblJ8lXo2c1F6Fie+J0M6gyn+UFn2AVAcQvi+grc0iGZ86T2fBr
         e0+g0pGP/uzNHp6jjCvAfgahjLm794EwsEBruYCFvshTHZDGl3KVo+y7ZXFgbnFDmX
         +GktkU+qBuHig==
Date:   Tue, 17 Jul 2018 16:28:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Safonov <insafonov@gmail.com>
Subject: linux-next: build failure after merge of the staging tree
Message-ID: <20180717162839.2f5e7053@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G4=UAVGCdduh6QkxzOe22w3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G4=UAVGCdduh6QkxzOe22w3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/rtl8188eu/core/rtw_security.c: In function 'rtw_tkip_decryp=
t':
drivers/staging/rtl8188eu/core/rtw_security.c:399:21: error: storage size o=
f 'mycontext' isn't known
  struct arc4context mycontext;
                     ^~~~~~~~~
drivers/staging/rtl8188eu/core/rtw_security.c:437:4: error: implicit declar=
ation of function 'phase1' [-Werror=3Dimplicit-function-declaration]
    phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0], pnh);
    ^~~~~~
drivers/staging/rtl8188eu/core/rtw_security.c:438:4: error: implicit declar=
ation of function 'phase2' [-Werror=3Dimplicit-function-declaration]
    phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0], pnl);
    ^~~~~~
drivers/staging/rtl8188eu/core/rtw_security.c:442:4: error: implicit declar=
ation of function 'arcfour_init'; did you mean 'rcu_init'? [-Werror=3Dimpli=
cit-function-declaration]
    arcfour_init(&mycontext, rc4key, 16);
    ^~~~~~~~~~~~
    rcu_init
drivers/staging/rtl8188eu/core/rtw_security.c:443:4: error: implicit declar=
ation of function 'arcfour_encrypt'; did you mean 'rtw_wep_encrypt'? [-Werr=
or=3Dimplicit-function-declaration]
    arcfour_encrypt(&mycontext, payload, payload, length);
    ^~~~~~~~~~~~~~~
    rtw_wep_encrypt
drivers/staging/rtl8188eu/core/rtw_security.c:445:23: error: implicit decla=
ration of function 'getcrc32'; did you mean 'get_cred'? [-Werror=3Dimplicit=
-function-declaration]
    *((__le32 *)crc) =3D getcrc32(payload, length-4);
                       ^~~~~~~~
                       get_cred
drivers/staging/rtl8188eu/core/rtw_security.c:399:21: warning: unused varia=
ble 'mycontext' [-Wunused-variable]
  struct arc4context mycontext;
                     ^~~~~~~~~

Caused by commit

  0d4876f4e977 ("staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames")

interacting with commit

  69a1d98c831e ("Revert "staging:r8188eu: Use lib80211 to support TKIP"")

from the staging.current tree.

I just reverted the staging.current commit ...

--=20
Cheers,
Stephen Rothwell

--Sig_/G4=UAVGCdduh6QkxzOe22w3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltNjJcACgkQAVBC80lX
0GxBegf/c9zGNcFo+qqZh4zuePSUerglo/jeGrTWiWiHxMmz/rjM4JYbU4OISdwl
ReSeAg+0vjstdBxu9VZD6LmRZJE/QrFzKIWy12hYG8//GhcGUR9QZ+MbPOK57z+P
P8IbwWRmm5wWWPDPPbm5lC6aW28ivlWrbl1TDDX7WPRCJaKREi+oPf7+fD3yRyiH
mvEQGXzQRauYvaRGoYTETG6JZm96LdPSGRrsgJXpJmHKPY7iOejXQ74uC4nUYluZ
hKRSAKHaX0nq91YdfgGm046IPa3CUls8e9ybcZXnwuebYxtValWvxOJs98raOzij
VuuZm+Z8sVEquzEdcGA3IwvQNEoUBA==
=D/Ta
-----END PGP SIGNATURE-----

--Sig_/G4=UAVGCdduh6QkxzOe22w3--
