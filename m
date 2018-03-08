Return-Path: <eric@anholt.net>
X-Google-Smtp-Source: AG47ELuo4aRrIKVRcBL9mxjD3fkDdAceHeHWmAARfU3D/rW75ej23F1LR3UXGbZj/Al/HygaUO5a
ARC-Seal: i=1; a=rsa-sha256; t=1520540148; cv=none;
        d=google.com; s=arc-20160816;
        b=DtaXwhk5s99C/4KTEi3lrHvIEM1cc3aoB16c7nIJSNrvcx84aMajCmojQrrarSNWOY
         YjPFkz8eOR9ykpE9q7bRHvZkeOJVKYox8Ie56m3OerZIbgffzDJAdxn82EdQSSbecuAa
         IQqxyhoow2S1U8rHY6hfqnXtWk6e4AnkaJQ8zSk8vQBs7lECnSd+r3MtQDSMcjlyGPfN
         VKpniMUIfUqHyqoKOzfWRYLtPAtIKtZHKvXmmwqnCu0XuvKPHi7HGQTjaCL8AzQGrDlK
         y8Hf4d2AdM0j8NQLKtbkdphEkO3E/+iit0C8k6b+rHPLKTKVImtr6V3IS1iW/OGFt4eS
         eLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=/wV+fucJyKWXvd6z10KsmS3/rGDBbcjiS4jSgLVeNnc=;
        b=Xth88SUyIuxZTcFHQgdt9lx7Av+KkHjHnDQiJpYOGA5Ser5ncXL6ReVxDk/lwnDm/s
         VxhI+8TrrBP7nvOATvIT+YiBYUhGt9pKuw6+3uPA6haq0a9bPkWu3utC9+FBbXAVIMyl
         LO6UMy3AZoAw3i0gbe/HXyCpxEhmZ2fq97gXsZ7Qjr5OprmNtheAVWGZhoXp5b4ECKFw
         x8xckI1f5G5sfEZ1cQVPm0hp38ycaGX6Q3t8bhw2s37hw88C0O8AhO1L/rLcyQlGxaLs
         tvMuGTVb/kEB0TXasPNO8Ie0KQ6nUFEuZmEG1UuwwrvXps4ArRvVzNs+yeFiIQxlkvzg
         pYZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Rob Herring <robh+dt@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Elwell <phil@raspberrypi.org>, "moderated list\:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom VCHIQ services.
In-Reply-To: <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
References: <20180307185716.17449-1-eric@anholt.net> <20180307185716.17449-3-eric@anholt.net> <CAL_Jsq+1-9-RGfzPimYwCokEZx1vef_PX5rkp-c8s6fUchg=ag@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 08 Mar 2018 12:15:45 -0800
Message-ID: <87lgf2fhn2.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306376933935522?=
X-GMAIL-MSGID: =?utf-8?q?1594401906612044141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Rob Herring <robh+dt@kernel.org> writes:

> On Wed, Mar 7, 2018 at 12:57 PM, Eric Anholt <eric@anholt.net> wrote:
>> The VCHIQ communication channel can be provided by BCM283x and Capri
>> SoCs, to communicate with the VPU-side OS services.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: dropped firmware property, added cache-line-size.
>>
>>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>> new file mode 100644
>> index 000000000000..cdef4abc5e47
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>> @@ -0,0 +1,28 @@
>> +Broadcom VCHIQ firmware services
>> +
>> +Required properties:
>> +
>> +- compatible:  Should be "brcm,bcm2835-vchiq"
>> +- reg:         Physical base address and length of the doorbell register pair
>> +- interrupts:  The interrupt number
>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>> +
>> +Optional properties:
>> +
>> +- cache-line-size:
>> +               Size of L2 cache lines.  The VPU firmware detects
>> +                 this property and overrides it with the actual L2
>> +                 cache line size it's using when loading the
>> +                 device-tree.  Determines the required alignment of
>> +                 offsets/sizes of VCHIQ pagelists.  If missing, the
>> +                 firmware assumes an older kernel using 32-byte
>> +                 alignment.
>
> How is this a VCHIQ property? This is a standard property for cache
> nodes, but this is not a cache node.

Because the existing firmware code is choosing a value based on the
property's presence in this node.  This is the DT ABI for the firmware
that's been shipping for a long time (at least since the 4.9 era).

> Is it really a problem to just use a fixed maximum alignment? That
> seems to be good enough for all the rest of the kernel.

If we can't have this DT property, then it looks like we need the
upstream kernel to just use 32, since that's what the firmware will
assume in its absence.  Maybe the firmware maintainers can give us a new
arg to the mailbox call for setup where we could pass in the value to
use (or flag for them to pass their preferred value back to us) so we
can avoid DT.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqhmfEACgkQtdYpNtH8
nujgDg//WUpAZuKEvrf/LC3Q/PJvpwU9xsPLOcgNFi8MTG81AFoG+BDc9TXVccZY
tpUe8WQufeLJqj8DI5DNPt355vOSvr6lCdU5H4RWv6mhA82uAO1TfULpO6DcV1Pi
8R2IEBqgQPIFdIOBvbggSHr5gvzAOT57ICwRDu802B9lY2Eor4prvpdjINYjMJS0
a1MQiQM/jtBguU68GQ3OL9EbMar8hhTX+IEUudJ9v8UAw7OQH8RdK1rC2TbY2sOs
6kEOOrXxJsfRU5czrBKEksgKj3U4+CjZnpx172rtIBbXmT1Q+V51j92RLteNwNZ5
mF1v2he0DggCgsco9VMwiS5szs5edsWWs+9GoV7qFWfBBcmFDJNZsi2HYrJTyeLA
VnTmByFC37jf/561Q6rnYcG6CXe4tJxgsz/cVqiIGif6ah+E0dI9PFFKdBE25k++
CBrQvrM0Qrh6XPHcgEMonUFichkys3eTb0hmUmtSOe8JwDCyqccoSnQpR2XAhEzw
zFCF2c8N8lymoh2EOdzV/T4w/hTgBLFuwqiBInWJl4XAm/YT2++XGpZJ+Dpv8jov
BaL7fII7pSWcRPWuhHWjPLtagHUQl/vlsH8FXnDT9mJy/tNxidBxefwWEGdZR963
eLERHSxsxyk6pdcOYIsqVRIW9zd2PUdZ8L7FPPunylqY/bpYiLw=
=7AfP
-----END PGP SIGNATURE-----
--=-=-=--
