Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBBJd2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:33:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751707AbeBBJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:32:40 -0500
From: NeilBrown <neil@brown.name>
To: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 02 Feb 2018 09:13:42 +1100
Cc: torvalds@linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH/resend] constify more dcache.h inlined helpers.
Message-ID: <87r2q42wa1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Many of the inlines in dcache.h were changed to accept
const struct pointers in commit f0d3b3ded999 ("constify dcache.c
inlined helpers where possible").
This patch allows 'const' in a couple that were added since then.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Hi Al,
 I still don't see this in your tree, despite you saying on Oct 20th
 that it had been applied.  So I thought it might be a good time to
 resend.

Thanks,
NeilBrown


 include/linux/dcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 65cd8ab60b7a..5b336f9faf01 100644
=2D-- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -359,7 +359,7 @@ static inline void dont_mount(struct dentry *dentry)
=20
 extern void __d_lookup_done(struct dentry *);
=20
=2Dstatic inline int d_in_lookup(struct dentry *dentry)
+static inline int d_in_lookup(const struct dentry *dentry)
 {
 	return dentry->d_flags & DCACHE_PAR_LOOKUP;
 }
@@ -487,7 +487,7 @@ static inline bool d_really_is_positive(const struct de=
ntry *dentry)
 	return dentry->d_inode !=3D NULL;
 }
=20
=2Dstatic inline int simple_positive(struct dentry *dentry)
+static inline int simple_positive(const struct dentry *dentry)
 {
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlpzkRYACgkQOeye3VZi
gblPIxAAuEV17To4x7JJK91ZTeoOUkc+s/jPrPx+n8t0ieKLvAv0M0QhtqRLRKjt
4jepYoQ+5boDyseM0eGaK13xtNv2da02+3xLa2hYWUOeICU6AbJloVlStBQwfYSs
CV6p6WVhdrd3Y2CjrFACDzczs33tUFTTbddXg+VGKlOLQL2JCkgMfjtIP/m7nsfv
uANkr0NpGyWG8Z6NMCbiFXPNMETPQNsCYFDz/cDe9OJyfhKmpPJ+2uohLanPIBge
m1tHMB6VIfl+0l2dJyhPX+vIVNpzGKL9gvQx6Gsf6f8pK8hcPN+B81FNgKQjbx1q
wRg7Id9tlM1LSU7+Gt6QcLLHlybaFxe50ZGnDjMkC2EDF28AClg5F3JL/IqraN9y
Q+r1YrYb9Mjx6QHB/7Fsvvne42xpMFeCs+RmHoMdSIn4tjvtaqspo85F8i9+2yFT
heYaHMwGxzYnn5w0QBqfla2xweE+GztFRyNR7znYfyz2BuAWFg7FHgRSUcXL/4yz
SyPtelyAKKBrfLJysXka3/jLp7vU3OTkBXVyW+dUs8R5P6rY02VhbHpmp7l9WPHz
/H3IhowTeUMkvDoi24qMcTr3h2uXWwWbiXs8A733j0AKMDo2jWE7+sKnIiFrhH4n
eQ40JvOiK0QfrUbROpSRxSkmYNyXQdUoZ7iB8uGI8NosNvI6azw=
=SALL
-----END PGP SIGNATURE-----
--=-=-=--
