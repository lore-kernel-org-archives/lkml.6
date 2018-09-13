Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B1B20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JSA2p9Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B1B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMNHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:07:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46102 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIMNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:07:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913075856euoutp0277d96991331eedfd6a1148b1d8096f76~T5q7muPfI1523215232euoutp02M
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913075856euoutp0277d96991331eedfd6a1148b1d8096f76~T5q7muPfI1523215232euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536825536;
        bh=q3yZm8Q+CX16ZHN6orngczIgV6OJwcIKxHX5/gW9tYM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JSA2p9Zs1HPnE/a7LFygT9GzDQhx8/6Vubksjsj3pHOYuChDADIkKNZalF6ROTkZp
         aIKICd8UwRPV/IV65OBWN1sIgKiCwlRmECbidL5PLNsCwKAuiOq+1Jx2wx8BYNXl36
         6ujWw1ElWLq+LdHgfyVlMKiViRGAk53Ae9bVMX4g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913075855eucas1p2ea9a1fe7129886823ddcc8c1993e90e1~T5q6uPeol2421624216eucas1p2p;
        Thu, 13 Sep 2018 07:58:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.D7.04294.FB81A9B5; Thu, 13
        Sep 2018 08:58:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c~T5q5vKjDE1335913359eucas1p1q;
        Thu, 13 Sep 2018 07:58:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913075854eusmtrp2aa77936e25faf5a3956de8840bff5d55~T5q5d3dEy2501325013eusmtrp2G;
        Thu, 13 Sep 2018 07:58:54 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-78-5b9a18bf4633
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.F8.04128.EB81A9B5; Thu, 13
        Sep 2018 08:58:54 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913075853eusmtip1f7d453c9e12a98c6a16bfd58a858ff0b~T5q5CI3fE1671516715eusmtip1P;
        Thu, 13 Sep 2018 07:58:53 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: s5p-sss: Fix and add aes-ctr support
Date:   Thu, 13 Sep 2018 09:58:38 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSX0hTYRztu3e7u5tNrlPYh8qIlUZqWpZxQ4uEhPsY9BAkojOvU3TTdtWy
        p60t0xU2RcvGtCwlnYQ1htoycwrtIXGZf9BaxRKkZpa1SWyay+1qvZ1zfuf8zveDD0dFam4s
        XqqsolVKWbkUE3AGXvmdB19CY+4hi1ZCOp53A9Lk1HHIG554snEkCEin8wmP/PTRj5DTNhNG
        tjlHEDIY0KKn+JS1dwGhBkYTKIu5AaM2O1s4lP37MEI1Ws2A8lokZ3jnBVlFdHlpDa1KO1kg
        KJm79oBX2c69HNwYxNTAyNEDPg6Jo/DtpAPogQAXET0AWtUt28QHoEGj5bLEC+B1zSZ3J9Ls
        +oayg0cALqyYOP8iLqcbhFwYkQHff/iF6QGOxxB7YMdaSsiDEhMInDK0oyFPNJENHd1tIOTh
        EAlQt5TDFkjgwmRDuAASPzD4tL0nvEdI1MCuYQXrOQ09j00Ii6Ohx2HlsTgeBp/dQ9isFsB3
        vjkuSwwA2vv021dnQsu8BwktRYkDsN+WxsrZcNU4G34PJCLh/EpUSEa3YPPAHZSVhbC+TsS6
        E+Gy1Yrt1H7xrgEWU7BpNhC+UETkwQ6jGxiAxPi/6z4AZiCmqxmFnGbSlfSlVEamYKqV8tQL
        FQoL2PoXrzcdviFg2ygcAwQOpLuFbfvv5oq4shqmVjEGII5KY4TLvC1JWCSrvUKrKvJV1eU0
        MwbicI5ULIxMKs4VEXJZFV1G05W0ameK4PxYNVCUYQ/3oeeONOt+TpvtQxW+oH5pVHW20zqO
        eTtK4jBKt5iVsSj2uLv8dWDweGNE9e9CW98xTWXGRf7er6Kc9OIpt+ZN0YydbhIEZtfrb99C
        16OmZiZbU8S99YEJ/4mrkfKCmM+J/RGr5vnMvD83k8fzbcmSbo8g0+V6satVymFKZIeTUBUj
        +wvXhhofEwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7r7JGZFG7zcJWFxfPdSRos551tY
        LLpfyVj07fvPaHH+/AZ2i/v3fjJZXN41h81ixvl9TBb/fzUzO3B6bFl5k8lj2wFVj02rOtk8
        /i2cwuJx8N0eJo++LasYPT5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1
        MjJV0rezSUnNySxLLdK3S9DLuNa6iL1gLmvF/z/b2RoYZ7F0MXJySAiYSEy684a5i5GLQ0hg
        KaPE1MYdzBAJGYl5Z/vYIGxhiT/Xutggij4xSuw7t5gJJMEmYCpx++4noAQHh4iAgsS8rzog
        NcwCl5gklkxeDDZIWMBR4vjSGYwgNSwCqhItz1xBwrwC7hKTZ/1jhJgvJ3HzXCfzBEaeBYwM
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLDdNuxn1t2MHa9Cz7EKMDBqMTD+0JpZrQQa2JZ
        cWXuIUYJDmYlEd7X7EAh3pTEyqrUovz4otKc1OJDjKZAuycyS4km5wNjKK8k3tDU0NzC0tDc
        2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA6NZLIth5f+ehUeEzrPL3Ff5flCafdvn
        sEjzsqX2kRJbhE2uWqh2CkYvXnnSNkyotXF5SURHdOeGw+6Gc853tiQdkZ7kw3qvekPZ1SUx
        rjOurl9ktW0at/0OQ/ftAdM6Wa+4f70juTfql67atdhtyivW6McuNuXwKBIq6tFgPTGBTWPz
        ymThZUosxRmJhlrMRcWJAJzMOJRpAgAA
Message-Id: <20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c~T5q5vKjDE1335913359eucas1p1q@eucas1p1.samsung.com>
X-CMS-MailID: 20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c
References: <CGME20180913075854eucas1p1ab212d14a48f86dd94f8580dca4bc63c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds aes-ctr support in s5p-sss.c driver. Additionally it
it provides a fix, and a minor code cleanup.

Patch 1 contains a simple fix, of a possible race condition.
Patches 2-3 are code cleanup patches.
Patch 4 adds support for aes-ctr block cipher mode of operation.

Regards,
Chris

Christoph Manszewski (4):
  crypto: s5p-sss: Fix race in error handling
  crypto: s5p-sss: Fix whitespace issues
  crypto: s5p-sss: Minor code cleanup
  crypto: s5p-sss: Add aes-ctr support

 drivers/crypto/s5p-sss.c | 114 +++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

-- 
2.7.4

