Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AG47ELuxwHcl3Y2BCJg7bHi0FAsnSR8FIhGkxmFjOYhDCMIXVE3aGqgjcyYh2aE2CktaqBDxtk92
ARC-Seal: i=1; a=rsa-sha256; t=1521557434; cv=none;
        d=google.com; s=arc-20160816;
        b=qWAWAIryZjJGiKHoinLQt5K+k1HCY3sQJvlxVS7/JHueXvUIx8yQbfbPrlzHrt2MfE
         U1hxHKnVEG75qMmusILOpUQ+ve3ki207hWBXAbOSIlTCFHFdAQt2eXfYaaGPVoPeTAf1
         Si1ciSOUGgUynMketsBoIiP2Tm+uGEtE6CUrCS4zVyMDdS2v2/XXPPZXCKZnEWKKcKHS
         OxKNLoq89+H7AqxnawHgK+JvvPB1ULnCHwKMFb5+ZFwm5pkWg6fR2eSWOEGz8Gg6xo4L
         U9LePA4WOvArI8phfg5QDRxweSOUg2c4fU5iDBONABaX6d9ABLgnOI8HpxbWAlMZ9IAZ
         puVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=R8rcqy9nQJGOelQ0T1uj14nSAEDz0dTjOLKedbaq+3w=;
        b=i6R10cIjOlVXphAdL9qv3DQATZ27ST8lh8qMYWGgzoA0Wr2+LYIKdV7W3I3mueXJCq
         4f14ehzlt6p1jvKKdY10gdTs5QslVxfsaJ9Sr29TpbLIsK+JfotZTnhEAD7bv856Gur1
         tx8XlrCgVFyDrE/bkCUd9FFLnvbYTbYD/fchuDy4Bdm9jNzMfd7YYN94yBEdxl9m/IJ6
         IOsFJ7HEIYxaYj1JPc6HutdSGXzTw1uyzktx/L09BPBcRva/sARXhymX8MpZapnNRzRM
         1e7KidqNSQmd2AeX2IhZEKn4nlKWwpeTl8nQPHrSALE+nyeTmeqSwptrbE44b8COnkRv
         qmOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=jsyjdxxQ;
       spf=neutral (google.com: 2a01:238:20a:202:5300::6 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=jsyjdxxQ;
       spf=neutral (google.com: 2a01:238:20a:202:5300::6 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc9qETrzvA==
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power control driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180319135418.GL18359@localhost>
Date: Tue, 20 Mar 2018 15:49:33 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 DTML <devicetree@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel@pyra-handheld.com,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>,
 Kevin Hilman <khilman@baylibre.com>,
 Thierry Reding <treding@nvidia.com>,
 =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com> <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com> <20171222124427.GI3374@localhost> <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com> <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com> <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd> <20180227070415.GB18666@localhost> <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com> <20180319135418.GL18359@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1595468607965808051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

> Am 19.03.2018 um 14:54 schrieb Johan Hovold <johan@kernel.org>:
>=20
> On Tue, Feb 27, 2018 at 08:32:50AM +0100, H. Nikolaus Schaller wrote:
>> Hi Johan,
>>=20
>>> Am 27.02.2018 um 08:04 schrieb Johan Hovold <johan@kernel.org>:
>>>=20
>>> On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
>>>> Hi!
>>>>=20
>>>>>> Let's restart this discussion and focus on the main roadblock =
(others
>>>>>> are minor details which can be sorted out later).
>>>>>>=20
>>>>>> If it feels like a hack, the key issue seems to me to be the =
choice of
>>>>>> the API to present the GPS data to user space. Right?
>>>>>=20
>>>>> Or even more fundamentally, does this belong in the kernel at all?
>>>>=20
>>>> Yes, it does.
>>=20
>> Thanks, Pavel for supporting our view.
>>=20
>>>=20
>>> But not necessarily in its current form.
>>=20
>> Is this a "yes after some code fixes"?
>=20
> No, we need some kind of at least rudimentary gps framework even if we
> allow for a raw (NMEA) interface for the time being (possibly
> indefinitely).

Ok, that would be fine if we can get that!

For a minimal set of API I think something like this (following hci_dev) =
would suffice:

struct gps_dev {
	...
	int (*open)(struct gps_dev *gdev);
	int (*close)(struct gps_dev *gdev);
	int (*send)(struct gps_dev *gdev, char *data, int length);
};

int gps_register_dev(struct gps_dev *gdev);
void gps_unregister_dev(struct gps_dev *gdev);
int gps_recv_nmea_chars(struct gps_dev *gdev, char *data, int length);

If that would wrap all creation of some /dev/ttyGPS0 (or however it is =
called),
it would fit our needs for a driver and user-space for our system.

And I would be happy to get rid of creating and registering a =
/dev/ttyGPS0
in the w2sg0004 driver.

Then, the driver will not need to be touched if the GPS framework is =
improved
in some far future (e.g. to provide some additional ioctl for getting =
kalman-filtered
position+heading by doing sensor fusion with some iio-based =
accelerometer/gyro).=20

So I am looking forward to some framework for review and integration =
testing.

BR and thanks,
Nikolaus=
