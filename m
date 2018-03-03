Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123767-2-4201584792574684477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123766; b=ddBr4iqUAJdXdj20EGvFVqX5eOV2M+V0+X9rxDtc1PQp97y
    VW9K2eybXZjcCy67x13/2tD8b8FkPCh1NOc2I5DfaEaDV7hpi/9MtcHoEhl9CRjM
    RoElTX/8O0XDssEnF347UY6B4A0G2aRMl7+3gNx6SzBLcuFXrEJPb4oDM57OTWX9
    YAOpoGvVYtvXaeeBCxkchVucynAyBJca759QMmnCPi73qrJPODLv3cfhuJ1xB/Jo
    2vqDFz9CsZ0kWm4IF7hPpS7um+qctg51fcBsSTI5syHVza4/svQ3CQEJuoSQo7KL
    04MIPpgiKTgdUT4yq+nmjoOpUUCMdUX3ZuhDF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123766; bh=MRVhUY
    bU62Omhq2fmy4gXE1ZlybYfrRHNydtjfjAspk=; b=dlj/xdaokx73XOpxv1flsZ
    x/vNobBBIniledl1xX7M7IghhPuwF94ZYNRD628drGFog16VMO3TpJ/w6mTY4RQA
    3PR+Zt2CiUqP0cCZal1l/4jYo/DH9nRpHsH3qTk+/aFaGMrfeBizC0H3Jk87NbRl
    5fLuVwpRlXt90tBjKgI5xTVXXq4od7zjJe5U5TLUwjOlbIj7cuFL6UiVTrhGXxMg
    u/ynMKgyvFCDf5XMBYUWW/5yXHl57t7lXT7L9H5tj0usYLY2zd660y2b68lTDnvx
    rCtvNa0bZYZ4HappZaqTCW1E9YtTnDUu5/PItrQ/8MjJX7l6J193QvU5oEpQvC0Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fRxijqH8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fRxijqH8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeCDAgD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:36:03 -0500
Received: from mail-co1nam03on0095.outbound.protection.outlook.com ([104.47.40.95]:24743
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932877AbeCCW1K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 079/102] media: vsp1: Prevent suspending and
 resuming DRM pipelines
Thread-Topic: [PATCH AUTOSEL for 4.15 079/102] media: vsp1: Prevent suspending
 and resuming DRM pipelines
Thread-Index: AQHTsz504N5cuhXpw0aBvoDiiNceXw==
Date: Sat, 3 Mar 2018 22:24:55 +0000
Message-ID: <20180303222318.26006-79-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:0yml0Il3GfCU19ZG34hISe42HNMAV2lFWywLNgDyY+JxO0YwnZuImSWzdUkaa/Z38jEUhuE69AdMiSrUiyasldk8lQO2qcULcBHbfXK8sfLaMOWtJOX3lQ1P4S1C+SWw6dBNGFc9oJac+bmK9SxDVtPyBRm5JF4bs2E/0nTE2s7rJ72HQxykRDc7o1rZcNvAHn5TNGHNdwo0w2vZ+0pLop7gyXENSg9v03LSko7fwbVLrsU5Zcf3SxewaiX4nb9J
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0464f6ae-da54-4eeb-d96d-08d58155e50b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067809B5A50F425DA1F0116FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(15650500001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gKy1BE8XxcHwanyDygebXsSkSAUpE8FZ7iS8lSrNEWwHc4okWtI7B7AL4KdAnevGxNsAAaBJhK9fZe7iD71vGOIxcR6qflxbMaQMy6ga1DaYABGNxHQvxPnDmyo4RSLX19Cc8163pZRoPumfjTkVtCuq4MkzafTcj2lprM3TKEc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464f6ae-da54-4eeb-d96d-08d58155e50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:55.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

[ Upstream commit a17d2d6cd9985ca09a9e384f1bc71d710f7e5203 ]

When used as part of a display pipeline, the VSP is stopped and
restarted explicitly by the DU from its suspend and resume handlers.
There is thus no need to stop or restart pipelines in the VSP suspend
and resume handlers, and doing so would cause the hardware to be
left in a misconfigured state.

Ensure that the VSP suspend and resume handlers do not affect DRM-based
pipelines.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platfor=
m/vsp1/vsp1_drv.c
index 962e4c304076..eed9516e25e1 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -571,7 +571,13 @@ static int __maybe_unused vsp1_pm_suspend(struct devic=
e *dev)
 {
 	struct vsp1_device *vsp1 =3D dev_get_drvdata(dev);
=20
-	vsp1_pipelines_suspend(vsp1);
+	/*
+	 * When used as part of a display pipeline, the VSP is stopped and
+	 * restarted explicitly by the DU.
+	 */
+	if (!vsp1->drm)
+		vsp1_pipelines_suspend(vsp1);
+
 	pm_runtime_force_suspend(vsp1->dev);
=20
 	return 0;
@@ -582,7 +588,13 @@ static int __maybe_unused vsp1_pm_resume(struct device=
 *dev)
 	struct vsp1_device *vsp1 =3D dev_get_drvdata(dev);
=20
 	pm_runtime_force_resume(vsp1->dev);
-	vsp1_pipelines_resume(vsp1);
+
+	/*
+	 * When used as part of a display pipeline, the VSP is stopped and
+	 * restarted explicitly by the DU.
+	 */
+	if (!vsp1->drm)
+		vsp1_pipelines_resume(vsp1);
=20
 	return 0;
 }
--=20
2.14.1
