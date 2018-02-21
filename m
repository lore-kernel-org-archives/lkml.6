Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219294-2-368557530558785938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219294; b=GESAhoCGyX6NBLvhi4yUNWW9Q4ytJnktCWgw8IPrWMBXHfP
    nZ3hZI3aDo2foCw3JKkRiChmtcUur1wuzgxh2HylJapMIgxJpa7+A3zlwXW8MXbR
    c5Q56dEwRpqYNSCApfHz7fDWbBDxDXp/XggXdqQXvkQ7OyDyWG/fdNmtTLTDcZjD
    lHUFrUt0OOyFu1CoqoLRSadcaIVXVaW3Su/sW169NDZSPDe7VSMf8KceVbLHrsVY
    BfgudssyHSjo/1FAbBgeRWLzWYHz+56DEHa9w+odviCtZT6j13wDIH9R3966WCQE
    GE2gUrmHgUzY/EhCqJPu/XRihCj5/ff/bmQHqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519219294; bh=6vST7jAqXGPGwJo59S27vi2pKzn/4V2+Yneh+z
    xrTT0=; b=Xsa+h+xcohDCIvFRmkOKuLxHzUh1j/ZSDwkRNuZbMrgBO3ZXApCq/C
    W724KGE99ukW1PvIZmRfZSkaRq7Y4+0sLrxRBdjxfv5pkGjz0lGHo53g6HL7gYt8
    f5mjWw+ReccfLDFyENG3Vlo/ZrUc6RnjJZurfWXoKVAmMOQhQ7GFEzku35SprnRY
    HKUGFFleHNGBBQxyELDjFD9hitcleBkuqxhSjf5bHmlsM2uT8JaPA1dQuhU7hRD4
    AGBadhqJiENucVd8cHMNW2i5Yc3ug7WcJUp2ZXdS+mxazUPbKyTEcoIE9FfycQk5
    g6yEzj9JxHo6umBrLM43LA56Jy7g1zwA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VbVjX1SM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AeJ79Q5R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VbVjX1SM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AeJ79Q5R;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeBUNV0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:21:26 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44947 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeBUNVK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:21:10 -0500
X-Google-Smtp-Source: AH8x225NDZTbz9ci8ZSfD5b4AKTY50IiZSqpX7vDDFrGMSQlFb6YLi/gs8oOqBGRBfwTsHt8OaXJQRq9k34TWoD064w=
MIME-Version: 1.0
In-Reply-To: <20180221124435.417056678@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org> <20180221124435.417056678@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2018 18:51:07 +0530
Message-ID: <CA+G9fYtrPk=yQ_bdRJDAPh7=DYDkRZ774u9oHNk-GuZXj97DUQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 77/77] mmc: sdhci-of-esdhc: fix the mmc error after
 sleep on ls1046ardb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        linux- stable <stable@vger.kernel.org>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 February 2018 at 18:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: yinbo.zhu <yinbo.zhu@nxp.com>
>
> commit f2bc600008bd6f7f5d0b6b56238d14f95cd454d2 upstream.
>
> When system wakes up from sleep on ls1046ardb, the SD operation fails
> with mmc error messages since ESDHC_TB_EN bit couldn't be cleaned by
> eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
> rather than in probe.
>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -489,10 +489,18 @@ static void esdhc_pltfm_set_bus_width(st
>
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> +       u32 val;
> +
>         sdhci_reset(host, mask);
>
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>         sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +       if (mask & SDHCI_RESET_ALL) {
> +               val = sdhci_readl(host, ESDHC_TBCTL);
> +               val &= ~ESDHC_TB_EN;
> +               sdhci_writel(host, val, ESDHC_TBCTL);
> +       }
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -584,10 +592,6 @@ static void esdhc_init(struct platform_d
>         pltfm_host = sdhci_priv(host);
>         esdhc = sdhci_pltfm_priv(pltfm_host);
>
> -       val = sdhci_readl(host, ESDHC_TBCTL);
> -       val &= ~ESDHC_TB_EN;
> -       sdhci_writel(host, val, ESDHC_TBCTL);
> -
>         host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>         esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>                              SDHCI_VENDOR_VER_SHIFT;
>
>

Found build failure on 4.9
Please take a look

  CC      net/sunrpc/svcauth.o
drivers/mmc/host/sdhci-of-esdhc.c: In function 'esdhc_reset':
drivers/mmc/host/sdhci-of-esdhc.c:500:27: error: 'ESDHC_TBCTL'
undeclared (first use in this function)
   val = sdhci_readl(host, ESDHC_TBCTL);
                           ^~~~~~~~~~~
drivers/mmc/host/sdhci-of-esdhc.c:500:27: note: each undeclared
identifier is reported only once for each function it appears in
drivers/mmc/host/sdhci-of-esdhc.c:501:11: error: 'ESDHC_TB_EN'
undeclared (first use in this function)
   val &= ~ESDHC_TB_EN;
           ^~~~~~~~~~~
scripts/Makefile.build:293: recipe for target
'drivers/mmc/host/sdhci-of-esdhc.o' failed
make[5]: *** [drivers/mmc/host/sdhci-of-esdhc.o] Error 1
make[5]: *** Waiting for unfinished jobs....
  CC      net/sunrpc/svcauth_unix.o
  CC      drivers/pci/host-bridge.o
  CC      net/sunrpc/addr.o
  CC      net/compat.o
  CC      drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.o
scripts/Makefile.build:544: recipe for target 'drivers/mmc/host' failed
make[4]: *** [drivers/mmc/host] Error 2
scripts/Makefile.build:544: recipe for target 'drivers/mmc' failed
make[3]: *** [drivers/mmc] Error 2
make[3]: *** Waiting for unfinished jobs....

- Naresh
