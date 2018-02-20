Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226SQ357bhvbmyF9KxVZKvm8l2ZiO0CPFklJj+y0wjZXW66kDgBsCmmITNv0pts+ti6Rl8S7
ARC-Seal: i=1; a=rsa-sha256; t=1519116939; cv=none;
        d=google.com; s=arc-20160816;
        b=ll1FS4wPCmGdbDikrbpBqy+rftx5hxIWdM9wZY+hASv1pHHEKGUzn4q7m5mwrCMzhh
         /RLtrY8SomBF1NrBCmToKJ3GinLL+2HOUZ+FLMUyPxiMVV6ViRQ57RXE1Y9766JhihIh
         2ZYEEXdGhYVvmLyku0OHtF41W/zKTEwvuO3AP6o9ySf+U0Mut7AE2YzwVRcd7kIxape0
         8BmCxAtUEKlU6c7P6slNarOluzs/U9kaOHGvynMP/yfl7Ab4jD8kNtUevPYTwlyZ2SrO
         zYNMxdT3I6+3oLwsDmJxEzEunedoN1Ae87LPKFrdHpIP4IK6/qDuNDw+7Y90suwxyOjS
         h0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=y6a3eQkYnvHjiwvbywvn+isHfCsnrHENFTI8974t6LM=;
        b=klSCPkYQ1RJEDnJoKTx/M7XpPA8ZKyTBoKiKNb2lavk/ffcpHfMpUZU1LFTPuZ7kSy
         KHF4AuDA620kHBBd3OhPcgXvf8+xiPHHN93BSC6PgMfVMSOa+QlOz0BUVEKnF+iOiaUA
         1dhea1Rft7HW6RFHAxetpqv2QvnrVr51MeHgsb5O5540lv8Z02tH7Wrns/zBmRzlhJPi
         TFhMqYhjjH2+GFPxY/lJKNvzwan3jx6WW8MHftPNa0ttgNFT0Tw2PsbGNy1jSvyt8F+8
         W5zXliYM0sMz4AJgt9OxrlWVHuscl7raonkhj9xyNpxNVlFrsh3An2+u/GfqDDmiPPVK
         I9kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Eremin\, Dmitry" <dmitry.eremin@intel.com>, "Drokin\, Oleg" <oleg.drokin@intel.com>, "James
 Simmons" <jsimmons@infradead.org>, "Dilger\, Andreas" <andreas.dilger@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 19:55:30 +1100
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Subject: RE: [lustre-devel] [PATCH 14/21] staging: lustre: fix assorted checkpatch errors
In-Reply-To: <9FC73D3DBECE0941BD2ED069D26863425CE8FF1E@irsmsx110.ger.corp.intel.com>
References: <151909308778.25814.9912662268627044409.stgit@noble> <151909341801.25814.16760126077741712102.stgit@noble> <9FC73D3DBECE0941BD2ED069D26863425CE8FF1E@irsmsx110.ger.corp.intel.com>
Message-ID: <87lgfojb0d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885047375416179?=
X-GMAIL-MSGID: =?utf-8?q?1592909564081440505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20 2018, Eremin, Dmitry wrote:

> Hello Neil,
>
>> diff --git a/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> b/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> index ab48746ce433..bde27acb0dd3 100644
>> --- a/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> +++ b/drivers/staging/lustre/lustre/mdc/mdc_request.c
>> @@ -1060,8 +1060,10 @@ static void mdc_adjust_dirpages(struct page
>> **pages, int cfs_pgs, int lu_pgs)
>>=20
>>  		while (--lu_pgs > 0) {
>>  			ent =3D lu_dirent_start(dp);
>> -			for (end_dirent =3D ent; ent;
>> -			     end_dirent =3D ent, ent =3D lu_dirent_next(ent));
>> +			while (ent) {
>> +				end_dirent =3D ent;
>> +				ent =3D lu_dirent_next(ent);
>> +			}
>>=20
>>  			/* Advance dp to next lu_dirpage. */
>>  			dp =3D (struct lu_dirpage *)((char *)dp + LU_PAGE_SIZE);
>
> I doubt this is correct replacement. In original code end_dirent is
> set always in the begin of outer loop (while (--lu_pgs > 0)). But in
> new code this is missed. Therefore in case of second iteration and
> (ent =3D lu_dirent_start(dp)) =3D=3D NULL the end_dirent will contain a
> value from previous iteration which is not correct.

Thanks for the review.  Yes, you are correct.
I had seen that end_dirent was initialized to NULL, and let myself
believe that would make the transformation safe.
In fact, that initialization to NULL is pointless as it is never used.

Maybe this would be better

@@ -1055,13 +1055,14 @@ static void mdc_adjust_dirpages(struct page **pages=
, int cfs_pgs, int lu_pgs)
 		__u64 hash_end =3D le64_to_cpu(dp->ldp_hash_end);
 		__u32 flags =3D le32_to_cpu(dp->ldp_flags);
 		struct lu_dirpage *first =3D dp;
=2D		struct lu_dirent *end_dirent =3D NULL;
=2D		struct lu_dirent *ent;
=20
 		while (--lu_pgs > 0) {
=2D			ent =3D lu_dirent_start(dp);
=2D			for (end_dirent =3D ent; ent;
=2D			     end_dirent =3D ent, ent =3D lu_dirent_next(ent));
+			struct lu_dirent *end_dirent =3D NULL;
+			struct lu_dirent *ent;
+
+			for (ent =3D lu_dirent_start(dp); ent;
+			     ent =3D lu_dirent_next(ent))
+				end_dirent =3D ent;
=20
 			/* Advance dp to next lu_dirpage. */
 			dp =3D (struct lu_dirpage *)((char *)dp + LU_PAGE_SIZE);


??

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqL4oIACgkQOeye3VZi
gbn9DQ/6AuKl03Xp0H9vqgBahu5E/xlb8ETHCe33DOeMAYKQzqlfY+n4rNFkHeli
15EnR9w8nbxUR6dlg2A8vVN/N1IZ6IvBWahMNI95x7SgS6VqvizNBZIwFgjUSfyl
tPexX8r741x+apSFKZUveNiaghIa3XMMEwwNwe2PTJ9bXq6CmXqSO31odVKbcjOQ
3AJKauMYIqvmpDOPtMCBBmgtyalwXC92HlF4Bsgi0rjMREfkLjitM6uod9YZsooy
axEAGtWMiTWlLWsiu+aw7zLT//UDa+ki24h2IU8lqqhujo8vZ7b/2Abr/Vj6x+22
+m2Xuh3KZ/Cw6XZSbJcJ/JDvBd1V+RUGccttnGvqHKHh24R/RurOCi5rv1ZFz1HB
JelKEjtEDlhBlgEQ7HxK6X75R9EMY/Qo03FRJRPWSwhe38lvzFu4jBKvTLuvHgWA
V1/WcQKnJfHKD6D0Tc0HaT4S8VntAxLFc9dekRamQA7pGOEiA2TCkGOQakAcf0P/
NAGV48yWNwiNipT+b7vWKY8jXwH9pMV5EunmuPyYV40EP8plu/2ntQhBuk6oenpd
GVWAcQcaNfTc9+NPNcfLnjEN9QOt5Qs4oHN9dG3xinbSjP7KCx0oU7Mx2MPOmgBf
l5i+7pnNJJJq9JQZciMAJMr6CGkIpRIiq6NR7nEOEgktzWUq5cM=
=zA5b
-----END PGP SIGNATURE-----
--=-=-=--
