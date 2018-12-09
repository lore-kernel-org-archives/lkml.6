Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D761AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA06208E7
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA06208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLIW6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:58:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbeLIW6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:58:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89BD4AC36;
        Sun,  9 Dec 2018 22:58:43 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 10 Dec 2018 09:58:37 +1100
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: convert path-lookup from markdown to resturctured text
In-Reply-To: <20181206100912.535b351d@lwn.net>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name> <87sgzc7v50.fsf@notabene.neil.brown.name> <20181205124644.3f8a452a@lwn.net> <87woonelit.fsf@notabene.neil.brown.name> <20181206100912.535b351d@lwn.net>
Message-ID: <87h8fmcnoi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06 2018, Jonathan Corbet wrote:

> On Thu, 06 Dec 2018 08:00:58 +1100
> NeilBrown <neilb@suse.com> wrote:
>
>> > Is there a reason you used "include" rather than just adding it to the
>> > TOC tree with the rest?=20=20
>>=20
>> Simple.  I didn't know what I was doing, and so randomly made changes un=
til
>> the result seemed acceptable - then I stopped.  If there is a better
>> way, feel free to tweak that when applying.
>
> OK, tweaked and applied, thanks.
>
> jon

Thanks...

However we now have a stub section "Pathname lookup" which serves only
to introduce another stub sectoin "Pathname lookup in Linux", which does
little more than introduce the rest of the section.
This seems inelegant, and is probably why I went for the "include"
approach.

What would you think of something more like the following?

Thanks,
NeilBrown


diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystem=
s/index.rst
index ba921bdd5b06..605befab300b 100644
=2D-- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -363,8 +363,18 @@ encryption of files and directories.
 Pathname lookup
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=2DPathname lookup in Linux is a complex beast; the document linked below
=2Dprovides a comprehensive summary for those looking for the details.
+
+This write-up is based on three articles published at lwn.net:
+
+- <https://lwn.net/Articles/649115/> Pathname lookup in Linux
+- <https://lwn.net/Articles/649729/> RCU-walk: faster pathname lookup in L=
inux
+- <https://lwn.net/Articles/650786/> A walk among the symlinks
+
+Written by Neil Brown with help from Al Viro and Jon Corbet.
+It has subsequently been updated to reflect changes in the kernel
+including:
+
+- per-directory parallel name lookup.
=20
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/file=
systems/path-lookup.rst
index 30a155736afe..9d6b68853f5b 100644
=2D-- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1,18 +1,3 @@
=2D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2DPathname lookup in Linux
=2D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D
=2DThis write-up is based on three articles published at lwn.net:
=2D
=2D- <https://lwn.net/Articles/649115/> Pathname lookup in Linux
=2D- <https://lwn.net/Articles/649729/> RCU-walk: faster pathname lookup in=
 Linux
=2D- <https://lwn.net/Articles/650786/> A walk among the symlinks
=2D
=2DWritten by Neil Brown with help from Al Viro and Jon Corbet.
=2DIt has subsequently been updated to reflect changes in the kernel
=2Dincluding:
=2D
=2D- per-directory parallel name lookup.
=20
 Introduction to pathname lookup
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwNnh0ACgkQOeye3VZi
gbnoGBAAjDczYJTC0kacul7i43refFtkjks8ZUBJMNWfY+6Vwt26wUFJxFXUDwA4
afavTflcD7ESD40GFljq/bwhwHjGI+1AB5Y5o2I8SaTlSUPnzohWQKbg8tgZRVxp
n9b27wTGvD7kWbXShoGPclfRJsFR04ZW3gughrz0369IyZTO9UByzx/GMbxj/Ejo
UtHqWQFmh90RTl4ES4Ms3bjVNwSBrBie2ZSAqS2Kqs8gJ38R7gbF/DE2CfHhsKGj
lT5HF+9UEtb4kwZsn+QoSCqeMbtwKRm3f0KsbhKYNgi0Z0dreSa/d5RH7NFwbPfC
0TwlcTI/2VxOyDxod4Z6p3CZ7CkQu8BiuRLOZTOaL/0I3GEV+YKEM4lFli9Uy68D
4jk9Qhgec63FNwn8UXA9LiTAUIHILdoynYXmquZjmIC/FQomgCG6/pilLLM6hMRi
dw91OCsj4KFCd8oqMfbyjjYo7KwCyBwraDic83GG15eqijv+L0GfqY9mfnMXWXqf
3Cp9iFsNJnEmX3ZftDqonQiUKQ0BHzN1C2MEbMQyTo0Z/sxrWHitzbpNqb62RtEk
IdgpZ32p0mvnXnGl2F2gsJJH06P0O+SNtBCer3TeVzvjQd/vmHCbrypoIxJUag+R
JLJUBRawiwNSATv9rn03GJFgdekypUUKwSxylRg79mNyZfHZpoQ=
=sKnw
-----END PGP SIGNATURE-----
--=-=-=--
