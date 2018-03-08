Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486642-2-5506285636994756545
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
    t=1520486641; b=rpsW4qEeZNcCcl4dOW2H5ys3ieCim99FSluhKEFocUDlPFM
    uqID56IH9axFcwglIDKDgaE/tEp9gyE89Qvs0qwF8xmSpK55JyYxdosKixFeImEI
    yHxtuLRPrkhaNUpV+SA+skaZwDrWIM2H8xWWgGlrAktr54klZEtywtujpDsNthdC
    1ST2vSXDz7g1VAeg0tjXyqyAZ8IFji1n1kr6KqjFz6GV5Rg6Zfihh6VYtnds8UE4
    eIV+XhUcO5kklhQZuh6KvyWwaNfZtTa16XbSyBLedMyLWPvFeBDn6EJKUrnrNBNd
    hiRU1IgvurJ5tU/ufKXUwBcei2dR8AA8j/rJi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486641; bh=/0n1bM
    0P9Ys1m2N3whGcj9PspR5xmkC+YmWf98vndYg=; b=IAloTT9Zl3JPgPvfZPjBe2
    5qZ9N582s+GbzePmWQiyAe6yZIFLjyWA/SAUFyq6UFyczisf1NJb73uNrxBc9g8a
    2UVtclVCIQFhjSsBwcyWS+JklTpjIYVCEEEb0IQesSl5bgYYbMLeZXrzBUxaH2He
    yLUoU68svWkp83yaQZWOJmqyrjazrwUuTlOGVo9hL1gVFW+25zKNpQW1778QwC3z
    HCnabWeMVe4F5CYSEun+KOiuu0Lu1Z4wPIRxD+xQdIzLa4EjY1ENoVkz0uaTRjD1
    EDyhvqrHMwKXqoFDPGzOAXM+8BJTyO+4Xpmh2nBvZ9V1SHz0Ud4bHb2ChFZhbRtA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsI1T9tZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lsI1T9tZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966460AbeCHFH6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:58 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966647AbeCHFH5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 092/101] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Topic: [PATCH AUTOSEL for 4.4 092/101] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Index: AQHTtpqf9FVUZZoz8kexDLK01B9xSA==
Date: Thu, 8 Mar 2018 05:02:13 +0000
Message-ID: <20180308050023.8548-92-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:9RYGV+jyla389xUx/eks419XYnMs+cRDDC1pQ3DG+eK5M46rPotzDQwCBt9GGeWuY2+66Voe2MzB73xCjBJc/BcqSavOWg4JizzfP4QmMvEcIl56QmVArLT+sRw2dhWMgBuAd3NeM7irT+BvnCO9Z3szuuYYyL6zV7BEY+1SRHIzAGjFnlQFmSAQ2rG5rZlOQm59EF2e4uIOTkrXAQizTAm5eMNKrz60tXRDA9vU5s5mSCCOlGVwK0EXTvqn4C1k;20:WFVpCcBakzQ1NYSfs4fPv++QJ7s3dXV02LSgSF84pWJNmi1H6Yq6S2evf9/iBDFoSwBktUoigtvzOQCrQfmXGJbfIIkGq1WZr35syOW1MlIl6b6FgyvAG3Ijk6DB/wiWIQfEU8Tt8eqzvHQrS+akoz8b5TfPGO8qBIHdfVpnvns=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c4b11a0-241c-44e5-e387-08d584b28bf3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07272A21ED35D276E8CC11D9FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(551934003)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: luu6KWTno1U0QaNLYVmxDTifpQgePNqHCJL+1nVUhAGxgVNk1KLhtOa8AbD6uVkYKNjecUWp9+ZI6dw/zcQM1/hzzYv15cpI9WljSoDr1QzmvGQcuWwr0AtC0NQUhCTJ5pCocAqybvu5Vb31CQm+cI/gnDs3h4EvaicFk84irJB5b9KBiSlE6M1aIxsrJFgnxYZmNQp6lmWjt3oMCwG4mEn824eSRqcSsoZW7Tp8FlGpqRCck4/+lVsH6cstVC5KhQI+9FZc6kSvz6MyLBTD8sXiW94g0s2xcGCwxYf7tGZbPkHyvsZmKSKDO3zJ4FZkexLNCOnoplZJLEOAbUy9YA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4b11a0-241c-44e5-e387-08d584b28bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:13.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index f516b5891932..083db3f5181f 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -288,7 +288,12 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wa=
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
