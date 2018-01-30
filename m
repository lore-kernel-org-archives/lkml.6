Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeA3T1s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:27:48 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:38902 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeA3T1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:27:42 -0500
X-Google-Smtp-Source: AH8x227B3qkZnbVt5rx0kvQtAoD84iLmXdyaCnm0xpHdxNHaSuLDwOp0Ktyuzqtm0vxLzivier+VLg==
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com>
 <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
 <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
 <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
From: Steven Presser <steve@pressers.name>
Message-ID: <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
Date: Tue, 30 Jan 2018 14:27:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms050409050204070805020506"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050409050204070805020506
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 01/30/2018 02:05 PM, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name> w=
rote:
>> Andy,
>>
>> I apologize for the long response, but there's several issues to addre=
ss
>> here.
> NP, it it a good explanation why. That's what commit message missed app=
arently.
Probably my fault anyway - I don't recall discussing with Jeremy exactly =

what chip was inside this little Frankenstein.
>
>> First, I believe the "bmc150" in the subject line is in some way a mis=
nomer.
>> You'd have to ask Jeremy for more details on what he intended it to re=
fer
>> to.  However, I believe the device in question is actually the bma250[=
1],
>> which does not have a magnetometer component.  I'm unfortunately away =
from
>> my notes, but I can check later if you need me to verify the exact chi=
p.
> Please do, I would really be on the safe side here.
Will do.=C2=A0 My digital notes indicate I worked from what was exposed b=
ack=20
to what chip matched.=C2=A0 If you can give me through Friday evening, I'=
ll=20
crack it and do a visual verification.=C2=A0 (Alas, I'm traveling and won=
't=20
be back to it until then).
>
>> Second, we're seeing a difference between what's in the data sheet and=

>> what's exposed in the wild via ACPI.  I own the laptop that started th=
e
>> process of building this patch and I did the original ACPI-tables
>> investigation.
>>
>> The device in question (BOSC0200) appears in the Lenovo Yoga 11e (and
>> possibly other laptops - this happens to be the one I own). These lapt=
ops
>> have a 360-degree hinge between the screen and the keyboard, letting t=
hem
>> convert into tablets, if the user desires. The 11e implements this
>> mode-switching by placing an accelerometer in each of the screen and
>> keyboard, then doing math with the resulting vectors to figure out the=
 angle
>> between the two.
> This makes a lot of sense.
>
>>   For whatever reason, Lenovo chose to expose these two
>> (physically separate) accelerometers via a single ACPI device which pr=
esents
>> two i2c devices at sequential addresses.
>
>> As part of my original investigation of the Yoga 11e, I wrote a
>> proof-of-concept of pulling accelerometer data from the two devices ex=
posed
>> under the BOSC0200 ID and using that to calculate the position of the =
screen
>> relative to the keyboard.  So based on my empirical experience, I can =
tell
>> you the BOSC0200 device ID can expose two accelerometers at sequential=

>> addresses in the wild.
>>
>> I don't understand why Lenovo has reused the BOSC0200 ACPI device ID f=
or a
>> device that is fundamentally different from the base device. The ID do=
esn't
>> belong to them and we're (apparently) now stuck in this situation wher=
e this
>> ACPI device ID could represent two different device layouts.
> Bad, bad Lenovo. (DMI strings might help here)
What particular DMI strings would be helpful?=C2=A0 All of them?
>
>> Finally - Andy, I apologize if I came across as challenging you in my
>> initial mail.  I was trying to strike a balance between brevity/respec=
ting
>> your time and asking a question.  Evidently I struck the wrong balance=
 and
>> should have given you more background on why I was doubting what you s=
aw.
>> This is my fault and you have my sincerest apologies for any offense I=
 have
>> caused.
> No need, the root cause is lack of description in the commit message.
>
> Nevertheless, the approach chosen I don't like. It looks like an ugly h=
ack.
>
> What we can do here is:
> - do not contaminate core part with I2C/SPI/etc
> - do not create another driver via board_info, we already in *the same*=
 driver,
> so, the better approach here AFAICS is to add DMI quirk into i2c-core-a=
cpi
>
>
>
>> Steve
>>
>> [1]
>> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA=
250E-DS004-06.pdf



--------------ms050409050204070805020506
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
C+QwggXiMIIDyqADAgECAhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNV
BAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1
wLUZr5gkrLtXedg17AkefMyUGwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV
/8Sp5lZEuiMnvMFG2MzLA84J6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyy
QzxvuA/GZwKg7VQfDCmCS+kICslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7
m1uTyHaKZspMLyIyz6mySu8j8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+Lat
oWELrjdI4a8StZY8+dIR9t4APXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0f
BCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUF
BwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUF
BzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSB
bDlhvkkPj7cbRivJKLUnSG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8G
A1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5S
H9uh2NCXTq7im61g7F1LIiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXB
sxsaRTYw5kG3DN8pd1hSEUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyet
OrRHPbkW4Y07v29MdhaPv3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl
149tKeqvwlvrla2Yklue/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF8
1snTr2d1A7Ew02oF6UQyCkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4
cJ2jrpmYSz/kliUJ46S6UpVDo/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6uf
QbwyO0V+oFa9H0KAsjHMzcwk3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+Jq
vTCIzv2bJJkmPMLQJNuKKwHNL8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPV
OMxLDSUCXsDO0uCWpaNQ8j6y6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOj
MIIF+jCCBOKgAwIBAgIQblaS/9kadBN5WggiIMdzXzANBgkqhkiG9w0BAQsFADB1MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50
IENBMB4XDTE2MDgxMDIyNDkxN1oXDTE5MTExMDIyNDkxN1owQjEcMBoGA1UEAwwTc3RldmVA
cHJlc3NlcnMubmFtZTEiMCAGCSqGSIb3DQEJARYTc3RldmVAcHJlc3NlcnMubmFtZTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANawlmrhSo5cCRT6pKi1VGoktCtiFh3vwsY3
D+KnXNxrTaVWcrqvEnWrcx6CYctQbvUWnxPt1Yrgnsev4TSNqPqIv+oqkwiho3UOM9AutTLa
U8RsNkoercgA7klslpjC3ItaWazN5BlRaZ8QWwpg6TjRATEG5RvNMbi31DHNM/1yinv7U495
SOSue5jvKvW639GlwxTUfWrUmtmtKJZSMpAYKwnhSehxyN8E3vzd82j4MvlrFSvPEdfIVPkt
o3K0BNAwYd2eHPVlHlWEBekNAzCQqY2vxPTjzlsusYV9lKzCPQ439D4XEWRvEDVS+wCcWepv
dgXqz38rzm4BO3T7udBDBvy2KaImZpPm1y/VHQ8ZFuRHJsdkq+E63wZuTuYFY1RJGm68vaV/
gxFSDZc4adZ/HG0+2/kPc/NuZa66yP4n58irIZXWBe6b6PvET3SUEA7HmsU1arLXVwE/TkPS
/QmGKZLCRrzpgeAP2bwuZMr+dXoNeGlGaf9TBhMXRqrRM+rvWrTst/745uqV5pUTQSJE8xha
SXUanZWZ3COcHiepdq7Lr09XAXU4QU29SgOi7cpxdZAUe0apsTMMWhJYBvISQVBvYZqPPj1X
WuCR4mAUouL8zFvt108F8iTh3VU1lCAI3ulrGqPPlJF7AXEtUGggkxwxnQR7p1Kk/BYeJn4T
AgMBAAGjggG3MIIBszAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFHEeAfB8TH+O1yTnfhhCM4F+NomZMB8GA1Ud
IwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0
YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0
cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3JsMB4GA1UdEQQXMBWBE3N0ZXZl
QHByZXNzZXJzLm5hbWUwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMEcG
A1UdIARAMD4wPAYLKwYBBAGBtTcBAgUwLTArBggrBgEFBQcCARYfaHR0cHM6Ly93d3cuc3Rh
cnRzc2wuY29tL3BvbGljeTANBgkqhkiG9w0BAQsFAAOCAQEAOBc5QbBzQ4Ghvh1xoHKcCsMj
xm38z1Z3bPWYmEWs0mQVjfT6otJ5dAhmJW8MS2I3MTIg/s8w8b9nSzah84JZT4/pqN0BLvfW
paEn3R3k2OtMnqYNglNEd45PwZO17wD1vqBSoArRXsgGn3X/jTbM+bC7E1c1AnqTePhNdd+d
nGvzFA52eL1HeyecgofMANKiFGViUBFVBW5No1rtw0cF9FVrNMubsLE5J/e/j8OOPYO/pMfr
ruOcbAPTHTEmDJJhYQ/9GQoTBOAR2J2BzbLmjNIjwnxCKggIP5QR59JBQ11JPn9MoX82GRGB
wVGNBj2Rifdg20JXDLuhQUdNVZIIhDGCBOwwggToAgEBMIGJMHUxCzAJBgNVBAYTAklMMRYw
FAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/Z
GnQTeVoIIiDHc18wDQYJYIZIAWUDBAIDBQCgggIzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDEzMDE5MjczN1owTwYJKoZIhvcNAQkEMUIEQLcctOt0
m6uShJLsV5ShqLGyMZPhBrOpOYXev3zHsxbRoY2qi7VeSrSKB1Zy7PvQNLFDOjIYVftfXS/p
p+9afeYwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDH
c18wgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEj
MCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDHc18w
DQYJKoZIhvcNAQEBBQAEggIAwNabwZMc3XYE4KodszczZCvYR24J4p9dRw74BeIAZmEkslS/
UBSKO1hv8X2J6eyj8wxS4/u9BbcMNBobWUjnRm8z9vOTsTMz3o5RyspGkYEYEvbu1yb7xtYU
t1y/VhX2tbBSzkA8/w7wvxoy5GRXUCoZTySjEm5QpQKVgyqWJ6u8osUMd80oW9VcMCP8dqKh
TTz8ieJnw5u7+Eh6KkBf1Qv4V82ZBBK0s3g47UexN3E++FDJ5zR+AGZy6CbKeQq/3CwF58fA
b4H8F9kQvwH4Ajli4JaoqGOZxoHKmWn1IWqWgaGFCvj+97EfMMtayftN7Bxkep3EjJIhN6e5
iEhNhOXTijg8sLzXVhVD/EZwdbSSFSqoV0BB3mxz5cZYQ/32amLyFm+Ey2J03aY9QPfhuyoG
4o3NXk3APWbPXsI83+t5MuZfFLsN0VFXNHtfoF37vW941hs26ptrBXYX91f51GbPw7soDn1o
/ZV3hpNbKo8ZIf0puNLeG+mX8s62VP0mmP9/IyuppUMHdLwlWAd31aHjMQ1caoMbCSErjvle
Ps2y5PShXZTfJRCO7NAKHZF3LE/n7VemoqV7mbE3DMxrd/elMnobELWu5lNjlM/Gf80W0MsP
/EGbLzujdtQU7Lr6bVcbixtr55vJWO5RKlGbTH3QbfroK3r1ICoD4bBRclIAAAAAAAA=
--------------ms050409050204070805020506--
