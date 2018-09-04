Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38192C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeIDVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:55:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeIDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Lp7GG-1fREJi3M9c-00esIV; Tue, 04 Sep 2018 19:29:38 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/4 next] net: lan78xx: Bail out if lan78xx_get_endpoints fails
Date:   Tue,  4 Sep 2018 19:29:09 +0200
Message-Id: <1536082152-3669-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
References: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:B/B9WzsyPV6JdCvAOS/Kzjn0ncEXoPUrMhptKGJjexecT1vqpOD
 eyu4RPmiCLJy63Uv9sCRjKqyAV7n+CafQ0+DCGZ/Wc9Jj2MByqinnxQRDe6fe48Qz3KIe9M
 +hyG8Fx8Zj3SOsxrCLo/TOwmjJnQHqt2NuXVMrzoxFOjP9FtgzF35lEip833g6HThWAaPgf
 On3HHCOaYF+UWPT7P2kmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LjWl2pm+5hk=:cbchJ6Zwyx6HaiJzUDXtO/
 YIWPgF+pqkgCE5QD4LonANCoKQd5TzX3Aft3c+1FxWD3CqfkUHXX7XnjkGHX/CS3MNOp8+scD
 sFYEF7dut3niWECuuW1mQrWNEbmSRVgQgPhW1QF676WvAWfPpuDbnxwTmt8FT5Tusamcdexdo
 hIpEkvcKeBJLtW2PiVPBg90WDg/el197pZd7Zge5JmSrq7n5/A+w04bA5aaMU67o61JJUXxCI
 YHA/X/Hogqw9PLel/LIpu/Uobhe7g+7rIzFL840VnYAibpJSdw1kNFJfhBlm2E5f5cbcyFPtT
 QQcevy8t5pesSYUIcnFvxxtXO3hTrKuaro4UA4q0aSDQ4Io23f2CNR7jzycOl9aXY4FSi1ED8
 96x4g4/sMhTzBd5TXyhq6hnpA4wExu/czpDu5fC4yeG9FSLWX2k26m7fcHjlr3O28KJ0kEdFc
 mOvK+DpzGzdOsD5JAJORoPy6B1zvIb15GEZP2WOudv+3jyLW3i0AdcJSiKMQa0iDdH/tIAs2H
 wPq7+KOhnGSeznVY0bppIeNxTOHHt76NWYvDrMo8RCUTfvjotHMlUGxSP90tO8A3MQV2ukmnx
 Q1hb3po9PS3UYm9p2FmHHxujpe8STz/8KVM/rM0bnARUwv975xhcTfXy7Hij+wkPhHV08zjvO
 6Mc2VzhuaGbD6ZP4sYIbkv8Hk+CBCH4UanxrGxflNUv/+HMo99/qJ4wRXqJdIXXRZvOs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to bail out if lan78xx_get_endpoints() fails, otherwise the
result is overwritten.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Raghuram Chary Jallipalli <raghuramchary.jallipalli@microchip.com>
---
 drivers/net/usb/lan78xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a9991c5..3f70b94 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2952,6 +2952,11 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 	int i;
 
 	ret = lan78xx_get_endpoints(dev, intf);
+	if (ret) {
+		netdev_warn(dev->net, "lan78xx_get_endpoints failed: %d\n",
+			    ret);
+		return ret;
+	}
 
 	dev->data[0] = (unsigned long)kzalloc(sizeof(*pdata), GFP_KERNEL);
 
-- 
2.7.4

