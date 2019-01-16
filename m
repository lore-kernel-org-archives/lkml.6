Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="D0048m02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbfAPONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:13:45 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:37299 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404414AbfAPONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:13:43 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43fq1w2wj3zPkDb;
        Wed, 16 Jan 2019 15:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547648020; bh=Qn4ZAm4ZnD9clRQuO5XSzpyPUvbYoL90//Gi3fUfhxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=D0048m02WpTF9QQ4k7fHbekQ/dbI1xw2+yCNw+OdMJvYIQSgEJdDWYBfJY7uWOk0B
         DnCslVJEoTXvCOBgG9K+k+CTJMNkPTW1IBY4Quv0+U7f3I+20eRF5/oRZWtVhcXMLs
         zkNBJvY9u4RHCcEJnlDb3BjMf0MFthmAeRlIh+OwBSBIOKKXrAhRfH3xMQcgljVHil
         YElKgXVOjUpyoFyWqJMmHtfgyJM67p+6ym05FuX835d24sL5yl+9+rgdLTWtVSTRZZ
         SczQ6D82XExGF17GmsBAoOSiBG59JOITY7Zy6Qvqgk8TH1O92qjrEpmGUrjFvz0njS
         r2xE+DYgSI2HQ==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/BfgpubdDWQF2w7ZItr9z4CLjdGlOOFtA=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43fq1t0cq7zPjkn;
        Wed, 16 Jan 2019 15:13:38 +0100 (CET)
Subject: Re: [PATCH] tracing/uprobes: Fix output for multiple string arguments
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
References: <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
 <20190116094112.16043-1-andreas.ziegler@fau.de>
 <20190116084021.34b0beee@gandalf.local.home>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Message-ID: <a4f55c55-08fa-014d-d6bb-ba9229187901@fau.de>
Date:   Wed, 16 Jan 2019 15:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116084021.34b0beee@gandalf.local.home>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060009020303010003010500"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060009020303010003010500
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/16/19 2:40 PM, Steven Rostedt wrote:
> On Wed, 16 Jan 2019 10:41:12 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>=20
>> When printing multiple uprobe arguments as strings the output for the
>> earlier arguments would also include all later string arguments.
>>
>> This is best explained in an example:
>>
>> Consider adding a uprobe to a function receiving two strings as
>> parameters which is at offset 0xa0 in strlib.so and we want to print
>> both parameters when the uprobe is hit (on x86_64):
>>
>> $ echo 'p:func /lib/strlib.so:0xa0 +0(%di):string +0(%si):string' > \
>>      /sys/kernel/debug/tracing/uprobe_events
>>
>> When the function is called as func("foo", "bar") and we hit the probe=
,
>> the trace file shows a line like the following:
>>
>>    [...] func: (0x7f7e683706a0) arg1=3D"foobar" arg2=3D"bar"
>>
>> Note the extra "bar" printed as part of arg1. This behaviour stacks up=

>> for additional string arguments.
>>
>> The strings are stored in a dynamically growing part of the uprobe
>> buffer by fetch_store_string() after copying them from userspace via
>> strncpy_from_user(). The return value of strncpy_from_user() is then
>> directly used as the required size for the string. However, this does
>> not take the terminating null byte into account as the documentation
>> for strncpy_from_user() cleary states that it "[...] returns the
>> length of the string (not including the trailing NUL)" even though the=

>> null byte will be copied to the destination.
>>
>> Therefore, subsequent calls to fetch_store_string() will overwrite
>> the terminating null byte of the most recently fetched string with
>> the first character of the current string, leading to the
>> "accumulation" of strings in earlier arguments in the output.
>>
>> Fix this by incrementing the return value of strncpy_from_user() by
>> one if we did not hit the maximum buffer size.
>>
>> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
>> ---
>>   kernel/trace/trace_uprobe.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c=

>> index e335576b9411..dfb9bbc7fd82 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -160,6 +160,13 @@ fetch_store_string(unsigned long addr, void *dest=
, void *base)
>>   	if (ret >=3D 0) {
>>   		if (ret =3D=3D maxlen)
>>   			dst[ret - 1] =3D '\0';
>> +		else if (ret > 0)
>=20
> Do we need the ret > 0 check? What if the value is ""?
>=20
> Doesn't that cause the same issue?
>=20
> -- Steve
>=20

yes, it does. With this patch an empty string will also print "(fault)", =

I missed that, sorry. I'll send a v2.

Thanks,

Andreas

>> +			/*
>> +			 * Include the terminating null byte. In this case it
>> +			 * was copied by strncpy_from_user but not accounted
>> +			 * for in ret.
>> +			 */
>> +			ret++;
>>   		*(u32 *)dest =3D make_data_loc(ret, (void *)dst - base);
>>   	}
>>  =20
>=20


--------------ms060009020303010003010500
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
BTEPFw0xOTAxMTYxNDEzMzdaMC8GCSqGSIb3DQEJBDEiBCCloOntJFd3GAgdFGfiJ1KT0z6W
qegimUCZR9+IDImsmDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIHFBgkrBgEEAYI3EAQxgbcwgbQwgaMxCzAJBgNVBAYTAkRFMQ8w
DQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2VuMSgwJgYDVQQKEx9Vbml2ZXJzaXRh
ZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRSUlpFMQ8wDQYDVQQDEwZGQVUtQ0Ex
JjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFuZ2VuLmRlAgwclFi/j/PFlOAOvOww
gccGCyqGSIb3DQEJEAILMYG3oIG0MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJu
MREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51
ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkB
FhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0GCSqGSIb3DQEBAQUA
BIIBAFw2lF3ElWyg1IEZSFaXEInrJzQHC1mexvf22QUxtPaduqkLCyARLynmy68BdaAL8hSc
+2sbdIGcYfvsYiUV+vkOj4daALx6FylMm+SFhEHaY4Y/cDRg/aRBjrakD/Pher5QSIEpaVfJ
+1LiSSdbTQb8SfXTKDstjq06UYFHn6u4l12iSjmtJ17Nod5GCSC9gD8o7pEvrJ1lEarj/Ry1
DZzPzW1N4XyOeAX/mfMeXYow3tPjsJa7ikbVD3Y4ZDbLjV8hmlCvMqs4xuAOnCb1PywKMShu
QdxgoAyzvv9HjQxzOPYYUXdpoqu0Mux6JJycAGkcotMLVTE93UOIWG8y5QwAAAAAAAA=
--------------ms060009020303010003010500--
