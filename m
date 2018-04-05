Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522909794; cv=none;
        d=google.com; s=arc-20160816;
        b=A0P7YUUERpdWgdmwJoqwI1kosZCv90yK9Sbd6om0kRKK9f8a8Z9FJQ/xtwpPXfJkTj
         toj/V3jaCzkSN7og32daPzdACMkuFXZ5tPvVIDBVrI/JzNAfCVERhTiFCYybmdaSekHc
         lG/3QfVW+LDu3Yi2WPDiwrXEOzai8kbUQWCMF6TtiYwsDPYoksz37BRevt/K5HAvhKRh
         sPDLzsIs+njhta3CTPC4ay9uyQiQW5R0BeXf9gUYpntSq2Z92AKVC6+DPmeW+4rQakI7
         XKUQDn34DWZkwcsVrOaM29EZU+ibLr/QgwwZ6iKlLCPCt7iwIXaWdPZOHUye+2tox5Va
         xkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ro378sUmnNmrWw87xANnbcWtaXTyubssqYH8WPA+5vw=;
        b=k8OXGupbudILfhneNMM2JZ4SSDnPLatGsKd4Vh5IP1kICuj5EtOvewlyZAGCr5fVIE
         vfujpeeeK5vQ2FtqLUytX/jpGuJlLf0tJq3CFRcvz8nXSunF46rUJsz4r9ONRgS6hZYT
         /tnknbkK0f3UVtBpNvFDeulrpYwQKvECp++q2axg3XkkWDxvZcVhKxH1VJXaY9nlEwy/
         kdkJFCxtQRSb12+x/in09rB1rOCQwoOr00dv+14zZEQ+VzHwFQDknqPFYaD0/veqHQRo
         LSSaLws2pvyJxS1r2ntUuHnVGN5zEzZFPKUbM6NxyLu7CJQ3iPHKoeJR4PI6IW6IKUlx
         hfMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QXPbORFt;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QXPbORFt;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+k2/5f4t92mQHcQLojDX+plY6rj6BoD2dq75+ShdS01kaGbGMNDOFwHo8GezWgcGbhHeYPpg/figQUsAjuPoE=
MIME-Version: 1.0
In-Reply-To: <20180404215623.2bf07406@bbrezillon>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home> <20180404215623.2bf07406@bbrezillon>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Apr 2018 08:29:53 +0200
Message-ID: <CAPDyKFoFz_HgYPOMGuOTpehrTR3DtWE3uZbcnVwUwVhDy02Mow@mail.gmail.com>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Nicolas Pitre <nico@fluxnic.net>, Samuel Ortiz <samuel@sortiz.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, driverdevel <devel@driverdev.osuosl.org>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644905129799893?=
X-GMAIL-MSGID: =?utf-8?q?1596886661275565469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4 April 2018 at 21:56, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> On Wed, 04 Apr 2018 21:49:26 +0200
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> >> Hi,
>> >>
>> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
>> >> knowledge of the DMA requestors into architecture code.
>> >> As this looks like a patch bomb, each maintainer expressing for his tree either
>> >> an Ack or "I want to take through my tree" will be spared in the next iterations
>> >> of this serie.
>> >
>> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
>> > would removed some churns and make this faster/easier? Well, if you
>> > receive the needed acks of course.
>> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all
>
> Especially since 3.17-rc1 has been released more than 3 years ago :-),
> but I guess you meant 4.17-rc1.

Yeah, I realize that I was a bit lost in time yesterday. Even more
people have been having fun about it (me too). :-)

Kind regards
Uffe
