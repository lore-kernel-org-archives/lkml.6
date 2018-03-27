Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC0Ovy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:51:54 -0400
Received: from orthanc.universe-factory.net ([104.238.176.138]:43328 "EHLO
        orthanc.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752019AbeC0Ovw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:51:52 -0400
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
 <20180326125131.15fba249@gandalf.local.home>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 JUrAgszpeMHSk7AmTcV1x3o=
Message-ID: <966ff66c-5ab9-23c4-7c23-01a802c20159@universe-factory.net>
Date: Tue, 27 Mar 2018 16:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326125131.15fba249@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IkZS7wcfbe8VosOCUTAOV1TBXIH6crG9l"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IkZS7wcfbe8VosOCUTAOV1TBXIH6crG9l
Content-Type: multipart/mixed; boundary="OwpcvSgJzRVs9uuLYG4H9pMNIceYopCH4";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <966ff66c-5ab9-23c4-7c23-01a802c20159@universe-factory.net>
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
 <20180326125131.15fba249@gandalf.local.home>
In-Reply-To: <20180326125131.15fba249@gandalf.local.home>

--OwpcvSgJzRVs9uuLYG4H9pMNIceYopCH4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/26/2018 06:51 PM, Steven Rostedt wrote:
> On Sat, 24 Mar 2018 17:26:38 +0100
> Matthias Schiffer <mschiffer@universe-factory.net> wrote:
>=20
>> @@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_gr=
aph_ret *trace)
>> =20
>>  	rec =3D ftrace_find_profiled_func(stat, trace->func);
>>  	if (rec) {
>> +		unsigned long long avg, delta1, delta2;
>> +
>>  		rec->time +=3D calltime;
>> -		rec->time_squared +=3D calltime * calltime;
>> +
>> +		/* Apply Welford's method */
>> +		delta1 =3D calltime - rec->avg;
>> +
>> +		avg =3D rec->time;
>> +		do_div(avg, rec->counter);
>=20
> Can you find a way not to do a divide in every function call?

I think the current method based on the sum of squares is the best we can=

do without a divide for each sample. The completely bogus result

  nf_conntrack_proto_fini     50    373.523 us    7.470 us    3234315951 =
us

I mentioned in my commit message was caused by the second MIPS-specific
issue I mentioned in my last mail, so while this method may lead to
inaccurate results [1], and it is certainly not Welford's method, it migh=
t
be good enough in practice, and you can disregard my patch.

Matthias


[1]
http://jonisalonen.com/2013/deriving-welfords-method-for-computing-varian=
ce/


>=20
> -- Steve
>=20
>> +		rec->avg =3D avg;
>> +
>> +		delta2 =3D calltime - rec->avg;
>> +
>> +		rec->stddev +=3D delta1 * delta2;
>>  	}
>> =20
>>   out:
>=20



--OwpcvSgJzRVs9uuLYG4H9pMNIceYopCH4--

--IkZS7wcfbe8VosOCUTAOV1TBXIH6crG9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlq6WoYACgkQFu8/ZMsg
HZxL2xAA6zKu/j4fAvQiN5/pdo8GEXC1aZA3Dk/kZIuYhIemnwXzXSc5CjQeTvdc
M4NpIy3O9x0lwJhhxVSFt3wP0xsNnNXgyNAMqI+btlPa3svSDbwnRqFaLfZSBTwW
Fml4Iw3GgBvP0wuc9e3wakOsO5FtUMhLzgzl0ZNuPpk0JxVMPp0Q+G8n8PqlKtq8
SDiI7oNUrxMIGJ9nvDXk60uHBrhan63Imj87ZRXwh4SCStohjKJPgXuGGMTce4pY
5IyzzWcHcPLFFPeYos7elUbIevOlX87g3MXZgY4Il3ma7BYifFL+wu60i4lvpjCl
B/oHCLYDgJkh/+Emvjm4ypi/kTU4LKbFlCBuGQx2hrssdmFPxfCPOsIVJJ+9zoKu
6EQubsG2aCy1Z4ioghPCBzdBfIoWLrR2oyU3xSnIUxrTSVSjDCrVx7RHUR5z5LW7
OT7cLSqrkfWG4vOPSBzE53/XZ00ta7Og7OJI5atMiLPqscM3Hu5A4ikR0+X02laO
ZTaD6MohczKBduA0XBRAF5A/nGPgO0Ya9DYeV9RlPZB4j3RvIQHkMJdQxkA3C6k6
+IJUZGUtGWCbSmbExPPYHw5NNoHzpHevT3J0r0xvOR5Dkh463kVC5mQyVdf6TIfi
GCW/kA8Zn1uOFVzOwTMBkBFoPN+tdtREtNvEKEV5rIKU/aI3r84=
=0aPD
-----END PGP SIGNATURE-----

--IkZS7wcfbe8VosOCUTAOV1TBXIH6crG9l--
