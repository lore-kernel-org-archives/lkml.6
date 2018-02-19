Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-154452-1519047355-2-7729188344450866703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Attached: smime.p7s
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519047354; b=gIN1pBwBkSrdxwF0xEha5O4UK9vXhQDekH38wBdCmk8k6M5
    OezJ682QsOCUeTOqdQt22njOtXSVsw9iPLgaI1Id6P71KrRJGhJKMVTVXs/VqFJN
    Jib31mRoL5/tXfS7LHoW7g7Qf+IT66lkj0jmxYYKoqqw1lDY3qR3Io2eejTXK390
    84nSnLNv0TuSL/Bl+ORn9mprutkLNapUPshHG+rHwnWhklRB8ytQVL5x7cC9GUC+
    AxjShR3VS4+tAJALAPqFWosREegGKY+R60x4sjnKRpXi8aDMDfY9zq2XcOTpCPxJ
    WmmC4rEUsaREsa9sPlAdl8BlTdC+kulyc+h4AOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:in-reply-to
    :references:content-type:date:mime-version:sender:list-id; s=
    arctest; t=1519047354; bh=AYo6ydBLiyP4+O7W1pAmTy/bKSMs7eWaxWArii
    ESG1k=; b=aVqGU9hWnXBDPHWL9IlGHaywktkeYLPPe2exXn4b5+MXMpcKuMAe+Q
    Q3pTdU9wS5R/VAkccdOzVUHBs5te0WkJ36eSKj2nu5WK5/ZUh9SnZNF38wfujNQk
    vFUjJyaWKyLNbNLlEBbhicDJXYQ9SbkTui+axygq3RshXmsYE1eFf+FmxygkdamP
    9nID0CXJMd9WJM/9KiXnzqNmFaMYRgnju07eOYEwlrBDsZQDN/796eY7l0BtKV4R
    gEqSj+AiYSXFCRQZZxooVPflHWXeajboHy4Qv5d7OH23pvzq2nhbk02pbnh7Ux/7
    hUfa9iW0LVaFEBS/1Muz1OuL7AxmhKUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=owB4UrhD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=twosheds.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=pass
    body.smime-identifier=dwmw2@infradead.org()
    body.smime-part=TEXT
    body.smime-serial=4d46113293f1d9ee768e7931d6af3b80
    body.smime-issuer="C=GB,CN=COMODO RSA Client Authentication and Secure Email CA,L=Salford,O=COMODO CA Limited,S=Greater Manchester"
    x-smime-valid-from="2017-12-20 19:00:00"
    x-smime-valid-to="2018-12-21 18:59:59";
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-smime-chain=info
    body.smime-part=TEXT
    x-smime-chain-identifier=null (COMODO RSA Client Authentication and Secure Email CA)
    x-smime-chain-serial=6a9be1383bff2b6b9f01d5d9b8a75256
    x-smime-chain-issuer="C=GB,CN=COMODO RSA Certification Authority,L=Salford,O=COMODO CA Limited,S=Greater Manchester"
    x-smime-chain-valid-from="2013-01-09 19:00:00"
    x-smime-chain-valid-to="2028-01-09 18:59:59"
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=owB4UrhD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=twosheds.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=pass
        body.smime-identifier=dwmw2@infradead.org()
        body.smime-part=TEXT
        body.smime-serial=4d46113293f1d9ee768e7931d6af3b80
        body.smime-issuer="C=GB,CN=COMODO RSA Client Authentication and Secure Email CA,L=Salford,O=COMODO CA Limited,S=Greater Manchester"
        x-smime-valid-from="2017-12-20 19:00:00"
        x-smime-valid-to="2018-12-21 18:59:59";
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-smime-chain=info
        body.smime-part=TEXT
        x-smime-chain-identifier=null (COMODO RSA Client Authentication and Secure Email CA)
        x-smime-chain-serial=6a9be1383bff2b6b9f01d5d9b8a75256
        x-smime-chain-issuer="C=GB,CN=COMODO RSA Certification Authority,L=Salford,O=COMODO CA Limited,S=Greater Manchester"
        x-smime-chain-valid-from="2013-01-09 19:00:00"
        x-smime-chain-valid-to="2028-01-09 18:59:59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeBSNfg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 08:35:36 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:58296 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSNff (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 08:35:35 -0500
Message-ID: <1519047329.7876.64.camel@infradead.org>
Subject: Re: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc: Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
In-Reply-To: <a4693ca3-face-e1f5-b619-74fc59870ce9@redhat.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
         <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
         <4be4e462-61be-53a9-b0e1-3508466d1645@redhat.com>
         <CALMp9eQQ-94g=fNanvwpr6b2pmH87RPGr6s9gOv43dUDABFuhw@mail.gmail.com>
         <a4693ca3-face-e1f5-b619-74fc59870ce9@redhat.com>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-8j9iP8j1h7rOJbUTkSU7"
Date: Mon, 19 Feb 2018 13:35:29 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-8j9iP8j1h7rOJbUTkSU7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2018-02-19 at 14:10 +0100, Paolo Bonzini wrote:
> > Hardware seems like a reasonable place to get the default value (cf.
> > the VMX capability MSRs).
>=20
> There are some differences:
>=20
> - a zero value for ARCH_CAPABILITIES should be safe, while a zero value
> for VMX capabilities doesn't really make sense.=C2=A0 On the contrary, a
> nonzero value for ARCH_CAPABILITIES is not safe across live migration.

Any VMM which is going to support live migration surely needs to pay at
least a small amount of attention to the features it exposes? Exposing
the ARCH_CAPABILITIES CPUID bit without actually looking at the
contents of the associated MSR which that bit advertises would be... a
little strange, would it not?=C2=A0

I don't see why we care so much about the *default* value, in that
context.
--=-8j9iP8j1h7rOJbUTkSU7
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEFQw
ggUxMIIEGaADAgECAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzEyMjEwMDAwMDBaFw0xODEyMjEyMzU5
NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDgzLNWa18DNpGUj/ZeH0Sgz53ESIbzdPw3OJeuNP6jZhxZojbyfxbM
hETscxI/Hj6UZ4a7sHm5BkVjlsB1Af2Za/PXUt8MmLAcPMHkMPGunvkUibEvblDvpqMkQZlaZM+t
5PqFmWkbehLaEvbpNY7dmEAAeKh4klTzJzrr5AAzaCQ32cA2e3+DEIv5O5l9ViMIjy/JM+xMQrfX
3PZ0chY1PaVWjg59d4Uno+5LRDbgCnPkKJX4ysBGadibjBGQGJEZCjh94iiEebn2KsRLvtrJ72Ph
3W2HDEdngW3YP0wujFQVs81U7L8XN3kdPRsa9zNqGtYQP/+1KMMJQ57hnfi9AgMBAAGjggHpMIIB
5TAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUpL+/5lli9jmj2KHj
ryyhnB2xRt0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUH
AwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEB
AgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8E
UzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKG
SWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAe
BgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQCK28BdbVJ9
QKQqTDfXwogAYiRBEGptfE1Bjy4F5vC6eWJqOJ15vunxjLwdbZYb4L0qrJlh+ZHHHlbIK8uEZu7N
XHUntmWMbGbZiu7JgrbSXJK1ct9gxrN/sdWYJ+JDjVHg7GfDTvTTPa26JMRqJsO1TjjyDX7A3K39
TjV8C0hqXvwF9BsNf+qBeWO6GVzJ5572awY221hc1umibmZaKV4fg+7fS7qscx5TSuIc6uvMBQhm
7NQiCq6euMMWBDUDlotQCDW0ilm0OuLW3IVLuZCm6Msc+6hT9+dCT4JUvxTHZnnO7uLCxV+Ujad+
PH3itRm38i96p2zvwgLr8vwWA0ckMIIFMTCCBBmgAwIBAgIQTUYRMpPx2e52jnkx1q87gDANBgkq
hkiG9w0BAQsFADCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcx
MjIxMDAwMDAwWhcNMTgxMjIxMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRl
YWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4MyzVmtfAzaRlI/2Xh9EoM+d
xEiG83T8NziXrjT+o2YcWaI28n8WzIRE7HMSPx4+lGeGu7B5uQZFY5bAdQH9mWvz11LfDJiwHDzB
5DDxrp75FImxL25Q76ajJEGZWmTPreT6hZlpG3oS2hL26TWO3ZhAAHioeJJU8yc66+QAM2gkN9nA
Nnt/gxCL+TuZfVYjCI8vyTPsTEK319z2dHIWNT2lVo4OfXeFJ6PuS0Q24Apz5CiV+MrARmnYm4wR
kBiRGQo4feIohHm59irES77aye9j4d1thwxHZ4Ft2D9MLoxUFbPNVOy/Fzd5HT0bGvczahrWED//
tSjDCUOe4Z34vQIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8Aw
HQYDVR0OBBYEFKS/v+ZZYvY5o9ih468soZwdsUbdMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYB
BQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FD
bGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkq
hkiG9w0BAQsFAAOCAQEAitvAXW1SfUCkKkw318KIAGIkQRBqbXxNQY8uBebwunliajideb7p8Yy8
HW2WG+C9KqyZYfmRxx5WyCvLhGbuzVx1J7ZljGxm2YruyYK20lyStXLfYMazf7HVmCfiQ41R4Oxn
w0700z2tuiTEaibDtU448g1+wNyt/U41fAtIal78BfQbDX/qgXljuhlcyeee9msGNttYXNbpom5m
WileH4Pu30u6rHMeU0riHOrrzAUIZuzUIgqunrjDFgQ1A5aLUAg1tIpZtDri1tyFS7mQpujLHPuo
U/fnQk+CVL8Ux2Z5zu7iwsVflI2nfjx94rUZt/Iveqds78IC6/L8FgNHJDCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4
A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1
nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0Zf
xcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2
jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO
4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY
7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNV
HRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRw
Oi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBx
BggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20w
DQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+39
4k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlx
Bhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7
vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANP
ECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72
uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9
mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iA
N2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQ
px9/s81rgzdEZOofSlZHynoSMYIDxzCCA8MCAQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCWCGSAFlAwQCAQUAoIIB6zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMTkxMzM1MjlaMC8GCSqG
SIb3DQEJBDEiBCALIvtqDZc4u+IDEY5cofNHX1zUmhRbZDsQJ9yhQ4qIpzCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBAFSE7G5sD2oc
uunW3YIQ6Qs5Il9X+0Z83Zvg+9XXF/KXoLKitXMQK38Drizh8cyPqYUnBk6gwyDwKoND53ELGI/L
WyXMQgQOLHD3b3QHImig7xCPMWbuVDKod60ixGRnil1a3rZs+L7ATx/Ki/MdWfofFSqiHO/NkomB
iswnWGUH/UUHPRRkZHsl4MiPJUWGU6mSAIXw5xd9ASzvaMJUE32zAPTI2Vd2yU5w++pDMdGvGWT5
Q/MlgJG/0SscGzx/HspS62RHYHGqkHM1psxpOhwmcg/770mIbuhOBGRFfGxCAErBi/Aep0xIS6hk
Z1qypQB/z6QGZ1Os1kNn7l/pS/IAAAAAAAA=


--=-8j9iP8j1h7rOJbUTkSU7--
