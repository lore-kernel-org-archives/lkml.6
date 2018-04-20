Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1751301-1524231634-2-7596098588337050394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524231633; b=Qqt0wcONOT1V7boEQlkMYDc5XzDhR8kjG+YcTtiq+qWnNzu4NX
    dmDNul/LplrXBeNEyni8QIfWc/r3hBGidOW3p+Vt09cLRAHkkjVdLfGOyD1MfACZ
    gbWArXYqstDR8EY3Gp+MQLhpI9XGlIdRnwLkKJew3a8hRQJLEYBvnnj/kt+rNldE
    uRPd+zYx3JfVoKRWnAnfPc+lqpD7hZVaUFtbR6Hy4DHbKrmPUNW/DSQR3RgKXE8X
    7hyyQ7wHOQzJOjay0ztY1TZapFXo1AcrAHItKM3m2fpGqE3jlgQcRBrSxTTU/lq2
    sifTSO3oKlKBdAXHcva5P4ukwL3f5N+CyuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524231633; bh=ZUoyv
    FqhDfDzlYBOlEyNmZpvH4/fWcR4cuMkiVHypuU=; b=XRTBS/bC8BkUbM93L/JPU
    PtBlxiBgOhtT8ZD4gfBhOOZa/NnPc2oJtOKwCVC85HiaEguKtshp+tOp0ZtBp3Uj
    KeRzig152aVqHe7vDJ5DzGXw+IvJS8jyQGdXsR8oYBeDrJ3fW9cikmC4LwnFEL2k
    FWGFgHRr+YM68voEvIU0NZtUgZ32uyEZL/nBLkD6YJFsl7a+pUY7E5ljo0OZyxd3
    MsEvCPjs0JZIJ/OL5uHzmDfFLjgSYFUTmEyE0drJNZh1RRVl9f/z3uSOaCgwCHMP
    HzSYUNNWoirL1RnVLc7TBWumeJjlXKsfxIMJaADdpf6g0gSJM0mDqL7T1wqH6srt
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cohrh2Dw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S1dzsOaF;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cohrh2Dw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S1dzsOaF;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEaSSxSjLrFa2TkIzyXfE5wR11gPFldysJdrGamnHRXO54TqnMkIjM1V057R6BfjayZP5EO2C/HBJ0qO9Ag8BxvzYl1Xtv7xeyHlUtN1hu2EXDNUdiOf
    NJ3vXA+E0m63ZyKa+vUhguS7//IaKVYy1+TXMzM68VhzbnO6Og3s5RyavdD/UBNiXU5KlnTKNElsbZS3p14OhUFnJ3MY5shSA5ifxrmVEx7ybIi1PDfY3J0m
    Ovs/sADC4ahlTk7RT1FEUg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=mYvlDgnsMRYyQ7LKNP4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZp9eWHDt8smlQ6eh881r8Sf7bBhaAszeVJ6YTTYZMkvz5mKAPTMR0nMytXUpico7H7EdEhOVikYW2haB5M/pkk=
MIME-Version: 1.0
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 15:40:24 +0200
X-Google-Sender-Auth: 0hNPdtFYkmGrh_SWwa9uWvaVxu4
Message-ID: <CAK8P3a17+rD9o=dKGYPhhjmtZsc7S-1YpPpH+Zfxbx6xVo7UWg@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
To: Geert Uytterhoeven <geert+renesas@glider.be>
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
 driverdevel <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>, Networking <netdev@vger.kernel.org>,
 dmaengine@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 3:28 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
> ARM SoCs.  This patch series completes the conversion, by:
>   1. Updating dependencies for drivers that weren't converted yet,
>   2. Removing the ARCH_SHMOBILE Kconfig symbols on ARM and ARM64.
>
> The first 6 patches can be applied independently by subsystem
> maintainers.
> The last two patches depend on the first 6 patches, and are thus marked
> RFC.

This all looks fine to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
