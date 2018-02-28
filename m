Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838409-2-14148315081486169383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838409; b=NLa5PBmv4jFQwk3GznG8N6TL+PIz534+0CtYWm4BrDEBoI1
    gtvaEeKmv3BWqyHJYnEuSC5Yz3FjSjzWhCSbLlAUCPGeqlmT6hINT/V5E+tPaL3H
    1RXPfkEaQPo2SiJeii71f9gyBe7FUIRwEcVlpxcfFldNF5ua3lWDyWd4R8a15QL+
    AD1XnXA5wu+uu5emrz7vvWZHaVI/Ug2UnH03QnpPrAEH8VQ7ur/6hVjbuDYWMd7H
    vG4Kw0iZ5vUBZY3U8zTNP6kax6miwf/TJGtg4+X7jBvCuWoYvSPFYccPBsg8ZlRu
    y2lUjcVaeK/HaRlUK9le3H7uTiAtE2GpRx5KvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519838409; bh=Sx6jMB1GryE8FILddFDfY28qnymRgA5/0gfgRE
    ThDHg=; b=tnkhBb/GBGoVUHnRFA+eJZkAPjdFX+SFNXw6iwjxBsGukh1dWbgupQ
    DoonTT12wKhbCsSt5X2BBNx2AmqLM5ZJtwaTb/h3RyVhbTCJj5B0SasDpl+DJth7
    S+lndwTypt6WCmc+xRD0h6x5vEHTwx3ioiCXiVY0HU9vzwHcxD5ZdwlWgKxP+CjV
    srMkD6PUQ/HVGHhgwQc4Lgss/BwN2mnQIVMxEaLOCn2EowlZpKb20Niug+KuFC86
    /8AVHzh9fb8wQ+gYkDeHJUoilHIfVUTQcv2av05s56IL8CH2ARIuZsstjYzWrzXB
    0bubERqndbD2TdzKETeFzCfizVSLxS0Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MLwPRu3q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jXVPei04;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MLwPRu3q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jXVPei04;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbeB1Pru (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:47:50 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34096 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933433AbeB1Prr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:47:47 -0500
X-Google-Smtp-Source: AG47ELsjvb5BN1Cy1l/iqHY1tH/EjNPte1eD1iWDsMLC7z9jl3Bz0KuIOhtGvps1yV6vkNI86hXfRmP7N76pXroSoN0=
MIME-Version: 1.0
In-Reply-To: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 17:47:45 +0200
Message-ID: <CAHp75Vf0z6PpUYrmhrcPs6PT1cR8siT76bLW-_wW1SFmSPRqdg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 1:53 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> have been made changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations leads to unexpected ETIMEDOUT errors and
> causes stacktrace splat (such as below) during normal data exchange
> with SD-card.
>
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
>
> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
> code gets compiled on all 32-bit platforms as opposed to usage
> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
>
> Lets cast this multiply to u64 type which prevents overflow.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> CC: Shawn Lin <shawn.lin@rock-chips.com>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org>
> ---
> Changes since v3:
> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
> -Make one patch from two patches
> -Modify commit message
>
> Changes sinve v2:
> -add fix for cto_ms
>
> Changes since v1:
> -uint64_t switched to u64
>
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..cba534d4c81b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -409,7 +409,9 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>         cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>         if (cto_div == 0)
>                 cto_div = 1;
> -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> +
> +       cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
> +                                 host->bus_hz);
>
>         /* add a bit spare time */
>         cto_ms += 10;
> @@ -1944,8 +1946,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
>         drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>         if (drto_div == 0)
>                 drto_div = 1;
> -       drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> -                              host->bus_hz);
> +
> +       drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> +                                  host->bus_hz);
>
>         /* add a bit spare time */
>         drto_ms += 10;
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
