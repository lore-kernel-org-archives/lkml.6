Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34307C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063E1222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FLZPMbET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfBLSFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59246 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfBLSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:42 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180540epoutp034138fdb2381712981006bfd643618f6f~CsAETtIic0209002090epoutp03p;
        Tue, 12 Feb 2019 18:05:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180540epoutp034138fdb2381712981006bfd643618f6f~CsAETtIic0209002090epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994740;
        bh=Nd6iMSvoNPPtuCu3yqq70f1b8IyocyyRrKhnyfhM8vU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=FLZPMbET15idMcOxDZmCnRRRpyoFRsnaEKC9K03GV8DfxPS1L5oFNO+vJCO69w7ZB
         9xNi8x+EvFkg7lhzDjRkUNQEgNZVS/tjr/yKFMnBi0vs7nJU65dK54XldCxzit+Ak0
         kiba1UC2MIurZ5VMy9VCHcWfPp8BOP6LtqhFztJY=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180539epcas1p1cd2a023ab501c5c35bbf3522caad9a1f~CsADVo3YQ0083100831epcas1p1g;
        Tue, 12 Feb 2019 18:05:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.FC.04173.3FA036C5; Wed, 13 Feb 2019 03:05:39 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180539epcas1p457a5c91f2c2cef0d1b92ff8bf804beee~CsADEU6dY1662916629epcas1p4J;
        Tue, 12 Feb 2019 18:05:39 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-6a-5c630af36b98
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 46.11.04015.2FA036C5; Wed, 13 Feb
        2019 03:05:39 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:38 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 17/21] ASoC: samsung: i2s: Change indentation in
 SAMSUNG_I2S_FMTS definition
Date:   Tue, 12 Feb 2019 19:03:38 +0100
Message-id: <20190212180342.32040-18-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmge5nruQYg1c/hS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ+5Z8ZSvYxl7R3HOMpYFxKVsXIyeH
        hICJxMxbJ5m6GLk4hAR2MErMPLiVEcL5ziixeNcOuKoLTVOhqjYwSsz71cYM4fxilPg89QQ7
        SBWbgKFE79E+RhBbREBM4vacTrAiZoEWJok5c5cygySEBRIlbizfD9bAIqAq8XLWSVYQm1fA
        RmJL9y12iHXyEud714HZnEDxZwu/sUDUCEr8mHwPzGYGqjl45TkLyAIJgQNsEjPXLgJyOIAc
        F4nT+y0gTGmJS0dtIUZWS+za3s0MUd7BKNFyYTszRMJa4vDxi6wQM/kk3n3tYYXo5ZXoaBOC
        KPGQ6HjUCHaOkEA/o8SWf94TGKVmIbloFpKLFjAyrWIUSy0ozk1PLTYsMNIrTswtLs1L10vO
        z93ECI5xLbMdjIvO+RxiFOBgVOLhXXE0KUaINbGsuDL3EKMEB7OSCG8ac3KMEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd71Ds4xQgLpiSWp2ampBalFMFkmDk6pBsYuxc7qS3Yxs0VWRYVLbXiV
        lPPl+uT3yyp9GG1eSgWwL/OpXLdscbrNL6bu/z4/PR7KlScdLe8+ov9oEo9q4L+ZK3gZa0ul
        fh+caHdY+6faycXa/NdfH25t2aYmb8P5d9bzyOvcy3MUlh68YOnx75Pt1+ioow0bNDYJ1LI5
        bc1e/sHUJXNyxH4lluKMREMt5qLiRADM6B5H7QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd3PXMkxBnvaWCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ+5Z8ZSvYxl7R3HOMpYFxKVsXIyeH
        hICJxIWmqUxdjFwcQgLrGCVWTrjPCOH8YpSY+PwoWBWbgKFE79E+RhBbREBM4vacTmaQImaB
        JiaJXbcvsoMkhAUSJW4s3w9mswioSrycdZIVxOYVsJHY0n2LHWKdvMT53nVgNidQ/NnCbyxd
        jBxA26wlrmyyhSgXlPgx+R4LiM0MVH7wynOWCYx8s5CkZiFJLWBkWsUomVpQnJueW2xUYJiX
        Wq5XnJhbXJqXrpecn7uJERjE2w5r9e1gvL8k/hCjAAejEg/viqNJMUKsiWXFlbmHGCU4mJVE
        eNOYk2OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYORg
        yalLVfu5erf7gdIl/1efqn5efvvoPV+/MsWirA3MV3f9+HF+xzrTiG/rJY69eH7mtXyqI3dR
        nfa6GxEC6eF+6796bor03GfH7e836+KXvcaTA+pPH50XkSThGbR7j1+OS229gsBqHhP73Hr5
        KcFBvts3eQflKyaKL/6TomB6NkV1w+IObiWW4oxEQy3mouJEAHBtDqleAgAA
X-CMS-MailID: 20190212180539epcas1p457a5c91f2c2cef0d1b92ff8bf804beee
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180539epcas1p457a5c91f2c2cef0d1b92ff8bf804beee
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180539epcas1p457a5c91f2c2cef0d1b92ff8bf804beee@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change indentation so this macro definition spans 2 rows and looks
more consistent with surrounding code.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 097c641fc1b9..debeaf51cc7e 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1150,9 +1150,8 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
 };

-#define SAMSUNG_I2S_FMTS	(SNDRV_PCM_FMTBIT_S8 | \
-					SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S24_LE)
+#define SAMSUNG_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+			  SNDRV_PCM_FMTBIT_S24_LE)

 static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  const struct samsung_i2s_dai_data *i2s_dai_data,
--
2.20.1

