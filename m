Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522871795-5-11919981775137999211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522871795; b=tPXD38K3+qiZRE5kXopP3w2HUiLcCmu5oKB6tYH6kF+buPZYVV
    SzmqUttDNhgAKr9BSTi6IBuua/poQSRfpqDB8HngeAphDFhCadUrhLbk7gdS19Rl
    dT/bKEX9kpKZmMg16Rymd4rKGcoJkjHmk8O0AvDpyD1DiD9pasfJG3wk7yoqivTC
    92kJE/LIStOsdJef7PdjmxEUUn1nYT6Qmoj8vPJe//zwvigF6DTiTQWMQttFavky
    /fL3WDd7+QrENTwY5IPOkdKkokyUtTJK8BfsRfp8l4wD3u7e1rex7nOBpxsRn+VR
    XWN16GzH16FIuX1fxP6Haoj9BwY225FHJhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522871795; bh=7cJsh
    6WOxaR2ew/MsN+TcFlBc51Fl9cdampA0dieF1U=; b=rNg9Vk9SrZMPgTgalZTBr
    8dzjp+efKEKOWc4DQ6eDqQRZD6q+1J3+t58NDbmLdMitkyb+6IZ7UValJjWb8Q0f
    tKoJ/2koNhgKmQXe8Dbw3ghT6e4ITcc5kkD/oN7tPGXRj+kV5PAValASuAlUZpyz
    HY/TvkyKQ5+lBSzyC5BvGgnt1hMoHzskRDxPuykLylU/I2AzQzVSCe/+ZOjDnk8Y
    v3lkZp3wzWpFnKOxNQ1HmdSlA8QzdTJmmcMcnMtUF0eEEUf/VwuXA1vXwMCpLd7c
    WEfvHtQ+/2Hs7QJXM4pnKTIVSAXXuvHOcZbuEBOkutHpsW9SouX9m3uR/HLHyi+1
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEEqN3JaZ6A/Ts5Xuzn6CQCTr11kaZ964KTChbmQkh+1x5mQY4UBBNzmdh7F2Urm5SbMxRI/mAS7raPNWwJBiTeztYd1PrkCtx6a3OUOfhdD/U2PBFeR
    y1GLHK0rpnWW9QOpUPuBXZ2moeiRNlYL4+9xrV75dBq7PUiL0egRttWQyaT2aMEaBKr+QLZ3gejhc5hx1mlK2eaymtd2cUg4hlxNVtZsf0i9U+dOe1WnNdoI
    qUVUKhT/PVw9P8vYYSfUug==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=DDOyTI_5AAAA:8
    a=S6tNpf5VY_hrQvZA2fUA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 4 Apr 2018 21:56:23 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
Message-ID: <20180404215623.2bf07406@bbrezillon>
In-Reply-To: <874lkq4urd.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
 Jaroslav Kysela <perex@perex.cz>, linux-ide@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 driverdevel <devel@driverdev.osuosl.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
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

On Wed, 04 Apr 2018 21:49:26 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:  
> >> Hi,
> >>
> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
> >> knowledge of the DMA requestors into architecture code.
> >> As this looks like a patch bomb, each maintainer expressing for his tree either
> >> an Ack or "I want to take through my tree" will be spared in the next iterations
> >> of this serie.  
> >
> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
> > would removed some churns and make this faster/easier? Well, if you
> > receive the needed acks of course.  
> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all

Especially since 3.17-rc1 has been released more than 3 years ago :-),
but I guess you meant 4.17-rc1.

> acks, I'll queue it into my pxa tree. If at least one maintainer withholds his
> ack, the end of the serie (phase 3) won't be applied until it is sorted out.
> 
> Cheers.
> 
> --
> Robert

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
