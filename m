Return-Path: <BATV+fa3758ec04dcdc472965+5276+infradead.org+dwmw2@twosheds.srs.infradead.org>
X-Google-Smtp-Source: AH8x225L6Ec8DY+ngo2eSpcPgXSHP/NfOOm/feEb0OqFOlzaNyqeAjiH/z4+ENYS1jpz4B00zffI
ARC-Seal: i=1; a=rsa-sha256; t=1517570897; cv=none;
        d=google.com; s=arc-20160816;
        b=fmdhjP4sCvlKdF/D/Pg5b2AfQHpXRTPhA4MwIVGb8HjxzvNRyXR9U/fyYviLa5+QDO
         CEt47/za1uP64QYvWWgA26bygf699cDKr0zSgMLb+KxkVWkvUo1x3nsrvs7kVNNrtKAd
         kK56MuUAMEHrrdB/j7G3Qw8E23ew/LZCOKB/rWv4mVE3lixswXMTpqJ/E/gsaEgALtNA
         9W2Pv+GPpe8zGwZOScHjaaS7phD0RtOifQYtRcXR1jItjCdva7Hrwe7cJ/cciTWXmTjd
         zQOx+yL5wE50VHzm/Bqun5yjvQtcUMbc4/ubgklI+a+A/JgSt9SIVk9OELcTyIS/Mxzm
         MaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:face:references:in-reply-to:cc:to:from:subject
         :message-id:dkim-signature:arc-authentication-results;
        bh=tnzj0RvukCXkpjQx88hQwqiIGtlkv/+dopqjmRbitoI=;
        b=hCW2EtM1g8wDulRHAH1UkjbiC3mm+qOsmFa5N4VW2wFpm8Gcws08VKThQakyq3IZrt
         7oxB8puKBxq+7EGhCiCev3FpNPwf/MpAInMkReO8TJ1JYQD91e2DeeiYlLZsBMWpO7ei
         Dx0n5HYpv7lNxEIykw2XuARyclQbpS2vinVS+HGyT2V1T8H8ZDbNBWMir/tP2bzGY7dJ
         vF6N+1PflkK5uZMWwaswkEKhYEo4K+KxxMEoufmI+eXjfUpCvtayWWta3YFJklWTLA37
         AIQMVJbrRnZmkCD9fi18xsQg9DDRG+WYbIg0piqb9EEC9/HL72QPNbfnei9EiGwTDcY0
         745A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=twosheds.20170209 header.b=pBaohZkq;
       spf=pass (google.com: best guess record for domain of batv+fa3758ec04dcdc472965+5276+infradead.org+dwmw2@twosheds.srs.infradead.org designates 90.155.92.209 as permitted sender) smtp.mailfrom=BATV+fa3758ec04dcdc472965+5276+infradead.org+dwmw2@twosheds.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=twosheds.20170209 header.b=pBaohZkq;
       spf=pass (google.com: best guess record for domain of batv+fa3758ec04dcdc472965+5276+infradead.org+dwmw2@twosheds.srs.infradead.org designates 90.155.92.209 as permitted sender) smtp.mailfrom=BATV+fa3758ec04dcdc472965+5276+infradead.org+dwmw2@twosheds.srs.infradead.org
Message-ID: <1517570852.31953.13.camel@infradead.org>
Subject: Re: [PATCH v6 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
From: David Woodhouse <dwmw2@infradead.org>
To: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Asit Mallick <asit.k.mallick@intel.com>, Arjan Van De Ven
 <arjan.van.de.ven@intel.com>, Dave Hansen <dave.hansen@intel.com>, Andi
 Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Tim Chen
 <tim.c.chen@linux.intel.com>,  Thomas Gleixner <tglx@linutronix.de>, Dan
 Williams <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Greg KH <gregkh@linuxfoundation.org>,
 Andy Lutomirski <luto@kernel.org>,  Ashok Raj <ashok.raj@intel.com>
In-Reply-To: <1517522386-18410-5-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
	 <1517522386-18410-5-git-send-email-karahmed@amazon.de>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-DLZHqgCYNs+NBdhjqleo"
Date: Fri, 02 Feb 2018 11:27:32 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237580461918240?=
X-GMAIL-MSGID: =?utf-8?q?1591288421657914047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-DLZHqgCYNs+NBdhjqleo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-02-01 at 22:59 +0100, KarimAllah Ahmed wrote:

> [ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]
>=20
> Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
> guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
> be using a retpoline+IBPB based approach.
>=20
> To avoid the overhead of saving and restoring the MSR_IA32_SPEC_CTRL for
> guests that do not actually use the MSR, only start saving and restoring
> when a non-zero is written to it.
>=20
> No attempt is made to handle STIBP here, intentionally. Filtering STIBP
> may be added in a future patch, which may require trapping all writes
> if we don't want to pass it through directly to the guest.
>=20
> [dwmw2: Clean up CPUID bits, save/restore manually, handle reset]
>=20
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> v6:
> - got rid of save_spec_ctrl_on_exit
> - introduce msr_write_intercepted
> v5:
> - Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
> v4:
> - Add IBRS to kvm_cpuid_8000_0008_ebx_x86_features
> - Handling nested guests
> v3:
> - Save/restore manually
> - Fix CPUID handling
> - Fix a copy & paste error in the name of SPEC_CTRL MSR in
> =C2=A0 disable_intercept.
> - support !cpu_has_vmx_msr_bitmap()
> v2:
> - remove 'host_spec_ctrl' in favor of only a comment (dwmw@).
> - special case writing '0' in SPEC_CTRL to avoid confusing live-migration
> =C2=A0 when the instance never used the MSR (dwmw@).
> - depend on X86_FEATURE_IBRS instead of X86_FEATURE_SPEC_CTRL (dwmw@).
> - add MSR_IA32_SPEC_CTRL to the list of MSRs to save (dropped it by accid=
ent).

This looks very good to me now, and the comments are helpful. Thank you
for your persistence with getting the details right. If we make the SVM
one look like this, as you mentioned, I think we ought finally be ready
to merge it.

Good work ;)

--=-DLZHqgCYNs+NBdhjqleo
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDIxMTI3MzJaMC8GCSqG
SIb3DQEJBDEiBCDv3mHt3rNgBbyf5v46+BMNILuqgmPXu8cCKquK0w+54DCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBALOwCe+KB7o7
Qa+SyIL34mAXtkjUnRvd5+AFtCK2PwpEDlJTC8KGzqyKnpGxtvG+9Z7UyJt+Jb6SuIoJpHiuW3/w
0aBdTdzka5QIBBKBfRp/SPydWdlL23fXa1xWEbQXDfHJHL7jOuQBVjxtwRHP9R2H7DmTDqRtBNK4
qyUiyCd+/HgDvTEXdH8z5f5HscMDSpXrEHBp5Z56/7Xv6nSh83KrnTnu4pP6jOfw411yDuwXx1il
+ajo85lTtucq7YR/XK7IwY2wOpalkKwtxDDdXNbx1FbFNuQ8AfHuiFv3Ftv/QAkpgSCL+T+gOoMI
cz5BMnEoqKNz6WMKiFwPTtxpLvIAAAAAAAA=


--=-DLZHqgCYNs+NBdhjqleo--
