Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-826942-1524470197-2-773552552685490390
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
    1524470196; b=F6FQT7zh99qEMZEoSgx4kOMNLA9JPdoWLDD/3sRMQZZ1ZzIswo
    MNTLgnY5UK0Dwo3cyGbMTEaeTTwgdpVjh/vusgjUV8LhqDqtN9TqFTSh0pGKol8p
    WTIDSNDU57pDuXKkUYllsJJY7bGJ6zW7OhaLILGigGDMo2YwMjqllb+5MxnHQpWA
    7X5XY/TjKP9woPjx2jA1p0KkchPk/qWE1a5fCtCJhA8GmuL/I4bW9ORLlOGLErT2
    WD1cCr26QcjqNYEi1a6YHZH1UXsEEZUeS9gwZefh+UcmujnF+9t/3EbUkn39Jbn8
    v8i5L4LXDKxNZaJzD6Wwibe+jw62DTfpcKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524470196; bh=SlyPN
    P7fycvbz8bPDrOCdZQwlKFifbNtxtoxHiQq/t4=; b=Uj7ISN5ypB1A+j1nquO9G
    jHnoKs6f96xzyr6tla6TMP6ndqnAs0BseNlqfkRWTC/e1pPFz2cGLdQjSxUQ1U7a
    ex/VwdYkzsKq10rgqfm8u5gfR1K5Oj7eQ+Bw9tQGWPIbQSm3Vp4xCiwLoJFa2QdB
    1Qsic2fX+gEALxB1nQ5xmRaZF7r45DjMHvlITddXI3DOycPnjTt4WJy93L4VQwAd
    ST+PX7J2Vkr3W4fAY+DNGe6kVQALL2hV70szjNXfc+ZXSgG4JsECKBByzasXTgeR
    llm+KnkMdi6ReEFLb/ADBFwMwrEnng+DFVqm++sk2xiRlcKCxLjr4Cr4HZ0Jq9bp
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=IwmoALqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=IwmoALqj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
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
X-CM-Envelope: MS4wfPD2VqzLFXWaX1mF5tzd1qGOkJVmygmu8HX13Pw7wjBS3yDJ2Y5qz+P4stF1lgeOGskAfJ0pfKOacp60++IelZHcOhCUCuxkCfE7GROy6z9hGstefsXo
    m8wC8ugq3S6R+GZbf5m1ZDv2x1wt0gNraJDTafsQQqRyGNXFzk/uTMRa5Obcy20fBAxXGK0PIt7jJ14ebG/TsEGWmVhdpur5rTNvAYmz7OWuwPFbTT7wHmZk
    y2ujzG8X1/JP61Z/ZFjYhg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JhOpUDsbAAAA:8 a=DDOyTI_5AAAA:8
    a=gFh9OMtz1F5VKzm5fc8A:9 a=CjuIK1q_8ugA:10 a=id22BOPz_3nJaf3FINPD:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 09:56:26 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 5/8] staging: emxx_udc: Change platform dependency to
 ARCH_RENESAS
Message-ID: <20180423075625.utzf6sgu4rlvb55r@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1524230914-10175-6-git-send-email-geert+renesas@glider.be>
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

On Fri, Apr 20, 2018 at 03:28:31PM +0200, Geert Uytterhoeven wrote:
> Emma Mobile is a Renesas ARM SoC.  Since commit 9b5ba0df4ea4f940 ("ARM:
> shmobile: Introduce ARCH_RENESAS") is ARCH_RENESAS a more appropriate
> platform dependency than the legacy ARCH_SHMOBILE, hence use the
> former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
