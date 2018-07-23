Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CD220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CD220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGWLKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:10:08 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50693 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388375AbeGWLKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:10:07 -0400
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A97612012BA07C;
        Mon, 23 Jul 2018 12:09:37 +0200 (CEST)
Subject: Re: MSI B350M MORTAR: `AMD-Vi: Unable to write to IOMMU perf
 counter.` and `pci 0000:00:00.2: can't derive routing for PCI INT A`
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <605ca165-0071-eb7f-4c0d-b1e76ddd0e05@molgen.mpg.de>
 <20180720123153.GC18541@8bytes.org>
From:   Paul Menzel <pmenzel+linux-iommu@molgen.mpg.de>
Message-ID: <d2c5ee4a-e72b-672e-ae30-7b3cd5a43c63@molgen.mpg.de>
Date:   Mon, 23 Jul 2018 12:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720123153.GC18541@8bytes.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080609080103040107060400"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080609080103040107060400
Content-Type: multipart/mixed;
 boundary="------------A529CF20E19C5183D8DADD40"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A529CF20E19C5183D8DADD40
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear J=C3=B6rg,


On 07/20/18 14:31, J=C3=B6rg R=C3=B6del wrote:

> On Tue, Jul 17, 2018 at 06:02:07PM +0200, Paul Menzel wrote:
>> $ dmesg
>> [=E2=80=A6]
>> [    0.145696] calling  pci_iommu_init+0x0/0x3f @ 1
>> [    0.145719] AMD-Vi: Unable to write to IOMMU perf counter.
>=20
> This is likely a firmware issue. Either the IVRS ACPI table is incorrec=
t

Please find the output from

    sudo iasl -d -p /dev/shm/ivrs.dsl /sys/firmware/acpi/tables/IVRS

attached.

[    0.000000] ACPI: IVRS 0x000000009D3D8588 0000D0 (v02 AMD    AMD IVRS =
00000001 AMD  00000000)

> or the BIOS did not enable the performance counter feature in the IOMMU=

> hardware.

Is it possible to check that from the OS side?

> Are you running on the latest BIOS?

Yes, I am even using a =E2=80=9Cbeta=E2=80=9C one from [1].

DMI: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018


Kind regards,

Paul


[1]: http://msi-ftp.de:8080/main.html?download&weblink=3D99df4e98c25ca3dc=
f0f6e7f8366cc1c7&realfilename=3D7A37_1g1.zip

--------------A529CF20E19C5183D8DADD40
Content-Type: text/x-dsl;
 name="ivrs.dsl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ivrs.dsl"

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180629 (64-bit version)
 * Copyright (c) 2000 - 2018 Intel Corporation
 *=20
 * Disassembly of /sys/firmware/acpi/tables/IVRS, Mon Jul 23 12:07:58 201=
8
 *
 * ACPI Data Table [IVRS]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "IVRS"    [I/O Virtualizat=
ion Reporting Structure]
[004h 0004   4]                 Table Length : 000000D0
[008h 0008   1]                     Revision : 02
[009h 0009   1]                     Checksum : 7C
[00Ah 0010   6]                       Oem ID : "AMD  "
[010h 0016   8]                 Oem Table ID : "AMD IVRS"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "AMD "
[020h 0032   4]        Asl Compiler Revision : 00000000

[024h 0036   4]          Virtualization Info : 00203041
[028h 0040   8]                     Reserved : 0000000000000000

[030h 0048   1]                Subtable Type : 10 [Hardware Definition Bl=
ock]
[031h 0049   1]                        Flags : B0
[032h 0050   2]                       Length : 0048
[034h 0052   2]                     DeviceId : 0002

[036h 0054   2]            Capability Offset : 0040
[038h 0056   8]                 Base Address : 00000000FEB80000
[040h 0064   2]            PCI Segment Group : 0000
[042h 0066   2]          Virtualization Info : 0000
[044h 0068   4]                     Reserved : 80048F6E

[048h 0072   1]                   Entry Type : 03
[049h 0073   2]                    Device ID : 0008
[04Bh 0075   1]                 Data Setting : 00

[04Ch 0076   1]                   Entry Type : 04
[04Dh 0077   2]                    Device ID : FFFE
[04Fh 0079   1]                 Data Setting : 00

[050h 0080   1]                   Entry Type : 43
[051h 0081   2]                    Device ID : FF00
[053h 0083   1]                 Data Setting : 00
[054h 0084   1]                     Reserved : 00
[055h 0085   2]        Source Used Device ID : 00A4
[057h 0087   1]                     Reserved : 00

[058h 0088   1]                   Entry Type : 04
[059h 0089   2]                    Device ID : FFFF
[05Bh 0091   1]                 Data Setting : 00

[05Ch 0092   1]                   Entry Type : 00
[05Dh 0093   2]                    Device ID : 0000
[05Fh 0095   1]                 Data Setting : 00

[060h 0096   1]                   Entry Type : 48
[061h 0097   2]                    Device ID : 0000
[063h 0099   1]                 Data Setting : 00
[064h 0100   1]                       Handle : 00
[065h 0101   2]        Source Used Device ID : 00A0
[067h 0103   1]                      Variety : 02

[068h 0104   1]                   Entry Type : 48
[069h 0105   2]                    Device ID : 0000
[06Bh 0107   1]                 Data Setting : D7
[06Ch 0108   1]                       Handle : 05
[06Dh 0109   2]        Source Used Device ID : 00A0
[06Fh 0111   1]                      Variety : 01

[070h 0112   1]                   Entry Type : 48
[071h 0113   2]                    Device ID : 0000
[073h 0115   1]                 Data Setting : 00
[074h 0116   1]                       Handle : 06
[075h 0117   2]        Source Used Device ID : 0001
[077h 0119   1]                      Variety : 01

[078h 0120   1]                Subtable Type : 11 [Unknown Subtable Type]=

[079h 0121   1]                        Flags : B0
[07Ah 0122   2]                       Length : 0058
[07Ch 0124   2]                     DeviceId : 0002

**** Unknown IVRS subtable type 0x11

Raw Table Data: Length 208 (0xD0)

    0000: 49 56 52 53 D0 00 00 00 02 7C 41 4D 44 20 20 00  // IVRS.....|A=
MD  .
    0010: 41 4D 44 20 49 56 52 53 01 00 00 00 41 4D 44 20  // AMD IVRS...=
=2EAMD=20
    0020: 00 00 00 00 41 30 20 00 00 00 00 00 00 00 00 00  // ....A0 ....=
=2E....
    0030: 10 B0 48 00 02 00 40 00 00 00 B8 FE 00 00 00 00  // ..H...@....=
=2E....
    0040: 00 00 00 00 6E 8F 04 80 03 08 00 00 04 FE FF 00  // ....n......=
=2E....
    0050: 43 00 FF 00 00 A4 00 00 04 FF FF 00 00 00 00 00  // C..........=
=2E....
    0060: 48 00 00 00 00 A0 00 02 48 00 00 D7 05 A0 00 01  // H.......H..=
=2E....
    0070: 48 00 00 00 06 01 00 01 11 B0 58 00 02 00 40 00  // H.........X=
=2E..@.
    0080: 00 00 B8 FE 00 00 00 00 00 00 00 00 00 02 04 00  // ...........=
=2E....
    0090: DA 4A 29 22 EF 77 4F 00 00 00 00 00 00 00 00 00  // .J)".wO....=
=2E....
    00A0: 03 08 00 00 04 FE FF 00 43 00 FF 00 00 A4 00 00  // ........C..=
=2E....
    00B0: 04 FF FF 00 00 00 00 00 48 00 00 00 00 A0 00 02  // ........H..=
=2E....
    00C0: 48 00 00 D7 05 A0 00 01 48 00 00 00 06 01 00 01  // H.......H..=
=2E....

--------------A529CF20E19C5183D8DADD40--

--------------ms080609080103040107060400
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
SIb3DQEJBTEPFw0xODA3MjMxMDA5MzdaMC8GCSqGSIb3DQEJBDEiBCD9RPPWi8OLZXiB2iMY
VZ1mttvHHIStaxDG++UwYGlajzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAJb7
L/3J90spkk9hbWu497jt2tOf/lMWgDbRZQGIbsl4hHL9rNgqqXmsujA6C1S1QQAveM4EgbtC
0+uSsfHkalkmmle7u2GXsiQbwkeXIyH9B/po04GleKGWQ2nzg7Y3+PgvBUBiN93crKTyOKIL
tm3o213fA91WrsTyoWjN2hWz0NOrI5aNENQZQkuaPjZkl1ooT0C4GoqF15GOvlNgaF3M3yBP
A5IHnTNuaubbSTnbxDTtTDiY/qwgZIK//wgC2yyds8oPcWGs/whVlNJcbQUuS3A1FikToRZG
rpiOs8Rl0glvhCSA6N8szaf0UXkJGpYuzK0UTeiZIggYNukeMGQAAAAAAAA=
--------------ms080609080103040107060400--
