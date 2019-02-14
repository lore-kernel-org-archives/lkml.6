Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C172070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YVDkPODZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437903AbfBNJi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:56 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31347 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437873AbfBNJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:54 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214093852epoutp046d3ff03d92ed568a5683c302e85037ff~DMYI7yDKR1365913659epoutp04g;
        Thu, 14 Feb 2019 09:38:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214093852epoutp046d3ff03d92ed568a5683c302e85037ff~DMYI7yDKR1365913659epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137132;
        bh=PdXUiHMjO8jWQA+bA7KAm5R1xW5ACTcrowF1ypy2U0E=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=YVDkPODZxgprhdA5Idnu6wMuGXq/kQQ94pVkJVnDCbH+zgd9hIBCshE650XSFqd4S
         K4sZLW+N405RWc07VHhEUsZr+0HNBUKFp4BOG40ZawTsEA2G0JjywWtXZz1hThdsOQ
         Tl5eX/AkCyHqD9yYI4QZmTeZH9jxACgnt5OAR6UQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093851epcas1p306dc679f25a40a20c3b89ccfa00198b5~DMYIrXAfC1440014400epcas1p3B;
        Thu, 14 Feb 2019 09:38:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.24.04288.B27356C5; Thu, 14 Feb 2019 18:38:51 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093850epcas1p2ced5d0673c9c4aebe57aa0ab4b08aeaf~DMYHcWcFy2981729817epcas1p2X;
        Thu, 14 Feb 2019 09:38:50 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-ac-5c65372b0059
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 4D.F3.04015.A27356C5; Thu, 14 Feb
        2019 18:38:50 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:50 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 10/13] ASoC: samsung: i2s: Simplify pri_dai,
 sec_dai pointers usage
Date:   Thu, 14 Feb 2019 10:37:44 +0100
Message-id: <20190214093747.2414-11-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmnq62eWqMwa11OhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bVu50sBfe4KlZ9aGFrYLzD0cXIySEhYCKxds409i5GLg4hgR2M
        EtOn3oFyvjNKnLz4kRGm6tbSeUwQiQ2MEr++rWeDcH4xSux/t4sdpIpNwFCi92gfWIeIgJjE
        7TmdzCBFzAIrGSW27NvEBpIQFoiXaFj+iAnEZhFQlTh9eQlYM6+AtcTc2wuZINbJS6zecIAZ
        xOYEis/ctB3qjB42iZ7d3BC2i8Sk08tYuhg5gGxpiUtHbSHC1RK7tneD7ZUQ6GCUaLmwnRki
        YS1x+PhFVhCbWYBP4t3XHlaIXl6JjjYhiBIPif1NsxghHutjlDh2dhPrBEaJBYwMqxjFUguK
        c9NTiw0LTPSKE3OLS/PS9ZLzczcxguNMy2IH455zPocYBTgYlXh4K4RSYoRYE8uKK3MPMUpw
        MCuJ8F40So0R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrvewTlGSCA9sSQ1OzW1ILUIJsvEwSnV
        wFhm1i647iHT/5THs+zMYh/2SPn4f/t09/2l9b4Z+2PYuU6fKLA7XPtLeOatlKkyj2rjbwfs
        vBYYIMP60eJ+q9znPNFPBUs8XcqmpDKvijg24xJTxNmUmWlMBgsvMmy6fvIvl4TtdNYUpk3/
        tn/98CVn9cNjszcEcSU4txXubpXrKArc23q66ZkSS3FGoqEWc1FxIgCEXCJ2rwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK6WeWqMwZVD8hZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bVu50sBfe4KlZ9aGFrYLzD0cXIySEhYCJxa+k8pi5GLg4hgXWM
        EjPe/GWGcH4xShxZ8ZIFpIpNwFCi92gfI4gtIiAmcXtOJ1gRs8BKoKLvq8ASwgLxEg3LHzGB
        2CwCqhKnLy9hB7F5Bawl5t5eyASxTl5i9YYDzCA2J1B85qbtQL0cQNusJNYdKp/AyLOAkWEV
        o2RqQXFuem6xUYFhXmq5XnFibnFpXrpecn7uJkZgGG07rNW3g/H+kvhDjAIcjEo8vAoCKTFC
        rIllxZW5hxglOJiVRHgvGqXGCPGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1
        tSC1CCbLxMEp1cAo+mVyQJT2lziP7YretbqrbOS+FZTVMXROWLxccd+8dycZDM+fWs3moqQg
        Zc1bmGT1/1jBQTbvnb5Htiue8PcvbdLgXn2c11HkfkTShNU+5ifmPJzSXWXximdD+4LP3FMS
        2m6c2B3Wc+tQNLPUbn3rYiWDxqlBAer539tXXZucpnNnqUpKdLUSS3FGoqEWc1FxIgD9jxTe
        HwIAAA==
X-CMS-MailID: 20190214093850epcas1p2ced5d0673c9c4aebe57aa0ab4b08aeaf
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093850epcas1p2ced5d0673c9c4aebe57aa0ab4b08aeaf
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093850epcas1p2ced5d0673c9c4aebe57aa0ab4b08aeaf@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe call is on the primary DAI we can use 'other' in place of
i2s->sec_dai, if the probe call is on the secondary DAI we can use 'i2s'
in place of other->sec_dai.

While at it fix one whitespace issue.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 16e6868376f6..4f15b6af8268 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1057,18 +1057,17 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
-		snd_soc_dai_init_dma_data(dai, &other->sec_dai->dma_playback,
-					   NULL);
+		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-					   &i2s->dma_capture);
+					  &i2s->dma_capture);
 
 		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
-					i2s->sec_dai->idma_playback.addr);
+					   other->idma_playback.addr);
 	}
 
 	/* Reset any constraint on RFS and BFS */
-- 
2.17.1

