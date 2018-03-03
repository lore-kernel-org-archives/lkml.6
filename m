Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118771-2-13327852519873918785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118770; b=bLGXM60hJslZfyoSHUQNpM0H9hF0rFczUAWb5sqIu8GbtNY
    jdBgeEyUkVsWSS/RXX3pZzH5niERiO47Zb5EFV2xuHMQ3etSvsFmXBnDs9mMuFh5
    8H/qljofTgdKbGuAWZdKJsU7iLi/JubeZV7r3NKthlYwTNFf3mcRX6+Lbb2B7t3s
    aKfE2PZnDtbUl/HZLK34sGO2gaomnAMF/JLPR+xWiBwhSk69pV+aq4nHdyEGtKh2
    TjRdtx/wZfcrp6JeyNo4Ls2hunEKUgPKybOmoczb9TxPWlPPHT4JIgoxC1qDs1nK
    TtkEJ9Rhz6uBjJLQDAZDuwZe9kVbDOJZ4+T0DvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118770; bh=ewZOCL
    b5e9ETj4YFvO8pzQrEs3SAx3wmZMQq/H1Ipso=; b=TI4RxGfGZqv05J20Tk/ZK6
    dwtW+h5Mkhb0Gzz9reY1bS40R61c5bPjzIQngQuOA4ep7Vfij4/nPqjWzLXQ7NvX
    V9BboFyBlTI2AisrZoMWM9nCF2UwGl25y2ixUZIQesGSqGoCcYrwKHM/A5fnahyg
    WfKySkO50/WWTsFox/9EEkDzRszVylLNIWABd/o+h0nttzZCD0Etw6CRhOMTl18J
    3Qpd5QgCDUQaDkFCDizZg0wX/psfQbkTnK5I8RF1plmnOkZCK4SdRuEsv9/utrJ3
    j6nq75YCYF0aV2+g7ZCjFWby9mK2kctOqdwPQm0xIxnwgBXGQ+ZLUVBbYKukA+Sw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eUkQWpe8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eUkQWpe8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeCCWjR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:39:17 -0500
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:14848
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935032AbeCCWjL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sinclair Yeh <syeh@vmware.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 044/115] drm/vmwgfx: Fixes to vmwgfx_fb
Thread-Topic: [PATCH AUTOSEL for 4.4 044/115] drm/vmwgfx: Fixes to vmwgfx_fb
Thread-Index: AQHTsz9Wr5TMw3RmCUOvz1yu8DhXrQ==
Date: Sat, 3 Mar 2018 22:31:14 +0000
Message-ID: <20180303223010.27106-44-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:EvTUJZfWI2PIFp/UIkHTKDmYlQoRbNx/AA/lB288wPUZy2ReIDiqtEoX27D/Yq5kCb0weHsRztgWQr6aaZkCFMI62MlAnTOvnRkH1TgJYtL/0Y0ROY2tXUaur5KbLshVYPU5+2ETcgsgGiRyQtc6CNaCdPYWi6KFqJ7jrUYEZIJPtndYKTIUMFunGUeq7sqDntE6IAx2DnChaXk4bb3A0tDQzXl2Xx77zz2hPd2O1KMZqVbB2qEBjn/k8ho67DdReY5JFDOMH47n45gpy1LIEuY0CVTXTSkL3zlMr7yCt7XVYIs1e7kazUTVOgtHRjJC9VC+R9YAoUdV1wCzugZ/lFfDnwTGGmCSTUncOkCpBm4Sow2+ErLwFZaeeASnwweX;5:B5A9ssR4HRoYQevkTfsRfxBUsvy+DabpNNeWxblLhv1G9+dNZkWJq7/ukR/35W3FHyUgeMDjlara22W9uKD7zUcuzQgyjWwsgDckSTbbtO/SoO//3diklAc8mhacncH2vIhy83wA8zZcGrDqIKmiZTcJroes7IckXIqPof/lzMw=;24:CBqVA92sfFB7ghcPvCrljSbQ1oReqwOfh1tIYLoAXQBq79JihB4pEQvbnUSfw/rIZXkPWjLSzYcw5OJwnfb13IJ3bIShmARp0Arpff4/7rM=;7:Dbq0zyZbaICkGgoJ+RUk3aXRbrjIXpOKnOTQ3wykhYRrMf+IfS2jTxYk/lNQcJ0AKl/7uku1leQtemBiERUWNQvIsHBxeV0qV3psOJ0TtkcSpc6DbcG3PjoaPscXJE3wSxHNWAdJl9/Rde1xO+oBf5XyI6q4n/H3+xv7vj290Qi4sKRlhaOJ8irIYQmmd8TkWwez2iSP978yHg1nB1751rSduvXliBPYarNfgU8xCFs/PMc9xeyQC6PkUXB/CSMu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7c4906e-ce4f-422b-315c-08d5815793b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093872E28D1AF694F96AE55BFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(6436002)(6512007)(14454004)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hu94WWgujfLfzfNEYjc7eCAVB97qUwQT+g2kbF4CCBTR+KHOycrFki1wDkltgk+PpZ76SDNGqR7VAAIBEEYkqtCY+ysZw1kMklDuESLsMzDSSNO4ClE8T/K2iSRAgCV8N1p1qSGxelFdUeh40yPzsWkD8mn5zfVpjQJvH2UccR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c4906e-ce4f-422b-315c-08d5815793b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:14.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sinclair Yeh <syeh@vmware.com>

[ Upstream commit aa74f0687cfe998e59b20d6454f45e8aa4403c45 ]

1.  When unsetting a mode, num_connector should be set to zero
2.  The pixel_format field needs to be initialized as newer DRM internal
    functions checks this field
3.  Take the drm_modeset_lock_all() because vmw_fb_kms_detach() can
    change current mode

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vm=
wgfx_fb.c
index d2d93959b119..aec6e9eef489 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -433,7 +433,7 @@ static int vmw_fb_kms_detach(struct vmw_fb_par *par,
 		set.y =3D 0;
 		set.mode =3D NULL;
 		set.fb =3D NULL;
-		set.num_connectors =3D 1;
+		set.num_connectors =3D 0;
 		set.connectors =3D &par->con;
 		ret =3D drm_mode_set_config_internal(&set);
 		if (ret) {
@@ -821,7 +821,9 @@ int vmw_fb_off(struct vmw_private *vmw_priv)
 	flush_delayed_work(&par->local_work);
=20
 	mutex_lock(&par->bo_mutex);
+	drm_modeset_lock_all(vmw_priv->dev);
 	(void) vmw_fb_kms_detach(par, true, false);
+	drm_modeset_unlock_all(vmw_priv->dev);
 	mutex_unlock(&par->bo_mutex);
=20
 	return 0;
--=20
2.14.1
