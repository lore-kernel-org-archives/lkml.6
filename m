Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AG47ELubqqXO110bZyBWeriqMlI4+LNqt82EF+RGiYmp2S5wAMPmMziZ/mGnQwzYC1uwKophAPky
ARC-Seal: i=1; a=rsa-sha256; t=1520438060; cv=none;
        d=google.com; s=arc-20160816;
        b=pJiJkvljRYcFGf2ygJE8TSDQWgGyrPB89vQ0fHaC1JWV3ssm2HYyt8ATlEIFZiOvZ1
         1UU+ge1gs/fmPz/9593Ddl2a/lFJ2WUmipUhztDt8lyfDVhc/YAhpDO0huxyaxR7czKj
         6HsOuD2NdKIZ2RhCgYdzw7Apf1UH+af0Rg//sQeaQWb6W1Mrhu82uq7ZlVX5yIR12F5S
         P7qSs31LbVzNBYdQXSk5egzmIRYMiQl7aKMX7qDlGHr9pQfk3DpyaWt3plpXI5S5ebxg
         Sy1bUVApZ9ff51MD6xj5dAQxAbbdXn2Y1Zysvy953CgZmr/sTxGxVgRkwKZcUvlHijIs
         inVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=eVBwri79ce9OxQQfDxzw7ZZVrYY7+KDeW7NLhepfSWo=;
        b=AjodYhIjDGk1egeCv+MqKluQrbrGB7DfGD4FVOocZ1881fbgPKMtr2R4JiZmB4JIB+
         c/zOHLXfe9tJNrQJ9xPepNlCNs/k3RIXp3e6m6JUvlG7E5g9dnwV9C8OE2s+fwPzE0zq
         Jyja5nOyfRuL5UugckR0hb1Uws8AXBOn5nT6klhJ7Zz1sqyeJv9Gtb376+CnFcUqSt+h
         3IWB2cCNd/806EepHLP7G7KwXyPNsCTLnPWl9q3pTbzrAL1HvL9p1TgzZlbFmJ8gbb6M
         NDLGJ1E9y1jRvhiaGHBq7hPk5/0yOhxpxzZCovrLnt07ZrGKD0eToZL4WigqnO7muqGx
         yMrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=pdj9hKhK;
       spf=neutral (google.com: 2a01:238:20a:202:5300::11 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=pdj9hKhK;
       spf=neutral (google.com: 2a01:238:20a:202:5300::11 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qEj3wLA==
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power control driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <8B2641B8-E86B-425C-9E79-E9C41E4E623C@goldelico.com>
Date: Wed, 7 Mar 2018 16:53:12 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 DTML <devicetree@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel@pyra-handheld.com,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Thierry Reding <treding@nvidia.com>,
 =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <461DBB7C-5FF7-4723-9518-C9A5E7E5610D@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com> <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com> <20171222124427.GI3374@localhost> <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com> <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com> <20180112153903.GB5992@localhost> <E7ECBBB8-2E88-4F04-AFC3-659332E84CF6@goldelico.com> <20180118061314.GG3286@localhost> <8B2641B8-E86B-425C-9E79-E9C41E4E623C@goldelico.com>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1594294859847296875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,
I know you have a lot of other things to do, but we are still waiting =
for a
statement that this driver will be accepted after fixing the final =
coding issues.

Please advise on how you want to proceed with this.

One more technical comment/question/aspect below:

> Am 18.01.2018 um 14:43 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Johan,
>=20
>> Am 18.01.2018 um 07:13 schrieb Johan Hovold <johan@kernel.org>:
>>=20
>> Hacks are never good, but sometimes needed. But we should try to keep
>> them contained in drivers rather than allow them to spread to core =
code,
>> was what I was trying to say above.
>=20
> Well, aren't we talking here about a well isolated driver? And not =
about
> core code?
>=20
> Core code already provides everything to build a driver for this chip
> to make us happy with.
>=20
> It is just not yet providing a generic gps interface API to make =
everybody
> happy with.
>=20
>>> That is what Andreas did remark as motivation: provide a solution
>>> for *existing* user spaces.
>>=20
>> I understand that this is what you want, but that in itself is not a
>> sufficient reason to put something in the kernel.
>=20
> Agreed, but it is a secondary (but still strong) motivation, not the =
primary one.
>=20
>>=20
>>>>> - can not guarantee (!) to power off the chip if the last =
user-space
>>>>> process using it is killed (which is essential for =
power-management of
>>>>> a handheld, battery operated device)
>>>>=20
>>>> That depends on how you implement things (extending gpsd, wrapper
>>>> script, pty daemon, ...).
>>>=20
>>> No. You can of course cover all standard cases but there is one =
fundamental
>>> issue which is IMHO a problem of any user-space implementation:
>>>=20
>>> 	How can you guarantee that the chip is powered off if no
>>> 	user-space process is using it or if the last process doing
>>> 	this is killed by *whatever* reason?
>>>=20
>>> E.g. after a kill -9. Or if someone deinstalls gpsd or whatever and =
assumes
>>> (and wants a guarantee) that GPS is now turned off and never turned =
on drawing
>>> precious milliamps from the battery for no use.
>>=20
>> Have something run at init to put the device in a low power state.

If I look for example at the camera module drivers provided by
drivers/media/i2c, most of them could be easily power-controlled from
user-space by i2c-tools and 1-2 gpios through /sys/class/gpio and
a big set of scripts.

Still they have a place in the kernel and cameras are powered on
if the device is opened and powered down if it is closed.

So I am still trying to understand the rationale and logic (if one =
exists)
behind having them in kernel but rejecting our driver which does the
same for a different class of devices.

> This does *not* solve the issue how to *guarantee* that it becomes
> powered off if the number of user-space processes goes down to zero
> *after* init.
>=20
> Please consider that a portable device is rarely booted but might be
> operated over several days with many suspend cycles. And people may
> still expect that the power consumer "GPS" is turned off if their
> personal user-space setup simply kills gpsd.

>=20
>>=20
>>> As it is well known, a user-space process can't protect itself =
against kill -9.
>>> Or has this recently been changed and I am not aware of?
>>>=20
>>> This is the fundamental reason why we need a kernel driver to =
provide
>>> reliable, repeatable and trustable power management of this chip.
>>>=20
>>> It is equally fundamental as a hard disk should spin down after the =
last
>>> file is closed. Even if this process ends by a kill -9.
>=20
> Please advise how we should solve this fundamental problem in =
user-space.
>=20
>>>=20
>>> This seems to contradict your argument that user-space can very =
easily
>>> adapt to everything. If the latter were true there would be no need =
to
>>> keep old interfaces supported for a long time.
>>=20
>> You probably know that we try hard never to change an interface that
>> would break user space, and that's why we need to get it right.
>=20
> Yes, I know and agree that it is very important (and difficult to =
achieve).
>=20
> But it seems that there are different opinions of what "right" is...
>=20
> You seem to focus on the "right" API only (where we agree that the =
"right"
> API does not exist and likely will never come or at least in the near =
future).
>=20
> But for us the whole combination of kernel + user-space must behave =
"right"
> (and use a function split that allows to optimally achieve this goal).
>=20
>>=20
>>> So can you agree to that a battery powered portable device must have
>>> reliable and trustable power management? And if it provable can't be
>>> implemented in user-space (a single counter example suffices) it =
must
>>> be a kernel driver?
>>=20
>> Having a kernel driver would make things easier for user space, sure,
>> but again, that's not a sufficient reason to merge just any kernel
>> implementation.
>=20
> It is not about "easier" for anyone. Neither for you nor for me. For =
us
> it would be much easier not to have to run this never-ending =
discussion
> over and over...
>=20
> It is about making it technically fully "reliable". And not 99% as per
> quick and dirty user-space hacks.
>=20
> It is so easy to invent scenarios in user-space to make the device =
practically
> unusable by unnoticed draining a full battery within less than a day =
when
> not perfectly turning off the chip power.
>=20
> So if a kernel driver can better protect users against this situation =
for
> a portable device with this chip, why shouldn't it do with a handful =
LOC?
> What requirement is more important than this?
>=20
> BR and thanks,
> Nikolaus
>=20

BR and thanks,
Nikolaus Schaller
