Return-Path: <prvs=593727dcc=dwmw@amazon.co.uk>
X-Google-Smtp-Source: AG47ELt2RzpC7CLGrcVOmVlNZmDq9YXIvOB6mc+IugXV+PI1cp6ppNFnQ4uhH5o6J0vBPMPZBQg7
ARC-Seal: i=1; a=rsa-sha256; t=1520077084; cv=none;
        d=google.com; s=arc-20160816;
        b=sPdyeNUC/HX60qe/FABAFqUwOy43tqJAdFwE7242Bbc6lw1OCxNJZUbNtU+PiZt7WT
         8qAOVwLSn7eVxc1fi0K1Sil7M7AAIt6KRNTBXmN9DepGGfMJpg+D0bjTTrutrGAEE6jZ
         1+WkSY6pWTUw9Oy25u37iSNO82fs7Bp6Qv4fVkygi8lnljrIFe86c2sQssiIB+jfAijO
         4FPrjQF8l7Uj91lxvHpDGBKqaKzgitppbHL7an6YP1BkJrL7waLfXdaqKELCJzEWIOzB
         AtPWN0DBV3jJ4y1ShuWDiUaSMWks88M/7dPNpZCzi3cLkSbKxX0zuimDViEWoX1WJ0bB
         S/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:mime-version:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :mime-version:dkim-signature:arc-authentication-results;
        bh=As9IY5rHXV5vmlNAt6Tb0sJ0mAl0tnt9jiTDWqf1gvU=;
        b=G3W0/VcKxMaQvpZnMNbqaQtD6wZM970QVAK0g4u1oKH3rtftHpK1zhu924m7nmLaj0
         G+1nJrUyA9+j9BzjHQ/g3xyHGQq6Z2elyqB+7o+D22W4ZMMWd84di1P0jz/veqA66qU7
         xqOHq81BnQpxrl36AaXubGmwcZ3mPVmdutpJAFGFjTuyWF1LH8GhhyAgKQ4XfFHDggkx
         R4u/QuQaCyEvvRGxqF6kkbadpFXXckBbzlYmrFLUsK2pC3KJatCGLkRoRaFQMUgg48jE
         +MtYOFAvMZRz/5pP+MK87E5kET469BT9L+cg6ALzHbixqEkzilygEp0L9wve+hIL4ter
         hDsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=MZtrH7he;
       spf=pass (google.com: domain of prvs=593727dcc=dwmw@amazon.co.uk designates 72.21.198.25 as permitted sender) smtp.mailfrom=prvs=593727dcc=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.co.uk header.s=amazon201209 header.b=MZtrH7he;
       spf=pass (google.com: domain of prvs=593727dcc=dwmw@amazon.co.uk designates 72.21.198.25 as permitted sender) smtp.mailfrom=prvs=593727dcc=dwmw@amazon.co.uk;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.co.uk
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="5.47,417,1515456000";
   d="p7s'?scan'208";a="710276917"
Content-Type: multipart/mixed; boundary="===============7353256177094947470=="
MIME-Version: 1.0
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "Raslan, KarimAllah" <karahmed@amazon.de>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com"
	<nadav.amit@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "riel@redhat.com"
	<riel@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "pbonzini@redhat.com"
	<pbonzini@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@intel.com"
	<dave.hansen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: Re: [PATCH 0/2] Backport IBPB on context switch to non-dumpable
 process
Thread-Topic: [PATCH 0/2] Backport IBPB on context switch to non-dumpable
 process
Thread-Index: AQHTss1QN1m3UrzBOUaJwGMCvDXcRaO+YomA
Date: Sat, 3 Mar 2018 11:37:56 +0000
Message-ID: <1520077075.7929.4.camel@amazon.co.uk>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
	 <20180303085454.GA23988@kroah.com>
In-Reply-To: <20180303085454.GA23988@kroah.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.61.91]
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593863143306630762?=
X-GMAIL-MSGID: =?utf-8?q?1593916348880823953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7353256177094947470==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/x-pkcs7-signature"; boundary="=-Z7kEP2drWRt5Nh7dR/J8"

--=-Z7kEP2drWRt5Nh7dR/J8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-03-03 at 09:54 +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 02, 2018 at 01:32:08PM -0800, Tim Chen wrote:
> >=20
> > Greg,
> >=20
> > I will like to propose backporting "x86/speculation: Use Indirect Branc=
h
> > Prediction Barrier on context switch" from commit 18bf3c3e in upstream
> > to 4.9 and 4.4 stable.=C2=A0=C2=A0The patch has already been ported to =
4.14 and
> > 4.15 stable.=C2=A0=C2=A0The patch needs mm context id that Andy added i=
n commit
> > f39681ed. I have lifted the mm context id change from Andy's upstream
> > patch and included it here.
>
> What does this patch "fix" in those older kernels?=C2=A0=C2=A0Is this a
> performance improvement or something else?

It's part of the Spectre variant 2 mitigation =E2=80=94 a full flush of the
branch prediction on context switch to a sensitive=C2=B9 process. It was th=
e
one I called out as "needs more attention" when I did the rest of the
retpoline etc backportingk, and Tim has now fixed it up. (Thanks).




=C2=B9 for now, "sensitive" means non-dumpable. This isn't perfect but it's
a reasonable approximation for now; it would be too expensive to do it
on *every* context switch. And for your purposes, the important part is
that it's what's upstream.
--=-Z7kEP2drWRt5Nh7dR/J8
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
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMzAzMTEzNzU1WjAvBgkqhkiG9w0B
CQQxIgQgBWWrtY9EBlqJhnhiaNCBz+sQJa7lnFpdrFJ4wh5z/4Awgb4GCSsGAQQBgjcQBDGBsDCB
rTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCkS0vfWDoftE5d06JC
cD1GMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0
ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUg
RW1haWwgQ0ECEQCkS0vfWDoftE5d06JCcD1GMA0GCSqGSIb3DQEBAQUABIIBAGbuJ8pKIFvfst78
3z7n+2a6KNZwV0qclJIR1qs+cauT2uNWEDNfFf1ynMYJhxlspkGYm6X/xtK5lmyvLC2Ex936bxaQ
NHJfQsTD1hOXfGPoI3hd2SbLWTznI3IHlLYgs+PeByIodL0FG5nKIkaIMUUWLMdFwv2LnPAjX1I/
XZRyB3+uG7iEZL5aBZzHAR+j4J9/EXmhGpo1p96LwNhCi1GSppcT79aPybumTIQK5mFjrOd3gPHQ
92PyHMK+rQKNzdLNaUc//6s42ygl4QIsuagzJEm/3j3QBb7wL8k/cBHdcs8wMtvHZH1IhgYMwNUT
dAoQrPSHx2uRrlPjNb8WdIoAAAAAAAA=


--=-Z7kEP2drWRt5Nh7dR/J8--

--===============7353256177094947470==
Content-Type: multipart/alternative; boundary="===============3329041558673815841=="
MIME-Version: 1.0
Content-Disposition: inline

--===============3329041558673815841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



--===============3329041558673815841==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Web Services UK Limited. Registered in England and Wales=
 with registration number 08650665 with its registered office at 1 Principa=
l Place, Worship Street, London, EC2A 2FA, United Kingdom.<br><br><br>

--===============3329041558673815841==--

--===============7353256177094947470==--
