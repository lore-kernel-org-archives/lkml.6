Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBDR6Z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:58:25 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35555 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeBDR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:58:16 -0500
X-Google-Smtp-Source: AH8x224iNwd/52mry+db8syuMfmtLVz78GP2IhVN+RiCvFrhNLX8evH0zOk3NwdmHmgSWWInbpAq2A==
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
 <197f448e-322f-dae4-aa4b-3cc2bd5b16bb@pressers.name>
 <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
From: Steven Presser <steve@pressers.name>
Message-ID: <9ee7da52-d86a-7784-8c00-6e5b4ae3ed96@pressers.name>
Date: Sun, 4 Feb 2018 12:58:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VeVuS51Z7U2P+t3YnfitUtVVAa_8oSbnXCHTY7rqrJUEQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms080707010600090001020705"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080707010600090001020705
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

All,

I had a chance to sit back down with the machine.=C2=A0 I didn't take it =
all=20
the way apart - there are pieces that I'm afraid of breaking without=20
directions on how to properly disassemble them.

However, I did recover an exact chip ID - the chips in use are BMA255s=20
[1].=C2=A0 Rather than take the machine apart (and because the chips are =

2mmx2mm), I queried the chip over SMBus.=C2=A0 On page 50 of the below=20
document, you can see that register 0x00 is a read-only chip ID.=C2=A0 Th=
is=20
chipID is unique per Bosch product.=C2=A0 So, using SMBus, I asked the ch=
ip=20
for it's chip ID (0xFA, in this case) and then searched likely products=20
until I found the matching chipID.

Does this suffice to settle which chips are in use?=C2=A0 If not, I can=20
finish taking the machine apart, I'd just prefer to avoid the risk of=20
breaking something.

As soon as I finish screwing everything back together, I'll grab the=20
other software IDs asked for and build the branch referenced elsewhere.

Steve


[1]=20
https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA255=
-DS004-05_published.pdf


On 01/30/2018 03:12 PM, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 9:27 PM, Steven Presser <steve@pressers.name> w=
rote:
>> On 01/30/2018 02:05 PM, Andy Shevchenko wrote:
>>> On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name>=

>>> wrote:
>>>> First, I believe the "bmc150" in the subject line is in some way a
>>>> misnomer.
>>>> You'd have to ask Jeremy for more details on what he intended it to =
refer
>>>> to.  However, I believe the device in question is actually the bma25=
0[1],
>>>> which does not have a magnetometer component.  I'm unfortunately awa=
y
>>>> from
>>>> my notes, but I can check later if you need me to verify the exact c=
hip.
>>> Please do, I would really be on the safe side here.
>> Will do.  My digital notes indicate I worked from what was exposed bac=
k to
>> what chip matched.  If you can give me through Friday evening, I'll cr=
ack it
>> and do a visual verification.  (Alas, I'm traveling and won't be back =
to it
>> until then).
> We are in the merge window anyway, so, no hurry.
>
> I'm looking right now in the clean solution. Looks promising.
>
>>> Bad, bad Lenovo. (DMI strings might help here)
>> What particular DMI strings would be helpful?  All of them?
> Let's do this way. Create a bug on kernel bugzilla, attach output of
>
> % acpidump -o tables.dat # tables.dat file
> % grep -H 15 /sys/bus/acpi/devices/*/status
> % dmidecode
>
> and share the number here. I will take it.
>



--------------ms080707010600090001020705
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
BwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDIwNDE3NTgxMVowTwYJKoZIhvcNAQkEMUIEQH9TxzVh
eKO55lxIvn++NoHQg62z0tf73hwUQCyxWAIHpltRP5Fm9O0Vdg3rarG5ntRswghfd0pI5g2W
1+ex/LQwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDH
c18wgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEj
MCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDHc18w
DQYJKoZIhvcNAQEBBQAEggIAFmphdepFXZZUP3Z9N3OvH+hck8ZEqJR/+JVtF8kWbXEQmw7f
4Ye3WMTLjcXJwhrhiVmiKPmkk/k7ugDFbkGR5OVqfF8rLRY5QlGwt02+jbS4TXrQMz17c9k+
AtFoX14sL+U9G9vjCy+pbzXfP87zLJybmUC05KMKeTvi80x4kxMLS3otTRhh5qNRd1EgG64n
anuGgwePvAVS5Km0LevM9HgFwEp46qdiVSsLgL5VONX1xCXszEX4hMd24yUA1NHnnyv54G4+
U9mAOlUPyhPdJ6v4QTRvp/RXMXuuu2Ih5Sbr/qHlgiY20x2Hrn0jye1kPygad8YHOWRKm+vv
/rPUdPP9T/G2PgkQwfXdldfDuTKt8AXZmpw1PHqgqAgpLXn8Zoa/00aDKZ93MkAzQ1gF7iSY
K5JU3TuarxwNuRyZBEHDcLlvGNfz7QummJSF3rHO4MExyOUxxLyo7wIuzv/iOvVKq18J5+E+
D6qSgMf3SsFnFXU34apd8Or1tjLMHo2tJFwTYbJg1SN8ZollPz5M9/1+vZpJDiYmfvcXe7H9
RKKwkPHmy5f3PIeoOBNAXDmPqmnp1bZhdYxvB/MAGGjdOebFDDUvcShuK3fvn70+d0xK8lE+
d6EgIOZJHWp91rQe83J7U3FeM1wR+4J56sVGdTgo8D7QhKQ31F4vOTLzDVkAAAAAAAA=
--------------ms080707010600090001020705--
