Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486847-2-14337086302710331347
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
    t=1520486847; b=imx1JfDH9H5HSGxKD38R0SYtVrppn9ayWrhDhfR6Y111CXH
    nJtCyqdABhtXwhzLbYz7tCG44koL+3EYyEqyPF/Nn6n1c+7OoB8yXxQfcksMmP7u
    YpIuRysphp3YavmyK61NgrxPL3srFwfmY1bzeKEokq+xwy0VMsaLw9WNtfOMPm3l
    rRjOn4DNT2nb5xrhQXQ6q+/ElyGrFTUpnDbOUXHu2SecLT1VBxg6s+yAi4nrtqb+
    YlCgdZYvZRkAp59dYELObhNtFTJ2B9i9ET1wq5PVy5qpBUxMJ8h2Rr0yl5BQSIvV
    swAPLGQQPsGKyaI+iIS7nCPGspIrXiS0ib69a6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486847; bh=XHQRde
    gbPHnoz82H8rqatF9LlItd2qWIBZP2yXbhQfQ=; b=qN5U42xjalic14izngXCjC
    BClAAEiNjTZxZVW5yrNcOFUA2BpOuWeM8l8z3/F1Y2FRY6Iz8x483Pyjcc3xZluy
    tsk6EfnaroQuxLQ61aw5s/URHZQO6MPgV5czJ1fs87mL0zwS4z4TDVm/iJAfYihm
    tjt1FZcPir000+ZmfwWwTAiO7Vm02+Typpx4fantrDsDCMKrUO462Db9OdgA2jFf
    NKIi85Yf/fIu7k4O3BzuSQHvrmInXdZ0nZIx4gzdUEAXGi2JzcOGZ9pMVr3tP0G3
    MMLIJOWK4imqoaHECFzRYnunO/XN5qCqmcS1qVaL3BIV4lxDThLyyIcdcNU9DN3w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YyBBfWd2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YyBBfWd2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966394AbeCHF1Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:27:24 -0500
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966539AbeCHFHI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 076/101] rtc: ds1374: wdt: Fix stop/start
 ioctl always returning -EINVAL
Thread-Topic: [PATCH AUTOSEL for 4.4 076/101] rtc: ds1374: wdt: Fix stop/start
 ioctl always returning -EINVAL
Thread-Index: AQHTtpqaO3OwxSTry0CHzUK4qg9Q2w==
Date: Thu, 8 Mar 2018 05:02:06 +0000
Message-ID: <20180308050023.8548-76-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:zAWx+DLUJr5kM3kCulNEFUkw4zgrEpFRv6jnhtHPALzBTtWQ13zMP2rMI7JF8dRwgLEupdrOw3fgCzH3E+iLx8VS2MlHOaaeFgMq8j3CLhjPG4FYiciamMU4k1Wt86Enfy42dGbIj8HKjdBzKpbIJp+94QH0liEl2xZF2PftINQb+irM0m2vmtO5pyWKxT59dTd/maLUKuK2G3NlFdjKA7MjaBUT534G+CtPGimN4WPMzDooGM8fAE7xnGAmuT4j;20:j9kbvRjIjqdbkgzQegjbuN939y9d3E+pMCV5HkG9xUOxVPBJlMlPlnTDQ67jXW/WE8RaWBO8+xlf2T1nefJNxoJMRknYRUIGDb0K/57qYj2UEemm5YyMgIw2akw1FGs6Ej99VKuNa+elhdo6gY1wLTxvGs7MeVAcGKgbZm4WChI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4ba228d-3d89-4cf6-1529-08d584b26f7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10165675FD8F08C5372711D5FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(575784001)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: d6hTcZQjSBnz/3Nf7BLHz6sZqWOPVkFzWekRCABiyZA74POPRHCTrxswGgvkl9tXKNPJsEAqrOU0Qy7Wl+u/uIhm14E969zg+98s0e/UACcKgwsolzG0QZpkUeCUxA7rpbwm4p+y+vbJ7GUNCDOqyglkvKTLDpFCyrja2v0qut5mekDeLHmZbXuDIbPk3vHiALv8wsn4tAJfYw8ydhd0F/g+V1E3T20yrd9AHCk+3ep2UoHn0bXntqrM+svDzJec2NeRqSa2ny6+/2xgRpneNXmZtizgTl+O/5I/IdOYOSSCnDa7Dwje396NhThRsIFP2WPUDif10T8NOt0a2I5jSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ba228d-3d89-4cf6-1529-08d584b26f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:06.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit 538c08f4c89580fc644e2bc64e0a4b86c925da4e ]

The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
through to the -EINVAL case. This is wrong since thew watchdog does
actually get stopped or started correctly.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-ds1374.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 5b5bc7dc3a1c..c0eb113588ff 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -548,14 +548,15 @@ static long ds1374_wdt_ioctl(struct file *file, unsig=
ned int cmd,
 		if (options & WDIOS_DISABLECARD) {
 			pr_info("disable watchdog\n");
 			ds1374_wdt_disable();
+			return 0;
 		}
=20
 		if (options & WDIOS_ENABLECARD) {
 			pr_info("enable watchdog\n");
 			ds1374_wdt_settimeout(wdt_margin);
 			ds1374_wdt_ping();
+			return 0;
 		}
-
 		return -EINVAL;
 	}
 	return -ENOTTY;
--=20
2.14.1
