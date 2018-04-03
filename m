Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923211-1522739712-2-10884206894780013916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522739711; b=boM7lBy4bopuWczHoFC40E/NzIY4qr/EhVcia6b+MVEKWSvfk0
    sg/MaUJw7+NPuiUDPgh3VEfPyyKMI//wfI8K0pDCgJPTByr0aL541WSRvmfQ4dHs
    h6eVK2bZFC6/LjPRvhph5IW1b/mNzdeIBnqzpbpYCR2O3Ro4JIRS9OHh8Iu/ofT9
    LUl1lwXI6NIrwh+RZrra//0N+VSEUb81njnljBiMQqmHXbrhXcImo1VNJIn4kB4p
    zIzW5t1Up20hJ1ToD1BH+wP5Vkfy6jePg3gqNoXZgjwv/VeYVxeHro8UyXLaDOO6
    HXHGTd4XoLIOTxKweb0EWIoRKoZK5lJbtBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522739711; bh=JESWh
    zSYWVyj2UWr4AA4Nm73ckXmLVvzWUeScCWaeeM=; b=tgv4zI4vz/Uy6A2Xe2NEE
    LbdHPAMCIhPZgPyoCsr15BKUgd9A9jJsIpSm+uZFSJ4bMe3YggVElLAAPwBtn77B
    FYr6aKXGnoMHzjc9C9H0BVXuQhKIVt14jArg4hs0FP2MAOvyR1VypMNNNZ7k/y38
    iS+086QhknBbKRO3NRoBkZupohVV4EBuRVG2PQinKDBojC4wMVq2lZo+uNeoefPG
    TrJkyukjoiuqKAc2kTs5ggcTPdsRSMlUxLpS3vQt2WEnboqfVTLIasQJTdB5yO7E
    ciuM3aZXnibMvb4iCNNew1godyrDf+E7Ilxwzrjlzu2hNyarrmAxr7BxFjS0YvNP
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rpDJ97+M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A09daxMC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rpDJ97+M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A09daxMC;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZG2rMrMMdiaPPizEXiEf0JIfUKCciOm2rBWjJCmrHmtjpET+3BAHNKDj9R8y2HWxgE7YYAnOAjTlw6kuVx4KKNlGLnPmWQBUvmCO9nMlVlCok6rkP4
    VOYVCa1dg7nA5kKEhmlNvXgmgO4GyU+UP3EYF8H6/v3KMkCJTWxIc5joujr5B1CeZHgpkM9j3CjDnN7FickR5vJQoIjGqdM2V5XPHSOF37oiBT9x6Sy5oQj7
    nmpOEJturcDfBOWKduVKYA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=_4flbzIaVCeXR7HAoQkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/iN4G6G3YQlbpZki4Btmn5VLR+843nreINOuPIQz6dCgPJa0yYEc4mZvxOLzqCimnkVTD84kPO+YQHtyX8yqQ=
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 09:15:03 +0200
X-Google-Sender-Auth: lN6egglfOSLD5xWCDCvyUg_3QnE
Message-ID: <CAK8P3a20etAsuj_-b2UbtPcTdB0ry7CZbh660omTk=c_eY8N6w@mail.gmail.com>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
To: Robert Jarzmik <robert.jarzmik@free.fr>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, IDE-ML <linux-ide@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Samuel Ortiz <samuel@sortiz.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi,
>
> This serie is aimed at removing the dmaengine slave compat use, and transfer
> knowledge of the DMA requestors into architecture code.
>
> This was discussed/advised by Arnd a couple of years back, it's almost time.
>
> The serie is divided in 3 phasees :
>  - phase 1 : patch 1/15 and patch 2/15
>    => this is the preparation work
>  - phase 2 : patches 3/15 .. 10/15
>    => this is the switch of all the drivers
>    => this one will require either an Ack of the maintainers or be taken by them
>       once phase 1 is merged
>  - phase 3 : patches 11/15
>    => this is the last part, cleanup and removal of export of the DMA filter
>       function
>
> As this looks like a patch bomb, each maintainer expressing for his tree either
> an Ack or "I want to take through my tree" will be spared in the next iterations
> of this serie.
>
> Several of these changes have been tested on actual hardware, including :
>  - pxamci
>  - pxa_camera
>  - smc*
>  - ASoC and SSP
>
> Happy review.

This looks really great overall, thanks for cleaning this up!

The SSP part is still a bit weird, as I commented, but I'm sure we can
figure something out there.

    Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
