Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485500-2-17221664611158169293
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
    t=1520485500; b=Vf761vW0mbMi+F3wa9TVuIKcbWU7/3tBxhgOI92k7+p8/bF
    f90GjoOyvPvLhlpUB3cs8nYqWrN+cWgLHlY6zGvejVWrQKXtUiqAPJq6ZoI1ow2x
    fmd3WFdVVor/f0Uif6HzAHVKbNmGxpaFCGEOpFxYhWjsOPIzAZ1BuHJgMPVxVIFy
    FGb1SKaJlH7z2VZMUS4egFYh/VVGCI8eKpURj71Alxygqz6OAjLFHqoqNuhrP9Vf
    W7Ns4kKAUY4lBTwoQ72Wt2lc/7JBoJSPNoNzRC/Yy2tESc0jGy4a7gKnTaUZtM3a
    +u664giQg0J5bQyb/KvbLQ1lrH4GwRBIUOU9mYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485500; bh=MW7ssl
    Kzof+QhQn+SHWNIa1eQMHfDaBhs7HoRvji4Lg=; b=o3GGjWNAoIXcwj17RzAiuB
    LqAgAffP7hkG05YybrtLIMn32oTnU+oJM9fEns0uUgrJBoqnXOefO8K3EpfggtoU
    RL8zjKN20qDAep1Bj+dQXxJKFL5Z91x1PFA3Jl7ZNJJgmj9tEdG3hrumshcL+Skl
    ZAe58utJTShQ5Fxy1xiIrMRBi9CEDQDWdStMALIy9v45/bjdChiXZnrb2WeQsk6y
    XQqSOmx6gLeR3lSXSLDdOLDrtm/SGVuZnhIlUuBMAkNtj1qx+w9MAxtiBFqCEQ+Y
    +Z+HNILetR7YnYniRPjYepPIVejcbP8g6KFKGiYYxoHt2PK4gj/igoo61Mt4Vtag
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mhwFhPju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mhwFhPju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935518AbeCHFEa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:30 -0500
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:39791
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935433AbeCHFE2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 177/190] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Topic: [PATCH AUTOSEL for 4.9 177/190] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Index: AQHTtppWXdMjmt0DJUyzCrfWbkZNBg==
Date: Thu, 8 Mar 2018 05:00:10 +0000
Message-ID: <20180308045810.8041-177-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:X1S+pzHeOBo9HiepvQEipJ7x0SXVEEdgFgNJEyx1S4NzeZI6Wbrl9fiR3b3YIh+r0fWaoJEj8p5JJSRGlw31q0VDDod/1B6U/eEQt3FkHXbcvdBrFauHZrB5pGdKCr7Rbq6JhdKalo7ooekeorHk/3ffg7PFZfFRxyk0F42Bs63OVZpy59j185m3WD5O8XIp3+vzPYJrTkwQ9lCz14gZJ9DPxg37hSZCTf7UYy+gSs3Kbq8wxLHhMqdDvb2kNt1p;20:J01oZyjSHDozAGYJphcvMNbYjRdmOmzoa4Vh1lIEA73ZciQOS/v3W5e1Z+FeL0pRWqFX1c9/XKgwYB6+qSw8QC+BmnStc8wfngpBB+hpTXA7WmHDKIP0BvIM6zqaTxUQuX50s+OX4DzkeLHrU3hohmW2lzRiA9nJgCHEswgcjaA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a071b9df-4ad7-4888-4e0e-08d584b20d45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09192D01CE30FE668F65DCA1FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(551934003)(2950100002)(106356001)(6512007)(2900100001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: w2asvxvg7YBzzUMbnL/gvs3Ikw2Ptu0tZqQKq0dMceiMVjVU31fd896NhGItQL1saXFKmlS8tAnBwHL1Mzm2j1vcbkNaj7rm2GikDbbUidX4JeJdOZ8l6FfCm7va6yQocUZhPuRYg/Y2yg02QaY79GLq2cmpztWeLVuFaDbTH3+yvlR1Nj0pu+SVXqjFPLozdUp04Yl3uW6anWXKcjUO9RtuRo5ybqX3lAPG5o2p8a/B6Y2tq/igzR1iUGIDMnHvPdiMgFQttQ29X7NyNfVKcMDMvwRHwu2fkFwlB3XrwFxYj0u5EAd1nGBphUnbz71oNsSGgsyVls61qNARKbyxSA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a071b9df-4ad7-4888-4e0e-08d584b20d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:10.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit b7ea6b286c4051e043f691781785e3c4672f014a ]

Check the status of the DMM engine after it is reported that the
transaction was completed as in rare cases the engine might not reached a
working state.

The wait_status() will print information in case the DMM is not reached the
expected state and the dmm_txn_commit() will return with an error code to
make sure that we are not continuing with a broken setup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/oma=
pdrm/omap_dmm_tiler.c
index 4b83e9eeab06..7def04049498 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -298,7 +298,12 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wa=
it)
 				msecs_to_jiffies(100))) {
 			dev_err(dmm->dev, "timed out waiting for done\n");
 			ret =3D -ETIMEDOUT;
+			goto cleanup;
 		}
+
+		/* Check the engine status before continue */
+		ret =3D wait_status(engine, DMM_PATSTATUS_READY |
+				  DMM_PATSTATUS_VALID | DMM_PATSTATUS_DONE);
 	}
=20
 cleanup:
--=20
2.14.1
