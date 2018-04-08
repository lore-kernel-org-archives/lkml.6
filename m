Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3194117-1523223051-2-7659329487033121956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523223051; b=GMT9gev4I6c1Gzzoyr9oHr5qcLx8ANkRN03+D0/cXk9ahEzk1e
    rqgGhz7gX7kZhjMQeaumlGYDgOeyy9GzPbqJBCE1fzrTn+QRiWNWIfWiawJaQRqo
    tcRRbxNQXADetu9RIyr7KM6aOLSBlLNsCM1vy0S4Dac2G6AaQnCb3C5mZTtjvlMK
    9vjqEaTMBjXfDqbrdZtB+k6fo+10Nfi8W8uyRcY8rqS9zy0iYybEoBxBayBG1MgI
    aEukYjSqmCObUdDHx1Bi9LEBkl8tDckkXO85Pr4sFUtdULY6zyHzHBgwo5GJud0V
    xkzpNsBLL03bjmTuRji1rXKxKgb60NHqx11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523223051; bh=LhmPbpCSJYRJGIiIJfvC3MVexdc1m4deLuErqrO/Po
    0=; b=mCuBniAzcvJWglI4Vqm/oOJ0j8TN+itCr/5t51cKPkkrgkPu8AvndvzbxC
    o5j0r8GoZLkKeAa8TTzYyqFeSu0IyNxs2fC+CDWEpVLc216eI+k4hw1i/TRBo01I
    KXxSfa6huBfpE4VmGLMrcD4eEIV2y09l5S1TGmE5TbZbePcYa6x5ge+o7I+08dVt
    jVH7HNmCJl3/KuaAfFZxaCoNIaesKvK6hpuoADQNWHziUSIX3bHr1bgCfCAud3zA
    FpvcNg38RURdtnvic26V1KP6siq2qZItKI2N6kjhszsHKiFWiDKWcEYPlwK7TQCk
    lrZNvUxkC4ol1xfTVsVTxWAxus3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=LEPyaE32 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KlxzYmmu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=googlemail.com header.i=@googlemail.com header.b=LEPyaE32 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=googlemail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KlxzYmmu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=googlemail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMvjosDzsuFjdeWlPM3DLwaeJYbcNgCN++j+U5VxFRy5ncXu8UBnY+dvrsHQwzohHiuCKyYFIAxsaUDrlBStwraPBHFEsH+VZOIm7pzwwcu7uXStTG4G
    eIZXZ947R5nxZ4DsgCgyUdqozN8SQj9esHND32GfxQSZvqUrqCojViLgMYAmedHnI4qRSsw+xD55EVwi/2TQQbDFxKuqb5CP54UpKUriEKbwGWj2/MB00PnA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=25T5d9ZgbPEA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=mK_AVkanAAAA:8
    a=JOFlVsdlppnw7wLxj6cA:9 a=sKjfSSXQFOFSNF3n:21 a=iZr9WrtXYWsyQbbh:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=3gWm3jAn84ENXaBijsEo:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeDHVat (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 17:30:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42223 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeDHVas (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 17:30:48 -0400
X-Google-Smtp-Source: AIpwx4+bJNWPWuab/3CjCbqrhVEMA6+76TLi7iCmV4OOFgv+othkoJcP3pu4aTQUYViKdZmK+/zyzgRbpiPIgb7J3ls=
MIME-Version: 1.0
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 8 Apr 2018 23:30:27 +0200
Message-ID: <CAFBinCCQO4B3a+ft7H1mMgfaS4=qSnmern3ZqD3QGt0815Oh0w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To: Mathias Kresin <dev@kresin.me>, Hauke Mehrtens <hauke@hauke-m.de>
Cc: john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 10:30 AM, Mathias Kresin <dev@kresin.me> wrote:
> While doing a global software reset, these bits are not cleared and let
> some bootloader fail to initialise the GPHYs. The bootloader don't
> expect the GPHYs in reset, as they aren't during power on.
>
> The asserts were a workaround for a wrong syscon-reboot mask. With a
> mask set which includes the GPHY resets, these resets aren't required
> any more.
>
> Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU syscon-mfd")
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you Mathias!
@Hauke: maybe you can also review this and give feedback?

> ---
>  drivers/soc/lantiq/gphy.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
>
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8d86594..8c31ae7 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -30,7 +30,6 @@ struct xway_gphy_priv {
>         struct clk *gphy_clk_gate;
>         struct reset_control *gphy_reset;
>         struct reset_control *gphy_reset2;
> -       struct notifier_block gphy_reboot_nb;
>         void __iomem *membase;
>         char *fw_name;
>  };
> @@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, xway_gphy_match);
>
> -static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
> -{
> -       return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
> -}
> -
> -static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
> -                                  unsigned long code, void *unused)
> -{
> -       struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
> -
> -       if (priv) {
> -               reset_control_assert(priv->gphy_reset);
> -               reset_control_assert(priv->gphy_reset2);
> -       }
> -
> -       return NOTIFY_DONE;
> -}
> -
>  static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
>                           dma_addr_t *dev_addr)
>  {
> @@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
>         reset_control_deassert(priv->gphy_reset);
>         reset_control_deassert(priv->gphy_reset2);
>
> -       /* assert the gphy reset because it can hang after a reboot: */
> -       priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
> -       priv->gphy_reboot_nb.priority = -1;
> -
> -       ret = register_reboot_notifier(&priv->gphy_reboot_nb);
> -       if (ret)
> -               dev_warn(dev, "Failed to register reboot notifier\n");
> -
>         platform_set_drvdata(pdev, priv);
>
>         return ret;
> @@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
>         struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
>         int ret;
>
> -       reset_control_assert(priv->gphy_reset);
> -       reset_control_assert(priv->gphy_reset2);
> -
>         iowrite32be(0, priv->membase);
>
>         clk_disable_unprepare(priv->gphy_clk_gate);
>
> -       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
> -       if (ret)
> -               dev_warn(dev, "Failed to unregister reboot notifier\n");
> -
>         return 0;
>  }
>
> --
> 2.7.4
>
