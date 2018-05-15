Return-Path: <felipe.balbi@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoQ55iIMV5KH+XZUTHGBgEVXEYJu/gDVCeDe4e5zM3kGxq2W9sY/T5Yan+YGNz/06zFqPqP
ARC-Seal: i=1; a=rsa-sha256; t=1526369025; cv=none;
        d=google.com; s=arc-20160816;
        b=CSlpOa+d7PF2hGY/TzCYRmlzPfYLsd17BG8Pr3wgdpvTCS9ktltFII4ryHVEO9mdJd
         lzo8QNc+2DEnRdh8XAIvoMFCl4eNdBF9neJQvsTMhvafui6OzIz8eePJrrEXKHfaO8Rg
         zmCFl8X3eSEpSEMtInQXiMfQ8TIJmkHPRnhmr+p7Im6KryxvrPBwR6yvfSdoV2ico39M
         /I4mZwHIjjoom1oZso2kMOm0iTpLUPhmfrYyri/WpL86ceoEbXqQWyU+VmNM4ErBamaO
         eXHfvhH09LfjU7ihosuI7kguu1TDjzrzhoftXpKfViwdyKcZbo+aGDvdrtZsng+Rfsoh
         a4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=AfQ5TXDQWO3SJspnXZHD1z5Jui/n8TkMFsag7H116II=;
        b=E02xAxKEhNtf65CsrBt5mhcVhdHcDL7my/uD6nQbZt1rmy1btAnCgF8ZZJBWPgcJXx
         Xu/ExMdhIch84vUjTh6RgIusB8fzpnnjgFJJKL5vxAKUpsOQofLN5aAPgyNH3nvksiMS
         ags/oum+uxQ0c+o8ox3/DHANxu463ieJVp7jQZvoO/4JS4yAS8p4u8LkinCW5U9zkOZl
         tyT0vY5ygHzAWq6urICnbHcR2FfDokou00MQPgMIavd7h7j1N5AqhAq4+SDjvlTFWB6b
         B3YXvSZnhPrSRmJn930FssoepglWIkzjWlI8ddAtt5hdppN1Ej8B1GoQTO2tKhrSKuus
         0NOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of felipe.balbi@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=felipe.balbi@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="asc'?scan'208";a="224315463"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for SuperSpeed or higher speeds
In-Reply-To: <1525913200.32173.3.camel@mhfsdcap03>
References: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com> <8736z1kqrq.fsf@linux.intel.com> <1525913200.32173.3.camel@mhfsdcap03>
Date: Tue, 15 May 2018 10:22:03 +0300
Message-ID: <87efid9yec.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599986136874105880?=
X-GMAIL-MSGID: =?utf-8?q?1600513927513142774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> On Wed, 2018-05-09 at 14:33 +0300, Felipe Balbi wrote:
>> Hi,
>>=20
>> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> > The USB3CV version 2.1.80 (March 26, 2018) requires all devices
>> > ( gen1, gen2, single lane, dual lane) to return the value of 0x0320
>> > in the bcdUSB field
>>=20
>> this sounds really odd. What happens when I get a USB 3.1 compliant
>> device off-the-shelf and run it through USB3CV? will it fail now?
> Yes, it will fail, the last version requires it 0x0310
>>=20
>> Care to share a screenshot or the raw html of the test result?
> A screenshot is attached

really odd. But I'll apply the patch.

thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlr6ipsACgkQzL64meEa
mQYO6xAAhtcb9jjMwlbve2ite49+UwfbMIQ0QNcFsueR9owX9yE63gZy/5F0zmPO
0cm7ejdZuApKRuzAaZf2yjiQyMEpNtlc0u5Xrfozka+jeEJkQoh5O527HzZcwlEf
pz09dD/qMXo1m0jGsHhMJTKRlPW+6ix8JemN5Po0eGQEoezonnAuYcTS1/EtJS/H
G6WxrT9phd3h/uqsoZk7D0cl/RyUpAuW9WBp1KS1HEB4xNdENBqm9QJ/rxMN1GNN
QSbLbXfF2HPSCLPmPEniUtHNhHCrH5DteJjsf5B/oGFI4EDoOYec3umMONuQh5tX
zog8HEF8qO9vQC9k5y9Abqc35Xo+9UCqNO5EG05ifk+MmOTPe4258zeRw6wUnDx3
iREmWilxtHatef+af67W0pYnWu+XN38SFKlg+qXA85hb1hlFr1r6teXC07bZplLu
z7kY68v0xt1PAMsP5JuFP50G0qvP4Wp7hsBNup66KEIBNlUda28Ihu/+5wgb1B8Y
POucrJ7N5vfjG1HqJoHlTX1/sKcnrtuWsaoVO+hMVzf5RuzXpeddPh/vvXHT6hDy
YKhJhbiGlJLkgFlwyeQxrBXZ4nfO3UeHma/uoa6eouB2sDNqm1Jo0PGoZCwubVc3
R/wst0nOiV8bv+86VxpU4wSKiL/U2qmapvskVvTEa4p9FtKmtYw=
=g+N+
-----END PGP SIGNATURE-----
--=-=-=--
