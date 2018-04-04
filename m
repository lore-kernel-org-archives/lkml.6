Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522871386-5-17015989346078157779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='fr', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522871385; b=LTWsWpuiNnOEhuywju2UL2yg9QZhbkdxDy3AOI8jx3UmqdGbdZ
    b2DRpYcyZQXlbyuGJQnNSD994MN2ZudtvqDA7KWmItmH14KyBSggSPkk8uqLRvqf
    Uya0tQYYP7Mg+OgGzw85RzSn09wQIBbmjGqHRhcuMMiyiQ8DYKSbsAz6KlvBgYUP
    qj82kBex1VIUPmWU/S7LXLn8w/WUjXdXckIh8lCYmZeq0zK0foQDM+TI1HWnQahM
    uGBdnZ2KKKjERJ4UMiYprq2BRNLdQp/LFP5IrfMOv6SLXGW9y7dRX0If6FuXyd2m
    Xa62RKy8fiNDJy9OCRa5ETU0gpBvpNVKTX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522871385; bh=rtBNQ
    W5xWtB05k/5MeRNky6hnBbMloJ+oH0jdMOPQkY=; b=VeAlG4ZIj84GW6J4R2lGr
    /DUDQZwYP/YksYHngpUiadioNBefFWRZ4DwGLv8h0z7U+W6JnyVO3QgRT1brp2Kf
    uhgACQCogHAL68gKn53/uN9pJcF3x2aZf/ehB2ON1JY/IM0BZLwxZRACP/rYNpRI
    da8XCT3uK8Zw2mVITzVyQgnWTdDDhlI4AXnd9b/D8htt4o3KxmpoNXApj5vFrP8y
    cOb7zuAPQDCxjCQOAcu3HcRjf4EDWUvam3Bav9263d69/eGRQyMvB3L6OP+MynD8
    geDp0PrRthloEIiYSoHLAMSIpv4qXSUF17u1XjED6POrbuoNAJ1pMHJM7MFuUxfQ
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJfTVrysOHVO1M/VhsuF4QrdG8UzgUphbeBN4qhsB/u02aXCUwZqqFIxWAnnbmMq9ldzfAVjYpxzzqcvM6/pVQ8BwMRlD9U/KGqt5MJgHITdXmT0WMID
    HzpivrPPZH0hEV4tWXJH0N9AfYDaLKpqFhDgJbQzhwFOyQW+/fh0cIi3gD+MUM0xY22kiX5OPpA6omhb1fGmfP98nJCjn/jVBkfd7YWryv2Mcu2bbPjehCUU
    CluRdI+D0jJJqyJJiy1jGg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=DDOyTI_5AAAA:8
    a=0uNMWNoD-LD8VDpMNv8A:9 a=CjuIK1q_8ugA:10 a=9ebnPlJV2y8A:10
    a=cvBusfyB2V15izCimMoJ:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 04 Apr 2018 21:49:34 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 04 Apr 2018 21:49:26 +0200
In-Reply-To: <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
 (Ulf Hansson's message of "Tue, 3 Apr 2018 17:08:42 +0200")
Message-ID: <874lkq4urd.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
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
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-mtd@lists.infradead.org, driverdevel <devel@driverdev.osuosl.org>,
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

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Hi,
>>
>> This serie is aimed at removing the dmaengine slave compat use, and transfer
>> knowledge of the DMA requestors into architecture code.
>> As this looks like a patch bomb, each maintainer expressing for his tree either
>> an Ack or "I want to take through my tree" will be spared in the next iterations
>> of this serie.
>
> Perhaps an option is to send this hole series as PR for 3.17 rc1, that
> would removed some churns and make this faster/easier? Well, if you
> receive the needed acks of course.
For 3.17-rc1 it looks a bit optimistic with the review time ... If I have all
acks, I'll queue it into my pxa tree. If at least one maintainer withholds his
ack, the end of the serie (phase 3) won't be applied until it is sorted out.

Cheers.

--
Robert
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
