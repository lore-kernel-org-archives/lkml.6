Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518515680-2-5919217119987340996
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
    t=1518515679; b=imWVLCxO2wSoPporPOvE4hqGC4T1a5+eYXWcUAvbDMN2KPx
    9+GZGju5mgBPdKB7od4FhstzF+NEpjeWR1OdQTAWHDGj7AXHP6JMmFG03TDd+k07
    fh3168PMl2OXSCtEhHW2aNf7nlZvBT2BukmcJ6j8XoMfFPyiPkNePAoRhy+9oCiw
    k8dzFox/dO+TQXGft9tjzewY1jrCFoIbp0KWURYCZNUVRRTGWTPjUqxyRj1lN9se
    2LAf02gkFTF/S9PwJ4r8qGOfoO9zIpf4ObIupaotzQIldsKzu+Txl5Nwb7SIlaSR
    PBB7gLi8cFgqBuBjS7MKz4mJWh5lJ8lezLRWegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518515679; bh=VeE5PvOgyd8/yj4NWCGF/lfrkxB1KeVDtWQk4cjB2Ik=; b=d
    Pw8cwY4oUAOBwHNJTHRNAOEN2nCNYguEgRuTt4fbIvVuKBqZiZrzOiUQI0MDVeJY
    oYPd/ZDd269CcG9anFlFjJVsWduW0wy5wOE03Gth+TxzHrpE2rZDn/OHpsuh2dTi
    2ByNx1C7LIHcsL4W2zFx+FMy1LNBLBIpOkCjrY/Q2CzjYU4aVfL8x3CTOk4k/+s6
    TOoW2cM1DYjOgczNLLR4Yocr0jaSEnPpiyO6BiNBnrwku+UIvNHHbK7+su1Zzr9R
    lSBo+dLckfMK09cT4xoHsju9WV1czGk+foTcu18q+p72T6EFK9eukQWSMKIvAxdf
    17oTDt57+xrY9TEq/0OUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeBMJyR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:54:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934268AbeBMJyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:54:15 -0500
X-UUID: 18d436b9485745579093fd8815e8d2fc-20180213
From: <sean.wang@mediatek.com>
To: <stable@vger.kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>
CC: <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] cpufreq: mediatek: Add mediatek related projects into blacklist
Date: Tue, 13 Feb 2018 17:54:10 +0800
Message-ID: <8193c5fd73ee34b59799fdf5c6cc24ca60971d6e.1516693333.git.sean.wang@mediatek.com>
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

commit 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e upstream.

Please apply 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e to 4.14.y and 4.15.y

commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
device with OPP v2") not added MediaTek SoCs to the blacklist that would
lead to cause an occasional hang or unexpected behaviors on related boards
as kernelci reported and complained on [1] specifically for 4.14 and 4.15
tree. For those reasons, add MediaTek SoCs into cpufreq-dt blacklist.

[1] https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/

Fixes: edeec420de24 (cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2)
Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Kevin Hilman <khilman@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a753c50..9e0aa76 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -111,6 +111,14 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "marvell,armadaxp", },
 
+	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
+	{ .compatible = "mediatek,mt7622", },
+	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt817x", },
+	{ .compatible = "mediatek,mt8173", },
+	{ .compatible = "mediatek,mt8176", },
+
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "st,stih407", },
-- 
2.7.4
