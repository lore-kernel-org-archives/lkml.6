Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeEaIBy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:01:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:54703 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753934AbeEaIBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:01:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="asc'?scan'208";a="45314351"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        "Gerlach\, Dave" <d-gerlach@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, "Nori\, Sekhar" <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call pm_runtime_set_active()
In-Reply-To: <d6015f73-358b-1f96-2682-8cbe2423960a@ti.com>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com> <1527518174-27860-2-git-send-email-rogerq@ti.com> <87k1rlcok2.fsf@linux.intel.com> <d6015f73-358b-1f96-2682-8cbe2423960a@ti.com>
Date: Thu, 31 May 2018 10:59:52 +0300
Message-ID: <87bmcwcl1j.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:

> On 30/05/18 15:31, Felipe Balbi wrote:
>> Roger Quadros <rogerq@ti.com> writes:
>>=20
>>> Don't call pm_runtime_set_active() as it will prevent the device
>>> from being activated in the next pm_runtime_get_sync() call.
>>>
>>> Also call pm_runtime_get_sync() before of_platform_populate().
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>=20
>> This patch is wrong.
>>=20
>>> ---
>>>  drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-=
of-simple.c
>>> index e98d221..2cbb5c0 100644
>>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>>> @@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_dev=
ice *pdev)
>>>  	if (ret)
>>>  		goto err_resetc_assert;
>>>=20=20
>>> +	pm_runtime_enable(dev);
>>> +	pm_runtime_get_sync(dev);
>>=20
>> No, this is the wrong way to do things. My device should be enabled
>> already from probe, specially since I have already enabled clocks.
>
> As far as I understood just enabling clocks (which might not include bus =
clock)
> doesn't ensure device is enabled.
>
> Did you mean that I don't need to do a pm_runtime_get_sync() to enable my=
 device in probe?
> Who is enabling by device for me then? Is device core supposed to do it?

Not device core, but the bus code. Look at how PCI handles it. IIRC,
only TI's omap_device behaves peculiarly WRT probe & pm runtime.

> The issue I was facing is that without this patch my device wasn't being =
enabled
> as pm_runtime_set_active() is being done _before_ pm_runtime_get_sync().
> It could be an issue with the platform's PM domain code as well.

Could be

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlsPq3gACgkQzL64meEa
mQbNIxAAuy04aGRDNcfBLfnHTZc6SImdiuiGUNL8okbukSji03jWf3EN/8TSDjGd
P+SbInnQeZ/VuPsdzR7wKbEoRudOrKJ5fbp/BSQuKJjjbj2NHBAnCepmzsfPYTf/
u6K+fKiROfgdH7UpwFkYQgCPSSHBxOYHuwwst++Px10V67VWOFYcVy6oY2MPBEmM
Mh4Trc7rlb6A9mR9Ye7buCfWLX7O+XJLYES27+NOlbdRsegn5PEt0NmLulqSgch5
yF9fPlwM+9W5bIxDp8WVlxvcf7Ixd5P8JwrMkbP5Xp7Bar709MLAK6sCB3P8fK96
on6pzFkkFgK1hr3/6KDCpqTcXJNQR/fPRYB96o4I+Tvd8leFqGC6T204x6Ghn8uP
pSQ652ObHGHjj/JuVaHWscN+YD+cAvs+gbjI4UwpHuU+caCrdNMsW3PzummZV8Km
KEzZVBtU/CXZFuliJJ7oDiglw1/Hf6BFK1kH9ob/xrZsqZ8YLYRCcEPbhzouM3ta
W3VFzNN+qEmMI8mu7yir/Xku3O2RtQG6MsrqwxceO6mBKvz5ToJGPsOq6g2LUXOy
U3p94VjNNRo41viRMX1Z0ofdTJeyedA59FtOC5/KBgI5jdvM1hz+9Zfxxli+o3qS
nf1TSNkcWcvc2SuniNvAnwgrGYzUSP0pkfxGbkUOQyLLSzVIQEM=
=eyym
-----END PGP SIGNATURE-----
--=-=-=--
