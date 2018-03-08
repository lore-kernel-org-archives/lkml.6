Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489369-2-14982674252598046122
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
    t=1520489368; b=DRzFkHrBg8TzImSZ1XM/hywxO/itentfK/DLlqx2lO/NMPC
    CUyj8cjv3tdCXEK7P6/Bz/jxmdqJp1JzBRPAXx1Cx4taOPmUq+9XaQ/cIkoeP/+5
    4nuNytuAJUy3BBUbuqhX6SoI+/D9kbq1bMVXrYctfoHDte0Y64QrFSj1POhu724k
    +8GyfCKQUBaibi5ywieI8qi+SqKZxjEYZk8nSm/2I26wyX80XD0+LIKZZwrDBPcC
    XNCXpFLrNAj8o7Lv4BEHL/KazhKkqV6IPlsOqa5MaKDhjJeLYW/R928Tn+K/4S4C
    MyIAUFvLe7dYxUZxyV73cUrXu+izmXJxcnWZngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489368; bh=kdY1AX
    Vxs0t9rXJlEwLUJpIvaZMoJUJUB9vT2ZaMGuA=; b=VW/U+PuQoa0qkV3qtaF7Is
    TuJbnZUjAPjEHdYrLGm7r78t75OHV2qTDjI9v1EG0DLtUwavT1o7bkcsBn5VehvK
    xFc7HrytmfIGvJZc8iV7qSbsKRsNWo+3/pzNsYXO5zR+5tN6BnN2WX8aQBS4RqjF
    tPjuEKrWwH5fm1FCt5xfBAu0EIpwlbD9z3t/qbxN1cNvgLwHD0WAeoPHQVhzvxAW
    uEn+rg+kYC7aunZg9f0UqP0hRkHahEYgTBEuMOlgAMgQ4yv4iqxmVVIfzV0o2eau
    YWvLnpFZ0kKTj3XQ7zdGytbwFhCSXY0KQCNgD8Pk9lb7VY/ediOAT6SFnnjfg35g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bXZX68Fe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bXZX68Fe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755364AbeCHGJZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:09:25 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751603AbeCHFCJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 092/190] rndis_wlan: add return value
 validation
Thread-Topic: [PATCH AUTOSEL for 4.9 092/190] rndis_wlan: add return value
 validation
Thread-Index: AQHTtpo+LAAE3IbJgUuGbgDC+RJSAg==
Date: Thu, 8 Mar 2018 04:59:32 +0000
Message-ID: <20180308045810.8041-92-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:nHSd8BU2QgEeQRuhK01og6s0WmwVcyMiSSwRTii4jQSAPhgCqFDq4QW2V1Uh22ozjHMs1Qlm5C7zw7eEGQ9f6jbKYpNmm9PXx+W9UD/TN2ABI2cI39/qGWAT2UB0w0M95e2TXeYLtOuqEbVvoDK+m3wYLDua3Jx5Oq3wl61Czw87mc7Pw2q0ZC2enVN9gk5884MCk2WrZKr5RmPbjbnx1WlbxUPOirhfWlxTra2SV57iP+z3MCriB5OGhYAChbr8;20:aBlh79qTJ0Cf6tlaQixbrEcGNndct+Piy5ZknCfI30dqFKpPwpYVrbqn6c6d1pdKYqMnFYWFF+F6KbnZulfyBgb3PtVgcshH7u/Fbjz2lGNQ5idniEIIFLbqrlSzFnOpYHmBsNvDQkBGsEvknNV5aqqf4e9kVAhV6sFxitRSVnk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f52a8fb0-59f7-444e-51d3-08d584b1bd81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10632CCCAE629FE15D8BDD9BFBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(59450400001)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: o0Shk/2Eiv+5tfFxdIbNS96xaQZARy5PnXDYoISgWmtHAFwWJvrxHrm+CAk8iMkFFLUyKzQBsDCrJn4XoBopMwmHjsrd5iFdEoxuORwz7PkA2qbR3ioDTSGddS6+UqbohsILjlVrYqNQ+LqcOyrPTcn3eF6rDydL72Zkqxg0E5UlP9JQDLdKIj+4FwcrJnaIJ3h3UgF71dlgRwgOqmJKBjhGFh4Q1gMNMsCnM0JFm+QG2prn6tMc1pLwtAUJoZj49L760k0W5oUXYboq07gXlUR98C75WOTcudioKYgPgU7Gl0YE0ZiuHH/IoPTayDJRqYGij3hb7UNCFrlhOEIxQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52a8fb0-59f7-444e-51d3-08d584b1bd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:32.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 603c90470225..15b2350d9f45 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3427,6 +3427,10 @@ static int rndis_wlan_bind(struct usbnet *usbdev, st=
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
