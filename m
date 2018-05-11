Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2999894-1525999281-2-16342898370779223024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525999280; b=dXOUdbkT8f8PEKetxavwrfVNAifGg2NntFuOxOIW0/C3OW7O2T
    b7cLKYQ+eCA6yHQEsBBPjUtw4GNDdawybss4T2DqLud/ZUuDnpcDf6nfXsuhIN0c
    tViTdx7wVSO7xTq2FwuXfpyQdJGxB3MgIVWB/C16I14jTwhwwQ4TD01ZnL+Rr9os
    sycW/L94VZx3AyuMErfxsxFIQsOOmOOEUQP43wMUfbRUCpWWuyKFxoMRp+hnRcPM
    cAny3TGaEx8u2baTJnQqYyhHtt9vs734orR5Eggpiora7J36j3SpiIDHBSyZhmG7
    OM2BORDut5lAfUWH8K1/fwXzhuNlHcq1JWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:in-reply-to:references
    :date:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525999280; bh=iSOGqACmk1wbQ9yDy/k2iXB+5skXUfL
    eG3fywqPs67I=; b=ea4FVndMqvPX8quFFh5y9xaN0F3zujvxX/Nl8rOwras+THF
    P0ugZsugsRC52TWtxmyiyr4I5wqbBY6I7eSHL/MwSvgjDtdktkjJHSv8tBYjeQY1
    mehMDVFO/CRDGM5dpXNLQl1LJxaBnTaik+/5IpdhC0UwRQ+6GRwIeQhupdTXrrhW
    gTlKbtN72nteBoTULwc5hemQo5udnN26XaDxH5ill36xVsbJg33c8u+0fEOiTZIA
    mTi58A8V9oH2YwPgBaIZdU9uT4j36RSKIKLj9CA7gStdR+IJtI1ION22WV/wq60k
    yK+b+f0z0phIxwlEI/Sa5Jgzj+wJ0Zgbt4Z8QyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbZtFt2Z7LB7Cw7rRixKAaDvc2d7wETWtBJk3sSqolwsuUqQE0d8/qqIlzGuo7MZbvM1HC/7ef1l/9NAgC4FDKL4X4xdX0UHtwTYkRCi9au404qJsnm
    kqwp8cvpODn6bHSvbw5o3WKGXZX5QRL0whrVjVXhlwpekaJ7vubQnyKoghOKd65oYSx4Ei27kfi1jNFwtcTkbtiy7oqZwAcd/hD7EqiGn1VVelO6oxTP7iH7
    ftW5/Yr89jrkFUaihrY2PQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=5mpuRNi4AAAA:8 a=-VAfIpHNAAAA:8 a=P-FKnmpYe0d4dzOy0hwA:9
    a=Pma8vGdcPvkA:10 a=6OAn6XIyugDZEs76KzoA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=eHWn0xJZPbZ7L6UZR85b:22 a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-rpi-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-camera: Replace open-coded idr with a
 struct idr.
In-Reply-To: <1544770503.215491.1525995621129@email.1und1.de>
References: <20180510233107.1684-1-eric@anholt.net>
 <1544770503.215491.1525995621129@email.1und1.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Thu, 10 May 2018 17:41:09 -0700
Message-ID: <87efij3ty2.fsf@anholt.net>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8585866708896643075=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============8585866708896643075==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 11. Mai 2018 um 01:31 geschrieben:
>>=20
>>=20
>> We just need some integer handles that can map back to our message
>> struct when we're handling a reply, which struct idr is perfect for.
>>=20
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  .../vc04_services/bcm2835-camera/mmal-vchiq.c | 135 ++++--------------
>>  1 file changed, 31 insertions(+), 104 deletions(-)
>>=20
>> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b=
/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
>> index 3a3b843fc122..f0dac6440cfb 100644
>> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
>> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
>> @@ -21,7 +21,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/completion.h>
>>  #include <linux/vmalloc.h>
>> -#include <linux/btree.h>
>>  #include <asm/cacheflush.h>
>>  #include <media/videobuf2-vmalloc.h>
>>=20=20
>> @@ -111,7 +110,11 @@ struct vchiq_mmal_instance;
>>  /* normal message context */
>>  struct mmal_msg_context {
>>  	struct vchiq_mmal_instance *instance;
>> -	u32 handle;
>> +
>> +	/* Index in the context_map idr so that we can find the
>> +	 * mmal_msg_context again when servicing the VCHI reply.
>> +	 */
>> +	int handle;
>>=20=20
>>  	union {
>>  		struct {
>> @@ -149,13 +152,6 @@ struct mmal_msg_context {
>>=20=20
>>  };
>>=20=20
>> -struct vchiq_mmal_context_map {
>> -	/* ensure serialized access to the btree(contention should be low) */
>> -	struct mutex lock;
>> -	struct btree_head32 btree_head;
>> -	u32 last_handle;
>> -};
>> -
>>  struct vchiq_mmal_instance {
>>  	VCHI_SERVICE_HANDLE_T handle;
>>=20=20
>> @@ -165,92 +161,19 @@ struct vchiq_mmal_instance {
>>  	/* vmalloc page to receive scratch bulk xfers into */
>>  	void *bulk_scratch;
>>=20=20
>> -	/* mapping table between context handles and mmal_msg_contexts */
>> -	struct vchiq_mmal_context_map context_map;
>> +	struct idr context_map;
>> +	spinlock_t context_map_lock;
>>=20=20
>>  	/* component to use next */
>>  	int component_idx;
>>  	struct vchiq_mmal_component component[VCHIQ_MMAL_MAX_COMPONENTS];
>>  };
>>=20=20
>> -static int __must_check
>> -mmal_context_map_init(struct vchiq_mmal_context_map *context_map)
>> -{
>> -	mutex_init(&context_map->lock);
>> -	context_map->last_handle =3D 0;
>> -	return btree_init32(&context_map->btree_head);
>> -}
>> -
>> -static void mmal_context_map_destroy(struct vchiq_mmal_context_map *con=
text_map)
>> -{
>> -	mutex_lock(&context_map->lock);
>> -	btree_destroy32(&context_map->btree_head);
>> -	mutex_unlock(&context_map->lock);
>> -}
>> -
>> -static u32
>> -mmal_context_map_create_handle(struct vchiq_mmal_context_map *context_m=
ap,
>> -			       struct mmal_msg_context *msg_context,
>> -			       gfp_t gfp)
>> -{
>> -	u32 handle;
>> -
>> -	mutex_lock(&context_map->lock);
>> -
>> -	while (1) {
>> -		/* just use a simple count for handles, but do not use 0 */
>> -		context_map->last_handle++;
>> -		if (!context_map->last_handle)
>> -			context_map->last_handle++;
>> -
>> -		handle =3D context_map->last_handle;
>> -
>> -		/* check if the handle is already in use */
>> -		if (!btree_lookup32(&context_map->btree_head, handle))
>> -			break;
>> -	}
>> -
>> -	if (btree_insert32(&context_map->btree_head, handle,
>> -			   msg_context, gfp)) {
>> -		/* probably out of memory */
>> -		mutex_unlock(&context_map->lock);
>> -		return 0;
>> -	}
>> -
>> -	mutex_unlock(&context_map->lock);
>> -	return handle;
>> -}
>> -
>> -static struct mmal_msg_context *
>> -mmal_context_map_lookup_handle(struct vchiq_mmal_context_map *context_m=
ap,
>> -			       u32 handle)
>> -{
>> -	struct mmal_msg_context *msg_context;
>> -
>> -	if (!handle)
>> -		return NULL;
>> -
>> -	mutex_lock(&context_map->lock);
>> -
>> -	msg_context =3D btree_lookup32(&context_map->btree_head, handle);
>> -
>> -	mutex_unlock(&context_map->lock);
>> -	return msg_context;
>> -}
>> -
>> -static void
>> -mmal_context_map_destroy_handle(struct vchiq_mmal_context_map *context_=
map,
>> -				u32 handle)
>> -{
>> -	mutex_lock(&context_map->lock);
>> -	btree_remove32(&context_map->btree_head, handle);
>> -	mutex_unlock(&context_map->lock);
>> -}
>> -
>>  static struct mmal_msg_context *
>>  get_msg_context(struct vchiq_mmal_instance *instance)
>>  {
>>  	struct mmal_msg_context *msg_context;
>> +	int handle;
>>=20=20
>>  	/* todo: should this be allocated from a pool to avoid kzalloc */
>>  	msg_context =3D kzalloc(sizeof(*msg_context), GFP_KERNEL);
>> @@ -258,32 +181,40 @@ get_msg_context(struct vchiq_mmal_instance *instan=
ce)
>>  	if (!msg_context)
>>  		return ERR_PTR(-ENOMEM);
>>=20=20
>> -	msg_context->instance =3D instance;
>> -	msg_context->handle =3D
>> -		mmal_context_map_create_handle(&instance->context_map,
>> -					       msg_context,
>> -					       GFP_KERNEL);
>> +	/* Create an ID that will be passed along with our message so
>> +	 * that when we service the VCHI reply, we can look up what
>> +	 * message is being replied to.
>> +	 */
>> +	spin_lock(&instance->context_map_lock);
>> +	handle =3D idr_alloc(&instance->context_map, msg_context,
>> +			   0, 0, GFP_KERNEL);
>> +	spin_unlock(&instance->context_map_lock);
>>=20=20
>> -	if (!msg_context->handle) {
>> +	if (msg_context->handle < 0) {
>
> handle < 0 ?

You're right, thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr05qUACgkQtdYpNtH8
nuj/Rg/+PlV8dHpO1V9hGTsV7IPJmXmos59IgdETjXJTJe74ybv3c43/pJuo1lJU
LggNlXUIpQNjkZ2mCvXIF1PkVJOxdHqnmsHMMcOjbw8BL4uPfWfpoDBnBFVSwTVC
i7RWGLm5/5E2/EtbscvdFWkiiiQKeNKLUmqXnb6md6ct6g0dnbYT9gTZLub71Syu
dEdDtu3eO4LK2utpaz0PC9llExOw/p7QEp9lUPNyJeGa77BvG4GPjc/cGiFUN+1Y
1PxrRFK3WJmUglAGv1r4bRJBZdh1Q2LolOJlR6FYd9SPPBF5g4dsFs7Q1cAL86c/
PLuo35y1wj3mzdgODo0Xa6jUTIVokdc1fvdP11LJr2wR6Jy1zU7SujNT7VOyRN8Y
65Fxb/oY+sejNW1JiFYSBrw8pP46xCpZauHN63w/B5TGb9kaFsY2ts1+/fFBACO1
1Vbtw/jNs600WdLC8UVR4HVLFsdBLTY5Mp4VkJN15iebNawqnvH5l8AsJv2ahnI2
o+avamNLG6jVVW+fLS0622li+5gmzoOTNs9bU2/B7VnYBKFSVWR/7bdnjI0Qncwd
4WkFPitfBAyjYUKe/MJnLcacv3bb1TCFdlh33Cg0Y/QSLpPfapsl5NN1yKdk+mdu
1so0fmBcCD63LV3bvYrNwEztVIk5xO0QF5y+KTwAwjXMcs8VXb4=
=L+zx
-----END PGP SIGNATURE-----
--=-=-=--

--===============8585866708896643075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8585866708896643075==--
