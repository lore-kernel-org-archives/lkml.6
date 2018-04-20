Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1876515-1524237736-2-7031646669897498225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524237735; b=g38TygsKNMzlJn5UMQi8whY/eClMSuBRB4uyFatzYPjGjHm6y2
    zLrfezk54bvDojcE81ZS//3n8dCpoQw2NcqCjKkh4PVLxhBGIeQEi2ORlH+FSCIH
    +/hRSpC3oMVK1+bZIYLcDIIDSGF4kQKKGSrQWNqX1w0PAbLamQ9tju8v21sEKyPG
    35071BIiIQdluqGBMIFRc38NmQHHHX44MNW+OklMZotWFzPcm69Kx911enskHRPJ
    SFyQvhdC2L+OjVqlTjnzJ8P1a3icW+SzMEInC/4e61BQuSJwLDTeOJoiIbxPxUYv
    /IDVS/wNrM+UE0E97HR66J9owC9i2Z293pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524237735; bh=miqLk
    79t36buK+l7NuQ/gkXJnRUZBS9rjvXOWJhT6cs=; b=wpAOeOxZRw/yfD6Q16qjA
    GNy8aootJYfTDlt2qnwRRLPznq+TpLFi6JLdnqDm/VxvsUSMsIlo2r2Fxq2Cxpi1
    2xOE26PxKok2F72xG0+qMFTvTsb7UcIJVecmO+NArZQlesT8NuZ+NSx1cdtx6wNt
    QufIOd2MzKbh5mBq0s/kZK3WKnMXRv0FqUsu/jT3pUq7TOuyrG8f0FyTCTU3PDX+
    Lt5MKeu3mP0myXEpwuAqgvVfHbAZ6sbCeHQXKm9QuHeYLxHkvU+jyWtnos/P/H6J
    +Q5VSQVhEDzauWl0Z6TpWnHUKtJUVjWNhzkGU7ITzZ9IM8/H7fgrtzuKaB/Y/6s5
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=pNCe5HXz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jlxnACbG;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=pNCe5HXz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jlxnACbG;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM8LxLMC4Cb8AhcF48MMfaDfbUuABtCq9TI00+AiCICXAmQ3WcCGaIcs5FPDXc/ah1ZCwW4EE9gMRMlmTz5TiAQ+l3NVklnL1UT//00hRQDapvxoDiH5
    ymmkg9nHOsV6g4T2JwDTgf5Q0HFiGnu2i9hdtndDQ6j7EFP9MSHT7CCseGIxS45+nlkZc9R6teJrCcHjrF3nIA9k53MbandyU2DwWrm39hBRKguGWMZ/eB4U
    XtnZGCdMyYSH9GaRnkNPSQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=AMTvMMonAAAA:8 a=DDOyTI_5AAAA:8
    a=4Iqu5zmfTK5Yk6Ie5s4A:9 a=CjuIK1q_8ugA:10 a=p5oU-coMHzOM5oT1KbOf:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqVwdo3KBKGDxpy1FHgnQWu8y5SMH4dKuHnF8QUdngpEcH62Ol8JK5ZoKlgjxwcfBPYLOrtvg==
Subject: Re: [PATCH 4/8] sh_eth: Change platform check to CONFIG_ARCH_RENESAS
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-5-git-send-email-geert+renesas@glider.be>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b0e4bb99-f964-cf8a-dddc-621f599d35f0@cogentembedded.com>
Date: Fri, 20 Apr 2018 18:22:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1524230914-10175-5-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
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
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/20/2018 04:28 PM, Geert Uytterhoeven wrote:

> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
> CONFIG_ARCH_SHMOBILE, hence use the former.
> 
> Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
> check.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
