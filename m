Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192120846
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cS1xSkt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7192120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH0MZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:25:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37257 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:25:02 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180827083918epoutp0373110197999f59cf19a81360456341eb~OsQUvdegt2112721127epoutp03L;
        Mon, 27 Aug 2018 08:39:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180827083918epoutp0373110197999f59cf19a81360456341eb~OsQUvdegt2112721127epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535359158;
        bh=Vj3HBJD5xjxX16NWptovv1RS8hnShRIBiS+kDrHptT4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cS1xSkt4jvtT64P5PaAuZ+4a+9fBernw9IBWBx9agFAkJfi2lln7lR6+0gCToLuu7
         /0Mxtw+svrrCoFCO4IcLtn6/TZTQaDXbfwCXopby9L5uPhPXeiMlaLN5VFrq3ZRTwk
         fHrT9YfJMDWqOPovWx8uZj6Ihkw0tt/cOTxPpsGY=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.193]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180827083916epcas5p45029073d99f77854179d9b904d9e42ef~OsQS00gWk1346913469epcas5p4V;
        Mon, 27 Aug 2018 08:39:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.22.04305.4B8B38B5; Mon, 27 Aug 2018 17:39:16 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37~OsQSodb4C3157831578epcas1p4c;
        Mon, 27 Aug 2018 08:39:16 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000010d1-b1-5b83b8b4452f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F6.74.03702.4B8B38B5; Mon, 27 Aug
        2018 17:39:16 +0900 (KST)
Received: from srikanthh.sa.corp.samsungelectronics.net ([107.108.218.43])
        by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PE400MPE2P26O80@mmp2.samsung.com>;
        Mon, 27 Aug 2018 17:39:16 +0900 (KST)
From:   Srikanth K H <srikanth.h@samsung.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     srikanth.h@samsung.com
Subject: [PATCH 1/1] Preventive patch in the pin control subsystem to handle
 NULL check.
Date:   Mon, 27 Aug 2018 14:08:59 +0530
Message-id: <1535359139-6264-1-git-send-email-srikanth.h@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCmvu6WHc3RBj9PallM+bOcyWLz/D+M
        Fpd3zWGz2PHiFZMDi8eda3vYPPq2rGL0+LxJLoA5KtUmIzUxJbVIITUvOT8lMy/dVsk7ON45
        3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ibkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KdrQ0EjP0MBcz8gISJvGWhmZApUkpGZ87t7LVNDOUfFk9y72BsarbF2MnBwSAiYSp/a1Mncx
        cnEICexglPjw4BU7hPOdUaLpWRczTNWM++tYQWwhgQ2MEjeafCCKepgkVj54ywSSYBPQlnj/
        t5kRxBYRiJD4++MJC4jNLCAl8efMYXYQW1ggSqK5+wTYahYBVYmbDT1gNq+Aq8SUgw8ZIZbJ
        SZw8NpkVZIGEwFlWiVu7XkNd4SLxYsslqCJhiVfHtwAN5QCypSUuHbWFqJ/MKLFs2XImiJrV
        jBLvHvhB2PYSMxZvZYY4iE/i3dceVoheXomONiGIEg+JDW33WSCejJXYeXoBywRGiQWMDKsY
        xVILinPTU4sNC0z0ihNzi0vz0vWS83M3MYLjXMtiB+Oecz6HGAU4GJV4eAPeN0ULsSaWFVfm
        HmKU4GBWEuFt9myOFuJNSaysSi3Kjy8qzUktPsRoCgyCicxSosn5wBSUVxJvaGpkZmZgaW5p
        ZmFgoSTOa+QXHC0kkJ5YkpqdmlqQWgTTx8TBKdXA6DfxwPFSBYNfK99+NLn899PMxJ2Tcio2
        cnldrSzKuRA8daH1D678YKa7zf2yBw/etjK/9cO3lS1Dsvsdz8ZjPxmKdjU5t83kUTyqe/zj
        pDVK+tMv2wosPf52mXzCNX6uSd/MDpQ6yk+dyRo0LTDKRuHG++pzi831TkQv6/i+vbZwflH7
        RAX3RCWW4oxEQy3mouJEAMPRGkkJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJMWRmVeSWpSXmKPExsVy+t9jQd0tO5qjDd4dkbaY8mc5k8Xm+X8Y
        LS7vmsNmsePFKyYHFo871/awefRtWcXo8XmTXABzFJdNSmpOZllqkb5dAlfG5+69TAXtHBVP
        du9ib2C8ytbFyMkhIWAiMeP+OtYuRi4OIYF1jBKHOm6zQzh9TBI/7p5kB6liE9CWeP+3mRHE
        FhGIkLi5cAoziM0sICXx58xhsBphgSiJ5u4TYFNZBFQlbjb0gNm8Aq4SUw4+ZITYJidx8thk
        1gmMXAsYGVYxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgR6edthrb4djPeXxB9iFOBg
        VOLhXfGxKVqINbGsuDL3EKMEB7OSCG+zZ3O0EG9KYmVValF+fFFpTmrxIUZpDhYlcd7becci
        hQTSE0tSs1NTC1KLYLJMHJxSDYz6K7Z/jkxOmDEhsVDw5d8HFw72dpx0ncdf5tnC5rDXNPnO
        nl17FaJ+3M+do1hZZvd10/J7DMWOnfvUXvxaWDGNab+//nr9z362wQFp9ULHo+Uats38++w5
        i+8Lq6uuN660XSjJFBRRn3RU/2YMx8yDjc0NG4yi+qR2HVnzzqt54z7ujjMKUwqVWIozEg21
        mIuKEwELgGa+7gEAAA==
X-CMS-MailID: 20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37
References: <CGME20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pin descriptor requested for the physical pin fails then the
descriptor is dereferenced without checking for its validity which
may lead to crash, hence added preventive code to check for NULL
and accordingly dereference.

Signed-off-by: Srikanth K H <srikanth.h@samsung.com>
---
 drivers/pinctrl/pinconf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index d3fe143..576d08d 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -269,8 +269,9 @@ void pinconf_show_setting(struct seq_file *s,
 	case PIN_MAP_TYPE_CONFIGS_PIN:
 		desc = pin_desc_get(setting->pctldev,
 				    setting->data.configs.group_or_pin);
-		seq_printf(s, "pin %s (%d)", desc->name,
-			   setting->data.configs.group_or_pin);
+		if (desc)
+			seq_printf(s, "pin %s (%d)", desc->name,
+				   setting->data.configs.group_or_pin);
 		break;
 	case PIN_MAP_TYPE_CONFIGS_GROUP:
 		seq_printf(s, "group %s (%d)",
-- 
1.9.1

