Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524230956-5-2414033827222491020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='be', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524230956; b=c4Y6dawPamAfksr8YdaNv+A1ikCS6MM1dukqHTuwPFGo+ajjJ2
    C4Oe50tDhrk3dYm/VdRlFH1uKHWUnbX4fUPJs8uxn0CegWBArqJ8GJ4vOzlnJXQE
    73SpL1nnowQ20pYLEMoAEZzHZEoyX9YOQIAqUg/R5ZwoYO8bX8rVTEcoAotthaw2
    n9SZR9sNJhIB7xeKCB9CxgP74urabz5aWN1tO+T5LTlaogtPLnIsLONAHUqKoTi9
    Bupt4XrPJA8RBd2HrjEgL+hsqlp4sJRmN1vyb9hPDmYYCCzmHIeFzv9altYbgH2B
    o8NZ0pxYw/KpiWLcq/GZdT6R+zSMHOPBmGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524230956; bh=5j3Hw
    kozaaYZdh6vScQK3oOuSyXUgR2LYjHgGncbyNk=; b=qmA3VdYHSG9ehU3SlV+KC
    OoDUaWvEuFGsE7TQxgxLDwa5hyDkiq3KLPlT31nL/aitnuGrkdvpWusScmywX7IX
    aZ5msk+zamyzVK3t9E80LmefMsFm4/cdPhuFjBvmlBLQzbSLH/bjU/H5Mch+v3TA
    q6//CeluqwDdInr1+h4+CSVX3lqnvfkiVgcmFp6EFVmFy/2jTGN483SWqHHqYfY4
    yXDZ3MLNj1CvVUwcsabV/RRH5VMORFaYvfTzKOmEu2ogCZn26iOh74CawoHMyHra
    l53mvizssrExr/8WSxdwMyPHthRubAujHvNYOmZSO6TvIPuEMflOGoYPdaDJGIos
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEOe2YSujAt0McGX/zFI/G970CRqRRn7yEEQBD4zcU3yQVftusRmE2xNffY6TuPx9bgREH1PduGzu6t8QBA/FvEbPdjwUmznWgEAxJzjYM9JxxdWG7uH
    /x2qIWB3x2a0Y6FwgS+aP1J1morTvrQ1ZgXDkn1+O8zoGpgQ1jgQWHSA0IRQwlXDNSTArXNFKKKnwXKQ2sL6EgGLXXMUmOp0NIU1sNocbWjjox7/WDpIwAN5
    ElmpggTBpOtaMY0zAjZSQg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=d53lkjku8EkA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=tBb2bbeoAAAA:8 a=DDOyTI_5AAAA:8
    a=8lQgwNv0kxQVv5W_Tg0A:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "David S . Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/8] arm: renesas: Change platform dependency to ARCH_RENESAS
Date: Fri, 20 Apr 2018 15:28:26 +0200
Message-Id: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
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
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

	Hi all,

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
ARM SoCs.  This patch series completes the conversion, by:
  1. Updating dependencies for drivers that weren't converted yet,
  2. Removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.

The first 6 patches can be applied independently by subsystem
maintainers.
The last two patches depend on the first 6 patches, and are thus marked
RFC.

Thanks for your comments!

Geert Uytterhoeven (8):
  arm: shmobile: Change platform dependency to ARCH_RENESAS
  dmaengine: shdmac: Change platform check to CONFIG_ARCH_RENESAS
  [media] v4l: rcar_fdp1: Change platform dependency to ARCH_RENESAS
  sh_eth: Change platform check to CONFIG_ARCH_RENESAS
  staging: emxx_udc: Change platform dependency to ARCH_RENESAS
  ASoC: sh: Update menu title and platform dependency
  [RFC] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
  [RFC] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

 arch/arm/Kconfig                      |  2 +-
 arch/arm/Makefile                     |  2 +-
 arch/arm/mach-shmobile/Kconfig        |  4 ---
 arch/arm64/Kconfig.platforms          | 42 +++++++++++++----------------
 drivers/dma/sh/shdmac.c               | 50 +++++++++++++++--------------------
 drivers/media/platform/Kconfig        |  2 +-
 drivers/net/ethernet/renesas/sh_eth.h |  2 +-
 drivers/staging/emxx_udc/Kconfig      |  2 +-
 sound/soc/sh/Kconfig                  |  4 +--
 9 files changed, 47 insertions(+), 63 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
