Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B49ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3881520854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3881520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbeGTWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:48:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:48:59 -0400
Received: from 1.general.tyhicks.us.vpn ([10.172.64.52])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fgdQE-0004lw-DM; Fri, 20 Jul 2018 21:58:46 +0000
Subject: Re: [PATCH net-next v2 6/7] net: Create reusable function for getting
 ownership info of sysfs inodes
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        netdev@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
 <20180719143616.GA29715@mailbox.org>
From:   Tyler Hicks <tyhicks@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tyhicks@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8f1d3ac3-136c-aaf4-ee99-5858c733eca9@canonical.com>
Date:   Fri, 20 Jul 2018 16:58:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719143616.GA29715@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu
Content-Type: multipart/mixed; boundary="nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Christian Brauner <christian@brauner.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
 <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, netdev@vger.kernel.org,
 Linux Containers <containers@lists.linux-foundation.org>,
 bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <8f1d3ac3-136c-aaf4-ee99-5858c733eca9@canonical.com>
Subject: Re: [PATCH net-next v2 6/7] net: Create reusable function for getting
 ownership info of sysfs inodes
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <1531497949-1766-7-git-send-email-tyhicks@canonical.com>
 <20180719143616.GA29715@mailbox.org>
In-Reply-To: <20180719143616.GA29715@mailbox.org>

--nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/19/2018 09:36 AM, Christian Brauner wrote:
> On Fri, Jul 13, 2018 at 04:05:48PM +0000, Tyler Hicks wrote:
>> Make net_ns_get_ownership() reusable by networking code outside of cor=
e.
>> This is useful, for example, to allow bridge related sysfs files to be=

>> owned by container root.
>>
>> Add a function comment since this is a potentially dangerous function =
to
>> use given the way that kobject_get_ownership() works by initializing u=
id
>> and gid before calling .get_ownership().
>>
>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>> ---
>>  include/net/net_namespace.h |  7 +++++++
>>  net/core/net-sysfs.c        | 15 ---------------
>>  net/core/net_namespace.c    | 25 +++++++++++++++++++++++++
>>  3 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h=

>> index a71264d75d7f..a257710527ce 100644
>> --- a/include/net/net_namespace.h
>> +++ b/include/net/net_namespace.h
>> @@ -170,6 +170,8 @@ extern struct net init_net;
>>  struct net *copy_net_ns(unsigned long flags, struct user_namespace *u=
ser_ns,
>>  			struct net *old_net);
>> =20
>> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t =
*gid);
>> +
>>  void net_ns_barrier(void);
>>  #else /* CONFIG_NET_NS */
>>  #include <linux/sched.h>
>> @@ -182,6 +184,11 @@ static inline struct net *copy_net_ns(unsigned lo=
ng flags,
>>  	return old_net;
>>  }
>> =20
>> +static inline void net_ns_get_ownership(const struct net *net,
>> +					kuid_t *uid, kgid_t *gid)
>> +{
>> +}
>> +
>>  static inline void net_ns_barrier(void) {}
>>  #endif /* CONFIG_NET_NS */
>> =20
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index 41d84c40fe51..a3ad8108d296 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -656,21 +656,6 @@ static const struct attribute_group wireless_grou=
p =3D {
>>  #define net_class_groups	NULL
>>  #endif /* CONFIG_SYSFS */
>> =20
>> -static void net_ns_get_ownership(const struct net *net,
>> -				 kuid_t *uid, kgid_t *gid)
>> -{
>> -	if (net) {
>> -		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
>> -		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
>> -
>> -		if (uid_valid(ns_root_uid))
>> -			*uid =3D ns_root_uid;
>> -
>> -		if (gid_valid(ns_root_gid))
>> -			*gid =3D ns_root_gid;
>> -	}
>> -}
>> -
>>  #ifdef CONFIG_SYSFS
>>  #define to_rx_queue_attr(_attr) \
>>  	container_of(_attr, struct rx_queue_attribute, attr)
>> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
>> index a11e03f920d3..5257875fa84d 100644
>> --- a/net/core/net_namespace.c
>> +++ b/net/core/net_namespace.c
>> @@ -448,6 +448,31 @@ struct net *copy_net_ns(unsigned long flags,
>>  	return net;
>>  }
>> =20
>> +/**
>> + * net_ns_get_ownership - get sysfs ownership data for @net
>> + * @net: network namespace in question (can be NULL)
>> + * @uid: kernel user ID for sysfs objects (must be GLOBAL_ROOT_UID)
>> + * @gid: kernel group ID for sysfs objects (must be GLOBAL_ROOT_GID)
>> + *
>> + * Returns the uid/gid pair of root in the user namespace associated =
with the
>> + * given network namespace. The caller must initialize @uid and @gid =
to
>> + * GLOBAL_ROOT_UID/GLOBAL_ROOT_GID before calling this function.
>=20
> If they must be so initialized why not just enforce this directly in th=
e
> function? This way callers can rely on always getting back the correct
> permissions and the comment can be removed as well.

I agree and made this change in v3 of the patch set that I just sent
out. Thanks for the suggestion!

Tyler

>=20
> Christian
>=20
>> + */
>> +void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t =
*gid)
>> +{
>> +	if (net) {
>> +		kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
>> +		kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
>> +
>> +		if (uid_valid(ns_root_uid))
>> +			*uid =3D ns_root_uid;
>> +
>> +		if (gid_valid(ns_root_gid))
>> +			*gid =3D ns_root_gid;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(net_ns_get_ownership);
>> +
>>  static void unhash_nsid(struct net *net, struct net *last)
>>  {
>>  	struct net *tmp;
>> --=20
>> 2.7.4
>>
>> _______________________________________________
>> Containers mailing list
>> Containers@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/containers



--nubycyRPPLVvL3uADqLNYwrhoCl2ivIUr--

--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAltSWxAACgkQ1pIAPaoC
xwoOCQ/9Hwk8s0dL2KpCLqwdcs06QE0A9nw4ZsnjmzKvJN03QtWX84qTK+RTo0cF
Dq1gyS+MDBIUBwpRBYxg60pdyJszW2zAUUWfxiceAM/+10czY7PVdYKbbNLdr/Kj
K0FXWbAPgKZWZxSL3xOM+EcTgEY/oVU1FsNyTdtT32JuL6BsMBrOCNkMEZ5VIUSd
hSvhhO2idquMUDGB3O/MF9IZXVuCNn6DsYweMi04lz4zBuriOwB67F4ik4R4XKNp
+ZiiHCrEujy0vhqPu3ekMD13HNHaLFf5njcCqZ7teElq0zKE3mx+Oc/WX3Tx9F28
WKFPg/FDmCTsGYOfRBM2NOtkzwn6Ty0ZzmfHORjZ2JTuV3fuvzRTjzB11fg6+W5z
b7t0eSFrijJPk/UDUh4pKhHVxVwBgg0nk3QXfuFvFcdeBjChwWxNmqnbtHyr8+8Y
/vv7GZYCkj8OgaziQ0Ie0v6XVt/QcpDltCCL0O8H0l9X5+EwBC24RqKf0mTKTqJN
vwA7wu0MSfeitq1YD0e9Us2fDa0LuA0SmJnVlzoiuLHyqmtY11EGKmYlx6Ou5Ffl
WKlsssjdeQYbAg+ooUiRnSEIL7j23yQl+U/NCcqvB2gxmgStUmJsiflyDQ/IMsYH
vVF1EYLS54/Is7OBvgwApJX05I5LpDWU4v5o3SzIoL0ebeUxTk4=
=5BMd
-----END PGP SIGNATURE-----

--pmZOc5s212o0USrQWaV5bkzsPG2zYgGqu--
