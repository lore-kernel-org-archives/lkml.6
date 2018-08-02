Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B7121501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+lv2hHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B7121501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHBTKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:10:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:10:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so2887518wre.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yDpcNrzd3bIdRHtMLKWH12x556X3QclGSR/SBsoypRs=;
        b=g+lv2hHFsBCnr6WI4s2j20cGgVozLmWZ0xlDLwCpKmbsICll2uliTVnXfVmIpnBQLn
         TQK31DeYO6QWWorR/RzGeSk3SgUxOMgPiuoRpToCcQzb3zp04WpbuBEmq2hheTlIYcWh
         QKq/K8Lty4G6TlO3sh4csTbLTit4wcjKhsmwye6tyacjMkRTAE1X+FNf6/UhiMBtXgMI
         W6SszJY+boLvBMNiJATJzfzMS7HdCBWCApstolY+9/EbwJs4Zg+YGU9KSY6PDzvYgB8K
         Py1ao4vPiVubWJ9zDwbMTQi/XlLAawNePlad8Wkw8hPIMBSpU5mywoX/514jMY/ncquC
         B8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yDpcNrzd3bIdRHtMLKWH12x556X3QclGSR/SBsoypRs=;
        b=IQ/K2fuopEJlymaxSxUxkvp6xcRDEXCjxWDrJPLfs09q/W4O66jDMwkgFi3Y8QEK2G
         lPcmadsUJTxHx8y9FdJyyUO2vNqdnPTMaZ1IE2JzbM+sboVFeblTaLWlUL9WVSVnzej+
         mxhqt+im3B8kxWdYwzIaMjA9n4rw5sUgWgX/JL1uLDAiaXL5SJhWF+d1ZUkHcla7wTxy
         KlWtjKNsQqKAe+merL7nJoeB5JX97bdrQPNXeU7KOp4LTqwHwLqycDllo8bz/p16L5jf
         B2nb95aPOCFlX9VCkzeR1fCCqxw/lkt/+a/fKfHcKa/rR2OVjB0/rCy+g3EqEeNaeg5F
         b63Q==
X-Gm-Message-State: AOUpUlHYfTwq/oZ/9jNo4E61c4nHhuJVPiNzdCBgbkYX9VLdR+duG3/j
        CkxjhNdQcsSCpXTgpMbqyaqzGMqj
X-Google-Smtp-Source: AAOMgpf163dDRC8NPUKJFkzzjJ6wC80qHOVcO/NA6hPlJ67s+rZljD0bgQml0KRbDwvRrprbwp2ehw==
X-Received: by 2002:adf:ff11:: with SMTP id k17-v6mr213467wrr.255.1533230324454;
        Thu, 02 Aug 2018 10:18:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3205081wrn.34.2018.08.02.10.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 10:18:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: use is_multicast_ether_addr
Date:   Thu,  2 Aug 2018 19:18:19 +0200
Message-Id: <20180802171823.1571-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802171823.1571-1-straube.linux@gmail.com>
References: <20180802171823.1571-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
hal/rtl8188eu_xmit.c.

There is only one use, so remove the extra variable for the
result of IS_MCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 14622eee56ca..82fc5075e0a6 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -167,7 +167,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	int	bmcst = IS_MCAST(pattrib->ra);
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -186,7 +185,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 	ptxdesc->txdw0 |= cpu_to_le32(((offset) << OFFSET_SHT) & 0x00ff0000);/* 32 bytes for TX Desc */
 
-	if (bmcst)
+	if (is_multicast_ether_addr(pattrib->ra))
 		ptxdesc->txdw0 |= cpu_to_le32(BMC);
 
 	if (adapt->registrypriv.mp_mode == 0) {
-- 
2.18.0

