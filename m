Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923211-1522739624-2-13680846014682969494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522739624; b=FeJJygKgOavnctNUlm02qDXRuHfOOOQH+DMErMzOa4BBj8gIjh
    0OA7a44mhYjHdg85O1WWfyaF5LbtNk9c3fsyvCtOUI6oFnYAsmPc8L8vbwkDnGe8
    6PmTVRc4OORjWFFNtEcNsA4i4iaoFjRclRpOCMKCGIYiQPLvZxFUn9wdR7T2hfXf
    4LxS1fQEcutDaW4H796E1UogcZPUHLGfTjVlbKZ7jhIz/1b2PV3Jradisyphs7nI
    sHe7UI8DHmbu2kKvwOmwm2wp0+dweDtzm8yk15DA+7WOrzCJG4/ElPBtzOhbjwCq
    TsD78L2m8UBxflIPmyYZlvU4LbsN8XUFvW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522739624; bh=SyYh+
    jQOn46cgtjD9KZx/HthEywp9WvAs+XsLLq0DI0=; b=AXONOXmLD0DqiertXki0X
    xnBrb8jwYktA2Wuv5jnhqXekf+lVqU/UTF0k20Xhp8rDTNKMd4k5re/d4gZ1tl07
    QUtzF9qKcAsZ515ZwDcxDsXmq6nEsv67lFR2f3wGbUL97CW9MVE7Q7ZfA3RM2h30
    pyaySdDQ+6BC9e2GkMt6o4UYh82EzAjD875c1N2EwJMLcPX+wjHDVNiDkISAUYES
    p3HETXcc9GCj4aNx+SU5IwNGb3HkMHEbrDpd2YjsV8dohhxGJJSvecH1D9j2uA6m
    9ntpr/mTF5oKdZeDeZqQi1aItHvQYqWaIeIwhqAgiodBYwndbfvKzhep1VaMRF4D
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cv9gQ4iN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nJNc6AxH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cv9gQ4iN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nJNc6AxH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKO0k+fm02sxVDNtzRfva92/tBiQ1/TkUvV2OgvXiqH79ZjveanA2jT/TnJe/igqAGh1pTc6tsuubmQYWJ2kSpWQMvlNDKnV12sx81Y/yuH9udwnNj+R
    4bzhhjmq7QHPej5nX6yLhBq9okd7lhgYFCjbg7uS8mcSAx5q6cXS0LreRWVoDO8cC6J6vNEngKF9MlMD6ZYVM/57PNnW/1NCMVgI2vSFXzEroW7z5oR6j8oL
    U1ttzxgoS1PBMG/vz8AOJQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=xHGiGjTIuuxnK5L4MfEA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4953oUP7nIvCQdTnL5CEtX2ACGtQbF1d6eG3EDeSZIr+HLB+bh1HxB4uwvf3pNy6M8DF4CHIdmUcepnG4daT0g=
MIME-Version: 1.0
In-Reply-To: <201804030025.FmWPyArN%fengguang.wu@intel.com>
References: <20180402142656.26815-13-robert.jarzmik@free.fr>
 <201804030025.FmWPyArN%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 09:13:34 +0200
X-Google-Sender-Auth: 2APJ1Bv9YqmVyLjdJAl1ETPlDQU
Message-ID: <CAK8P3a0T3HV9ee4Kk7+Y16S-51SLzbn5fRBsr4bSV0ZQnthPVg@mail.gmail.com>
Subject: Re: [PATCH 12/15] dmaengine: pxa: make the filter function internal
To: kbuild test robot <lkp@intel.com>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, IDE-ML <linux-ide@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Samuel Ortiz <samuel@sortiz.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
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

On Mon, Apr 2, 2018 at 6:35 PM, kbuild test robot <lkp@intel.com> wrote:

>
>    drivers/mtd/nand/marvell_nand.c:2621:17: sparse: undefined identifier 'pxad_filter_fn'
>>> drivers/mtd/nand/marvell_nand.c:2621:17: sparse: call with no type!
>    In file included from drivers/mtd/nand/marvell_nand.c:21:0:
>    drivers/mtd/nand/marvell_nand.c: In function 'marvell_nfc_init_dma':
>    drivers/mtd/nand/marvell_nand.c:2621:42: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
>       dma_request_slave_channel_compat(mask, pxad_filter_fn,
>                                              ^
>    include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
>      __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
>                                                  ^
>    drivers/mtd/nand/marvell_nand.c:2621:42: note: each undeclared identifier is reported only once for each function it appears in
>       dma_request_slave_channel_compat(mask, pxad_filter_fn,
>                                              ^
>    include/linux/dmaengine.h:1408:46: note: in definition of macro 'dma_request_slave_channel_compat'
>      __dma_request_slave_channel_compat(&(mask), x, y, dev, name)

The driver is a replacement for the pxa3xx nand driver, so it now has
to get changed as well.

       Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
