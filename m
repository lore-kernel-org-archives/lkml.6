Return-Path: <BATV+291f36d4f04074be2bcc+5281+infradead.org+dwmw2@twosheds.srs.infradead.org>
X-Google-Smtp-Source: AH8x226dSinq7cKArUgHnnpfplbCwJz8RmqltuTOMEL/kWU7km8rav6WlwggHM8BFX41x13Z5Sif
ARC-Seal: i=1; a=rsa-sha256; t=1518042566; cv=none;
        d=google.com; s=arc-20160816;
        b=OvrSkG6YLqFw/rvAUmyM/suh0zVhRe1LrzMyQ9Mbuz/nbg7lYnplfxhX9cy8FtuXo+
         jkqxQdZEcVl4qcrI+QPN3Z0Q312rCPdBKCEpiHiKc7sFajvMesx4+1LTp12i3dSt2b2s
         QHsFCdYIV9JWLzU+Dlb+1oeAyMz78x61W55CEU8dQQ+pBnKNYp2tOe+nb5WJNx/bl6zG
         I6gFqNk34fcuOljHia8bR8wDPNJueiuHnCWjYS+flZfM8CuFfYBjjOmSA7g6ir36Ij36
         lw3ppUwXqV3P0FaaDQVDyXGPjm6mdllikHIBaA6Betr8xR+2OHLhqqEfuf+UX9MVAOvn
         1fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:face:references:in-reply-to:cc:to:from:subject
         :message-id:dkim-signature:arc-authentication-results;
        bh=PlYfRAbxXFh9ABEl7BzjLxfimJ8O5p3rFS648TeqLj4=;
        b=bLh9P3YosApjeYomQEw8b2cLau8UOjI1uhTy3YgUVZz5Oee45h53F/qWuZbLYDcHU0
         QIDKnqiG6TQuaiTCYtR9IOziOFbwhoRbxYn0fJri6lqlqu6+QNR/M3PTBqCbGXaC5rVm
         jvUxjQUQ8LwgHA49aZti4nZNJtMcuU5Z/Qk2Zs1zdPYybeBFLY3+kbRFalTs1PgWrxZ5
         JeoKF9b8UabEd6ikHWZP1lcbG4GkjhnC36BIfUu6/h9n/+xp/07HdPlfYJ+YJLIG7Mz6
         WTm+URQWZ78HondBInQ7qsUr1HrDdBinpfKi1pDNw69g388gKm4NmPVMDIDk7Tp5eWW/
         UzrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=twosheds.20170209 header.b=eiQbMB3b;
       spf=pass (google.com: best guess record for domain of batv+291f36d4f04074be2bcc+5281+infradead.org+dwmw2@twosheds.srs.infradead.org designates 2001:8b0:10b:1:21d:7dff:fe04:dbe2 as permitted sender) smtp.mailfrom=BATV+291f36d4f04074be2bcc+5281+infradead.org+dwmw2@twosheds.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=twosheds.20170209 header.b=eiQbMB3b;
       spf=pass (google.com: best guess record for domain of batv+291f36d4f04074be2bcc+5281+infradead.org+dwmw2@twosheds.srs.infradead.org designates 2001:8b0:10b:1:21d:7dff:fe04:dbe2 as permitted sender) smtp.mailfrom=BATV+291f36d4f04074be2bcc+5281+infradead.org+dwmw2@twosheds.srs.infradead.org
Message-ID: <1518042518.3677.153.camel@infradead.org>
Subject: Re: [PATCH v2] x86/retpoline: Add clang support
From: David Woodhouse <dwmw2@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>,  gnomes@lxorguk.ukuu.org.uk, Rik van Riel
 <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>,  thomas.lendacky@amd.com, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Dave
 Hansen <dave.hansen@intel.com>, Kees Cook <keescook@google.com>,  Tim Chen
 <tim.c.chen@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>
In-Reply-To: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
References: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-In0ljkpwT05zHcVK5Gb0"
Date: Wed, 07 Feb 2018 22:28:38 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1591783000695160619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-In0ljkpwT05zHcVK5Gb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2018-02-07 at 13:52 -0800, Guenter Roeck wrote:
> clang has its own set of compiler options for retpoline support.
>=20
> Link: https://github.com/llvm-mirror/clang/commit/0d816739a82da29748caf88=
570affb9715e18b69
> Link: https://github.com/llvm-mirror/llvm/commit/fd5a8723ce9f2a6b250e8597=
2ef859e4253ea95d
> Link: https://github.com/llvm-mirror/llvm/commit/59b64490fda69d29bb42cfdf=
7eec37bcc31ff833
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: gnomes@lxorguk.ukuu.org.uk
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: thomas.lendacky@amd.com
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
> Cc: Paul Turner <pjt@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: llvm has been updated to use the same thunk names as gcc.
> =C2=A0=C2=A0=C2=A0=C2=A0Tested with:
> =C2=A0=C2=A0=C2=A0=C2=A0clang version 7.0.0
> 	(https://git.llvm.org/git/clang.git/
> 		848874aed95a913fb45f363120500cebfe54e2ef)
> 	(https://git.llvm.org/git/llvm.git/
> 		3afd566557f3616881505db0d69f5d19bf55ae14)
> =C2=A0=C2=A0=C2=A0=C2=A0cross-checked with gcc 7.3.0 (x86_64-linux-gcc.br=
_real (Buildroot
> =C2=A0=C2=A0=C2=A0=C2=A02018.02-rc1) 7.3.0).
>=20
> Tested with 64-bit builds only; 32-bit images fail to build with clang
> with various unrelated errors and are difficult to test.
>=20
> I had to change '+=3D' to '=3D' below since make otherwise sets
> RETPOLINE_CFLAGS to " ", and the subsequent ifneq would always match.
> This is also the reason for the "ifeq ($(RETPOLINE_CFLAGS),)".
> If there is another/different/better way to handle this, please let
> me know.

See
http://git.infradead.org/users/dwmw2/linux-retpoline.git/commitdiff/82a1f41=
600


> There are curently lots of warnings when building an image with clang.
>=20
> ./include/linux/init.h:134:6: warning:
> 	unknown attribute 'indirect_branch' ignored
>=20
> I was inclined to add "&& !defined(__clang__)" to the condition for the
> __noretpoline define to fix the problem, but concluded that this should
> be a separate patch unless it can be addressed in clang.

... where I fixed that too as well as providing the
__x86_indirect_thunk for 32-bit builds (which are broken for other
reasons anyway).

We do still need the %V asm constraint modifier to work in clang
though, because otherwise it still doesn't build if you have any
hypervisor guest support.

--=-In0ljkpwT05zHcVK5Gb0
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDcyMjI4MzhaMC8GCSqG
SIb3DQEJBDEiBCBSVDzWYkaY+Yt/6Nehk3LlKKCPiJZHg0gFG9cKhZdSiTCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBAJS8oocAyp7y
ugYxShh7LXC9hSOmqy5F8WcO64hREelwM1WJEyNLFmh+bOzlQhfakZ2FFMPkWWH3+XydhE/Vhsio
5g+HRpTPNwWGVLT+qRmlle92b5iXoCKETPY6kUFdor8q/ChhD/J+l4pxu/ydw1fsJKbPGRRzC2Hu
mKcZ+aaGb6qyp5LAmEzjUBEmzIz64QvVy1PB4fkmGHoyWLSuxPRK3jyN2ZgK19abnmQUWkR4f1tw
7OiWtQA56WmsMU9quOoJVVxRj74GoaHJInuYH0cg/RzP8eC3TjW5r031+Geh0UVo0vpnXy4rvid0
6WO3ioKQU+ZvRf4SkReE6lCjwIUAAAAAAAA=


--=-In0ljkpwT05zHcVK5Gb0--
