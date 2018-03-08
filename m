Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485069-2-821495457189561550
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
    t=1520485068; b=EZzFGmXux9oRZ+KwmoUu1VTGpKvkJ+1CqVhyg5Bgk507cdK
    ar5zeyogerPQbytI9cJX81NsW0Dx95zOF0Vf1E1ZGFCgrJizaW5jsNQWow66f38a
    yEYldbDtR9t20EGPb0fx68tPbXg/Ijou+2S8IMuAFgYTXnsFLHUSmymUAzF46aky
    VG+inAUsAeVIKd7vDXMjLKchUUUMqjq+ip2K7sepoAGUtiqaB5soPxK88rak8eCl
    UW8XXSHIIdkDi942Dagxy1bzaVLrKuEYBy/EMGnnNBroMja33hME2vv4TMh3xsQX
    onE+z9W2fPSs6F86gGEHNPXKhSeHPcCo31nfJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485068; bh=pJW4eP
    ko26ffFmv15vUGGujGMsT3xCJ1lo6zYoRPnSQ=; b=R/m2iFDWihgbrqglaz+3Cr
    pNP39ERtwmqZnPuyVbNEdTCBR7SDZgdPLpQXBV3X6O0IJp4q5vFVsxVPhPl0Vbps
    kOsvoplGSJqFc94ijosymC5d3ju35EqOw/3sRUHAea11Xp/hWAfKyOKZlLpLImVS
    KHfTFt4iQV8yuEu0u174TtJDqc63QalgL/Nrs7r3AEiJwJdIQVD1ty+H6aROBzDT
    o18/uQAcA3e5OQBeo96kW+5bVJuY8GVDODjp4uLgkQOSIwvMf+r/zqAcUNpwHmUn
    k7S7XSNRyxfLOsQZTvkcyt5o52QoOvpoXi6QRz+ePvPldb/wbvmWO0gtNj2t1Yzg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osUNeozt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=osUNeozt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964864AbeCHE5o (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:57:44 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:51237
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935068AbeCHE51 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 50/78] drm/omap: DMM: Check for DMM readiness
 after successful transaction commit
Thread-Topic: [PATCH AUTOSEL for 4.15 50/78] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Index: AQHTtpnOgw/BpTksT0Cw02egVJiDkw==
Date: Thu, 8 Mar 2018 04:56:23 +0000
Message-ID: <20180308045525.7662-50-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:6UTOavEyJosnDMykc7AsnGzEcYQUsYZXKRvLWV9YokFbW3qRT4mHdAd01GqguCBD6jMW4TuMICB9tBjomYuuW7oI45N3q8ZnCtjhZ5n2K5oG8ldsM2d5O3qtdCpKSNXp/SHz1iMBPQEnWt/jVwS1CouyhGFEU00Ewi6ysQQgzN8BX1PZpMtkbv5RZBiYkXhUIzc+jdIOluZPZY5rHPwnk0SHJ/nM3lHv2s9Cr//Ekf3NwKNWO1HV01H3mORWw16z;20:3w8QiI4FNFHG4LQLUvYXBZCJan2vj1fauKcKA4gqbEL6DUwMvKxmWAqPSG5dthDYAAbdL4cuPWjY475vzIQEFsmjtC8sb5rq14xw8HNcH3r+O2TRxCd9EgvivN8VnoysJphTCeUC9RFT1ltTZwKiJRHkjbfg5H0IXo+2c3Hr00g=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bea406a1-02b6-405a-b6b1-08d584b10e65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107955F92A1062BB7B91FF70FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(551934003)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2HedMEO3affbwpr/IioqGJertc+Y8slwsk0YvUdjDoJRnOx7XXo+w7sNE7gDd7Q3pxEkaulxJQHF31v5VHFq8rUeROLMlDet3XkpjX06nYEyS85Uxnrr5/1CYcEtE39o9rQiK2W53bmBPpG4ilut/5bF7tTRcCg5l8PYZyudITawKw+UMt8RVBXmhhaZSSG80Dt7AOc6D9vCsH8F8uVfw82JbQ+QpU/uwYR4SbJ280v6t0ENk7VJipjwAenYKsjAyopsnHa0ONmv9SVsf4ezjrb+bBwY7T0j81+qnPjdq305PHoMoriYHtwL8gbBAhgsKV9dA5sme3Z3CzukoPpmVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea406a1-02b6-405a-b6b1-08d584b10e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:23.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
index c60a85e82c6d..fd05f7e9f43f 100644
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
