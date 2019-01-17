Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0E820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="eiKTw8l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfAQNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:44:47 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:41228 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfAQNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:44:46 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43gQL41s8Tz1y6H;
        Thu, 17 Jan 2019 14:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547732684; bh=XC8f8M65I7aa6JU3vR62x+xleYVdZ3S3vTyuva0mdEc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=eiKTw8l5EQCvC3i+xKpq7GUT4oQqbArOztxqH6TwzPJY16gWyYvR0QDqrCzyQG4cT
         72KIXFldVy9REkhIiDNdK0Ff7/U53HcGrb7DSmcXiPdmlfTI33EqpB0fNeAYgkheFj
         LRdwT/Kb4ltV1M1J7vVi4IFARG4TA7lIagZl2w7XWp5o41C+FwHJs/SJWes4Dbtfaj
         KaZCQTaYTumGtYCYPMSHP4Jdct4WoSrwWV1G8BZ3xX8+ep7VPsXsxNMAmuUX3sk+iN
         DTzjSHe0e5If3yl/ZxBVTOhEbiR5dFHs6ODAoK+AIhhyPcksnxibP8dp/ikFib1fDW
         pyReY/x2ibinQ==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+SkB1p2WdWj9adG9kRM8KKQ10dXGWqNAc=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43gQL16GcTz1y8B;
        Thu, 17 Jan 2019 14:44:41 +0100 (CET)
Subject: Re: uprobes: bug in comm/string output?
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
 <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
 <20190116190054.ac22c8495540578834446236@kernel.org>
 <62276858-9135-2393-8993-64e1088db7b9@fau.de>
 <20190117151309.711d41ebdd761b525a168837@kernel.org>
 <20190117170015.403157bf619907f8467189fe@kernel.org>
 <17147ef5-4348-9a02-d781-0f089fe603f5@fau.de>
 <20190117184717.9bbd1218b9f4fe6a8070a0fe@kernel.org>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Message-ID: <15ce335e-d40e-f9ef-e85a-507e153c55cb@fau.de>
Date:   Thu, 17 Jan 2019 14:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117184717.9bbd1218b9f4fe6a8070a0fe@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070204080708090201020501"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070204080708090201020501
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi,

On 1/17/19 10:47 AM, Masami Hiramatsu wrote:
> On Thu, 17 Jan 2019 09:08:41 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>=20
>> On 17.01.19 09:00, Masami Hiramatsu wrote:
>>> On Thu, 17 Jan 2019 15:13:09 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>
>>>> On Wed, 16 Jan 2019 11:16:07 +0100
>>>> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>>>>
>>>>>
>>>>> I went into this a bit deeper today, and right now it is simply fai=
ling
>>>>> to parse the code because there is no FETCH_OP_COMM case in
>>>>> process_fetch_insn() for uprobes so that will return -EILSEQ, leadi=
ng to
>>>>> a make_data_loc(0, ...) in store_trace_args(). If we just add
>>>>> FETCH_OP_COMM and let val point to current->comm (that's what
>>>>> trace_kprobe.c does), we get an -EFAULT return value from
>>>>> fetch_store_string because strncpy_from_user() checks if the argume=
nt is
>>>>> in user space.
>>>>
>>>> Correct. I missed to add OP_COMM support. And uprobe's fetch_store_s=
tring
>>>> is only for user space strings.
>>>>
>>>>> So I think we might need a special case for that, something like
>>>>> FETCH_OP_ST_COMM_STRING which is only used for FETCH_OP_COMM and co=
pies
>>>>> current->comm over to the dynamic area. The implementation could be=

>>>>> similar to the old fetch_comm_string implementation before your rew=
rite.
>>>>
>>>> Hmm, instead, I would like to add current->comm checker and only all=
ows
>>>> to copy that. That would be simpler and enough.
>>>>
>>>> Could you test below patch?
>>>>
>>>>
>>>> tracing: uprobes: Re-enable $comm support for uprobe events
>>>>
>>>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>>>
>>>> Since commit 533059281ee5 ("tracing: probeevent: Introduce new
>>>> argument fetching code") dropped the $comm support from uprobe
>>>> events, this re-enable it.
>>
>> this should read 're-enables'.
>>
>>>>
>>>> For $comm support, use strncpy() instead of strncpy_from_user()
>>                               ^
>> we're using strlcpy(), not strncpy().
>>
>>>> to copy current task's comm. Because it is in the kernel space,
>>>> strncpy_from_user() always fails to copy the comm.
>>>> This also use strlen() instead of strlen_user() to measure the
>>                 ^                        ^
>> 'uses', and the function should be 'strnlen_user()'.
>>
>>>> length of the comm.
>>>>
>>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
>>>> ---
>>>>   kernel/trace/trace_uprobe.c |   13 +++++++++++--
>>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe=
=2Ec
>>>> index e335576b9411..97d134e83e0f 100644
>>>> --- a/kernel/trace/trace_uprobe.c
>>>> +++ b/kernel/trace/trace_uprobe.c
>>>> @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *de=
st, void *base)
>>>>   	if (unlikely(!maxlen))
>>>>   		return -ENOMEM;
>>>>  =20
>>>> -	ret =3D strncpy_from_user(dst, src, maxlen);
>>>> +	if (addr =3D=3D (unsigned long)current->comm)
>>>> +		ret =3D strlcpy(dst, current->comm, maxlen);
>>>> +	else
>>>> +		ret =3D strncpy_from_user(dst, src, maxlen);
>>>>   	if (ret >=3D 0) {
>>>>   		if (ret =3D=3D maxlen)
>>>>   			dst[ret - 1] =3D '\0';
>>>> @@ -173,7 +176,10 @@ fetch_store_strlen(unsigned long addr)
>>>>   	int len;
>>>>   	void __user *vaddr =3D (void __force __user *) addr;
>>>>  =20
>>>> -	len =3D strnlen_user(vaddr, MAX_STRING_SIZE);
>>>> +	if (addr =3D=3D (unsigned long)current->comm)
>>>> +		len =3D strlen(current->comm);
>>>
>>> To balance with the strnlen_user, we must increse the len in this blo=
ck.
>>> (strlen doesn't count the final '\0', but strnlen_user counts it)
>>>
>>
>> yes, we need to add a '+ 1' here.
>>
>> With the typos and this one fixed, this is
>>
>> Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>
>=20
> Thank you for fixing typo and Ack :)
>=20
> Thanks you,
 >
>>
>>> Thank you,
>>>
>>>> +	else
>>>> +		len =3D strnlen_user(vaddr, MAX_STRING_SIZE);
>>>>  =20
>>>>   	return (len > MAX_STRING_SIZE) ? 0 : len;
>>>>   }
>>>> @@ -213,6 +219,9 @@ process_fetch_insn(struct fetch_insn *code, stru=
ct pt_regs *regs, void *dest,
>>>>   	case FETCH_OP_IMM:
>>>>   		val =3D code->immediate;
>>>>   		break;
>>>> +	case FETCH_OP_COMM:
>>>> +		val =3D (unsigned long)current->comm;
>>>> +		break;
>>>>   	case FETCH_OP_FOFFS:
>>>>   		val =3D translate_user_vaddr(code->immediate);
>>>>   		break;
>>>
>>>
>>
>=20
>=20
as the original commit breaking $comm support was merged for v4.20=20
(which is a stable kernel) and the wrong behaviour with multiple strings =

exists in all longterm/stable releases (tested back to v4.4), do you=20
think this should be going into a stable release once it's merged?

I added Greg as he might know the answer to that.

Thanks,

Andreas


--------------ms070204080708090201020501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ELswggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJE
RTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRy
dXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQw
NzIyMTIwODI2WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZO
LVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xv
YmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTD
llA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1
OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8B
r3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9
bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSa
cXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBhjCCAYIwDgYDVR0PAQH/BAQD
AgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT
1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1UdIARbMFkwEQYPKwYBBAGB
rSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAQEEAwEwDwYNKwYB
BAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1odHRwOi8vcGtp
MDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEEbDBqMCwG
CCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEFBQcw
AoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhth
Jxb/w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvN
TVx07iHydQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEs
jmpttzUCGc/1OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6h
L5Kp2AvGhB8Exuse6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtU
FzCCBYUwggRtoAMCAQICBxekJTUNxL8wDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUx
EzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1W
ZXJlaW4gUENBIEdsb2JhbCAtIEcwMTAeFw0xNDA1MjcxNDU2MzdaFw0xOTA3MDkyMzU5MDBa
MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEo
MCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJa
RTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdl
bi5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALeM6O3UbAkUYBzi+4jBEF8F
klzGxWvAHHou8+iNKcRVMU9fMiuJ/n4KuH/3AgzGloyieClmOqe/KlIhWURtMwsOmD3rMclX
p9ilG7eIU70uE82az1Cw7N2V3o9tlIPlDH61ZXK8XCQO05u/zubqLREeOidcV+irlur548hu
y+iURMGuowGgH1tm9l1X3735XqkvkFwnUzUkhFiABwtajxIZ022gMCJba5RXj+LSZv+67MPT
qQmdoMf3WSs8zpM854+RSSPNbinKDo4KARkfaNkTib36HPMfMTu5ViBR5TIuRJ/gAHtV3YC+
Uccjpj/y4XUN+EoqsqODlFsVv994KAkCAwEAAaOCAgQwggIAMBIGA1UdEwEB/wQIMAYBAf8C
AQEwDgYDVR0PAQH/BAQDAgEGMBEGA1UdIAQKMAgwBgYEVR0gADAdBgNVHQ4EFgQU9HPz+sZC
s8ZcacBYvnQ4+WErjmIwHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwIgYDVR0R
BBswGYEXY2FAcnJ6ZS51bmktZXJsYW5nZW4uZGUwgYgGA1UdHwSBgDB+MD2gO6A5hjdodHRw
Oi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMD2g
O6A5hjdodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2Fj
cmwuY3JsMIHXBggrBgEFBQcBAQSByjCBxzAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNh
LmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2Eu
ZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAAvdv5tQXS8Y3D2t/HCEcmY7UzcK/b8XU6IY
0o8b25SNIVX0qkNyC6nkx2NJNpas2cCVs5PgKmAV59oCiNupcUBJ126wiTlzuy4wI1YSJgHw
PX0rEMLefI/6YAfxgCqH0fcRy0WS845CSZNY7raVwyZBjrvCYio0i2jmniSAT6RPfWATXsrB
l3gmfBtJ7OFt0l1zLeKhhPhMeIUMojGUKsdyMslBC6Qm5UDA/N683/eGCfk3KOwKVQZ06hml
bEDwfa8j70R3XFmOVDCKcXJWlTRA/TAExQCz4Y0AWoZJ76PdMzQtjIKpvBq2Kh4L8D5azsp0
lBqMJ/8X8jD51omx47cwggZVMIIFPaADAgECAgwclFi/j/PFlOAOvOwwDQYJKoZIhvcNAQEL
BQAwgaMxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2Vu
MSgwJgYDVQQKEx9Vbml2ZXJzaXRhZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRS
UlpFMQ8wDQYDVQQDEwZGQVUtQ0ExJjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFu
Z2VuLmRlMB4XDTE3MDExMDEzMDEzNVoXDTE5MDcwOTIzNTkwMFowgaAxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVybGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJp
Y2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxhbmdlbi1OdWVybmJlcmcxFTATBgNVBAsM
DEluZm9ybWF0aWsgNDEYMBYGA1UEAwwPQW5kcmVhcyBaaWVnbGVyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAmtyQgCgFPnLKIEH2ckMjkdT6/Z9QqAOAvLrD3CPGYVBjX60K
D/vNCSxjmiljAIgA12c8atTvXjm0MPicbp6G1HAwiOZHompyuab7gF8lMiR+6aQTNwawwMRY
lEeuXVxslwVu4kMu4N5AVid2VRgnodtMdEWzhlnRF1Z4wuY9egLYdZjVVJyWKPGDrgvREn9U
P5wjvR2IjnrrjXBcEb1StUIYnQGIWySb+TjNd+LAlFy6mBVWiDOaHZO7VTZmwQOl/ezw+8LZ
b7aVxTPZsJV/Jx4sNDt1XextSSCnGDYUVGSlOhNOeFzJufdNwW6O7ZlS/DT3d1/OLcjf37SA
XWB/qwIDAQABo4ICiDCCAoQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYPKwYB
BAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMC
BeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTgq5FcX/tTXVoT
pjxFcHQMQIw8NzAfBgNVHSMEGDAWgBT0c/P6xkKzxlxpwFi+dDj5YSuOYjA0BgNVHREELTAr
gRZhbmRyZWFzLnppZWdsZXJAZmF1LmRlgRF6aWVnbGVyQGNzLmZhdS5kZTCBnwYDVR0fBIGX
MIGUMEigRqBEhkJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3VuaS1lcmxhbmdlbi1udWVybmJl
cmctY2EvcHViL2NybC9jYWNybC5jcmwwSKBGoESGQmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUv
dW5pLWVybGFuZ2VuLW51ZXJuYmVyZy1jYS9wdWIvY3JsL2NhY3JsLmNybDCB7QYIKwYBBQUH
AQEEgeAwgd0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2
ZXIvT0NTUDBSBggrBgEFBQcwAoZGaHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktZXJsYW5n
ZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBSBggrBgEFBQcwAoZGaHR0
cDovL2NkcDIucGNhLmRmbi5kZS91bmktZXJsYW5nZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNl
cnQvY2FjZXJ0LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAeakOmEmyphLw/P5o/WzEtqrvAa1/
JhcrbhqS4z+3ffCBxr6vz0Corp4ZqRv5mZ4aPQtP65/w/n28lFQm3AphDnmZCvUB3bH21BM1
aHOU3vGPTjuK7Ae/E9m77CbVTqnpOed7Dg2mBgy2PcdWOlqoNweM8AWEb3thsPcCdk1AueqZ
3Mp89KOHzj5wklaDyaA2k+qJdsf9GSdvXvYmoF1g9RgPPVFhwjfmgsixfTYD69E9SNVWP56B
/iQBm3wPeU+C2e8JGbAnjEoS7mOvrloGqjfpsQ7vg8vYmMwd1fu1ImLrYfxMU3wPsnv1hOd+
uGVmBu8Qu8FqH8mmhbYmwiUiUDGCBE0wggRJAgEBMIG0MIGjMQswCQYDVQQGEwJERTEPMA0G
A1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0
IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYw
JAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0G
CWCGSAFlAwQCAQUAoIICaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0xOTAxMTcxMzQ0NDFaMC8GCSqGSIb3DQEJBDEiBCBmSE9ZS+vH2vbnRjTELH7LKGQu
75G3KN2row0a7ubMZzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIHFBgkrBgEEAYI3EAQxgbcwgbQwgaMxCzAJBgNVBAYTAkRFMQ8w
DQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2VuMSgwJgYDVQQKEx9Vbml2ZXJzaXRh
ZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRSUlpFMQ8wDQYDVQQDEwZGQVUtQ0Ex
JjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFuZ2VuLmRlAgwclFi/j/PFlOAOvOww
gccGCyqGSIb3DQEJEAILMYG3oIG0MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJu
MREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51
ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkB
FhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0GCSqGSIb3DQEBAQUA
BIIBAGXtxCGZ0IB9c4CFWyZ0ryAMNikiQgFbbfJxQsqoypEZOTwY7MnMy6S8cKXqAgR0BRIL
nworokN1+pZrqLFHTNjxFVxgtKXAq6pu2wylO9IFc3mKxm9HHC+oBiAAIdEvSCqas25Vo6n2
ib3+poVwHTwjrKhVLUpJMFX6MIoH6F1Q1VRQNJtUOSy5u4rcA5GOvPLmEFvwZS/JwBonnP4K
YmsEIABDDj50giXub4kEjSdPCD7QS/4FRHRqQHsgEEJmW8rJFV8rUDCdECilems3Wz26obqi
3dE7BpJ4CrZXhi2QKgM3Wvkkry47Wv9rQ+wnr3dqyuOXNVhA8HQXm4HyvSQAAAAAAAA=
--------------ms070204080708090201020501--
