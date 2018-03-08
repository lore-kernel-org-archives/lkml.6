Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487208-2-2659936947793979634
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
    t=1520487208; b=KCPmopP5Rr3dRFQwF3X4WdBvn7QpuN5WkFjFBF695L34mi/
    a0hlBlLEO5F5csW2DngJm9hRlILEw0rXmTSv6euSlAvWU6m9jH0Tc3K1r+jYTAMM
    kR2XI0j5zaZVXJsae9GeGLv39JIFkNGDCeMb38FXTno+dZLV2ynt8zm9wSLpTBsd
    5UFCxXxvzXbf0/CYyQ1+B6TRRqESvQ8y5DCopOTfFqjxh24BP5op2fFWMCExuP+M
    JTTdklmt4ukLkrq0fqxW03iUZe/+aqa12UdtiNNgX+qQfBcAKSXcJjGx0HEjPM1J
    e357MX1ASW51T+S2Cw6pyvYDpHRvYuTu9b/CNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487208; bh=niWFw+
    bftzF14v/hghT9tU3Fd62ui96TDwuVGHE8X00=; b=Wbrwf1AWW5xGBzkdWZb1ml
    C63SlzfuFb2f9WcpZHs1Gd3nVB38nXxohEiqw6Bic+WKE9eIULogDHy53yXiZteo
    6sWYRlNqAH9oEKl7txf/KajJFMkmVsJmwUWetdgz4JGzUTGW7YQErqeOn+v1ZR8U
    mxMdrJ2bDKUcAGY9gWDIiPeupAvkQ6dhXFg/RJs2fn7zEPqNSeSGZ3Jgoc3asm84
    XECCwbqGZQK6vIIVTVpm/HZN5qEfJg0Hq/WfCZjxGMEHCf21Mzl3/Fch075VLbya
    lO//hMbS4/Y1EpUZ/lXHeaf02ZoYMrFA1CgyHGFP9K+4s0Zbt67o/rKcNrybX/wA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kf+GFj80 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kf+GFj80 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966374AbeCHFcm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:32:42 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966388AbeCHFGQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 053/101] rndis_wlan: add return value
 validation
Thread-Topic: [PATCH AUTOSEL for 4.4 053/101] rndis_wlan: add return value
 validation
Thread-Index: AQHTtpqTVCc/YELjBEqQjH+hHuwMIA==
Date: Thu, 8 Mar 2018 05:01:53 +0000
Message-ID: <20180308050023.8548-53-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:DEAozy2DS9vAi6Z1ctOtWYaKUR9zOppoNZ+NeHnk/FK+dfzDivhnhfWzEPjepC0W7wcq6KBZGIxBQ5inEP38FnP/vfOmrngP6O2CIfwGeBQGlmKVAg7BkmbufE1wmr73YfXvmd6SIH/we94bpSQm6ddMvBJkvDltSbgQAfqM2NljbY0LX1w3VNtW2SX0rAoTVlb0wj4SyQq2uptdu+BrnM9zq/IxPTD9SRA9jZXrSs2dMdXEnKr9PznIWXoseFB+;20:d8QyvJYz94K+v/pMh5/KBHk1BygSiF2VXboW00LP8sDTfJr6ETIq5zbraC2flgtMo0EAmdA7uFSHv1woLwmedZjksb8Bubir2kzP3q3lMWErqQK21HkkyIZVOaSkecgQ4q9O+EhhZBUhFdrTBDp+iL0CARljlEMuqLxdm+CTC04=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 882d1e64-9013-47d1-b137-08d584b25075
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09170B5EFC62B44BCD639DA3FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: TunRCfAaRs8BgWUS3o/iu3UwM0yV6QYZ1LYdrwuW8nJlK6BzoyTYza/LTKzrXVyCdubN0DouoZ2Khi50acKGPMZEA6vTrxvHDI7HvFAOsNxu5LlUVHj0O9EK1FwP0dJIhJyYvhVlAvNC6flcAwIPc05FPJ/l/XdZTV+R3hVAYVOHWx2SSqA3fVuJtQuxW1xnYBUGwlqjrNmsTdhkFW8965h5D6G4Gpcag6VFb4FmgZbmhYgzfhRMP0X6bQYYF15H0DuCkOsHeyoVDunqhwfbMpcnzGVJULzGZMyKOG/ldFMMb3I4V7jMepS5BAiYzU3RZYuLMR3isSt2gbixbtI0eQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882d1e64-9013-47d1-b137-08d584b25075
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:53.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 9dc7efd3978aa67ae598129d2a3f240b390ce508 ]

Function create_singlethread_workqueue() will return a NULL pointer if
there is no enough memory, and its return value should be validated
before using. However, in function rndis_wlan_bind(), its return value
is not checked. This may cause NULL dereference bugs. This patch fixes
it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/rndis_wlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis=
_wlan.c
index a13d1f2b5912..259590013382 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3425,6 +3425,10 @@ static int rndis_wlan_bind(struct usbnet *usbdev, st=
ruct usb_interface *intf)
=20
 	/* because rndis_command() sleeps we need to use workqueue */
 	priv->workqueue =3D create_singlethread_workqueue("rndis_wlan");
+	if (!priv->workqueue) {
+		wiphy_free(wiphy);
+		return -ENOMEM;
+	}
 	INIT_WORK(&priv->work, rndis_wlan_worker);
 	INIT_DELAYED_WORK(&priv->dev_poller_work, rndis_device_poller);
 	INIT_DELAYED_WORK(&priv->scan_work, rndis_get_scan_results);
--=20
2.14.1
