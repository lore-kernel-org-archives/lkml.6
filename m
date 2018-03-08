Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490976-2-17408948373420235932
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490975; b=nnh7oxhZQ5EsLGSdJ37eMRQqWGGDUm26OeyEcGYZmeYB6/6
    ZIyiRDWsb+qJXuHHcPrVMq3tz/Xf6S7ZeOEf9RNbdk5UPAYZ5+cMubeO5gh4945W
    MngSEsa9nFJtAlPVfyDHANQyJN4TXKm8SPPuThd22F6oNpl0ocuWcYcZCOP77wY0
    +qj8Ycz162hVRuE7hA8w8C193Va/+bBqoX293UDRDdx8rAUElxl35dBP7NBRWb4T
    ZzO+2BhpycS780hPPxWdTtQg/gbcxHQV2uv6LxCF1joP6J5HQZBlqEnKmSqZPfi7
    eIg+/mp3yNSq6FWGupEIOlvJAer95/NatrKqLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490975; bh=Y6ELh0
    P86ejt6XiF64v8XVe4WfWANQd6wm30mPNcRtk=; b=K8ocRmPnP09qhT4qbJSomj
    YUe+pg4L530r4BqfG6ayRwso6YbPXx+8FAqoKVepHzQNZsdGChaRUsJoWagKlyzz
    /GiUSp1+XMIhbQcsdlyKM9jaQb2JbYGMv//lJJsHP8Te5znN1h4G3bRRef4Ct9LS
    WXR7lXGCc0mTOdx7AFyZpUXUl2UYMosNXPC3jvXYkaiPH9B0HrHzyEzNaqDSYMny
    +9CeI9sUfWDkc51Xa4eyJ7oQef1eFmaCj5ZW1mZO76rwcbqaNjXwXwaciH0vmBzj
    fzhCsqshWUHJO9m/mDBHUUsnZ5pSOj7nr9itGNDl1wtsVHeilZ9ww9cTGidRnkGQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3WK32Ei x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3WK32Ei x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeCHGgM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:36:12 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965477AbeCHE7x (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 67/67] dmaengine: ti-dma-crossbar: Fix event
 mapping for TPCC_EVT_MUX_60_63
Thread-Topic: [PATCH AUTOSEL for 4.14 67/67] dmaengine: ti-dma-crossbar: Fix
 event mapping for TPCC_EVT_MUX_60_63
Thread-Index: AQHTtpoJed321Z9/oUOhO4NQx0kydQ==
Date: Thu, 8 Mar 2018 04:58:02 +0000
Message-ID: <20180308045641.7814-67-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:0RZ6yb4sSO9bbWQmsQLXV6bvTGY2p92yPdShjtcluq8qvcOcKXpg3JjMgKqTdKlDjOlq5ZVxD/dhJj2vENuhu15ekoHKFGAy3lyPkXdHJ4rWFTY15hVtbSiXGpWodhXUR7blbRLO0kUHcwxNYnkfQrG3ey6r/LCEYuhyUHFvG8afVB1v1Scps4MfcF9vedUfTWDJu4ZnrqEM+kEy9gLm3Olhg7dClLieILyDqQOJWkHBJSb9abKF4HwVsPZGpXOy;20:ACDf7exwpZvI244ISMWl2unJRCmnDxioK4mqkTIFsNvex+pssgNHpNNBoaIxb5kfxmBqGQuAmtybokAeBkRiv3N7FKseKTl/MQ3uHtIdvwZpEc5WU5I1ehls0PwKka1fwsvv5pQa2aRM6sk7u60CvmEBR2eVE/2w/qSghCsnCqk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fe57656-0b65-4b89-0545-08d584b16c7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920A42459FDEDE589F5FF38FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(15760500003)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PLTXKNAUlwDlJeV82wn3vc825hC6TqIsHBWBHN76ZBbMc9qy1HtETgFoY8j8ItnWrT0GLEYR+USDuOFIwc2tRyf4o9rUQ6ybNuAQE0TWgNaQj480HDX8oKAKCLR4YhOK+r+rlSAQff5+mcJ+J6ObFl+GZGFTsazAI9xGumU6QKQ/GiQ0e/6P88tKIngje4iFduihgakMrah0T1Afc33wfN/TIjdXZdZWtUaIzF7tv3JxgQtGd3D0rSmpbtWnLUzRZT3EzAl3N4kAMeKoavI9Mw7oRGn1OQbDI9LqH+A96IifaM6VF5myO2wuDW2mSW/jae+FAV2VfpBl2tQJmlIo1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe57656-0b65-4b89-0545-08d584b16c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:02.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/ti-dma-crossbar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 7df910e7c348..9272b173c746 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -54,7 +54,15 @@ struct ti_am335x_xbar_map {
=20
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8=
 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >=3D 60 && event <=3D 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
=20
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
--=20
2.14.1
