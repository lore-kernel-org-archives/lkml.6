Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52765-1526268272-2-11963495816962133081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526268272; b=GNfJ19mwjlmQD0Jjvj7OKVUsaqCrp55znP4GU/a19YawdcK7Dm
    3HgmdlQRKnx4BhjvtlMSz/HjbyU5aMV0TAvyMFSe5s6Ei7J2vHEy6S+/fmXlh7b1
    Tx5UaayvmutLarga7tNvmwTX/eRp7YqxoGrP3Tgx9/Zuk9yR07LyWooyMXKBhSpF
    4MZPoUe5v1kfFhvck/ifDGsRyr3/qlu6guGjPYqlaLuSidVytbSffkwa/Luvlk6W
    pGbF+uoqSKxI5CmLJRz3gq1Q16o4f6veONljE11gYhALwZzM6cl4eAfkIaVPd0eX
    1xqxPVDmP3Ut5SXqZEIj8og9Bw8ljO4PMcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526268272; bh=
    Hn030u+8OjeKjCzb+NYL/kEzpjONUlLnuupLM89GusE=; b=IkrhIomdMh+glUIN
    TW9Y+OJabWE9IHndy1A7ZyMY7z0Mf3vbAXLHz3y51l3kwgwtwMq8RcV1/7IYyUJd
    YlwQ4+4PAQ4mfQaK4BUQD8/QpydZbW6pxIuERQdmwq5XWpIQiU80sbpMZ5ZxcHDe
    Q0SV+v7RhCE0vOW+W2wa6XW5a0e1R/VsQQgkMg4nA7zr8h/E8Rn9U83V3nSesWPt
    WNS2eE3ogID+Oj39N8voEacmta58THxlA+OoTc5av1aWTerihbNw0uwTV08oogfR
    Vu/ZtGU4pYOWLHwLgPeToPostnLiFCJitRqNvVVj5MJ7c+SKsgrbEsQSenkO7eUz
    iQ7RyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmO5iQSxRDpCLG1HBHYel4Kq0l0AayWllW+E6eKRShpWCW4EJP+UxtvSINHmmf6Mqkn92w6Og/os3zIxUdB27TqExI2W9PApBMzvzFlGV98Gp/WxBKM
    09Rhiibe0SganuPynxoKtWTLefUxfc0nmqQH8+dhr/y6DzYoDIQ2XtMbeVEU25Frvb/KgIGwF0IJXjsyzoAp/IoUhFbjwlTgfuMGwsemJb3LBLzsVEAhJiQ/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=JK5o_xGMRocPfrdOJuAA:9 a=jGH_LyMDp9YhSvY-UuyI:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeENDYQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 23:24:16 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:35791 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeENDYP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 May 2018 23:24:15 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <21b3b7a490f46c2e83a8951f0b6786eb>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Elaine Zhang <zhangqing@rock-chips.com>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, stable@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 04/13] soc: rockchip: power-domain: Fix wrong value when power up pd
Date: Mon, 14 May 2018 11:29:38 +0800
Message-Id: <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Finley Xiao <finley.xiao@rock-chips.com>

Solve the pd could only ever turn off but never turn them on again,
If the pd registers have the writemask bits.

Fix up the code error for commit:
	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
	Author: Elaine Zhang <zhangqing@rock-chips.com>
	Date:   Fri Dec 23 11:47:52 2016 +0800

	soc: rockchip: power-domain: Support domain control in hiword-registers

	New Rockchips SoCs may have their power-domain control in registers
	using a writemask-based access scheme (upper 16bit being the write
	mask). So add a DOMAIN_M type and handle this case accordingly.
	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
	Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/soc/rockchip/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index ebd7c41898c0..01d4ba26a054 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -264,7 +264,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 		return;
 	else if (pd->info->pwr_w_mask)
 		regmap_write(pmu->regmap, pmu->info->pwr_offset,
-			     on ? pd->info->pwr_mask :
+			     on ? pd->info->pwr_w_mask :
 			     (pd->info->pwr_mask | pd->info->pwr_w_mask));
 	else
 		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
-- 
1.9.1
