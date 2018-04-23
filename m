Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-788869-1524470213-2-1591928295785130621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524470212; b=PNPPbj3HoXqH9ipmyjuNX9nyy6DLzTceKO2fqiEUKd8aht9IZj
    5rC/8yFIIT/lelpxf1Sb54HGFNxM/HkCD0PlTlsTEiOLj1c4yUSdrq7jWls6TeJp
    5T0susg/V7K0JciAzl9cxWnIPAWNLqHM4LfESA47aD/V4vp4Yp4vahBIY5KLT+vX
    VNZ2fUl8t6ubeMgWMkefdrmSKxfsdjdyhdt+yGJd0mVqHB/wTG5v979362bbPFSh
    KbuLAA178XQ5/GhdEP/i9Z6+jZxCdBdE9V6IlB57qjYJMrLJkrF1+pSGhpUTO5oI
    Ek2ijh3b3ugLWmEw6vIo7cAwG5zFpOcU/HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524470212; bh=4+JS0
    jzU0NSnq1ueKyA2KpfRy2eYXySOiBhPWoIR6ns=; b=VBFCU6hSzW7b4OUzRRP1c
    XVGBMFTkxjMQ3/5cD/j5U+xWq2gCmD34By6MqYCM4KNkuZT280q36rZ/JnSug0lk
    wCYurETogze4+ITRWJ/WMCY44jorqKJyCAhdwW4OzCw3qtkxfnWlJulMq10gz5uK
    UzHGPqtD8SndsrHOM/t8rPlgx/KP8g6rvNZ/q0d2TAwgza0wTV1hn+XioI3c1+58
    Z4BHrM+HoVEc9C6V+MdKrrbpkZlVHvBgqmU0sUJXP3edeLlYDrEAR8v3TAFsH5Sg
    W+MUgahBTr3PSq8HuMChaac5sjZh6rK4UhNtC+D4jMwHo1fLIzzINEWcNcgOLuSV
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=YkFiCwZI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=YkFiCwZI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNh4xy/fqRsR892lto4fZx/AHNjqbxBlDGBCWS4n7rUWHwfMRG8cGI+YN3T9EuG8wH1GhGHU8mycTyH6Vcrb4jhCiQfNgrAWK8QxKRg4NVpfwlmQHpZ6
    rDwSdi7tKS/G7448rqyY9wCkpx9VpTWJsjxdRAkcDYlSnFM7FaXIdFYiPNOXkAU44tzwgQjxXEEbcbNLkvLTQDoq82ld+n6OeUhiH7H+ObVuvfHBFBhc86yI
    41ns0OsZwtMQkxdb5lO1+g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JhOpUDsbAAAA:8 a=DDOyTI_5AAAA:8
    a=VGFCLDKRfBbh4DW_dYkA:9 a=CjuIK1q_8ugA:10 a=id22BOPz_3nJaf3FINPD:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 09:56:43 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 6/8] ASoC: sh: Update menu title and platform dependency
Message-ID: <20180423075642.avhihfr44se7dfz6@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
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
 Liam Girdwood <lgirdwood@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 devel@driverdev.osuosl.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:28:32PM +0200, Geert Uytterhoeven wrote:
> Change the menu title to refer to "Renesas SoCs" instead of "SuperH", as
> both SuperH and ARM SoCs are supported.
> 
> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is ARCH_RENESAS a more appropriate platform dependency for Renesas ARM
> SoCs than the legacy ARCH_SHMOBILE, hence use the former.
> Renesas SuperH SH-Mobile SoCs are still covered by the SUPERH
> dependency.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
