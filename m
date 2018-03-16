Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3171573-1521211048-2-6201147573589955550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521211048; b=RoJzT1Y1MJVdy4dXEWCLQ1ssCe/3effoOJQaklzuRZ2gDHX
    ZV8QPNMNrA+3fMXzyKTCukA1kTuVymvszxHPqE6vwPjkJVzm7vAw7dwk6XqJLJ4U
    uoM4Z1IyyYEdelpo37SCza0qL58u49fnOXMIJaBLAv5SVggwhjxX76BKv+Hn5TiI
    BuaWLpuD9tVandSh+vo4WfsT/THWGnjWmROXK2RqsKm8GoHEm7QxdTZXzgyJYFcr
    m60EuDeJQKhwA5RZO4tV/ufMNCRJDvpIjNas+YdsveFXXn3ntjZ7A60OQ0sMZGqH
    N1CI+0qgwvnWwlkEsc1I0SY2dlA2anUlrJ/hKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521211048; bh=XUwpFC4IZv4hWoSmjabyI4b3jZ0m6VTWBJ9KhZf9fXo=; b=h
    9mBlj241g6tHJhgButYXBr1mhXkp9sxPEwLAZThR53gZ7N0idxNBFWxs5eOcvhRn
    +XlZ+ftka4hE04fyqhBj5RSHxhDkN542ZZpPPQNOtRYM7IDnfU2uRuao0t/ak76J
    PcCcZde0DSnD7i118Pb9FawauknEnG8CIzyBEqKQzdcexxEOQICOFmI9OdoQT/yo
    XTkskSXVrNs+iTQ+SoTfY4md7AWtU52aQSZIlalzgmBEHYTwnIUl63HfVwZQjO5+
    +C5pa2LzxZODOoS4SGljDElLudpw7U2Jo6XEvvXBDVsBW/iY6M8ogNPD8IHOFypC
    BY71+cBkBLBwfGY/vuO/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH v2 17/21] scsi: hisi_sas: Remove depends on HAS_DMA in
 case of platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Mark Brown" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun
 Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S .
 Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan
 Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang
 <wsa@the-dreams.de>, "Jonathan Cameron" <jic23@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar
 <jassisinghbrar@gmail.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>, "David Woodhouse" <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Marek Vasut
 <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris
 Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger
 <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen
 <ohad@wizery.com>, "Bjorn Andersson" <bjorn.andersson@linaro.org>, Eric
 Anholt <eric@anholt.net>, "Stefan Wahren" <stefan.wahren@i2se.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-18-git-send-email-geert@linux-m68k.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <0786b588-f165-6f71-7ede-7c26a27becbc@huawei.com>
Date: Fri, 16 Mar 2018 14:36:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1521208314-4783-18-git-send-email-geert@linux-m68k.org>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-scsi@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/03/2018 13:51, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>
> This simplifies the dependencies, and allows to improve compile-testing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: John Garry <john.garry@huawei.com>


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
