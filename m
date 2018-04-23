Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-775307-1524469517-2-10022476012845644294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524469516; b=g6IooVxSj+CuOVK6+nLUPNrg6QV+VmmLv/fD/fEmiPqBhuFCle
    dVJ+fWUpy1y2MunM+1YdqOVwAcetFkknn81StaUNf81WcDsh0geFle/BvBx4noCP
    Jr+5VBPN2h4d83/gEApYutJYV0zNl773aheZvJ8Vql6NapufsEWb3GUDKvUo7Obb
    B88L23SplDzg/rRWh3ZLD/9OD7vxLkZaLor1rGgl0QoJSJw0rlU2CktyHjlAFznb
    JQzupzH5JemighWZF6QIecBRS/DJ/4ZvYdpbGdVl60IgTrasu4FVGv6EhktuGvex
    i1jbQlRfarHWPaJxbb9ML/YrZMS4/z0BqtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524469516; bh=zupuM
    yOLkhJ5XnFVTLT+i+7DbIreUUE/jYSi96gLBik=; b=cQunTCUg+5e1qedH9nCuf
    iLgbQL9qoGZWa2/dVodWRgeZfsZERaytK7BCmnDkCUnR/nRTCTeqJVW65KZFzNYq
    iJy5oJuJ623yPy68KfdE2pS0Hjl8kuf6aNeYmzFdoJGRsQPNVfAGBsgVCYSpWW3d
    b5eUlBobm/joo0ri/bnbI18lbef/FGK6RQ/D5rEuON0gWwPwwnCeR8B0whse7BOr
    3G/i0so6mr/slb2ZVLMgKyuHb4vXGc01TGgIsjk1+OvTiPZ+aXkPLWuSi4OK6b+L
    JTdQ0UaAUjzWv2BNFvXSc/KCJ8SRp8atLkdyoO04NI/gjWgI69ac9x2lO0/Iwpuz
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pkVyo1/e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OpP8nnP+;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pkVyo1/e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OpP8nnP+;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK9oAc4dxWRqrqd89qo/xtjjeUXmHqAwHAb+jhzAeWR5TIPg6/NgeytO5QvXulB16+lbjCZt/dYhdBG3Q4cwVSiRn2PHXxfaojLL7wO4EhNNFRT0iLlb
    WDAtbKm9GE5kbJ/tWZPbL/OhUKdoWOjtVmQY3rMxhiNkGUUSGzLQU67BTy+5uYoeTKYMF3jkc59xzI06wFQL593OPx0QRGHsNBkvduRpY0X8f0LpRHQz7x9v
    CQYyko6CcJPFCKB8kMSVQw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=tBb2bbeoAAAA:8
    a=DDOyTI_5AAAA:8 a=vIVakilI4SCMkaFhLdoA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpSWvMrG7XnAyBrH1kT7b8Y4QQojB0Pc+JQgbREtlfvLM7ksEvHw71AwMh6i/OnnLj6AZZtLamuS8pM6p1n75g=
MIME-Version: 1.0
In-Reply-To: <20180420164811.GC22369@sirena.org.uk>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <20180420164811.GC22369@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 09:45:07 +0200
X-Google-Sender-Auth: 7yugnEVVT0BcKI6VAWjKwUOb2q0
Message-ID: <CAMuHMdUt3ExAD7KEiBhntcOoSWSLMnpNT1Oix4tNRMAM=8g9jQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
To: Mark Brown <broonie@kernel.org>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 driverdevel <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, dmaengine@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,

On Fri, Apr 20, 2018 at 6:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:
>> The first 6 patches can be applied independently by subsystem
>> maintainers.
>> The last two patches depend on the first 6 patches, and are thus marked
>> RFC.
>
> Would it not make sense to try to apply everything en masse rather than
> delaying?  I'm happy to apply the subsystem stuff but if it gets things
> done quicker or more efficiently I'm also happy to have the lot merged
> as one series.

In theory, yes.

However, this touches multiple subsystems, and it's non-critical, so I don't
want to spent the energy to get this done in a synchronized way.
It's way easier to postpone the last (RFC) patches when everything else
has been applied by subsystem maintainers.

So please apply your part, thanks!

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
