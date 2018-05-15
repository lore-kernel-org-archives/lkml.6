Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526392062-5-4546680522743819964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526392062; b=fTI5arE8JsKMMahim8rDIP+aFcaaSxJZG6riD5/knWIR4bQxI5
    hQNX7i0mMKxGGrrN8uj7OcppT2ekToynYDOwjrMVnb/0cTIG5bx3aAEi0EC06hv/
    oog9/49ikKaU5e/oSkoBMAeoUsS6KAnhKgTGRvpVgiCdn0VVte9PmabIejHR55Jt
    GHT72K4B4bdvhDT3RGMSL7XbTypP+WLvPu/i/KpYgYaq7n0XxRq61xDJfx7boviT
    Mzc+3Q0GgaiXMxdObiI/vTh5UnH/A3EydBUmZLQdBf868FwNkX9VJKp/KzJTAXmj
    43qEqF8TI5sKE74HzsoM+n4Hiyzj7EHy0piA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:in-reply-to:references
    :date:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1526392062; bh=yPdSOmBFmYHiGGzCyK8T5Tql34CFF9k
    z85iz7VOQzIc=; b=X8WMQcD+/nTJTd1whOSgU22hiFcu+yUpFXRUT81xHtk57yC
    bA+MgKZBqcGyrXrAAM5MG6RTzlGtya56QEllPGWpc4+EHB0q5D+kuKeprjnjh7xa
    4fNmABGB0UBqM0YGAuEuJcO2ECYOIp3k78ho27ypcYqHlBmPMof35nPDuE1/jZVY
    663b9eb1+VcxSyn4yBipa0ix6ap35PxT7TqiszLq7OUVNKIQetBqEYUTLQoI4hJC
    dG9LhqLQJbV3HxSjP7m4p0No8nEcRRTQ2QBQ+UARjFcA3zRVSvl0ymrrdZuLR2SL
    5AceodOl7I65iLuCbPf80pZJPC5+e6ckAK8tjog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC9pWyBW4a/sa5BJpZb1vObTqPmX49nLiSCbc8wxedFwndqq3EVP92cHxBrvUX6mhxxDUrnLS1YjMgDW0aEpk7GIhk/WseK4OFD2IKRdN/wO9AhZPxlT
    WJ7wcKibG9ET9TeuqD+ttgn0PFmHZi1u88dVgQyWfrncmDkM3DcJowwe6pNS1MwtqW3L47Tey4JvnTW/8k0zqSDVJDMp9vXqjNtt3Xf9m1c44q8oHWndrmLp
    A8oRThTUVaTSA5dbeooNpg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=nhTcUU088zCk0I-6I78A:9
    a=VlACRpbGt0_9sD8V11UA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Replace open-coded idr with a
 struct idr.
In-Reply-To: <20180515120446.74vrnucehduhi554@mwanda>
References: <20180510233107.1684-1-eric@anholt.net>
 <20180515120446.74vrnucehduhi554@mwanda>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Tue, 15 May 2018 14:46:23 +0100
Message-ID: <87in7p6ngw.fsf@anholt.net>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6785091750770383906=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6785091750770383906==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Thu, May 10, 2018 at 04:31:07PM -0700, Eric Anholt wrote:
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
> This should probably be testing:
>
> 	if (handle < 0) {

That's what Stefan said and was fixed in v2 already.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr65K8ACgkQtdYpNtH8
nugIkw//erTRGtmf8XGkIP0OV+lVhP945a5tXwBQNvpUpgN7TWPGYrYF4XseVOwo
CN0z0zkjkRrri3s3JpQj6uaSh1mtX0q8UFTVQUAgZqcqlMYPFGToH2Wjax8aChaB
fDXPDQeIuM36lQ5/nb+c053bIu3aULTSFUkcyJ4RrQucwXkGw4Tsf7W0N942gBqp
12rys06E5lCNIqmylBmshLNpJcEH4AZk29S/J9S65Jux8D02z00i4eRnGEGauzOS
oGApTYDrm1RjqQVcZjIehfl9CJ326tvWh8VlCjQ7F9zc2H3mieI17G+U4fxcu1Rx
jUi1zyh5iWIZUTYYiTPuU69OISPlqSgs8rN1ONZ000st7YtJV6n+j/ojYmGuuK+1
xUrYVwU/pLRAl+ysGbxp/CN/f8moKNTDyeQoCW0T5Gm4WPoevFfn1M4dMO32qctR
d6bO/aXZkeaL/N2GRnZcHIJLlowX4R+TEGngk93FL6w8whTBRDVL1ydWrfC+izrO
vJbFZizAYZ1zFG3R9VVc1QqcLyNqDpbl8hEjsCLPaKhLZ/2wAywssBDQm4+9e5np
b/QJcPO5aBmkUttjZ3xdPak9Bqwgom9tVv7hiViB0Xcqe4dhxoDFWqtb/CHBAmRq
WIlYyzoaoGcFEZViSGqWzB0xnEZBTB8tKt6keKaUWZqmYaNBYSU=
=8Bre
-----END PGP SIGNATURE-----
--=-=-=--

--===============6785091750770383906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6785091750770383906==--
