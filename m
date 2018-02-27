Return-Path: <hns@goldelico.com>
X-Google-Smtp-Source: AG47ELveSiqr/qxZYJeumc4PWr2GbxTiNIbHjJvW+JwMytQIfT8FMcOLgFBHJ56xpg97rZAqyvFt
ARC-Seal: i=1; a=rsa-sha256; t=1519716820; cv=none;
        d=google.com; s=arc-20160816;
        b=dJ53kJtoPa43b0f7qpSn5PE9bPIOwelkhlUXZHbUNAnmbmM8SQuBFrvysD6My2vIkd
         o8qLpAlIIzUET8y3hyms/BNDeknzeTDCY4QzW/fidnxhZJs6lkDYIFzoiuvoqutbKRv0
         g2kB6f5LGnKdsV3FgqM/oT/C6tSca2/45WGyVD+7WbWofK3YENiSK6VoMcacYxXfykQH
         eXBO31VENZ/YxapROqwUAWBUnWmZsCniFWoP0cA5J/mRyhNpCuXMGOryL++rYn4bymsg
         pXC+n0/t3/5L+pBzMySw7imJDBErprs8llq5BK5ObkfdMyrUI8pTSn0dwrl6z+bLQSbT
         IO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=UDCFhsKIZB2zKSXKze8mHTxDGOF6cWL64G29bvg/15s=;
        b=aWQWZJHcF45p2C1hIZ3f6ArNymhO0vsTHu6CIYC+BLAnTaIcwzAljAXacV52mrzkqX
         fewYgVH/q4MDR84sBIxii9HU0TzGHFFEY8aY/lcB+mV/2D/+81XLFR0UXFwUm2w16JVc
         qmmreNdm+5oYMMGtmH/KI/9Xi5ZrZSKv97cuTTXzo69cXL3hlgEDKO3ri8P6jdCDFqxU
         1fSlZ6h16dgFkjnSoL552G9tT7s+rWdbqyy4bODOzIiey2tTFKDo3d6xHtLVICTd1VlF
         X7p7bZEi+BnvRjc/OSol5PpCukGAqoaSQdzJYy0gfpHBPImtri1B6JboInGUWIq2DhzG
         eQ5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=T0YoWwny;
       spf=neutral (google.com: 2a01:238:20a:202:5300::12 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@goldelico.com header.s=strato-dkim-0002 header.b=T0YoWwny;
       spf=neutral (google.com: 2a01:238:20a:202:5300::12 is neither permitted nor denied by best guess record for domain of hns@goldelico.com) smtp.mailfrom=hns@goldelico.com
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdNwE1M=
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power control driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180227070415.GB18666@localhost>
Date: Tue, 27 Feb 2018 08:32:50 +0100
Cc: Pavel Machek <pavel@ucw.cz>,
 Mark Rutland <mark.rutland@arm.com>,
 DTML <devicetree@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 kernel@pyra-handheld.com,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com> <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com> <20171222124427.GI3374@localhost> <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com> <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com> <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd> <20180227070415.GB18666@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1593538585265608336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

> Am 27.02.2018 um 08:04 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Mon, Feb 12, 2018 at 04:26:18PM +0100, Pavel Machek wrote:
>> Hi!
>> 
>>>> Let's restart this discussion and focus on the main roadblock (others
>>>> are minor details which can be sorted out later).
>>>> 
>>>> If it feels like a hack, the key issue seems to me to be the choice of
>>>> the API to present the GPS data to user space. Right?
>>> 
>>> Or even more fundamentally, does this belong in the kernel at all?
>> 
>> Yes, it does.

Thanks, Pavel for supporting our view.

> 
> But not necessarily in its current form.

Is this a "yes after some code fixes"?

Pavel mentioned an example where such an evolutionary approach was taken.

> 
>>> Now, if we'd ever have a proper GPS framework that handled everything in
>>> kernel space (i.e. no more gpsd) then we would be able to write kernel
>>> drivers that also take care of PM. But perhaps that's unlikely to ever
>>> be realised given the state of things (proprietary protocols, numerous
>>> quirky implementations, etc).
>> 
>> That is what needs to happen.
>> 
>>> The kernel is probably not the place to be working around issues like
>>> that, even if serdev at least allows for such hacks to be fairly
>>> isolated in drivers (unlike some of the earlier proposals touching core
>>> code).
>> 
>> Oh, kernel is indeed right place to provide hardware abstraction --
>> and that includes bug workarounds.
> 
> Right, at least when such hacks can be confined to a driver and not be
> spread all over the place.

It seems that you forgot that the driver we propose is not spread all over
the place. It *is* confined to a single driver thanks to the serdev api.

BR and thanks,
Nikolaus
