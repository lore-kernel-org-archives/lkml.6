Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517499365; cv=none;
        d=google.com; s=arc-20160816;
        b=WAOUSY43x1TKO9Hh+fPvo/FIprtLO7ujOM0q7B4GUdyyB5z80yzmEUInlE+juYKxLn
         JjBjFY9eu06v3QnSJmRX/KK6CHyssFMmSF6MDGaxeKc/N44TjkV9lo/R9+9KOj3NmeJb
         0/RZTboMsJ+nMziM4MSbPVi3ckLZWcFiKMzcks0GmAabAJsgdyDWawWiHXV1F5pcybMR
         sL6tSwr8uVXeQwhTZS35YyoXhSXRYU6xLuDFN7dOCvb1UNB/OpxLlC79KzjnkYw91TFw
         7R6Al1MyBVtpqkJYcQXZHCWRJkvHQPTZhE2Xs2KD0acuI62kDiL8mr1oNE48T/GVRHFl
         D6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7NrDr9SEyHkhzdZwcF67R1ycLo+fnqOfR8hkrM8czS0=;
        b=MOXvoj3/U+djiiKz5BRW4DsuKRonvr9aPSHUSqi92qephV9c3k7iwD4t+vShPrpX/A
         cN35UTi+JZmDddobI1T25i9kLQGKbvJi8yYKZQZTVdwnQEQ9z5kt/qbeSaPRoesezsFn
         nxbd2+Fip9KsGncS4y54mFeBNqPwZYFfhN9sjkTiS2lvz7aej247Ap+bQil6TyXZxRCN
         /3e0VOr99TP2C2GjExrW06leSnowMbG32d9A+hVdrZD3LiCrK/zg0PjJDWemMtjv44og
         DMqxrRurIB/essu6J8PCmZgUgD98umtNOdcndVtx1qiH/kM9RL64NJHaBSXtz83RsdR5
         iGlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BtkaspWP;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BtkaspWP;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227zNRfbxiUjIERA2DrZ1GdKuHikgm0GRAJmrFtt/AG86yTUWDbZPoIBgqHVp+o4o6BJqrziBqpTab0Uoyt+lFM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180201152908.mdei742x5k4fye6p@flea.lan>
References: <CACRpkdan52UB7HOyH1gnHWg4CDke_VQxAdq8cBgwUroibE59Ow@mail.gmail.com>
 <20180129082533.6edmqgbauo6q5dgz@flea.lan> <CACRpkdYAGwUjr2C-w5U+WuG48pZAOUcnxFjznLbdF6Lmy1uZuQ@mail.gmail.com>
 <CAK8P3a2HmPOTHAzqBnmim388pcWOE=fG50mG5HJifT=vzKOaTg@mail.gmail.com>
 <20180130075441.rqxzkwero6sdfak6@flea.lan> <CAK8P3a0QxQE=GM=SGPtT82=UreiqsgY6uMThvQ_woA3rjK0zjA@mail.gmail.com>
 <20180130095916.GA23047@ulmo> <20180130100150.GB23047@ulmo>
 <20180131072910.ajp3jc5dmetsjtf2@flea.lan> <CAK8P3a0X2bpLjKE6xKehG1junZoG1N_DjepOBQ+SZetKf6sgfA@mail.gmail.com>
 <20180201152908.mdei742x5k4fye6p@flea.lan>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Feb 2018 16:36:04 +0100
X-Google-Sender-Auth: IfSsIKaFGmizUXlozlVdnfCkBKY
Message-ID: <CAK8P3a2+wH_n6sKNOyzv7sGBuvYX++5ffahfz780WtKr3Bvj=A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Dave Martin <dave.martin@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>, Yong Deng <yong.deng@magewell.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>, Randy Dunlap <rdunlap@infradead.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Hugues Fruchet <hugues.fruchet@st.com>,
	Yannick Fertre <yannick.fertre@st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Rick Chang <rick.chang@mediatek.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>,
	megous@megous.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590370608168306586?=
X-GMAIL-MSGID: =?utf-8?q?1591213414933093014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 4:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 31, 2018 at 10:37:37AM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 31, 2018 at 8:29 AM, Maxime Ripard
>
>> I can think of a couple of other problems that may or may not be
>> relevant in the future that would require a more complex solution:
>>
>> - a device that is a bus master on more than one bus, e.g. a
>>   DMA engine that can copy between the CPU address space and
>>   another memory controller that is not visible to the CPU
>>
>> - a device that is connected to main memory both through an IOMMU
>>   and directly through its parent bus, and the device itself is in
>>   control over which of the two it uses (usually the IOMMU would
>>   contol whether a device is bypassing translation)
>>
>> - a device that has a single DMA address space with some form
>>   of non-linear mapping to one or more parent buses. Some of these
>>   can be expressed using the parent's dma-ranges properties, but
>>   our code currently only looks at the first entry in dma-ranges.
>
> As far as I know, we're in neither of these cases.

The point here was more about the general question of where we are
heading with the complexity of finding the right DMA settings. It's
already too complicated for anyone to fully understand what is
going on with DMA masks, offset, coherency etc when we look
at the existing DT bindings. Adding more complexity makes it
worse, so if anyone else is in need of a solution for the issues
above, we should try to accommodate their needs at the same time
to avoid adding more complexity now and again later on if we
can come up with a way that works for everyone now.

     Arnd
