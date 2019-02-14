Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B895C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A332229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M0aG66/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437916AbfBNJi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:59 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:44154 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437891AbfBNJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:56 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093854epoutp03d8cac5f1c482fa34dcda77abf48e8c5d~DMYK5AmpN0834508345epoutp03g;
        Thu, 14 Feb 2019 09:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093854epoutp03d8cac5f1c482fa34dcda77abf48e8c5d~DMYK5AmpN0834508345epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137134;
        bh=+melQFnhucKXec64n3LxQa4qD0lcZ3kQ1hkEfDibqRM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=M0aG66/CuOXis17Egx7In3VL0WqBlHIJJmaRh0qKtpvJLbjTe6n27h/6tnbgYdEZm
         iSzS9YQ+mAsaAG2sT2Kco2+xTj4OwSBJ1CGjdxYLsrRge/8a7qD6LO97YGshSb+klu
         9DbymjmXqHJSqfYz87BMdISYHLygnJbt7OmyjpJI=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093854epcas2p23b54a4f765eafc97824f4a3cb6a470ee~DMYKqobpN1576715767epcas2p24;
        Thu, 14 Feb 2019 09:38:54 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.D6.04093.D27356C5; Thu, 14 Feb 2019 18:38:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093853epcas2p2f48340585495bf0ba662ae42399d1cab~DMYJ_1sck1576715767epcas2p22;
        Thu, 14 Feb 2019 09:38:53 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-7b-5c65372d341e
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 5E.52.03689.D27356C5; Thu, 14 Feb
        2019 18:38:53 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:53 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 11/13] ASoC: samsung: i2s: Change indentation in
 SAMSUNG_I2S_FMTS definition
Date:   Thu, 14 Feb 2019 10:37:45 +0100
Message-id: <20190214093747.2414-12-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmqa6ueWqMwa0nlhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8beTScZC16xV2x4tYWxgfEiWxcjB4eEgInE51bRLkYuDiGBHYwS
        zdsvskI43xkljpzqYepi5AQrOvR/HxtEYgOjxK+ZG6CcX4wS654vZQSpYhMwlOg92gdmiwiI
        Sdye08kMUsQssJJRYsu+TWwgCWGBDInV2+ewg9gsAqoSZ9ccB1vBK2AtMeHJXxaIdfISqzcc
        YAaxOYHiMzdtZwQZJCHQwyZxcv0lqJtcJFZMW88MYUtLPFu1kRHCrpbYtb2bGaKhg1Gi5cJ2
        qCJricPHQb7jBDqJT6Lj8F92SAjwSnS0CUGYHhLdL/whPutjlJiw6wrbBEaJBYwMqxjFUguK
        c9NTi40KTPSKE3OLS/PS9ZLzczcxguNMy2MH44FzPocYBTgYlXh4K4RSYoRYE8uKK3MPMUpw
        MCuJ8F40So0R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvtQem60kEB6YklqdmpqQWoRTJaJg1Oq
        gbHv8ZJQDbb4h/9zvpkETO6bMGF9T3ho4/5spUrFv7x7gxZE9pVXLo+ve+LLfaKvUHldcLJv
        lq2mldqj9X5r54hP2XyY27jW8/HFrs+ZplXvu4SeKDt8eSD5jy+sfq/Tpk8P9vsaq1lYfemv
        etV6vMjx9ZeDxksX3Zl+Ps77rmU7O9fbonNSnUosxRmJhlrMRcWJAMXBZV+vAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK6ueWqMwYJ2fosrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK2PvppOMBa/YKza82sLYwHiRrYuRk0NCwETi0P99QDYXh5DAOkaJ
        Pf+PM0I4vxglbjx7ww5SxSZgKNF7tI8RxBYREJO4PaeTGaSIWWAlo8SR76vAEsICGRKrt88B
        a2ARUJU4u+Y4E4jNK2AtMeHJXxaIdfISqzccYAaxOYHiMzdtB+rlANpmJbHuUPkERp4FjAyr
        GCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECw2jbYa3+HYyPl8QfYhTgYFTi4a0QSokR
        Yk0sK67MPcQowcGsJMJ70Sg1Rog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB9MSS1OzU
        1ILUIpgsEwenVANjdsPflx5rJRNlV1zS/LuiZM6sG0tn/7+XuPkmz6wHqX8nxFxQ5OcWm3f+
        T970TJElgV/0P9v9r812/CV9yD7Pw7254nz6BOmpcx98T8+KuXW5vGpb4uzCrWz/O5Kln87T
        fDz5ZXiW4MOHu50tl8VIViUyr/RfKts8/cylx28+pilu/rY0+lLRAyWW4oxEQy3mouJEAE/F
        UI4fAgAA
X-CMS-MailID: 20190214093853epcas2p2f48340585495bf0ba662ae42399d1cab
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093853epcas2p2f48340585495bf0ba662ae42399d1cab
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093853epcas2p2f48340585495bf0ba662ae42399d1cab@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change indentation so this macro definition spans 2 rows and looks
more consistent with surrounding code.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f15b6af8268..e0c151843f9e 100644
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
2.17.1

