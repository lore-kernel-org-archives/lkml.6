Return-Path: <prvs=5999ce5a0=dwmw@amazon.co.uk>
X-Google-Smtp-Source: AG47ELtpwHYQG+O6TA6xhIas8aiXjrAnzMJ+kZCZwfCJmbYIIyJ+H8jqbZDcB+kLE7lT+R/G8DWm
ARC-Seal: i=1; a=rsa-sha256; t=1520609909; cv=none;
        d=google.com; s=arc-20160816;
        b=JsF3+ACJVxKskTAFLSKxT81Wfjm8GlYk6DCj3bQofV2l3vqrWNO42YwUtfTE4QW9Qq
         7PkfpTmkTaRXQPLTombiYu6HqLTt1r9FckZXMAolZ5dU/bzOfclTCRcMoIMjKawMeYB0
         WP5RW6HUqbZuyqgS8PEKOEPm32O9/ZsU1XFkh+TktCV0ILxbyU0+8EgmFnDV3OIVna5q
         AhpbnLtk7T91ZgSWAeJkeLaB4sVMQ618W9CJTCWZQeI41Xsf93CuePQ4G8ioxtLvYcwK
         h0WP5aO/WALni5lsJbizvo+zluFiSy89QIHrbWjF0xqseWTqPiu4kQq8CqqLnK9zudUu
         JDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:accept-language:in-reply-to:references:message-id:date
         :thread-index:thread-topic:subject:cc:to:from:mime-version
         :dkim-signature:arc-authentication-results;
        bh=educpAEtkBJ+JXFvqQq0BP032v76O5qRM34bJdzNbn8=;
        b=YvgDLKTxlk76mv70dHbED8X4wD1WHUW0PWqdBJKCmo8eLYBCpx//AID4AjFP6doX8W
         vG10c0nED1IeWAlAzgiU5HHuGlbQFfqFtP7UaYlsAIeuqWKdLIAcYqTzBrUkWOJFn22R
         h1gTYxnr/Pb0l3DhXuOf7nJjIzSBwQkfFcjGWQV+6qbL57vj3qCCxiiN9JtvTn3NT/yL
         8NeVG7HfNee5ecLhoGMAb9cmypU3QrNBV7w96HZ5+5ig6CXQfhmcPyANYZXKl8DIFXCd
         lN00ZJzsAi75W4lim9Dgh5wvOnxZ2i/dUcXJe8xwdIOQIvCG/+QeD87EAXvBdpU0qa/J
         FaRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=r8KmxxWm;
       spf=pass (google.com: domain of prvs=5999ce5a0=dwmw@amazon.co.uk designates 207.171.184.25 as permitted sender) smtp.mailfrom=prvs=5999ce5a0=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=r8KmxxWm;
       spf=pass (google.com: domain of prvs=5999ce5a0=dwmw@amazon.co.uk designates 207.171.184.25 as permitted sender) smtp.mailfrom=prvs=5999ce5a0=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="5.47,446,1515456000";
   d="p7s'?scan'208";a="726698254"
Content-Type: multipart/mixed; boundary="===============6602210368488092112=="
MIME-Version: 1.0
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "ak@linux.intel.com" <ak@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com"
	<jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "riel@redhat.com"
	<riel@redhat.com>,
        "keescook@google.com" <keescook@google.com>,
        "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "pjt@google.com"
	<pjt@google.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jikos@kernel.org"
	<jikos@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "gregkh@linux-foundation.org" <gregkh@linux-foundation.org>
Subject: Re: x86/retpoline: Fill RSB on context switch for affected CPUs
Thread-Topic: x86/retpoline: Fill RSB on context switch for affected CPUs
Thread-Index: AQHTt6hcoCPlo5CfOUaH8xuKc2RBiqPIA1EAgAAGIoA=
Date: Fri, 9 Mar 2018 15:38:22 +0000
Message-ID: <1520609785.17937.50.camel@amazon.co.uk>
References: <1515779365-9032-1-git-send-email-dwmw@amazon.co.uk>
	 <f2faf9ff-8955-d8b5-c521-91b9c273128b@maciej.szmigiero.name>
	 <20180309151428.GE22087@tassilo.jf.intel.com>
In-Reply-To: <20180309151428.GE22087@tassilo.jf.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.60.116]
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589409875989472083?=
X-GMAIL-MSGID: =?utf-8?q?1594475056804924257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6602210368488092112==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/x-pkcs7-signature"; boundary="=-d9OQBxs7drt03qmHddFR"

--=-d9OQBxs7drt03qmHddFR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-03-09 at 07:14 -0800, Andi Kleen wrote:
> >=20
> > Shouldn't the RSB filling on context switch also be done on non-
> > IBPB
> > CPUs to protect (retpolined) user space tasks from other user space
> > tasks?
> The comment is actually incorrect. There's no risk to hit user space
> addresses if we have KPTI and NX (which is fairly universal).

... on non-AMD CPUS.

The comment does say "If we don't have SMEP or KPTI".

> It's mainly needed on Skylake era CPUs.

I wouldn't have added it if it were only for Skylake. We still have no
coherent overall mitigation for Skylake except the original IBRS setup.

Did anyone ever get any further with the call stack counting hacks?


Maciej, you might be right that to protect userspace processes from
each other we should also flush the RSB on context switch to a
"sensitive" process.
--=-d9OQBxs7drt03qmHddFR
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEE4w
ggUuMIIEFqADAgECAhEApEtL31g6H7ROXdOiQnA9RjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcxMjIxMDAwMDAwWhcNMTgxMjIxMjM1
OTU5WjAiMSAwHgYJKoZIhvcNAQkBFhFkd213QGFtYXpvbi5jby51azCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAKdGKgXuwKMg2r+i/4BZZC0ddRxNq3xIKTakie/VCSzoO7P17A36ZzUc
VMEYPfqDt/65xoc6Tdih+qkY2pNDppZ1DZ8mVrAX6O2O60ZhmXB60wMoDvXPZInvkMOW4drqnje/
7/NOypn/XQAY+ln4KT+3tHG3TfryyJFMedqC/r29KJlCeeCxIzdtq2j5mN42tvPVv4+p+Kr77uui
GOASNdFJbNdgx7UGF+il6kRGSle17LJZKMgRiLJXYjECwnGwdfLdN5SINWD5IC3yXY8d14Bq6DyD
jNts1DFw+SKhW8kVFYRZpv7TE3/42QJKQVL6YWka5T4EJO7AD3gy2ypRsd8CAwEAAaOCAecwggHj
MB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBT/vhvBExl2wDr8f50u
b+0yzFyZRjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcD
BAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQEC
AQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoGA1UdHwRT
MFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRp
Y2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJ
aHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRT
ZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMBwG
A1UdEQQVMBOBEWR3bXdAYW1hem9uLmNvLnVrMA0GCSqGSIb3DQEBCwUAA4IBAQCK2HofespbCaDu
udwwfh8GxDpVUnVbZZVWScpZMxfYpXzLot7L6iZrr16oMQ+UOiDDAK6/D3+u2QN8u0lJ6yLKVmvh
lGOzDywGsyG2Ohy8Dt5jcEK5sz84OsPtrRH7ahZHLxYPhWlUKOjOPN6sb9h6uMYlXmG/KmAr2rwF
exN6Zrwh6YwF7ukuMs175YcNyYRdB8kVYq3WikfbTHOoRbJiu9Unw7LqnvPTfx+xUvD6aN2CKLtr
mactWbk98swNgbI18UWjfEpugvAqw09CDLjeq7N1v0SkUkQEDqGSUE+hKFryTNXtZ6zOfl+MQfD8
U7T5oJa34DmWXK9+x7dl+MrqMIIFLjCCBBagAwIBAgIRAKRLS99YOh+0Tl3TokJwPUYwDQYJKoZI
hvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01P
RE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE3MTIy
MTAwMDAwMFoXDTE4MTIyMTIzNTk1OVowIjEgMB4GCSqGSIb3DQEJARYRZHdtd0BhbWF6b24uY28u
dWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnRioF7sCjINq/ov+AWWQtHXUcTat8
SCk2pInv1Qks6Duz9ewN+mc1HFTBGD36g7f+ucaHOk3YofqpGNqTQ6aWdQ2fJlawF+jtjutGYZlw
etMDKA71z2SJ75DDluHa6p43v+/zTsqZ/10AGPpZ+Ck/t7Rxt0368siRTHnagv69vSiZQnngsSM3
bato+ZjeNrbz1b+Pqfiq++7rohjgEjXRSWzXYMe1BhfopepERkpXteyyWSjIEYiyV2IxAsJxsHXy
3TeUiDVg+SAt8l2PHdeAaug8g4zbbNQxcPkioVvJFRWEWab+0xN/+NkCSkFS+mFpGuU+BCTuwA94
MtsqUbHfAgMBAAGjggHnMIIB4zAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNV
HQ4EFgQU/74bwRMZdsA6/H+dLm/tMsxcmUYwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAw
IAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNV
HSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21v
ZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01P
RE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcB
AQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAcBgNVHREEFTATgRFkd213QGFtYXpvbi5jby51azANBgkqhkiG9w0B
AQsFAAOCAQEAith6H3rKWwmg7rncMH4fBsQ6VVJ1W2WVVknKWTMX2KV8y6Ley+oma69eqDEPlDog
wwCuvw9/rtkDfLtJSesiylZr4ZRjsw8sBrMhtjocvA7eY3BCubM/ODrD7a0R+2oWRy8WD4VpVCjo
zjzerG/YerjGJV5hvypgK9q8BXsTema8IemMBe7pLjLNe+WHDcmEXQfJFWKt1opH20xzqEWyYrvV
J8Oy6p7z038fsVLw+mjdgii7a5mnLVm5PfLMDYGyNfFFo3xKboLwKsNPQgy43quzdb9EpFJEBA6h
klBPoSha8kzV7Weszn5fjEHw/FO0+aCWt+A5llyvfse3ZfjK6jCCBeYwggPOoAMCAQICEGqb4Tg7
/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
dGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTEzMDEx
MDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVy
IE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVk
MT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4A5jTxhh2
IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1nxdlYCeX
IoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0ZfxcBa39V0
wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2jqPMLxFN
e1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO4nLUXk0B
OSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7NkyMtQw
HQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
CDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEF
BQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUFk
ZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJKoZI
hvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo7EIMERoh
42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+394k+z3ZBy
WPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlxBhh7ETrN
543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7vODqzCM6
ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANPECTQdu9v
WPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72uYRBcunw
wH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9mB12D4ln
9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iAN2ZBXFiR
mjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQpx9/s81r
gzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
dGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBAhEApEtL31g6H7ROXdOiQnA9RjANBglghkgBZQMEAgEFAKCCAe0wGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMzA5MTUzNjI1WjAvBgkqhkiG9w0B
CQQxIgQgXhCadcSzxcxI1CdMFBQgkEERIQv5tSWkLI/ViavkqQMwgb4GCSsGAQQBgjcQBDGBsDCB
rTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCkS0vfWDoftE5d06JC
cD1GMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUg
RW1haWwgQ0ECEQCkS0vfWDoftE5d06JCcD1GMA0GCSqGSIb3DQEBAQUABIIBABk5t2rk20zXoq3C
YwdkxkLa205huxUZBUpR/u4x8SAypZcdNXFEOJD8lCSF36IcktJrzxaiCKeM8UBUtO+ms0WVAv43
u1dPFX6Pzfjh3mXQjODpNDtcFNMT5+wNzv4VUL+6Nw33R+F5NJc0zeRhinJlKS04Rk1CA2DdzspA
VaoOa1BYqEBl+KC1aaz4iTITgcTL/y8hXOvKJSMtyMYzgOhbyvIPsHSEKFJdYBcIYqnJe2aXDxI/
m75R8KFqyD6Fnx9RZC3zC+bpXGC/2AC2x7RFe+JkjSCaL9MwpnLtCDg0ScAviFAnOvcxep+N1f2+
WRwPnYPd/Gh5xatwarwat04AAAAAAAA=


--=-d9OQBxs7drt03qmHddFR--

--===============6602210368488092112==
Content-Type: multipart/alternative; boundary="===============8995464109475085256=="
MIME-Version: 1.0
Content-Disposition: inline

--===============8995464109475085256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



--===============8995464109475085256==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Web Services UK Limited. Registered in England and Wales=
 with registration number 08650665 with its registered office at 1 Principa=
l Place, Worship Street, London, EC2A 2FA, United Kingdom.<br><br><br>

--===============8995464109475085256==--

--===============6602210368488092112==--
