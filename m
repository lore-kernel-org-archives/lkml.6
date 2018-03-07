Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757900-1520414514-2-5333530383855770687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520414513; b=UwstZVuNv/z/WRNQWUSXHMxbg3YHKiwQ8ELQni53sin1pUX
    qNIvbfqE2qL3Oq/M5ASqbRbxa7So5Gl4kxMt5brCtA/MG4CeXxlFNSrEUigB+MxE
    2kYWdWxn/djWPWC0lifplwmL90/tEcyeWc1Vx1omAgSMUhvo3+K8XWMB725AWi/W
    gZngar9UczoYIIfUYRafjQFM5Qn1oDvpvbRfi1W9nSrCEhb6hufUREgW3an5vckH
    qoB5moGcwhV19If0ky49SgLcpPGbXuqAM2B/lzf+9RwCH9/cTmIF3LugdCoYVZA/
    TALoJ+HT8KQ2QNt3Ehyi5iDs5xR9n/BSKN4oOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520414513; bh=a6lmrJ
    yJ4CFr/MZzW9aOHk55+azjDTiKZyg7y6Mix/w=; b=Pa1mvizIjrNtQ8+k20/zGv
    2I+1SktxzTK53yBNwgCjI0emGnFK9gDYxUieq5jfZ3EML3uhzYcgcBs9ra2MIXcx
    MhJW8fHNxFESoItw2zGrS8qa4kG/LtVAkUwTugc5TPoMf9ahVdjbaeSe0Jys6ns6
    nkkkbJpgD1tSTCDjd0m+gON2mFrhPdF1zGURiBSFXAKsmVrkD7hR1KttuBP2GQWf
    5RgHrCDvrPQXxaTkYw0LDBOW18bnh3jHRmKPBdL4fH4ZUk46cC+EANE+t640U+4b
    IX8tUAm6Q/U7A42FAZgmvXxKLTm0mLHcB1GtfHhVI9lHoAhG/MnxyVxKmt7fYSpA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCGJVu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 04:21:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43422 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751036AbeCGJVu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 04:21:50 -0500
X-UUID: 540e87e85c8047f98d76054730a301a0-20180307
Message-ID: <1520414499.677.5.camel@mtkswgap22>
Subject: Re: [PATCH] soc: mediatek: fix the mistaken pointer accessed when
 subdomains are added
From: Sean Wang <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>
CC: <rjw@rjwysocki.net>, <khilman@baylibre.com>,
        <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Wed, 7 Mar 2018 17:21:39 +0800
In-Reply-To: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
References: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Matthis
	
also a gentle ping for the patch
	
	Sean

On Fri, 2018-02-09 at 02:07 +0800, sean.wang@mediatek.com wrote:
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
