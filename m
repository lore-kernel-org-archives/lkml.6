Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923319-1524475769-2-9301318141927394615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475768; b=Mmz1vcZlQS/s4Gt1hhZYvKc96B5Q2DvwpXTHCeHA+QWuV7mlmt
    8cbHY81GYw4D6V/vMjWONYGIt4vQZRtS4O6n3qWPwNwHF5UEXYoT6wWk86EK73/Y
    ms4YEw+lwSTszVzmt4rHbCec2lgIBEyLVFhcLlZWHijKq6tpwOfmEkTQEcinPd1L
    4x67DQrkgpLDnWaUTZSgZ1CBARo8OiIzsX30fjaUYiI3qirEgvp6XO9tNF8C+gcp
    5d26I7q7+kBoFcCb4O7v5KYqvVkXBEOJcseZs5y3XDOV7OyEA12umRvX4TAHTHFZ
    6fkzyWdtlIGqKtjXJlYnHWdryy10JZlzgV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524475768; bh=oyabf
    TCXZhn59M7HgGcykSCF5k4cxmK/hx4wZZCUpG8=; b=wXJoNKIxzNteK87eJv6bg
    Fa/LBroW6+HeNJf5XycbFNKix9zUbPLT49DsWZGjpKWHziSIoQlWe92fw2NTFxMA
    kN5QKwVeu5oeUGxjAE9yLUuojpCxLro97gh+sxu0AS9Du8hI+Cd4hJmZcNjmsDjJ
    GeOy3RuVS6QsMcC02ShyzrkD6dOAKkMA2PG6FqaY708H6zXi+x5CR7q37W1f8d2a
    tzQib4IYIciI8/gS6XmNjwFB/CM2BjkCJyF7duOmvds2no35kMu1chTL9MaPX0Rt
    gpBri9yIL5go0TlugmzvwBsZ+ZiS1Rkj3AARdPFNNU1jcvJMfWsNe17tw1BNc6vG
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=E2sv5EwL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=verge.net.au header.i=@verge.net.au header.b=E2sv5EwL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=verge.net.au;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=verge.net.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMogTiHpAfC28Wa++/XV2vE4fzGhm832RC0cjCKkWfcdM7GB6CWR04gN6/WGzHtdkJFszauTVQ4H3aJ65xoPI7IMOlK+WgHmeTIZEkQCdn4Q3XQ8nEX3
    Vy8EjDKMeo5rd6CROCwOkQ0/mv3adHCdm8EgYZDWx2igttux84v1vpcD7ANKQDtOSz7UJATiDpKbbwSqjmLnB+ejdIjk2FY66e4IPJjt+7EqiTEsfq23GVC+
    wx+bgv8dvogZuL4PXCwj8A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=DK24gdrmsZPqZ_xNIn8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 11:29:18 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH/RFC 7/8] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig
 symbol
Message-ID: <20180423092917.h24b2gem6j24uhnk@verge.net.au>
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

Thanks, I have marked this and the following patch as deferred.
Please repost or otherwise ping me once the dependencies are in place.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
