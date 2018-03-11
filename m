Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2935051-1520808695-2-11450437384530309628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520808695; b=sx12DkuCLWl/AIdf1x7Fyign48RMhVo4vke4CO6sKBRHAxi
    wrSTMB93dzwrwYSMlqQT/NHMQh/teCXBBYAUFLcflU9bYpA5i9ToHw6LSRsU5+Qt
    mTRFZPQW+NdxsUMY4KvsHBKieio2mMPrG3nVHbSLwq3k5ImeUQ0zFnDDR4kmw4T5
    6iibU+VoNgmSDuohLy5GRc3WsNDBN4T+9xgJkV4jcRc5um9Dq7T6QXafNOR/wbnS
    NQ5PyJyk3S7HnXIMhmZQclqkl7XKxsrhO6jLClHMDRvoR6glKGWtu6czxnND7nx6
    tWrcaqaFo3SkdOxl7i009FXN9NnJDS2iD0KxijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520808695; bh=zJ28zOYfFHaqrdQFuDh7KB1kcBYs/P6EkyjtcLVi7Yo=; b=B
    gC+kpUA70i0lke7HuktAZe+CNFxyrILxY9EBcl8DifaH3R1YyaCktMSSAK/o6Ntp
    Y6Y0iXH0grXlL86dNyhdSB3Cz1b8QWpP2pniOXcaBHF4nytODexQapMIj70+B/5T
    B56woivhiaIosh/aAChztNgbVU+C9603dMACEeVoWnvFozSTEWSMQmBnGjwOXp0T
    9Be5L2AxFHFq/FFAnz8vKbgikk0k9/+g4HjGfNXFPh2gyVQiU/2H5HyUopB0+Mrc
    zahrvqEDEwXyVspHyGXwBqS0MUnsjacuI8qjoas2YfZIFow9AFMptGn4i83l5Mge
    Hk+Ox7CEdO8OMaozw6O8A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TvoVZQy1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AkIP6tzT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TvoVZQy1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AkIP6tzT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbeCKWvV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 18:51:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39130 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeCKWvU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 18:51:20 -0400
X-Google-Smtp-Source: AG47ELtX3o15ToIQlamHWvX0Y9mJNKUEyBv9zXsUSnP6kYeKJ/VxM3RG14NkKzR2nF9SHzeW6R9eGw==
Subject: Re: [PATCH] soc: mediatek: fix the mistaken pointer accessed when
 subdomains are added
To: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b3923ae4-3fb4-c107-e7df-cd9d3c5f0652@gmail.com>
Date: Sun, 11 Mar 2018 23:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/08/2018 07:07 PM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix the pointer to struct scp_subdomian not being moved forward
> when each sub-domain is expected to be iteratively added through
> pm_genpd_add_subdomain call.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
> Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed now to v4.16-next/soc

Thanks a lot

@stable this would need to be applied since v4.13

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index fc55faa..9de801e 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -1048,7 +1048,7 @@ static int scpsys_probe(struct platform_device *pdev)
>  
>  	pd_data = &scp->pd_data;
>  
> -	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
> +	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
>  		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
>  					     pd_data->domains[sd->subdomain]);
>  		if (ret && IS_ENABLED(CONFIG_PM))
> 
