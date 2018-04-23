Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-788869-1524472653-2-16809713103367823166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524472652; b=k/MPBEjT/jiw5r3zN1G3DaX4+JtjLjBcbraIjgJbySNkzGF0LS
    CKBv4r9CNBs2/CRDOUCT0VG2bLP/LAi46INguiIHqg/aapUK2jZcF+x+iIael06o
    4v2zCmCZI2RmvszV9ZBdl5hP8WS/ogygDMM+gudZVU3AdYnCzzwBAbpw+uqEWx87
    oNmRXrdoRScIHnACsEofYPqvwib6E2pG1AMTPE/pI8rnTKp8kldXDYvtmIYSm9qe
    ru6T32E76ZArg3e3iX3F6uYrm2mbguxsLj28FLRarDHHR2QUMjgURYPJu0KFySbq
    HoiGzGaQFNScUNI2I+a9kU95JGxTh9IOKLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524472652; bh=C1sGF
    zUFz3pqdmKfCrShwn/tDPwYp6uw/szYNkoabI8=; b=CRp9xjJEnU5vyPdS8aaM0
    Lsz0wZZ3+8bq52mi3rUKXJDa9pXi3voWLUxlcLe+wfdz2ECw9Upykh3kZ4v+yN/S
    XYNBW6sPu2CQ2fdwFb+xElYsQL77Phm299ei5h5+45cpELYLIHPMPuJT0ds87J4M
    Gmq0U35pxAwiHq55H3wKISakp0jGoRYrTN3dl9WukpBiX/SXwhRBJokEko9jXzhv
    tZm15U6FR+2at4VLn9+Ok9DEvfp3GUnKb+/MWmGbZpnX47kXXkMGlxqRORsmiBrI
    3MlLcT0Do29QrE1oS6rUYkhegwHFY6RZIQ5tVK7CLsjHCuC41JtDrz4XT0MHI1on
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGzqAmzAgAfrGoor8FXSjCeE/YXAWukcK0cy/1aMKeniI1qDzweYR+YKdnGhQ7qZUufPIKTf88Pe9yFS02cGZaKc42W+U3W4p6m+zJbqeObFcGadLg0Y
    0KV+kamoTGAM96UdVfDhtibfyq/Jt4iNrFTBFqd6qIb3wtKGYkbcjEn+Z/rsJJ/7vcqwNlo66NlnCD/I5WXSEOHs5XE8FiiIrOBEP5F/9pE7W2++NHGtBqmC
    CkCo6o5iQhJBOIvI36waaw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=ulz06bFKTe6HF_i2q7EA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 10:37:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 09/15] net: irda: pxaficp_ir: remove the dmaengine compat
 need
Message-ID: <20180423083720.GA25048@kroah.com>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-10-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180402142656.26815-10-robert.jarzmik@free.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 Takashi Iwai <tiwai@suse.com>, linux-ide@vger.kernel.org,
 Pravin Shedge <pravin.shedge4linux@gmail.com>, linux-mtd@lists.infradead.org,
 devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 Richard Weinberger <richard@nod.at>, Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>,
 netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 04:26:50PM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
> 
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/staging/irda/drivers/pxaficp_ir.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This file is no longer in Linus's tree :)

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
