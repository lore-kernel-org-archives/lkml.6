Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF81C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAWQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:25:06 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59515 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfAWQZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:25:06 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2D5A120135342E;
        Wed, 23 Jan 2019 17:25:03 +0100 (CET)
Subject: Re: ipmi_si: 90 s delay in system start with 4.14.94, but not 4.18.6
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Cc:     it+lkml@molgen.mpg.de
References: <8520014d-6805-ce87-143d-fffbeb94d11d@molgen.mpg.de>
 <78de72f8-e218-f91f-97b2-768ff5a920e4@acm.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <9ca94005-e2e4-cd5a-67bd-30c3d8680281@molgen.mpg.de>
Date:   Wed, 23 Jan 2019 17:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78de72f8-e218-f91f-97b2-768ff5a920e4@acm.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090708040203090906000602"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090708040203090906000602
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Corey,


On 01/22/19 21:58, Corey Minyard wrote:
> On 1/22/19 10:17 AM, Paul Menzel wrote:

>> Using Linux 4.14.94 on a HP EliteDesk 705 G4 MT desktop system, there
>> is a 100 s delay during boot.
>>
>> ```
>> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 4.14.94.mx64.239 (root@x.m=
olgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Mon Jan 21 11:39:45 CET 20=
19
>> [=E2=80=A6]
>> [=C2=A0=C2=A0=C2=A0 3.263092] ipmi message handler version 39.2
>> [=C2=A0=C2=A0=C2=A0 3.263520] ipmi device interface
>> [=C2=A0=C2=A0=C2=A0 3.263893] IPMI System Interface driver.
>> [=C2=A0=C2=A0=C2=A0 3.264325] ipmi_si 0000:06:00.3: probing via PCI
>> [=C2=A0=C2=A0=C2=A0 3.264804] ipmi_si 0000:06:00.3: [io=C2=A0 0x3000-0=
x30ff] regsize 1 spacing 1 irq 39
>> [=C2=A0=C2=A0=C2=A0 3.265496] ipmi_si: Adding PCI-specified kcs state =
machine
>> [=C2=A0=C2=A0=C2=A0 3.266019] ipmi_si: Trying PCI-specified kcs state =
machine at i/o address 0x3000, slave address 0x0, irq 39
>> [=C2=A0=C2=A0=C2=A0 4.255042] tsc: Refined TSC clocksource calibration=
: 3593.250 MHz
>> [=C2=A0=C2=A0=C2=A0 4.255618] clocksource: tsc: mask: 0xffffffffffffff=
ff max_cycles: 0x33cb6addeae, max_idle_ns: 440795225061 ns
>> [=C2=A0=C2=A0=C2=A0 5.264130] clocksource: Switched to clocksource tsc=

>> [=C2=A0 104.978023] ipmi_si 0000:06:00.3: There appears to be no BMC a=
t this location
>> [=C2=A0 104.978658] IPMI Watchdog: driver initialized
>> [=C2=A0 104.979095] Copyright (C) 2004 MontaVista Software - IPMI Powe=
rdown via sys_reboot.
>> [=E2=80=A6]
>> ```
>>
>> Testing Linux 4.18.6 and 4.20, there is no such delay.
>>
>> ```
>> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 4.18.6.mx64.221 (root@x.mo=
lgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Thu Sep 6 07:51:05 CEST 201=
8
>> [=E2=80=A6]
>> [=C2=A0=C2=A0=C2=A0 2.951174] ipmi message handler version 39.2
>> [=C2=A0=C2=A0=C2=A0 2.951604] ipmi device interface
>> [=C2=A0=C2=A0=C2=A0 2.951973] IPMI System Interface driver.
>> [=C2=A0=C2=A0=C2=A0 2.952404] ipmi_si: Unable to find any System Inter=
face(s)
>> [=C2=A0=C2=A0=C2=A0 2.952909] IPMI Watchdog: driver initialized
>> [=C2=A0=C2=A0=C2=A0 2.953339] Copyright (C) 2004 MontaVista Software -=
 IPMI Powerdown via sys_reboot.
>> [=C2=A0=C2=A0=C2=A0 2.954053] input: Power Button as /devices/LNXSYSTM=
:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>> [=E2=80=A6]
>> ```
>>
>> Do you have a suggestion, what commit might have fixed this? Quickly
>> going through the commit history, it looks like, last year a lot of
>> bug fixes and clean-up was done.
>=20
> That's really strange.=C2=A0 Generally when something like this happens=
, it
> means that there is sort of an IPMI interface there, but it's not compl=
ete.
> This happens when the low-level hardware is there, but there is no
> processor behind it to actually do anything.
>=20
> But as you can see, in 4.18 it wasn't detecting anything, and in 4.19
> it is seeing an IPMI device on the PCI bus.=C2=A0 The discovery here is=
 done
> by the PCI code, it's out of the IPMI drivers hands until the PCI code
> delivers it.
>=20
> So what I'm guessing is that something changed so that the PCI
> code is now recognising that there is an IPMI device there by the
> PCI class codes.=C2=A0 There really isn't a device completely there, so=

> it doesn't work.
>=20
> I don't see anything in the IPMI code that would cause that.
>=20
> If this is a problem, the device can be blacklisted in
> ipmi_pci_blacklist in ipmi_si_pci.c.

For whatever reason, I didn=E2=80=99t read that last paragraph, so bisect=
ion
brought me to your commit bc48fa1b9d (ipmi:pci: Blacklist a Realtek
"IPMI" device) doing exactly that, blacklisting the device.

    $ lspci -nn -s 06:00.3
    06:00.3 IPMI SMIC interface [0c07]: Realtek Semiconductor Co., Ltd. D=
evice [10ec:816c] (rev 0e)

I=E2=80=99ll backported it to Linux 4.14.x, and send the commit to
stable@vger.kernel.org.

[=E2=80=A6]


Kind regards,

Paul


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dbc48fa1b9d3b04106055b27078da824cd209865a


--------------ms090708040203090906000602
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAxMjMxNjI1MDJaMC8GCSqGSIb3DQEJBDEiBCBDeeRXOS3Y2D3dt52b
9CaqUbZfAtDhgrKzydluGyCkmDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAJTH
elGoByB4jdot39keyo2g3Cly/yIcah8bjYKTbub4iTOX8ex7EVDB5kaFT9QojZA9/WlLerN8
X8gU7I5PEM2S2ME9wJKhRsq1fzOhCrRt58iuBvjxO+x6b/ISv/sfx3SALCqhUVFnQxCh1kxJ
2cmxZymiipwLgM9+i6VJOWCclM2DbRTNRhBinSFS4sHIr4xod2axzQIo61w955xVuSPMYjuV
kVFHg8NNo96OoUFSQHtm2fPrSueEED4R9MuddA/hkn2vSqTmvzZ3T2fkAxB/ngK0UX5eLYHc
oRjj6Nk5ayBLtLuoIGCtso6wPXbrycfQXAvb0YPJsplkrUZq0qEAAAAAAAA=
--------------ms090708040203090906000602--
