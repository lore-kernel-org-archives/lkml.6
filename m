Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32733C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F15208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbhfCiES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F15208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbeFNLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:31:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42600 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeFNLb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:31:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id w17-v6so3394384pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDAAbse4iQFoVFB9gB6KAuHl5DfgzcuZxYfVl4UlGPU=;
        b=pbhfCiES8sTPilxPUZ+ZwKWK7qVI8Uhl1G8iEYe4RxtWIa6oq3idKNxTJ4gMQgO6Tu
         isTe82hZRQW+JwUU1iG1oKo0r2379JunUlkZBADsm5KsgYpDCdAB5ofBpzSrlQ4UAQDN
         117AA7LW/y271yoZWQH7Dy84N0rBp4viyP0BaX6Rp1n96sN7ddFjeMAd606t6gndEuim
         N2Y/O2NTLdhnFbvuuR8Gnt33U/EG+IAcj/eQN4EhjMbIGTxVOcf/2kpmiaC2WDnnvxfR
         TEu9Wlna2dsCKVuj5S/rRDDF9Sirlsj0KougUEenuDnCGloTABPOC5m3P185IV9zrDjl
         xo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDAAbse4iQFoVFB9gB6KAuHl5DfgzcuZxYfVl4UlGPU=;
        b=Fb/Gb8jInx2p4fnlDH3hwDYWifrASmjnUVTm5OAV3Ea4cjo7AzlucbWxc5FFgP/GuA
         49H6TThQ5v8hIWA/B1h/HW+W0IwwZEg7Ov7CMp2wy0EV693L0aLkrexohXNPmBk2HZWQ
         9N7JWkEMFWFIVeuUvJpkSNeBGlWJYH+i9sOuxJTefLaMwf5+lpWz/ecpcYxb+LHRdrQh
         dRb4cEifhAHzubwQgNoIKTaE+ebyAQ8/8vTOPsvjMnNKPeBaEE0HpyKvJ2pkf2fSN9Gm
         0+fh37BCc6pC0SekyWsO6gFk5T3DFsMKBXBvQhv8dYy8Yp096x3T/TfqPAC7ZXiKHPJv
         IIcg==
X-Gm-Message-State: APt69E3r0NQwFN/PC/ZG7xOoW8Xe1dyWgO5t7JTkFcc4kHv762HHYlWg
        MYxclRvATGjk8oxiKX/vuH2nVCYB+sg=
X-Google-Smtp-Source: ADUXVKLXfwc7zDshP+NFjfcnumMIq+SXOrYi41hweLfmfkC0WjxRoRUPRwHtLJpwe8HbF3u5iK6EZA==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr2607180pld.205.1528975917661;
        Thu, 14 Jun 2018 04:31:57 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id s75-v6sm13052683pfj.125.2018.06.14.04.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 04:31:57 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: gdm724x: add error handling for nlmsg_put
Date:   Thu, 14 Jun 2018 19:31:51 +0800
Message-Id: <1528975913-51879-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nlmsg_put fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling nlmsg_put.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Add some cleanup
---
 drivers/staging/gdm724x/netlink_k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
index abe2425..16da03b 100644
--- a/drivers/staging/gdm724x/netlink_k.c
+++ b/drivers/staging/gdm724x/netlink_k.c
@@ -119,6 +119,11 @@ int netlink_send(struct sock *sock, int group, u16 type, void *msg, int len)
 	seq++;
 
 	nlh = nlmsg_put(skb, 0, seq, type, len, 0);
+	if (!nlh) {
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
+
 	memcpy(NLMSG_DATA(nlh), msg, len);
 	NETLINK_CB(skb).portid = 0;
 	NETLINK_CB(skb).dst_group = 0;
-- 
2.7.4

