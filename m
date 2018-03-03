Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122501-2-5527592241399292804
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
    t=1520122500; b=Kah02rhDsufiXvl349m4d4D4hleDQHjG8VsEdiaAXQ/70US
    AEy3c6qtZ6opSVErHFXvn2xDDQVxt6xqB+p5534yM636WezSDCpC7vncpx4/K/0j
    yOrsSvdF/jywr+Zg3W/3QjDvgpPHAJNhaO/A5/q/x9iIcpymJGDpNDlOZDdfc5RG
    f5xwHYnlqChOXju4myfqrbcl4Pl0u8TIZLoLdy2NrNbcLZ1gsYEUYIiugz9tSq2L
    tXnfC9bs/B/qU69hAWqPVSlaZwDm+abDrP7UjAW9uqKTKDckyrK+B02Fh2ojKp1k
    TNlzZ0ifjZb5PI16FjqbMcwgB0kkwF0jNXTXyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122500; bh=MRVhUY
    bU62Omhq2fmy4gXE1ZlybYfrRHNydtjfjAspk=; b=q1s0H0a2VBTCUbYxfxKHK1
    VhofZirPQGCrQTTboWTOiuIkXX+bBbtQ4Ekxm+JL+/f6ngf6SmuULwtghF/iwCx2
    zH1qDlC/5C77uluq8ZFWE/+A4A7Xic2ZTtsJ96EbNjZJk02pijFuUnuuqI/K+K+r
    W+vnedpWurIg/jYcnbnvDU9AEKWSAbRTAAFQpVllSwNBgfx4ejwqM0FdEWm0vZBE
    IwZbYBnewG+hOu/mQTcayY0RChz1qvX3nubH+XOAjQNdDgghiiL4MblraX+9Wug9
    YMDfUtKvzt/B/Lv4MrVu15X49AidCu04GRo2PiY75U8FWJ+8PgMLIowtS+J1xXBQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vz3io8hy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vz3io8hy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932976AbeCCWap (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:45 -0500
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:55534
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932247AbeCCWan (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 61/84] media: vsp1: Prevent suspending and
 resuming DRM pipelines
Thread-Topic: [PATCH AUTOSEL for 4.14 61/84] media: vsp1: Prevent suspending
 and resuming DRM pipelines
Thread-Index: AQHTsz6wL5tNictSZ02rnzFbntbDvQ==
Date: Sat, 3 Mar 2018 22:26:35 +0000
Message-ID: <20180303222518.26271-61-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:21nT1ccPgciRAsXDe+jfr0BE3ZbEoccvTS3p3lb93dhDWNAIiEjRBS08riJDMCG+Zs3bJyQ0l8KurBRNvbk4FF20cYZ1hlO0kkhn3mGigXoosIT1aH8Q8GtkebeEnv9qHZ5UPmrFI9Fm7ddeM98LYtNbszzR5O0Z8DYpT9dXR5BC98NoH51hNSTBqO13T5KPinw1D1bD3vSLtxbv9vzWpDdIN4KSL4qqoQPG7m46v6MrE6iY9I6SjXDxF+96+SUC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e234a187-b6dc-460c-8437-08d58156656b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065CCFF587BB1128A6FFB78FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(15650500001)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 31Ivv0ydAE75X1syoali8/F3E4hFtaxBZ4vjLrWc0aI0qGdP2rl2AD8Tag6IJJYIxMkWjVg/V94AspBJaQw9PeD44ykp3ueyylcZfyPzLJopZMBZAgicEBiQnEzuegsNP9HeOxFOs+Pj/mXMQ1E4nDg/mGFDSOsbZRDn7HnIOyI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e234a187-b6dc-460c-8437-08d58156656b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:35.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
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
