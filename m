Return-Path: <david@woodhou.se>
X-Google-Smtp-Source: AH8x224+twDk4kfbqDG8x0T0X9HKPvDXI3x1DHSBWFyFEengZV6O3C3OIaj5wfk6LHSbDaTzwxS1
ARC-Seal: i=1; a=rsa-sha256; t=1517950380; cv=none;
        d=google.com; s=arc-20160816;
        b=lgXIbVH0LSZuoKZn5tWAwShAjayuLi4+zL9jd6mHH7oey7tSNu8fcdHl6SRDV53UYj
         442JKo/L4HB5YVQ77t6rOgEQcVmmQRnAkFoJjuL36Q9YoLmjjIE664hcxqgj8n1wUEm8
         3dObX6q8x65x2apV5YgbdFAhnrbeS5xQVxe7hUW+iEMfwJQkLcLP8t1yhQPTUkx4IMYV
         Be6IO6qjrYr9I0fq9POvToxm3y5Uvi9qacR3ezuBoVb/aQ1M19Fv2xoUh5gMxE4v2anI
         RxTd+5qAcLTekTNw4qx3KUNF9uRfYNWBx5goGwgmH+XvmcB+X+ORoR+ZjmL11gunafW5
         nFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:face:references:in-reply-to:cc:to:from:subject
         :message-id:dkim-signature:arc-authentication-results;
        bh=qSyWeN0m84AAgokJWdEeIBPp0skHKxauGBo1my6mYcw=;
        b=FdO3SzBVFY45oSRsD8IzsxKcwxLPLgchGlfnh9VGBN/NFOjZKFvvF3/zhFxibCLjgx
         ApZ6ifhJYWI3uvidxQP/xHEqoruLY7v7GVyhmavQob9bif+V5VdXmSOadXhEUDhrhgQw
         iomVAuH3R9OH+VgWfelKPN4Jza/Gyhf78UkZaMxqFKDXwiLaB9ScYuykLpwdXg16IBIN
         w4e3sU4mtEnoq/u0EV1DvzupK4Uxjkh7dkoqTO8ZkC+t7sNC/sFD+38U2iJV0xUpIknI
         ye1T+y9kM/Ryhsax4TJCALFAUIMhsO4vOv7Pk8pBTvNCbOIgB4+yxFEJMIchuWaMeIp1
         XGKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@woodhou.se header.s=twosheds.20170209 header.b=cmEgFbRT;
       spf=neutral (google.com: 2001:8b0:10b:1:21d:7dff:fe04:dbe2 is neither permitted nor denied by best guess record for domain of david@woodhou.se) smtp.mailfrom=david@woodhou.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@woodhou.se header.s=twosheds.20170209 header.b=cmEgFbRT;
       spf=neutral (google.com: 2001:8b0:10b:1:21d:7dff:fe04:dbe2 is neither permitted nor denied by best guess record for domain of david@woodhou.se) smtp.mailfrom=david@woodhou.se
Message-ID: <1517950341.3677.27.camel@woodhou.se>
Subject: Re: [RFC] x86/retpoline: Add clang support for 64-bit builds
From: David Woodhouse <david@woodhou.se>
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
In-Reply-To: <20180206203218.GA11026@roeck-us.net>
References: <1517614240-31269-1-git-send-email-linux@roeck-us.net>
	 <20180206203218.GA11026@roeck-us.net>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-bGSWtZKA9dRumKOPehNB"
Date: Tue, 06 Feb 2018 20:52:21 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591333873946801262?=
X-GMAIL-MSGID: =?utf-8?q?1591686337975160757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-bGSWtZKA9dRumKOPehNB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-06 at 12:32 -0800, Guenter Roeck wrote:
>=20
> >=C2=A0
> Feedback, anyone ?
>=20
> I understand that there is no love for the ABI differences between clang
> and gcc, but that doesn't help me. Even if the patch is unacceptable
> as-is, I would like to have some feedback to get an idea if I am on the
> right track, and what I would have to change to at least move into the
> right direction.

I'm going for just a comprehensive NACK. If they fix clang so that at
least the thunk symbols __x86_indirect_thunk_\reg are compatible, then
we could tolerate command line differences. Otherwise, just no.

Unless you really fancy trying to do some kind of alias hack in modules
so that they link to the external thunk by its proper name, even when
built with clang? I reserve the right to hate that too.

--=-bGSWtZKA9dRumKOPehNB
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEEow
ggUsMIIEFKADAgECAhEA9ZDpDf4kaqsgeKPMYkVQ6TANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcxMjIxMDAwMDAwWhcNMTgxMjIxMjM1
OTU5WjAhMR8wHQYJKoZIhvcNAQkBFhBkYXZpZEB3b29kaG91LnNlMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAsBVjYH5kFEalYHmtKg/8hdcqSItn6OthZem3CrU0/he9fK6DMfXw8z+i
BmYW+N5AirTPpwcufTLhJtp/B/ntuLVHf/rSJcHy7na2Ok26y1zayaua4Z210rhtxe4ptLThTDtm
iOTDnt/gCxiLJSZTC973kojSJs0swj1CSHnDLmLfVW7uJR9Zi91sVKrXfyY+AeAGBnRqbeYOx/xd
nwPh1sjMB6PKhxbGx37NE9cSD7MEgPn+fUh7UHRwlMQNFCl3TxTxMm/Uqc/P+edJGsROHwct6zza
vPIGsDrJY6sG093r7bZ2ZyOk5pYIZdyuSl3deMI3yJ3PZ6Vl1i4u97tQTwIDAQABo4IB5jCCAeIw
HwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFABDmnCk7KQSF/cC7zRB
l5hqtLaQMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwME
BgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIB
AQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMw
UTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNl
Y3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wGwYD
VR0RBBQwEoEQZGF2aWRAd29vZGhvdS5zZTANBgkqhkiG9w0BAQsFAAOCAQEAIhMBBm2DGjw+t7Tk
1FejWOAaDU7KW0Ew4dbKYl+48UzS7OvAf3Z6saJ17EauFovjf3MfM4bXwdqTHnUb2qfXhlmIB4gd
PQvJfB+MRkmIbPe9w5FvHInm7ix776MQxerJzG//s3BLPjNL9CcIXMUCYm3vWrxTg5A/ecsKKMm1
Sw/AGKYykPP5OLkwlnCw++U64cJig9BvImHZk9v0juz4FM0E/kB7WBZy+ysJDOX3/fG2KhpMGg1P
VVl59I8avM8nwnPwVynA/67xYYzN4gO+sSVg1Cb3sDVCo2zxQz4+tKHcE8LVn8pjlwDYMVoqk6N3
rvmo4leA2SjD8zNYMXzdLzCCBSwwggQUoAMCAQICEQD1kOkN/iRqqyB4o8xiRVDpMA0GCSqGSIb3
DQEBCwUAMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzEyMjEw
MDAwMDBaFw0xODEyMjEyMzU5NTlaMCExHzAdBgkqhkiG9w0BCQEWEGRhdmlkQHdvb2Rob3Uuc2Uw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwFWNgfmQURqVgea0qD/yF1ypIi2fo62Fl
6bcKtTT+F718roMx9fDzP6IGZhb43kCKtM+nBy59MuEm2n8H+e24tUd/+tIlwfLudrY6TbrLXNrJ
q5rhnbXSuG3F7im0tOFMO2aI5MOe3+ALGIslJlML3veSiNImzSzCPUJIecMuYt9Vbu4lH1mL3WxU
qtd/Jj4B4AYGdGpt5g7H/F2fA+HWyMwHo8qHFsbHfs0T1xIPswSA+f59SHtQdHCUxA0UKXdPFPEy
b9Spz8/550kaxE4fBy3rPNq88gawOsljqwbT3evttnZnI6Tmlghl3K5KXd14wjfInc9npWXWLi73
u1BPAgMBAAGjggHmMIIB4jAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4E
FgQUAEOacKTspBIX9wLvNEGXmGq0tpAwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYD
VR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAE
PzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8u
bmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9S
U0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/
MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1
dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3Nw
LmNvbW9kb2NhLmNvbTAbBgNVHREEFDASgRBkYXZpZEB3b29kaG91LnNlMA0GCSqGSIb3DQEBCwUA
A4IBAQAiEwEGbYMaPD63tOTUV6NY4BoNTspbQTDh1spiX7jxTNLs68B/dnqxonXsRq4Wi+N/cx8z
htfB2pMedRvap9eGWYgHiB09C8l8H4xGSYhs973DkW8ciebuLHvvoxDF6snMb/+zcEs+M0v0Jwhc
xQJibe9avFODkD95ywooybVLD8AYpjKQ8/k4uTCWcLD75TrhwmKD0G8iYdmT2/SO7PgUzQT+QHtY
FnL7KwkM5ff98bYqGkwaDU9VWXn0jxq8zyfCc/BXKcD/rvFhjM3iA76xJWDUJvewNUKjbPFDPj60
odwTwtWfymOXANgxWiqTo3eu+ajiV4DZKMPzM1gxfN0vMIIF5jCCA86gAwIBAgIQapvhODv/K2uf
AdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
KzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAw
MDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7
BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMl
eQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy
/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2Q
ZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP
1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG
3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYB
Af8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEB
BGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1
c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0B
AQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAY
ayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51
csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9
DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2
HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1
IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9y
I+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBz
sLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ
6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk
6h9KVkfKehIxggPKMIIDxgIBATCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQD1kOkN/iRqqyB4o8xiRVDpMA0GCWCGSAFlAwQCAQUAoIIB7TAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDYyMDUyMjFaMC8GCSqGSIb3DQEJBDEi
BCAsZ5gwv8lzMpzhofoqJzrN7Khx83Grkt2M3am7YNkVijCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPWQ6Q3+JGqrIHijzGJFUOkw
gcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBN
YW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9
MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFp
bCBDQQIRAPWQ6Q3+JGqrIHijzGJFUOkwDQYJKoZIhvcNAQEBBQAEggEAXFBUSTYyYGypIxEhWEDI
OOI6HOIAsV5lExY5sdThdJqo4zssaUchTa8i1izE5Kpvg/GtV/8OgoHJ79dD8g8qilhahhy2Gvhh
wN3/x+HYiQetk8jXI3OJkoup/bTmTM6tHF2Mk4dFa75lmzolyAcLZCtFE3gDIQHGKqJqxMdUfP1E
+0iGQMS5cxdgO203VviVgdPaSwnu6QYR8gL/I2lPET7sdwsBLDF0FasuJoSgk/5mls1MkSLZq6cY
hY7omrftRWgeU14QZtVOAMg1o8aVg9QO3JOPgZCOVq38qhd9pyRTczFxrO5trn0W7lZrx7EdJsA2
8EH2QcXQ6pX9t/JXFAAAAAAAAA==


--=-bGSWtZKA9dRumKOPehNB--
