Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D0DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5EF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k7is+4a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5EF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLLBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:41:20 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:57809 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:41:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181212014117epoutp040cd42e5277df9e581bc56d37ecb8689b~vck44c77D1411314113epoutp04Y;
        Wed, 12 Dec 2018 01:41:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181212014117epoutp040cd42e5277df9e581bc56d37ecb8689b~vck44c77D1411314113epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544578877;
        bh=b2cW/XGVs7AqGU1EB3o4t6BQbzq39uGva1KWg2HQQrU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=k7is+4a2QH8whNCA0P1ZCaY7dPqsawLwQ5KSS/orqV1punyAx5NoPKZWAuxDq5Y2b
         o/iQwL7nWn3i8A34WBAWGNjN/4uLwExG9mOAmUcjxpvi3m0ouKkSzPW5vPCfJxzJZd
         Yc36hnPB85FCquwJTZaPf+4fpgKPGsHcRrjFBOMY=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181212014114epcas1p3a7470295732ca4dcfa83986dfd7cec5e~vck2Toord1357713577epcas1p3l;
        Wed, 12 Dec 2018 01:41:14 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.72.04060.A37601C5; Wed, 12 Dec 2018 10:41:14 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f~vck05qP4B0256302563epcas2p3i;
        Wed, 12 Dec 2018 01:41:13 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-45-5c10673a1308
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 05.80.03627.837601C5; Wed, 12 Dec
        2018 10:41:13 +0900 (KST)
Received: from localhost.localdomain ([10.113.63.77]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PJL008GYOOO3DA0@mmp2.samsung.com>; Wed, 12 Dec 2018
        10:41:12 +0900 (KST)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de, krzk@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] MAINTAINERS: Change entry name of samsung exynos bus
 frequency driver
Date:   Wed, 12 Dec 2018 10:41:11 +0900
Message-id: <1544578871-5278-1-git-send-email-cw00.choi@samsung.com>
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7bCmqa5VukCMwYSd6hZz1q9hs/g76Ri7
        xfUvz1kt5pxvYbFoXryezeL8+Q3sFpd3zWGzeP+pk8li++aFzA6cHr9/TWL02LLyJpPHplWd
        bB4nZvxm8dg/dw27x50fSxk9+rasYvT4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6D4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1S
        akFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGiYmL2Qve8lbc6nzH1sD4lruLkZNDQsBE
        4nLbWrYuRi4OIYEdjBKzF+5nhnC+AzmHn7F3MXKAVb1ukoKIb2CUuNJzgh2u6PDBXlaQUWwC
        WhL7X9xgA7FFBBQkNvc+YwUpYha4yCix+9NyRpBJwgIREns/m4DUsAioSmxdew+sl1fARWL3
        xxlsECfJSXzY8whsgYTAHDaJRxvvMEMkXCSW7DsJVSQs8er4FnYIW1ri2aqNjBAN7YwSX140
        s0I4ExglPpzazARRZSzxbGEXmM0swCfRcfgv1G+8Eh1tQhAlHhL7j+4EGyokECux9PcuRqAJ
        CxgZVjGKpRYU56anFhsVGCGH7yZGcGrRctvBuOSczyFGAQ5GJR7eHa/4Y4RYE8uKK3MPMUpw
        MCuJ8MoYCcQI8aYkVlalFuXHF5XmpBYfYjQFBsJEZinR5Hxg2ssriTc0NTI2NrYwNbc0NrBU
        Eud9KD03WkggPbEkNTs1tSC1CKaPiYNTqoHR847qazM2a6vJJn93XH9TsCdz60WVWplnSc6i
        BnfF2j8HOWXLHo8RObB6jTn/O4ue/24M01wSwvRknhwWzrkYn11bxLc9aOe95HMJQjJzWKSv
        Fn6Qjvi2wqam68nK2FO2i9g8ynaEF25U4BPZyXxq/+z6Jdfzi7gnfAkMs5Jdr9zi9mBBSqQS
        S3FGoqEWc1FxIgD0L4WOQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e+xoK5lukCMwdxbrBZz1q9hs/g76Ri7
        xfUvz4Hc8y0sFs2L17NZnD+/gd3i8q45bBbvP3UyWWzfvJDZgdPj969JjB5bVt5k8ti0qpPN
        48SM3ywe++euYfe482Mpo0ffllWMHp83yQVwRHHZpKTmZJalFunbJXBlnJi4mL3gLW/Frc53
        bA2Mb7m7GDk4JARMJF43SXUxcnEICaxjlOheepAJwvnOKLF83S7GLkZODjYBLYn9L26wgdgi
        AgoSm3ufsYIUMQtcZJQ4duMIE0hCWCBCYvf+PrAiFgFVia1r77GC2LwCLhK7P84Ai0sIyEl8
        2POIfQIj1wJGhlWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIGBtO2wVv8OxsdL4g8x
        CnAwKvHw7njFHyPEmlhWXJl7iFGCg1lJhFfGSCBGiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9/
        /rFIIYH0xJLU7NTUgtQimCwTB6dUA6NNyuw0DvV16bVsvGtu5L4u36PzimMLp6P4kiBRnw/u
        QaLbuzYJBc1anCFvWTPP/YzP61MhCRafDF+9PeV5btOV2bPnFmUf/dZpdvjM/gdZqx4W+4fM
        v2Tet/6dz1ZPRqscZX6fPVumzrol8WHi/hXm2+YXJU0LFHki2anfqGrx6/3+zl0LPlYosRRn
        JBpqMRcVJwIA9XlwHiACAAA=
X-CMS-MailID: 20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f
References: <CGME20181212014113epcas2p3e8f44ef2a016a896110df8fe85d0118f@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung Exynos's device drivers have the 'SASMUNG EXYNOS' prefix
in front of the specific device driver name. In order to keep the
consistent naming format, change the entry name of bus frequency driver
for Samsung Exynos and then reorder it alpabetically.
- old : BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
- new : SAMSUNG EXYNOS BUS FREQUENCY DRIVER

Also, remove the unneeded git repository information.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8119141a926f..f180b8499036 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3248,15 +3248,6 @@ S:	Odd fixes
 F:	Documentation/media/v4l-drivers/bttv*
 F:	drivers/media/pci/bt8xx/bttv*
 
-BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
-M:	Chanwoo Choi <cw00.choi@samsung.com>
-L:	linux-pm@vger.kernel.org
-L:	linux-samsung-soc@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
-S:	Maintained
-F:	drivers/devfreq/exynos-bus.c
-F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
-
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
 L:	linux-scsi@vger.kernel.org
@@ -13102,6 +13093,14 @@ S:	Supported
 F:	sound/soc/samsung/
 F:	Documentation/devicetree/bindings/sound/samsung*
 
+SAMSUNG EXYNOS BUS FREQUENCY DRIVER
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Maintained
+F:	drivers/devfreq/exynos-bus.c
+F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-crypto@vger.kernel.org
-- 
1.9.1

