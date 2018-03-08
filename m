Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520485866-2-6827529981977637827
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
    t=1520485865; b=voiWcqsoH89lorwWXEkCZ3P97V6jLWK25uGJzG2xNTieKq/
    d2mf80FBQ472K1ym42rkW4P4eDMLlNrxxXtOerq/UfWx2vs8784w+O8Ze0WA8oLK
    LsUNfYTvpzDuLX05nC/TwUKOS/9c8ULi5vEGtALZ5ZlpLqoIOiko/w3XZirqsVt5
    nnJ3CEddZfiCbtijDd8cA/Ahk7W/GuqJGeQGzHfqNSV0SDKMtuuEwQbuSkgQbEF1
    7ciqzbhbzP7GpdpX8+dCL4JzOmWJiPPx74MQrz9ODz+I4eDzwgGk6Q1sLa1kHP9z
    wHu8wnpYVZX9+/99wa95XROLxL7qLEk2XqG8hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485865; bh=4dVz33
    z7mcDO9DxHBb6KiU37eqFyDCHekKLjvOiaguk=; b=SPLtd1HWsTqwz9K80KD6cj
    Y65Qjt+gNwZQwD8lkOQDWPBIpRAeYHgnqJJ2GeD9RowObhLZWn3bG1a2ZoCQJ4ra
    RVD5ytTjjG5gNLcXlPwEnCYc3u1xieG1DfvulmSJ3Z2CbCjl4RnNc+8sAkeiCD8e
    aVJXtZydwjxf19mYbT/LuHCiIc14nv+F+jGYSEdcT20dv2QSpNmILwtHoZEKnDgl
    J1Wvuxk7WTmz/nBrcRfHHnGyFoHtVbqksSilE5MB6kKeCJ/1fCR6EGW/TK9NvMjh
    Bd7juESUkP34QR1UkdLCzVUl8lm4jA494jpWU6UdP6x+gOARxlbSxLZDgqU5Yiew
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WO7h9KaJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WO7h9KaJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966270AbeCHFLD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:03 -0500
Received: from mail-bl2nam02on0131.outbound.protection.outlook.com ([104.47.38.131]:30649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966278AbeCHFLA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 31/53] rndis_wlan: add return value
 validation
Thread-Topic: [PATCH AUTOSEL for 3.18 31/53] rndis_wlan: add return value
 validation
Thread-Index: AQHTtprHY/VPv9q9JUiBatPwKtkhJA==
Date: Thu, 8 Mar 2018 05:03:20 +0000
Message-ID: <20180308050230.8876-31-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:m4K3FYes+nuHEh4CFgq1MKzYIQ5t8DZtgfz4ZuxFdRPy1/ejs0NFvxrGMeBalvmflr/f3r2QgjKaJwTXYoT7DNEgTonEkB/cZ/ti7hrjI0PKEgdesNwe0a7wDLGndRPs3ASsjhnT/XW7Gn88ToIiCLc0wHWtBfQA5ESYEsxZ3tb6OwVGla9zWQZFTUiwI/beyldWqK20F27oRaMoajfefwAEAZIJC0bxEtA+EYLPdiSJcjFZa3LzzhJ5GMgeqn5N;20:Ed1I+eOdm1UQereXq7acrqABCPYkMHEg3kRTb7lO0+xl8aTm6IkrQaAfFRDiX3bNKKRrHr3uPrCyXGul/LSjvbksMBDDzxCyDYAdo1lH3xiLjOC55v5apTtRDQR04pJlJ2Z6RHWavo/NS8o2BpwDqqVqZHJlxiAqLDOOIdetN2o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3209f247-c944-43db-0981-08d584b2ca4a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030EFD1862884FDEAC18DC8FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /v539LOwrkn3LZfMRL02oeOZXQc0ErHjtkzO1fP/DXhiWGCc5xG2GmyeRPP8NnknNUQWeI4xYAwdQ/meUsdvDOKDWZAYKxtSFmzv37YhbqZEedjv3d69PBhzDY1haMHtnQxcr4dubUmgEkhY2eHkmpxw1hZmOnwIxI5J/1iqyNnbBeQKz8Aok/12w98MXMvcL+3Lzhkxi0cFP8jjZJRDpXTZcGymqgK7qREdS+zujKW20MDJXeIKHa6GthX765YdIZuLJXeOL/jNbWgZ9XC7kFfaDs4qnYL4aQPJIZcizgV2z37YefOclZxvrxDsNsD1146N9mzDeI86VccSTF75Pg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209f247-c944-43db-0981-08d584b2ca4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:20.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 1a4facd1fbf3..46dda22cec15 100644
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
