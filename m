Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2086647-1522911019-5-15892443605450908629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522911019; b=o6f2yBcuLxzUJw7dJLXTc18e/igRbpARPRdS3SyVKDTLYNK8C/
    J3VWisPzP4+Vrq0CXiwg3keGSRm4pMn+ewHs7tki51PjwHYi3+gQ8dbIAZK6+GB5
    xUfMD2NFVIiSPYB8vmX8gRgU5G+DdaogF+B6jbmnZ9loZLa2iYgqBZItXBimCrkk
    XE41DNeb2VZnFyiKLWRBtUHOFsHwfrvoK3xScuAi4PEE6qwOh+SjOY/Zfu7RLxlW
    z32s/RnrQQgRNpx847JHShXvRWHbmFLPKnZOBOJwt1XlsTXOKOabj6ATGt8B7cjA
    r5JVUhFxYNTnNbhwsgMq8LyYYG0WKxwH/oJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522911019; bh=09tVn
    FB30/3GCe2vv2vHn97TgSg9jqmYz8n5cDKsKc4=; b=iUrxLrK474SpWgEWyOKyF
    Nf/vUZm0UPWm31m6yaT2xEU5fUfp3qmhqXzinNp5HSvb1wTcqQ/70pJ0tBVRI66P
    3NowdeOB/xDkz0KO48xMlH78B7utW257EW4vp4eLWnkpm3skQKzuCdOthH2XX6R7
    o8+XkfOXfBFT9nBTlKPSz/AmZt7Ih8toFxToOzJenP2lJshptjmdtwKlOqOYZ1iH
    SCgUW5KkoFxuUYa7fPy/mQUayk6ihqycogJ/qucG1kcFP4A3RsRWzJK2H6JKskB6
    APafn5IqhuyBtswju0Tn9g1YngOFNiBZ9oU66LhtrV2L049JxTpLMtNdTMm+OO5i
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0dW7n+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A7M9LKMN;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0dW7n+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A7M9LKMN;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3AjInb6QnmDsIXtz3YjN3VluDoNhv1vJCpS0warve7WV6B+YdOkJ+4V9nrzi13ZCKKDw90XnRNauihKRFEWKZ4bw4T5ZPTbsZxSeiOYaOYutmiHH4M
    4mq8GaHWO50sT0XTk5u6gt4frcQGDPb19BkFrZ/TPE3QF8MCBbQGGRVnD+IpdpnJ8+bg2xm9ZEQzYqvaC2YlcNXOUiqpXqmfTXZpbf13n4ALeT6tEdGVySVx
    bDDRVAQKQQpmxbl03wHLAQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=P-IC7800AAAA:8
    a=DDOyTI_5AAAA:8 a=fhrfqWjZBJfTMOB8RF8A:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+wlIWzRtEeKDBuaFyMpqt1v0uDDQtB27+Ykjp0Q5RkpENHZw6ICQ6bEK3qEpuaIkpTunWP7PyafZErmVMIEKk=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoFz_HgYPOMGuOTpehrTR3DtWE3uZbcnVwUwVhDy02Mow@mail.gmail.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 <874lkq4urd.fsf@belgarion.home> <20180404215623.2bf07406@bbrezillon>
 <CAPDyKFoFz_HgYPOMGuOTpehrTR3DtWE3uZbcnVwUwVhDy02Mow@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 08:50:03 +0200
X-Google-Sender-Auth: 5_HjEQ1gBZwz-j3T-R-E59qgfiE
Message-ID: <CAK8P3a1Y0X-2QQm+adXO8xNr7Z6SU6rDjZs8JhRskX-UrseyRw@mail.gmail.com>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
To: Ulf Hansson <ulf.hansson@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 IDE-ML <linux-ide@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 driverdevel <devel@driverdev.osuosl.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
 Richard Weinberger <richard@nod.at>, Takashi Iwai <tiwai@suse.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Samuel Ortiz <samuel@sortiz.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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

On Thu, Apr 5, 2018 at 8:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 April 2018 at 21:56, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>> On Wed, 04 Apr 2018 21:49:26 +0200
>> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>
>>> > On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> >> Hi,
>>> >>
>>> >> This serie is aimed at removing the dmaengine slave compat use, and transfer
>>> >> knowledge of the DMA requestors into architecture code.
>>> >> As this looks like a patch bomb, each maintainer expressing for his tree either
>>> >> an Ack or "I want to take through my tree" will be spared in the next iterations
>>> >> of this serie.
>>> >
>>> > Perhaps an option is to send this hole series as PR for 3.17 rc1, that
>>> > would removed some churns and make this faster/easier? Well, if you
>>> > receive the needed acks of course.
>>> For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all
>>
>> Especially since 3.17-rc1 has been released more than 3 years ago :-),
>> but I guess you meant 4.17-rc1.
>
> Yeah, I realize that I was a bit lost in time yesterday. Even more
> people have been having fun about it (me too). :-)

I occasionally still type 2.6.17 when I mean 4.17.

       Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
