Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488449-2-9183226711217592807
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
    t=1520488449; b=w7opXieA4B+kJ9qI0mQlTi20AvmgkNjWBQPtFLhWL8fRI2R
    vpHcHZEvbdnf9PRw/5Z/vGXpGATFW7v72HPazFf1m5e5bi447NBJkMVvLNG49Xjj
    p3ZL5QD8gcmqFw0DKHJ5ACGKwZAgGjAAvhTSK+tvUN8X6zxzqgrw2b7wJjo+z5V0
    ZGgmh78Y1g6yvD1L59PtJ0ZDNJbTvgfnlJ7nPZ7773wGBlSJewJeGoqv4Kuk2gjD
    /h2fPhsNf4rbWzyBlQiU2gK7oLRpxWcW1WCxv2S/+6hwIFY1biRNpBLOP/PGoWbt
    Lo+EVDKKx/IS/xsXeEL/I6Tbeos5dh5w8N3VNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488449; bh=AkJhVf
    J1nAur6Od7PlwDuH0UJiq+I5seQQeV+TnQWkY=; b=WInvnYa9GvsGOI788xAm6J
    aeVUGRj+cAex8c1OXjsj9hi4OXT8IbtvT+XtAnVE2przUPbjsOakFbdSO2a0nn6V
    +WCQz+DRS/XfG2XTnbXa6BCUueJG2WtHOlTYWdiVznb2hVQq5Vdx/mMMpcxV8mMi
    Nb7dT0nu5hAOkZDk8ILUMM9BGiJx6YVjuWCZDDBIu7Q8QNYxc4jg8U098q0xvFQU
    S9OJ9404MX8lE3zMwu5lEN6+CbQHiyM9oxAu06s4zWAssYt+819mLvuRSOXCo37m
    i5kLcmiVwO0CR0CUs75AQ1/YgWWF81aGYDrVrHkz83A6lvc4Ey+DWYqhz8pxfOjQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T2evC7ug x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T2evC7ug x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966097AbeCHFyH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:54:07 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:60007
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966094AbeCHFED (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 164/190] cros_ec: fix nul-termination for
 firmware build info
Thread-Topic: [PATCH AUTOSEL for 4.9 164/190] cros_ec: fix nul-termination for
 firmware build info
Thread-Index: AQHTtppSXkaj6D3WyUCUw3iFlEReag==
Date: Thu, 8 Mar 2018 05:00:05 +0000
Message-ID: <20180308045810.8041-164-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;20:Z2+t14GFOcOi4PLMOYWT32ipyobpCEorJ7QYt4g2AfJ6afmZp2l7uiTWIAFcsbBloJf1rARegRzGp1MwEaF54ljZ3vVKdLvnZH7khCko3D7RruPkCmUA+bOKvDNQz7z/gcDnr2H8o83+urBl54Vz6cWB0a5ek8lWT99T1pMOYok=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eba4705e-27d1-4f95-ee96-08d584b200fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08726B778F1D7EF3EDECC3D9FBDF0@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(5660300001)(186003)(5250100002)(26005)(316002)(1076002)(4326008)(2501003)(2906002)(25786009)(76176011)(99286004)(6436002)(6486002)(6116002)(36756003)(3846002)(575784001)(22452003)(3280700002)(6666003)(2950100002)(86362001)(97736004)(8676002)(10090500001)(305945005)(2900100001)(66066001)(102836004)(68736007)(3660700001)(14454004)(7736002)(53936002)(6512007)(86612001)(110136005)(54906003)(6506007)(106356001)(59450400001)(478600001)(107886003)(105586002)(81156014)(81166006)(72206003)(8936002)(10290500003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: W50d4dnY1t/4jaUpEqzqjif5ngoR8xnarczcKbRsx/vfCZ5tnc4XlaIaoRMzP+ew2vhE6rbH8/sH44jDVRRuFcAWfgE96eGNj8alm5NWf/ATx5AiGck4VvdO8/RH4u9GC4lLwK4xYSquFgjzwk5kEOGzgeYnSRBZl5yGexqJ4KRiAagi+GsDrEBFk/zst3mFn/lsolHBXVw3dxeesxBjxfr6wZtcCUMbupzrHsVPJkIdMPwZhc7kuQEJbjDZpCHHB/5y6RYg2qkrwgHPm+eddVbYON1WdQU/6KD25tyjD/hsZ6CEiIL/tOWMl0YIjk3eMapwp+ZIQLMap7Q23FOeEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba4705e-27d1-4f95-ee96-08d584b200fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:05.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 50a0d71a5d20e1d3eff1d974fdc8559ad6d74892 ]

As gcc-8 reports, we zero out the wrong byte:

drivers/platform/chrome/cros_ec_sysfs.c: In function 'show_ec_version':
drivers/platform/chrome/cros_ec_sysfs.c:190:12: error: array subscript 4294=
967295 is above array bounds of 'uint8_t[]' [-Werror=3Darray-bounds]

This changes the code back to what it did before changing to a
zero-length array structure.

Fixes: a841178445bb ("mfd: cros_ec: Use a zero-length array for command dat=
a")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chr=
ome/cros_ec_sysfs.c
index f3baf9973989..24f1630a8b3f 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -187,7 +187,7 @@ static ssize_t show_ec_version(struct device *dev,
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    EC error %d\n", msg->result);
 	else {
-		msg->data[sizeof(msg->data) - 1] =3D '\0';
+		msg->data[EC_HOST_PARAM_SIZE - 1] =3D '\0';
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    %s\n", msg->data);
 	}
--=20
2.14.1
