Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3316005-1518113295-2-3180550055425985644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518113289; b=PbtMK8PNfiQBh5TSSEChcakWaxgj6Z4SrjNLhDlKTEBkUwH
    4HntWroBvtzHq2yEPawSucK4Di9xx08M1Vn5ZCvxkh2h1yyjWhZsyig+uVm9QZop
    srMPLb1gOf4F9BTIOJGNm30Cnn53AXike5rsmdPa7BvzSFdbeW2eyeKgGLZLygPC
    uyhBsWgw14WRShSRBDJcsSfmb7JDqBUeFNLy8k17Imx5SpJALVeQPcD+gzk21BjG
    eDuEsRrYRCQ6IKxO+tQJwOBNUtu8SCW0c448R7qoJgQSk9vCOxXckgQ1DjSM4kMp
    WdN0tMoE9WWXHMQmnGvzS+Q9x3X4JpZZNHdmTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518113289; bh=Y59DRUc03PgUzFSxeDaB752DARhz19CWR62HGeqMp8M=; b=R
    L4Zvx77hpgVA5IfXGBjL7zpVCG6xfkHpHqx/3RApcBhQo+qkuaYxv98VO97/CYo3
    XHMi6q/XZuXoFxRT3tfRRQJEJ6W+a1eFZbhy2b+BXM6r7G5M7heqbNC3+6qfAXsW
    jEfO1yFW/vPn5ywFiahh9DYvRh7xn54yXKD46fyEedNjdkG4I2CVNQIvqD4AZJZt
    B/Y87UZgE52odEWByyQAJGDnsVb1hC9D8895NyYB34+dtcy1mE8Ckce6DLEXQVvg
    OwnITVb/gnOpYTNyUC2nVGnxriV+X+xiDqgQuWRRSytnPHjSkn9Qgy3iF3NWdffO
    qrzPwz3uwydlHXG2W0Q9A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBHSIG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 13:08:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45998 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751544AbeBHSIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 13:08:06 -0500
X-UUID: 10b7d4d3e9084c0280190d5142981d07-20180209
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>,
        <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] soc: mediatek: fix the mistaken pointer accessed when subdomains are added
Date: Fri, 9 Feb 2018 02:07:59 +0800
Message-ID: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Fix the pointer to struct scp_subdomian not being moved forward
when each sub-domain is expected to be iteratively added through
pm_genpd_add_subdomain call.

Cc: stable@vger.kernel.org
Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index fc55faa..9de801e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -1048,7 +1048,7 @@ static int scpsys_probe(struct platform_device *pdev)
 
 	pd_data = &scp->pd_data;
 
-	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
+	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
 		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
 					     pd_data->domains[sd->subdomain]);
 		if (ret && IS_ENABLED(CONFIG_PM))
-- 
2.7.4
