Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119632-2-7275948898016863122
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
    t=1520119632; b=fbmEYedqsksmQGEWb/4b/nukHMEuq+TI82cZk8MKkrCMp0d
    60U1HoUsm9agOXL4DXvFFo3bNVGVlLr/3bU7Fiy5O0XuTuCkP3QyHD35KX1k9TUW
    Hl4eAQ/Awc5O2U3zS9LM4zXQSU7W+8EiodTUdW9II6Os83DWhik2nATjh6+JQM8z
    B1dxF9y3vjXxYyCAjTZV48I2FDpNdDuzJR7W3qFBHfu2uuSSHOCvt2VAMJh234Ie
    b3CBvGkQXxReRMHa7I+2U6HIv3lLJzaqC9lBpaxYED7NRAxxFvy8lhGr0APl7XOw
    ARwjCSemIEQQIH+vpN6DzzpThQf1UfwztucUlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119632; bh=Cu3pHZ
    /VwDklQZjaZRom6LGtxyX56UIIzeBobRhgXQY=; b=PdPwkoFYtW7IQjVcz7gBYB
    pJZyUD+Ide4Ad2f51YhRc8IkhFWadQgK6Jfbp6kq0FS2nuDGGC5QJ/NaqT4fzp3c
    P6ZZHUNlRqutjh5X35RGRUdvDi89UABTqpjFgsKlaA5mqwe7uEVV/1HMXJXAL7w6
    PAe8RWuQayfsiH3TEerXeRaWzZ/JGTwAkwSR7kGMhqf/3J3cgZdrtIxHk3CLK+b1
    x453tELc/wir48neXwpBV2zCLe8onQqtdEVRBLU9/fkPYruIaVsRv05I0tpFbsUT
    gFTnNoWzOcQu6mla5LXDE6Y+O+jydoHBT0LsE8ebJc/fMrkc5g1KeX15M8k1Abvw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ojwqTZSf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ojwqTZSf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbeCCX0q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:26:46 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:23840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934416AbeCCWhH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 207/219] media: vsp1: Prevent suspending and
 resuming DRM pipelines
Thread-Topic: [PATCH AUTOSEL for 4.9 207/219] media: vsp1: Prevent suspending
 and resuming DRM pipelines
Thread-Index: AQHTsz8oBXW3V2PK4EejgF79QPJAqA==
Date: Sat, 3 Mar 2018 22:29:57 +0000
Message-ID: <20180303222716.26640-207-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:CIrLcZCzeTuGzAYrKUlk2xFPzn4WrYagGKN+xJrh4oSeMJKkgS7LSAZeSPHFX3VGTdbfQMmxSwfnT4eKUIJ8avambXNRYqgmRsbZeesSTP710sqFOkML+BE8vfQb/ACz878XEhS5SQOi+DQJ1A1Vo1D21kvd1RPeZMbm0zB53/qSiJHxBf7b26ScFm0i2ZRMzSxTfSyeeD7HZVJYtBIkIcoQs2ZyAY0VBz+hGJBVF4yssnUIeVzhtek20Fb6oNBn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 300d4542-97e4-498f-d14c-08d58157454b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969A8787C06FB4D549F030CFBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(15650500001)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3wdvr3fWORdWR3YVO2ImLTP69YFrbEymVJYtDYXvUln/jSHI2RVgnnY2C7PgqgbIf2aZ09SQAV5KkOExXfId4xCoAzljr3jE6NIt7NexjuSVDZQntRWIXWM7CwffusosKdr7SGSpB1fe3KOBrelZUfZ1IcNhPNk3OizoAjrY36g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d4542-97e4-498f-d14c-08d58157454b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:57.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 57c713a4e1df..4ac1ff482a0b 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -509,7 +509,13 @@ static int __maybe_unused vsp1_pm_suspend(struct devic=
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
@@ -520,7 +526,13 @@ static int __maybe_unused vsp1_pm_resume(struct device=
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
