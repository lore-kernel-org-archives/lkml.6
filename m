Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDSEhJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:37:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:48742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbeDSEhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:37:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="p7s'?scan'208";a="217713381"
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "dgilmore@redhat.com" <dgilmore@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>
Subject: Re: issues with suspend on Dell XPS 13 2-in-1
Thread-Topic: issues with suspend on Dell XPS 13 2-in-1
Thread-Index: AQHT05S3l/OM2r/yv0C0KBEFc37YQqQDkQZAgAJ8rYCAAPZB8IAA+lMA
Date: Thu, 19 Apr 2018 04:36:59 +0000
Message-ID: <1524112616.31134.43.camel@intel.com>
References: <6ce634cb82617c2a9a060ba6e2accef2a15dcc15.camel@redhat.com>
         <b7c4434319bf4ff8877f882d219a60ba@ausx13mpc120.AMER.DELL.COM>
         <1524005977.31134.15.camel@intel.com>
         <6ebf99dedde4446d84333c2cf25cc9fa@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <6ebf99dedde4446d84333c2cf25cc9fa@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.240.7]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-+NePDn2dt//gr43Av5gP"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-+NePDn2dt//gr43Av5gP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-04-18 at 21:01 +0000, Mario.Limonciello@dell.com wrote:

> >=20
> > > [...]

> > > Srinivas,
> > >=20
> > > Do you know why Runtime PM is defaulting to disabled for all of
> > > these
> > > devices?=C2=A0=C2=A0Is that a default kernel policy problem or a dist=
ro
> > > policy
> > > problem?
> >=20
> > This is default kernel policy.
>=20
> Why is policy set this way by default in kernel?=C2=A0=C2=A0Could we disc=
uss to
> change
> Default kernel policy so that users can get better power consumption
> by default
Good question. This was discussed before, the problem is that it can
cause some issues with legacy devices. It should be better done in user
 space by some policy in gnome power manager, which user can
enable/disable.

>=20
> I think it will be especially important as more machines continue to
> adopt
> suspend-to-idle.
Those should impact opportunistic idle since for S2I regular suspend
callbacks are called. In my 9365, I can get PC10 during S2I path
without adjusting them. Only problematic is systems with SATA, where we
need to enable devsleep.

>=20
> > I suggest run
> > #turbostat
> > then suspend and wake
> > when wake up let the turbostat collect data for next sampling
> > interval.
> > We have to see what are PkgC% residencies are?
>=20
> Assuming you mean for Dan to run this after he adjusts all the PM
> settings
> for those options power top called out, right?
It is better.
May be some device is not behaving correctly. So he can try with
powertop --auto-tune and check turbostat and see status of PkgC states.

Thanks,
Srinivas

>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > >=20
> > >=20
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Bluetooth device interface status
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Enable Audio codec power management
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for I2C Adapter i2c-8 (Synopsys
> > > > DesignWare
> > > > I2C adapter)
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Autosuspend for USB device
> > > > Integrated_Webcam_HD
> > > > [CNFGE16N092020028362]
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Autosuspend for USB device xHCI Host
> > > > Controller
> > > > [usb1]
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Autosuspend for USB device xHCI Host
> > > > Controller
> > > > [usb2]
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for I2C Adapter i2c-7 (SMBus I801
> > > > adapter
> > > > at efa0)
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Autosuspend for unknown USB device 1-2
> > > > (8087:0a2b)
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for I2C Adapter i2c-6 (Synopsys
> > > > DesignWare
> > > > I2C adapter)
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0I2C Device i2c-DLL077A:01 has no runtime power
> > > > management
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0I2C Device i2c-WCOM482F:00 has no runtime
> > > > power
> > > > management
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP PCI Express Root Port #10
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP CSME HECI #1
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP Serial IO I2C Controller #1
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP SMBus
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP PCI Express Root Port #5
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Runtime PM for PCI Device Intel Corporation
> > > > Sunrise
> > > > Point-LP Serial IO I2C Controller #0
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Wake-on-lan status for device virbr0-nic
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Wake-on-lan status for device virbr0
> > > > =C2=A0=C2=A0=C2=A0Good=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Wake-on-lan status for device wlp60s0
> > > >=20
> > > > Regards
> > > >=20
> > > > Dennis
--=-+NePDn2dt//gr43Av5gP
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
aQGEV8ArjHXcotL/yLNh30JyB9sygYzIQadqyFvtvhUyiHwAh7Pf6Gl7Gsz0i/QSq7MK49JvgbUM
F1TCZwc7AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUf6YLVqF1vjXfk2h4J2GzgJAOB/8wHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQDDpWcY9zqtG5P0e1FRJpG/RPQ6
p6sQJHZ5UwykMtYFqBJYOZn9B8koeLEhE4vOAh6v6fgVoCfOvwxJ57BUAdP3jvkbCaLz3r6nUHNr
6w6KwnT9rHykdDjZsRUGs2yP+139qVqoXRHTOLfqvnAzcirjgf4Fz3JRPJZraRWrICBehqhYVfFH
sxxBgOauQ+DTHjZARkomjmrATvlDpLMlN74L/BKZI4rl4R/BjSaLBzAKQnAN0nvWefpPzdeSYuxK
XaN1xDzINPDnmShXSbQzee0h2CvEnIMtPQDM9DJACUi14Cc9y4o7DqRky4r1+XnksN2lKnu83l4E
oSxCkDMhszkFMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAK0KIyEkTMbH5OYAAAAArQowCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDQx
OTA0MzY1NlowIwYJKoZIhvcNAQkEMRYEFOEdkqFMr9IsGcVzbs2vmxUrR41uMA0GCSqGSIb3DQEB
AQUABIIBAM0RHsOER8Po+tCFpiaxIeyIsN5fNqOE3kU5HaZG3/UMzgC8ADuEC5JrVO501nDw0E75
0ETpIfWEBLpfLWOrudbmB9zWQ+8bE/j1xX4D1ZbkkIm86fskaEVPPil7evTAA6WYjpxUlTNAG1qc
9ocJfyUrtONP9fLxW+kfUnW2uKTsiVall460lSwKMQjrHz0R14mRTCZ45vnyxzzIs+reUqPM/kMc
csxBs5uzHPRCWqsn5qSCPBiCgRQPGs4xFWOevoullq1P4zSBySXyR+wt7A4oS0FvKJESsMleB7dp
clIgYLMe/7LsvjoWr9DDDlx7MYBfRDBe/joSvEpcflBcIZkAAAAAAAA=


--=-+NePDn2dt//gr43Av5gP--
