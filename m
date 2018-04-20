Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1234427-1524214710-2-15002752204316214364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524214709; b=YNljpaWVIzqLA/jbaSBsPPddNwDIpVVOnxwT/uaGoJvi4sMbrc
    sVABvRk1HTmyJGy+QFKTdP3OXWDa/DbNjMjW7W9689M2UExGFAe4DqVSfpmL6lq5
    Ibn7P9/SguygjqOYYC890tywTaptUTOGuK6UNTrAfXTWa98GhZMq9hXUd2UeDmqT
    i7wBfY+j4vuAplf8AMt6PBF7IzljJeIhkZr0RbAIId4svJCaTeCOVGFqHWDfqHdc
    m7NBOGFV7qP7TBa/2iyOp9FfBooBo9dc19Mp9WA+VSt9JBPgwvqZ33SlL3v7RyB/
    ZzVDyor7DckJK15i9yIiXUhStHzOAxU37MMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524214709;
    bh=MXKpOPgMX0XaUrawq3E+6IStAZy98UMtIs4DKNzjxCQ=; b=RE6nruYee7gc
    CVmosNl0TYam4im5bC3BdUu/L9Tsx0deI/JEqp/EbLhuapMDkndwodZvcqtlgUbX
    Jdl6J8WymMjzdtxqp7+tk7dXN8Moy1KvDcAnE0L3UxFG0eyQEIGtoHTPdFAsY9ns
    D+F/BaZ8MeMK2OeEIuZl2XKSL3yWdMg6RluUFeAG7eGfSYkH+x5LNj/I/yiLRE9n
    wUWGyNZh1JP+ugb6Mk0VWTME2qy4dyr0W6HoyflPz4T+LmWwYRua3bO712ei+2bX
    Ig54F0hB9HtaIksZqN7QaQYfuJXOCDy35mkBd86NnKbpstRAiWslUk6nNGPQDqeO
    fJa7TDvxHA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInngOJVINf3BbZbXQag/cF0cOj9I7FgAzIkh6X+f8CyzIvx/r797i8QGa+XWOtUb5OOg6xKf9uPBrFqEGq+zWLTP4Epsi+9iMaz3CHJhBLKHb7uqe6Z
    TLRQnGyVwVVfp65SpIs/MaWYOfXdO8hGvTHLQhokRMNLzPvZSAnukN8ne0Lel69hF7ccYlql5CPf+vCHznupG7YfLgyXJ+ZiTNw402cv34XQwjLExLghYl81
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=U0zfkUukAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=j5T9_7abyRdEhQ7eno0A:9
    a=FQP-8_H270KKA6O2:21 a=BMFy5kQigyTxhJ9W:21 a=6heAxKwa5pAsJatQ0mat:22
    a=rXRU1dkEVDZ1dOovDhQH:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbeDTI6P (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:58:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28810 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754170AbeDTI6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 04:58:13 -0400
X-UUID: cc4da96602e64fa3b8a01fbfb069ef25-20180420
From: <sean.wang@mediatek.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <matthias.bgg@gmail.com>, <khilman@baylibre.com>, <arnd@arndb.de>,
        <andy.gross@linaro.org>, <timur@codeaurora.org>,
        <xuwei5@hisilicon.com>, <horms+renesas@verge.net.au>,
        <heiko@sntech.de>, <ard.biesheuvel@linaro.org>,
        <amit.kucheria@linaro.org>, <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] arm64: defconfig: Enable CONFIG_PINCTRL_MT7622 by default
Date: Fri, 20 Apr 2018 16:58:05 +0800
Message-ID: <aac9629afc510681a5dad1a24eb78f5f84f12c23.1524214111.git.sean.wang@mediatek.com>
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

Recently kernelCI reported the board mt7622-rfb1 has a fail test with
kernel: ERROR: did not start booting whose details could be seen at [1].

The cause is that UART0 can't output anything when it's missing a proper
pin setup with current DTS, so the essential driver is always getting
enabled to fix up the issue.

[1] https://kernelci.org/boot/id/5ad7d62759b51461bfb1f829/

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: stable@vger.kernel.org
Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..fe005df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -320,6 +320,7 @@ CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
+CONFIG_PINCTRL_MT7622=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_DWAPB=y
-- 
2.7.4
