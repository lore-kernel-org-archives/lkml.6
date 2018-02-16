Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966102AbeBPMKj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:10:39 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:42050 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965997AbeBPMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:10:31 -0500
Message-ID: <1518783021.7876.34.camel@infradead.org>
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Cc: Ingo Molnar <mingo@kernel.org>
In-Reply-To: <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
         <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
         <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
         <1518509708.12890.33.camel@infradead.org>
         <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
         <1518517262.12890.43.camel@infradead.org>
         <1518518198.12890.48.camel@infradead.org>
         <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
         <1518775136.7876.13.camel@infradead.org>
         <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com>
         <1518776517.7876.21.camel@infradead.org>
         <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-hNtnvu7IJ7EWRYYqbaRD"
Date: Fri, 16 Feb 2018 12:10:21 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hNtnvu7IJ7EWRYYqbaRD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-02-16 at 12:04 +0100, Paolo Bonzini wrote:
> On 16/02/2018 11:21, David Woodhouse wrote:
> >=20
> > Why? With IBRS_ALL the guest *never* gets to affect the actual hardware
> > MSR, which is always on. The MSR is purely an emulated no-op. Why does
> > that affect migration?
> Because even if the host has IBRS_ALL, as long as you want to migrate to
> a system without IBRS_ALL the guest will likely not have it.=C2=A0=C2=A0Y=
ou can
> fake IBRS_ALL on the older system after migration, and forcing the guest
> to always run with IBRS=3D1 even when in user mode; that is slow.=C2=A0=
=C2=A0Or...

No you can't; it's also a barrier. You can't just leave it on.

> > Even if the guest doesn't have/support IBRS_ALL, and is frobbing the
> > (now emulated) MSR on every kernel entry/exit, that's *still* going to
> > be a metric shitload faster than what it *thought* it was doing.
>
> ... you are making every kernel entry/exit 3 times slower by adding two
> KVM exits (both hypervisor traps and syscalls are in the 1000-1500 clock
> cycles ballpark).=C2=A0=C2=A0That cannot be fast at all.

I'm not convinced I care. It's still on a par with the performance of
*actually* frobbing IBRS every time. If the guest cares about
performance, they'll be using retpoline instead and not doing that.

We really don't want to penalise the *host*, and other guests, for one
guest which does stupid things.

And if we have a conditional 'set IBRS back on because we're using
IBRS_ALL and the guest had access to it' in the vmexit path, only the
*first* clause (IBRS_ALL) of that condition can be done with
alternatives. The other part is necessarily a runtime thing, and thus
needs the 'else lfence' to make sure it really happens, penalising
*all* guests. (Unless there's something else guaranteed to be
serialising in that path but after Arjan mentioned it last time I took
a quick look and didn't see anything unconditional).

An alternative would be to put the SPEC_CTRL MSR into the list of MSRs=C2=
=A0
to be automatically saved/reset at vmexit, but we've already carefully
*changed* from doing that for the non-IBRS_ALL case because doing it
manually in the host is faster. I don't know that we want that
additional complexity =E2=80=94 that might be the last straw that makes us =
tell
Intel "no, in that case we don't want IBRS_ALL as it is. Define a new
bit which is like IBRS_ALL but also promises that it's always like that
and the IBRS bit in the MSR is a no-op". That new bit would be set on
all future hardware except a small handful of current chips, I believe.

I think we can live with trapping and emulating SPEC_CTRL for the
guests which use it, for now.

If we *really* want to explore optimising it somehow, there's nothing
to prevent us doing that in a subsequent patch.
--=-hNtnvu7IJ7EWRYYqbaRD
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMTYxMjEwMjFaMC8GCSqG
SIb3DQEJBDEiBCAA/l5T1pNYo7WiieADhRx25c2OAcZcWK9vzjYmn4LhgDCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBAGHyRBC15sqK
SLPYIh9IAN0pFAPckxmJnN1lCo9JRzD3XGl9GXhpqrYqjdZiBiEVL/vpv0OtXpcH01lG7umXYXLI
8l+rpANTJOWOxnZnkEBpeXzN0FM5AiiWynO5xXd830T4Z7PF00tVzXwvLC5eqzx9Zqg7tluA0JXW
9LrORGwULULoHtMidpew1oUBGqr2Uxg7xy00gojaliuXqsuwzJG+8dldOYP8G94DokKJdwYF+LKX
nDCv/iSAA/YB4zO6ivb5JiHfOdkUw0S3c+A9F+r9vnTy9iidAj41IEmVmtv4vgpLTnvGX2SeHQ25
Nzjna754vpTZTsaXwT3UoICGVggAAAAAAAA=


--=-hNtnvu7IJ7EWRYYqbaRD--
