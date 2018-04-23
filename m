Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923319-1524475227-2-12618757430981457246
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
    1524475226; b=dKaH3/uXQyj+fOB8RDg3+osm3zwqtAlxaxvc0Aw6IgpJ2tPSWv
    GPxlpkyGs+D2g26mByhekgdBdSWgWACuBR+1noo+IFXzdcZoWLLa7k3170GFJnOU
    iPGObpnDIgAeoRBQvdwtxNYVoZDsAecn1aXci9IUiM8ltxuX1ZsXJmKpRxbicCiN
    BH54GgSbPysg9RRkqesGO4WE4BR1sIdizmQuZGC0gxHygLRor8oLgrN5H9SDDauq
    3Fiq5E36yoZd1MiBqDkkCpo3igQF+gmUhD5gvqMHjfuvlIwn+DX8cMKtQnTBm+8z
    59eG0AgupTJPeheX/hTxcEaO/bCPIOf8TyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524475226; bh=YqQSy
    Z+84yqmcwKxDYqI/oej20saKbh5Auw3ir40b7Q=; b=Fq2w1z1wgBMu2wR+fOU28
    FJki0+/mojvjncbx5uXe04sK6dXGiSR1W9IV1rzh3ujFbjgXVRWopq07hQIwfj18
    UwT9np124O/ddaM7gflw6RvNZ71AJ2ZP502n33ftJCXoqb5b2Lzu8Sbh1i+B9LYC
    3C4DHbijL7HYBklHiHu1AWRwOBQfE8LCGYN6jkF4qgbT2Ks7ly+4M7HBWZzKEiNZ
    C9lvGnS3BX1oMokfZpWdzAvgg5lALtE3GOAyNQB3/P1EgvbAKkTTZgdkz+8XjtTK
    +JgIZ8CHZQuROC/UGfhj8r4GX6PK5kuOrmsXCEtae2A1eG5T4XM+ZVmhN2tyghBn
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=dIiS3DCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=dIiS3DCW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
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
X-CM-Envelope: MS4wfD7egNjl43a0+xzaDPyC3fjOU4lIjC1SODdQenbkGvNwG+h5SCWEjNxclFTx6SLq6CVnKTPuUtzS1kCcPeqPadyd/pUVGpyr4voctIXFpmdRAfdiByLi
    BG8craqHEBHAveboiS9bxqiHts6POEAlmFmV65pFadugBcKIjq7CLjOdzGPFhtujFugrrg5tMfwuYbq6z1Po9OrC7+KOhtnSiPkt6gaq1+jlJG4DFixnVS1d
    Lnu5Y6tvbpGh0gIjWIw+LA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=J5lvwRSe18BbF4UvBYYA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 11:20:14 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH/RFC 7/8] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig
 symbol
Message-ID: <20180423092011.qnhcorgcu2j5hrls@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
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

On Fri, Apr 20, 2018 at 03:28:33PM +0200, Geert Uytterhoeven wrote:
> All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
> platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
> to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
> 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on the previous patches in this series, hence the RFC.
> 
> JFTR, after this, the following symbols for drivers supporting only
> Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
>   - CONFIG_KEYBOARD_SH_KEYSC,
>   - CONFIG_VIDEO_SH_VOU,
>   - CONFIG_VIDEO_SH_MOBILE_CEU,
>   - CONFIG_DRM_SHMOBILE[*],
>   - CONFIG_FB_SH_MOBILE_MERAM.
> (changes for a shmobile_defconfig .config)
> 
> [*] CONFIG_DRM_SHMOBILE has a dependency on ARM, but it was never wired
>     up.  From the use of sh_mobile_meram, I guess it was meant for
>     SH-Mobile AP4 on Mackerel or AP4EVB, which are long gone.
>     So the only remaining upstream platforms that could make use of it
>     are legacy SuperH SH-Mobile SoCs?

That sounds about right. If there is interest I can sift through my mail
archive and see if it yields any answers.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
