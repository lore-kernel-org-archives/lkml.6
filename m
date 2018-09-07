Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C067CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732AD2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYJ2Mjv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732AD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGWI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:08:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45557 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeIGWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:08:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id u83-v6so12849573lje.12;
        Fri, 07 Sep 2018 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l7Wmm5zNI5FkbzOn57PV2u80o55Qrfw7dU+DgFDUcEE=;
        b=uYJ2Mjv46GM9rcKmqkDibxkdFn/Y+gq9A4PCsW+D4tKKQI/0qKKV7D6sGZB2le5WgI
         5QFtcvvmfClkS5lHckPq9z2MPGiO0qCRod+pEKsabsfqvyfA9m3SKVlWTBeML5LL+OXw
         z7NT2ZjY6fXkW1VRLs6hGosDIqIka2GS8uJsMAVox9Lm8hJtQl7mbyU7OGQgJq+2VWS+
         q8qsUEf2BRPtwrAWxcZDXFiniHFFuUkKnvBjSGk/mkei4w3MLMhgUb9t9oyq63sUOWTH
         izn1wwVV9pS6UINdk9HLyNYsPEWq0Cip6y/cgUAl2oiKV/SGvCeuGs5OYNElPAzzm2Gz
         Hjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l7Wmm5zNI5FkbzOn57PV2u80o55Qrfw7dU+DgFDUcEE=;
        b=gdrFgtMTzbRsGnozzEPLqSPptjkS8zaRxEwe4GDMnV1jioHGUjOiLRE2Vf30VUSIQp
         aSDNpQEGXZUb+PnhobFbnJ515+aXXR7BTza9cnN05IpVMKW4JjtipQp1SbtlphpHAuQy
         c8t3RAbLe2f0WwRYzpDS0jJwAAjGXvA7LxOHjnaqwwOR/CMc8gjbRIuH1xYwJh5b5GYM
         jGlbeX2RVRoi1RPrepbdejhXb5wYnOx5GapsGyCUHQmbcuM1FVmnGO7wYsCsSFk3Te8X
         FHwSu4vgGyQgztjfrsSuQFx+/jbnL+zQbsvzMuGsLvlZlqKaR16T10vCa00bwjuVIlHH
         7oag==
X-Gm-Message-State: APzg51BMnnhNbrpYqLDoq5snr2lCU8ZO4X8l/ERkWA0BcbT6GS3OMsyf
        /vBs+AAqgnrak9fkgIDQd8s=
X-Google-Smtp-Source: ANB0VdYc4/aALH15G8RxXExPDtwMMAx176xM+969aiUPUrmiNTrhjPxe4gETxAcIwPCCEwiI0vxizQ==
X-Received: by 2002:a2e:4782:: with SMTP id u124-v6mr5937015lja.40.1536341218991;
        Fri, 07 Sep 2018 10:26:58 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id d14-v6sm1380854ljc.56.2018.09.07.10.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:26:58 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     huangdaode <huangdaode@hisilicon.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: hnae: add unlikely() to assert()
Date:   Fri,  7 Sep 2018 20:26:50 +0300
Message-Id: <20180907172650.29408-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assert() condition is likely to be true.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: huangdaode <huangdaode@hisilicon.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 08a750fb60c4..bd3c180a3fe9 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -47,7 +47,7 @@
 #ifndef assert
 #define assert(expr) \
 do { \
-	if (!(expr)) { \
+	if (unlikely(!(expr))) { \
 		pr_err("Assertion failed! %s, %s, %s, line %d\n", \
 			   #expr, __FILE__, __func__, __LINE__); \
 	} \
-- 
2.17.1

