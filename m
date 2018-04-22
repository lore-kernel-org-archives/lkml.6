Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2049499-1524386789-2-15886962246441853831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524386789; b=ZaM5bfyu0V4uVJaqU1PG1XOy1StwZ3Sderws6CQTfYY2FRQ9vu
    LQ57KgQmWDv4n8VZmQK+S0O1ZlWtzUswD8swnIPP3ynxN8v+02g+0v7qXctPFwyq
    8H+jiR50WaSuBm37uK3ppzfJInN+EyloVVqYPlLsL6y3fysi1lCqFin9yOGWbseX
    7TdgzSxiwMlwsJ24PWXOPgDYnXHBhXrlnlrl123iNKlG+TVT8Dg6H3+kGdAISZJH
    UuKFJLmk3BXzu7fbsh4B9789rLcb6V1WcW0IwAC2UMULFgzPKU9YzeBrQ1LqnaLR
    7P4vtRlmfA/XcK0ADDB4+D4BY6kyP6xWHjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524386789; bh=CmxG7
    So2OZgWsugI3snipGOp0WXuzIrMZaS2XHVy6mI=; b=TiUXGlkKg0lx34Hon4tyt
    nv6bd7CehqGgMk3nHiRajxK/NAUE/0ta+m1xuAPIU5BiVfvOPttICfnllx7gAgiG
    aqO9cS7QIEnWM252or08wkVmvoA3j7KFnJ0O7G+2Qf1f6kDulSL4LDSbvfMZZY+x
    PJInk6oKoQvhBb9V8nbXoUstiz06v32onCpEvokYbAW5tAo/0AxGObHKIQiF/Cn0
    PmvKoFtQXhCLPnyuHpuGiC14Qy23EyfI7dCQ8evDIzGhpDggRjvjqSqULKzZLVuT
    YVg285F+L96skaaqty02qXuHpQA36kgiapVEPC55/xPNgSNUIvz9CGkR5Q2Eu3b+
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gVGNHkM/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gVGNHkM/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA9nFG1cG9c8CMtUWZu61qmp5mChFIoUmEJDOIbcfUUZbmviDLUDPTpsNlp2u9U4RIsVI7koVVBXf7EUDr25MrA+5N4t/Orq57i19aVmbTAPRI/GqS3t
    +jzzRVLjJNmOerGFPJDe1bGADN6Dqaeax0hXjGj5IdIpg2mC/7rnyX2CPsmuJwEu1PrG21sH9jh50+i1RY7VCL85nRSK07AogjIFbtjM+9n4K8KEwIIRGCTy
    xUBZpGnNys3LAVYcu0cHKQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=P1BnusSwAAAA:8
    a=DDOyTI_5AAAA:8 a=mYDUM3UGPLGJtvUYNpkA:9 a=CjuIK1q_8ugA:10
    a=D0XLA9XvdZm18NrgonBM:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to
 ARCH_RENESAS
Date: Sun, 22 Apr 2018 11:46:28 +0300
Message-ID: <1700954.Qkp7xggMnX@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <3039853.rivznOVBTv@avalon>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
 <3039853.rivznOVBTv@avalon>
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
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, devel@driverdev.osuosl.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, netdev@vger.kernel.org,
 dmaengine@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

On Saturday, 21 April 2018 11:07:11 EEST Laurent Pinchart wrote:
> On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
> > The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
> > only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
> > ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
> > than the legacy ARCH_SHMOBILE, hence use the former.
> > 
> > This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> > future.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> How would you like to get this merged ?

Unless you would like to merge the whole series in one go, I'll take this in 
my tree as I have a conflicting patch I would like to submit for v4.18.

> > ---
> > 
> >  drivers/media/platform/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/Kconfig
> > b/drivers/media/platform/Kconfig index f9235e8f8e962d2e..7ad4725f9d1f9627
> > 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -396,7 +396,7 @@ config VIDEO_SH_VEU
> >  config VIDEO_RENESAS_FDP1
> >  	tristate "Renesas Fine Display Processor"
> >  	depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
> > -	depends on ARCH_SHMOBILE || COMPILE_TEST
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> >  	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
> >  	select VIDEOBUF2_DMA_CONTIG
> >  	select V4L2_MEM2MEM_DEV

-- 
Regards,

Laurent Pinchart



_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
