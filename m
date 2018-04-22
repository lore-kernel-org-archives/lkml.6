Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3234825-1524424705-2-11215415068501126913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524424705; b=OpXf8poYnp9MpDZpQcl70trhbdNQmBwycx4QlqJASxAHusIc/M
    W2O9ADMFWO/5zVGwnAtwoCL+um5zVVuYe0CsdiGMoVHd7s1V1k6ntaINkPqAFZde
    oItBurmnI6hfFGx2D7qx069gyluCa8w0lbKW9vyzDbU19ftAL/WjLAjOim0PBJ9Q
    mHDiLdCjQ+jEM7AVD8q6HlpIdS4jikakSkWzTiMualGL0LB4KDS4/9exVHy/2OLt
    Vkg5ZHP6XIO/SMgMI6+y2HqOwSptRzbqiyGu/WK64w8C9Pd5L6xznIW9mImkKZ6Y
    gK30aSvTYbKEJfJRGNekLJBVzp7+BPJ7qpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524424705;
    bh=cXzJ6wQhdTS7BufET4ah/VtNHs2XM4ilT8919KJ52LE=; b=Hvt7+70lXfKl
    9oEMGEVZdrazRV0xwvnknHPDaaq8I+4m3CxiJ+W5IG7g467BY0ubHpQRb3y/7g7h
    0nXZxogVy5y8Mm7GBYQ/pTyvXn8979xZb/6//8p/wM+YNwswJzDPtlrlxx6IFN5/
    XSnKDbim9S6+cmn0XyjR5bhIElGwyX3rgrNyBEjip3CUzkYaXJn9HXCVEyqnD2VJ
    za+i/aoSLn6IvWTJ4OYZTmniXEVsVZ7EVFZtRCZJtq049YuaZ0Px1vAQXp2Dr4bw
    cQY54e+ReDWKB4sZiE0za2vFb8P5faA6ZIl3zr9pOGCN4pox6YeTNu1ZzGVhw8Ce
    LmC0KR4NHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hauke-m.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hauke-m.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hauke-m.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hauke-m.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCWDqbtfrbKJKjyr90mcA3tQ3dWNdPKag1MM5Bsv4/OwCBSXQ9kUrXvHn75LSd+NlC9pXtNB3qebe/AP27ujo4FbNVLN0H5nwkRPq207R7IOZMjN66kU
    eAT/hH2i64hl+BI/GhYtiJOsHI8lJKp2v1xmgxcCcfx3+OKFvSLaK6Dr7kZaXQITZRM7w8GU9BtWSWZgYuEm5F49iaSnreqV5k2goixpv2BDGs2KTPRoEpya
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=FAiTVTwVy6Jk9jamRN4A:9 a=6i6OqkxNUnIm3mdJ:21
    a=qpwIK4FYy5Evs72Z:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeDVTSX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 15:18:23 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38866 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeDVTSX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 22 Apr 2018 15:18:23 -0400
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
To: Mathias Kresin <dev@kresin.me>, john@phrozen.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: martin.blumenstingl@googlemail.com, stable@vger.kernel.org
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <2c128bec-ce46-5063-cd61-6f4257ba2a3e@hauke-m.de>
Date: Sun, 22 Apr 2018 21:18:17 +0200
MIME-Version: 1.0
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/08/2018 10:30 AM, Mathias Kresin wrote:
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

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/soc/lantiq/gphy.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/soc/lantiq/gphy.c b/drivers/soc/lantiq/gphy.c
> index 8d86594..8c31ae7 100644
> --- a/drivers/soc/lantiq/gphy.c
> +++ b/drivers/soc/lantiq/gphy.c
> @@ -30,7 +30,6 @@ struct xway_gphy_priv {
>  	struct clk *gphy_clk_gate;
>  	struct reset_control *gphy_reset;
>  	struct reset_control *gphy_reset2;
> -	struct notifier_block gphy_reboot_nb;
>  	void __iomem *membase;
>  	char *fw_name;
>  };
> @@ -64,24 +63,6 @@ static const struct of_device_id xway_gphy_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, xway_gphy_match);
>  
> -static struct xway_gphy_priv *to_xway_gphy_priv(struct notifier_block *nb)
> -{
> -	return container_of(nb, struct xway_gphy_priv, gphy_reboot_nb);
> -}
> -
> -static int xway_gphy_reboot_notify(struct notifier_block *reboot_nb,
> -				   unsigned long code, void *unused)
> -{
> -	struct xway_gphy_priv *priv = to_xway_gphy_priv(reboot_nb);
> -
> -	if (priv) {
> -		reset_control_assert(priv->gphy_reset);
> -		reset_control_assert(priv->gphy_reset2);
> -	}
> -
> -	return NOTIFY_DONE;
> -}
> -
>  static int xway_gphy_load(struct device *dev, struct xway_gphy_priv *priv,
>  			  dma_addr_t *dev_addr)
>  {
> @@ -205,14 +186,6 @@ static int xway_gphy_probe(struct platform_device *pdev)
>  	reset_control_deassert(priv->gphy_reset);
>  	reset_control_deassert(priv->gphy_reset2);
>  
> -	/* assert the gphy reset because it can hang after a reboot: */
> -	priv->gphy_reboot_nb.notifier_call = xway_gphy_reboot_notify;
> -	priv->gphy_reboot_nb.priority = -1;
> -
> -	ret = register_reboot_notifier(&priv->gphy_reboot_nb);
> -	if (ret)
> -		dev_warn(dev, "Failed to register reboot notifier\n");
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	return ret;
> @@ -224,17 +197,10 @@ static int xway_gphy_remove(struct platform_device *pdev)
>  	struct xway_gphy_priv *priv = platform_get_drvdata(pdev);
>  	int ret;
>  
> -	reset_control_assert(priv->gphy_reset);
> -	reset_control_assert(priv->gphy_reset2);
> -
>  	iowrite32be(0, priv->membase);
>  
>  	clk_disable_unprepare(priv->gphy_clk_gate);
>  
> -	ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
> -	if (ret)
> -		dev_warn(dev, "Failed to unregister reboot notifier\n");
> -
>  	return 0;
>  }
>  
> 
