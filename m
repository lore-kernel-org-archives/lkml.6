Return-Path: <prvs=581a42071=dwmw@amazon.co.uk>
X-Google-Smtp-Source: AH8x224jmOaxFqxnbtHFE3yPkZJEybwMz6XrpnllRLgeCK91IF2tYxHYnTzjwLZ8XeHPPY1aQ9QF
ARC-Seal: i=1; a=rsa-sha256; t=1519050073; cv=none;
        d=google.com; s=arc-20160816;
        b=D1RElKzKAG6iT6bge5Sg3GU0ZuqzwkAt0Cz5jH/LFFUrMuTL8Hg/wgcHBS7OD3/FUm
         Ytsrg73Hyrgy4sZWHFf45khX0rcVdSRipX7oWalo8ikeXYZXc+iXLLmIq6xoSa8KHAqQ
         EeEzPUugvTfAVDsEWK1jRJAVoICGRsXWo7aSgOyjlfXK0qlSn/yYNVNf3lazczB2EzVS
         GAUd5TmF6qMKaoFngGQ0CKZnMjai6F9AkBs1MbRn+EY/e1WZJ4DMn9bbcR16xFqKE9bi
         vgrgv97Oo1pY/OG1aU9tLwZpV2ZrX1bKl/UxA8DE9ILNsMnVji/E18PAE/hxQYIuKPBs
         yQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:mime-version:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PYgsNbBqAdbA8XJIEQtJdflUSeWhnKWcbyjqOaDv55M=;
        b=Sntt34jfoJALP4SaP6BnZLT0fhEqF4sS3NH3xmClMVYx9kbd9H+QM7qGQPseS8LbQj
         uXembDDxg8DTG5QVrS2svoDymIHGmjdNotZd4Qsnf7Tm76N2Z1JerymMa53gYcnCLl+s
         aQLO9S1vlBx5Fj7IFR8cZIapdOXG1hanl89EYA3UO7/9gr6GRwOnho3ETQv28PcUXglX
         u83bA8TEQZ/xlcwf2Dz3dIPtFgqgtxE5gmgfnK5jEsYUpnaBqij0sGqNwgHdp43Q1AHb
         uo4dI8Gve752sQiGoJ/7UIHqpQKpARopuanw6m5lg3AvDXso4d2TEa6wJeDU82+EXMAD
         1yHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=VoPm6cnm;
       spf=pass (google.com: domain of prvs=581a42071=dwmw@amazon.co.uk designates 72.21.196.25 as permitted sender) smtp.mailfrom=prvs=581a42071=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=VoPm6cnm;
       spf=pass (google.com: domain of prvs=581a42071=dwmw@amazon.co.uk designates 72.21.196.25 as permitted sender) smtp.mailfrom=prvs=581a42071=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="5.46,535,1511827200";
   d="p7s'?scan'208";a="667459123"
Content-Type: multipart/mixed; boundary="===============8004706965984161412=="
MIME-Version: 1.0
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "arjan@linux.intel.com"
	<arjan@linux.intel.com>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "ak@linux.intel.com"
	<ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "riel@redhat.com"
	<riel@redhat.com>,
        "keescook@google.com" <keescook@google.com>,
        "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "pjt@google.com"
	<pjt@google.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>,
        "asit.k.mallick@intel.com"
	<asit.k.mallick@intel.com>,
        "gregkh@linux-foundation.org"
	<gregkh@linux-foundation.org>
Subject: Re: [RFC][PATCH] x86: proposed new ARCH_CAPABILITIES MSR bit for
 RSB-underflow
Thread-Topic: [RFC][PATCH] x86: proposed new ARCH_CAPABILITIES MSR bit for
 RSB-underflow
Thread-Index: AQHTp1t7jfq+/k+PH0SThe955lfQLqOryw8A
Date: Mon, 19 Feb 2018 14:21:10 +0000
Message-ID: <1519050070.7876.69.camel@amazon.co.uk>
References: <20180216191755.6F62DDEA@viggo.jf.intel.com>
In-Reply-To: <20180216191755.6F62DDEA@viggo.jf.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.60.116]
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592586608850569551?=
X-GMAIL-MSGID: =?utf-8?q?1592839449731421694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============8004706965984161412==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/x-pkcs7-signature"; boundary="=-VfJ9WjIp7m95q9HJ7aPw"

--=-VfJ9WjIp7m95q9HJ7aPw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDE4LTAyLTE2IGF0IDExOjE3IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToKPiAr
c3RhdGljIGJvb2wgY3B1X2hhc19yc2Jfb3ZlcnJpZGUodm9pZCkKPiArewo+ICvCoMKgwqDCoMKg
wqDCoHU2NCBpYTMyX2NhcCA9IDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYm9vdF9jcHVf
aGFzKFg4Nl9GRUFUVVJFX0FSQ0hfQ0FQQUJJTElUSUVTKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmRtc3JsKE1TUl9JQTMyX0FSQ0hfQ0FQQUJJTElUSUVTLCBpYTMyX2NhcCk7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCAvKiBSU0JPID09IFJTQiBPdmVycmlkZSAqLwo+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoaWEzMl9jYXAgJiBBUkNIX0NBUF9SU0JPKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsKClRoYXQgd291bGQgYmUgdGhlIHRoaXJkIHN1
Y2ggY29uc3RydWN0LiBBcyBzb21lIHBvaW50IHdlIHNob3VsZApwcm9iYWJseSBwdXQgdGhlIGJp
dHMgb2YgTVNSX0lBMzJfQVJDSF9DQVBBQklMSVRJRVMgaW50byBjcHVmZWF0dXJlcyBhCmJpdCBs
aWtlIHRoZSAnc2NhdHRlcmVkJyBDUFVJRCBiaXRzLgo=


--=-VfJ9WjIp7m95q9HJ7aPw
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
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMjE5MTQyMTEwWjAvBgkqhkiG9w0B
CQQxIgQgAZDOlcLDG+p7C8Kn17QqU6xcOZkI7MzZKgXzR0t+gY8wgb4GCSsGAQQBgjcQBDGBsDCB
rTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCkS0vfWDoftE5d06JC
cD1GMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUg
RW1haWwgQ0ECEQCkS0vfWDoftE5d06JCcD1GMA0GCSqGSIb3DQEBAQUABIIBAH1uEjrZxqAG26uo
kkoeymE7VXrce76yCtPCdiac903S6rRxmUoGG5BHXALdbWanAHI772CppyXiL7A9SeNJfAyNOGg5
39NJeIJigCjmx09biGOPh78qGIKzrsq7WcFtvNYDSvDhyoUufhxZgMyTxnhWi3XP00pCQP802NoR
yZlGSPBCrR0n4Vxj4B3TJj50qBN9Ta/jgtNbzoSZiey/VhX2fZ37sHSHsKXJ3uRSK6HcwxNP/NeC
IoxhLukS9jjMqIZfK0I7PLiYXgTkZKMNXgxD/OoJuWNWgbaN8PNj2/QMjSwa7MbSJ25zEZw+VM3j
s2XvypT0oJFGYhhq4aWYPzYAAAAAAAA=


--=-VfJ9WjIp7m95q9HJ7aPw--

--===============8004706965984161412==
Content-Type: multipart/alternative; boundary="===============4147220287252693457=="
MIME-Version: 1.0
Content-Disposition: inline

--===============4147220287252693457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



--===============4147220287252693457==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Web Services UK Limited. Registered in England and Wales=
 with registration number 08650665 with its registered office at 1 Principa=
l Place, Worship Street, London, EC2A 2FA, United Kingdom.<br><br><br>

--===============4147220287252693457==--

--===============8004706965984161412==--
