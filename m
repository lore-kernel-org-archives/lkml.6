Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491338-2-10648381667725565026
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
    t=1520491337; b=ILHmggVpvnKBQvV4E83MfxS4Bw79bssFG/REiqUYEeG8Gql
    JQPwJ5m7234M7Wc9a85ONw3VQ0hCB6ZpGg4ax6q9qif6EdRtik0wKsLvfYTSfgwB
    MuQtxAVYaDPiSquBfgxfXQfTiCyoVQbIM7O5ZyA0mSX+NEPjhq3KBvWY30OSp3e9
    ROQjsVHowjWVmCTWuc94jB4Pw7LvRAUGLAZx38YnVdzOgfG9aoIJK5yKuDwgp9XB
    zzJ5K8/0Ym/l5DAocL9vrXvvSGSCNm6oWkgoqIpbwVJqlua0Twnii0Pajwq769PD
    LeOAD//OJpuSVBT/yFPnAAcr37p5IMEjXAACiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491337; bh=pJW4eP
    ko26ffFmv15vUGGujGMsT3xCJ1lo6zYoRPnSQ=; b=wbFuO8zzvzFzl9B7J503e0
    SSJHMhC1GzwF1IYcBqXvJWy8bPBG8J3hU23G9kqU9p/QjQaEhzYymbS+9Pe1nDvZ
    mHeKDWBbun61OZtd0JYTlwBjqJkFmasEywgukSZit8i9gRXWRtk/NJbJMdux+RGN
    2VFTBqPD9aqamSDQ3415D3TP77I8bGLTZmn3WQZuELZy7g99NlJtO7qBw3V8qxTR
    DAdxOesocZBFLl+rQhLy2n+6cXV3kH2geJvr8QAwzUPOK6bEcLefv+9ObY7s2l7a
    3BL3BX0sGJKogSGOGzmw/jTV9wemaTVWbxd3kPJ1ZJUOZJmQGWLYPHEHKeTGGxKw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SbAGw4hZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SbAGw4hZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeCHGmA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:42:00 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965254AbeCHE7C (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 43/67] drm/omap: DMM: Check for DMM readiness
 after successful transaction commit
Thread-Topic: [PATCH AUTOSEL for 4.14 43/67] drm/omap: DMM: Check for DMM
 readiness after successful transaction commit
Thread-Index: AQHTtpoCBbnIOK/TKE+VZDoi40XMEg==
Date: Thu, 8 Mar 2018 04:57:50 +0000
Message-ID: <20180308045641.7814-43-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:2sLP2QhfWOT/DCeVZ87JZyme1jG6LLwKDApTqM330pt4hGShYr+0k1+9e4Y0Rprdil80AfUCy6VoYtCyaNHqhFkZG2Eyl2XoQy/x2p9qZ9T4yQdOgYgjV3PwwK7kSdhswX2L7uSQGn5XWt0UAcROpoH8qSTHW1FiJEZzyTk3dnw9xW6niXz+3FpIkmRefM54MvOXGDfTyLtKAPOQBBnBnIKFeH46NSzR8O4iChNAqi0TjJPw7GU42mSoxCC3ZFoR;20:yB0ztOJSx4TqrV0gPjSHQPgRoFkGF0Ng5G6j12xtYeltTt0bRbFIcNYYCexebXq1G1lvhe1PEGz2xL+RV4xZ6S+5j3vWoHtGckKZx7naThKzaNQo1mliqo8BSPEgsM3OLvGuGWEJ7Bi0LwUo4EvLqGTqlewg4FJHoGDCQOgrOzg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35eb6ad9-dc2d-4b6a-b9d1-08d584b14e0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015E52F5A7B0C05586C7F60FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(551934003)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: sz2N9pBiEyVq+uAkDuAuamu/lCQO3YUYrE39Nn4x5y2mvcpO8NiJbJtKji02qt9ocE5ybysvn22iyRfFBsgCXki0Azs5IbwEIm0izNXN6/u+t7HgPy3w6/8GYwIchp9wOrM/6deiCJRgrbqg0+igDO7BfLS4HCCpTqUVEj30tMzDaduNJIu/vnSWvFqPxQF6594sy14/fQyTx2fh140TK9/ZNYhwxHhsq5OD5Gy7WoLLWd8+cM9ZyedFmgg8cNUbKR8vAlMtHZOufftME7UjLp3UTebrqYyVLhK1Wapm3EkfKoq/Q3vayLh+ppIbuIK9UKAmiJOyXmJUuSr2bJ0GJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb6ad9-dc2d-4b6a-b9d1-08d584b14e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:50.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
