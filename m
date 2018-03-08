Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486744-2-1788369689330020802
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
    t=1520486743; b=klrJbQy9jjpX3u8leJAXxHtoi9lORHTH+fFquQiRdH6cdld
    BO5etTek5O7Xg2U0gw4OCSLAUB3x4fQZo7nGsb3UrXyu4XFle4eAdIYfupGDohxz
    Wwmiedw5FIrBhceLdOi0u8PAVq0pXCQcoUWdbFd0cHEW/Bqq+wMfS5aMn70Q99jj
    ayQrW92s43p9z+53Y4Jn6ixxc5S6OXJNm13cpT0xWboZmINwSTwJOQqrASInHoh/
    FUebscr3z8HmWujOZmPTc4zduuH3bIr2XuGfEm4IoNqvNZJR739jtfatj83j+ZZ6
    C3FlKx+cTz24IAguWGHA0BSM4Mf4bknPrLpLecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486743; bh=AkJhVf
    J1nAur6Od7PlwDuH0UJiq+I5seQQeV+TnQWkY=; b=oOrR0XtqRI6OvI8fYNJfgR
    QJLcrVJHkX2sk8GPBlQd8tdClt0Zc3XQE4jNDccItHG/GeIFYgfbtKIqMbWkukMi
    FnDT0Rg4wnGp2cNZBs3eWEpbbjNU6AZZWwwB0XA57wgc7G08RRzfolPc1UzOk43s
    LhpmE4Va6k2JmbZ2L/1JwMH7CI3xEsNqIrLae1n0k5hpLCV4Y4Y+cmnswKpwADsI
    yZeFgIvl8KC0zPWcvXlWzzM0LMB191BTecxlqi74BlLC/k+dU3OpvI3yzHDK5yl/
    6KnMZl4oxmjxIDYtqpQ6vGMm8wEyBGiMw1QhW2G4l8TyYLQdm7l10qHxa2zblHIQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GkDRSsmM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GkDRSsmM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966593AbeCHFZb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:25:31 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966589AbeCHFHU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 085/101] cros_ec: fix nul-termination for
 firmware build info
Thread-Topic: [PATCH AUTOSEL for 4.4 085/101] cros_ec: fix nul-termination for
 firmware build info
Thread-Index: AQHTtpqda72hFANWRUqQdTnYsn7hFQ==
Date: Thu, 8 Mar 2018 05:02:10 +0000
Message-ID: <20180308050023.8548-85-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;20:QG+dO7+KZcg8Qw6yGdkGmDqjv5DhxphPPUJi7w6kgkc/PX4EoAKgeyU5VPGxb/WdlECqZYqqtKCXwYZlOFeUWQyKob5s8OfBnDW8IWFm8rzDviPrZ5pQaxdCNniEzXyHdZ2Eq19r51/hxW15iqpBPYgMWuEPHbDusE5DKx+j86o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06e43d71-c231-4272-7bde-08d584b275cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077DA56C28CB55AB09D182AFBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pEBPY6RKR9G6zG1xfevwU0GMZjGEDq/TiWhyKJNiWMTM14lXrzjK3lZKQH96/wpeq82Jx7MAhnJZA4+CbrDT9g7d0WwfMb4uj+uunxcKL+yPMfADaqTV4RG5D4zktbVCPQwsfLDIK/xyEfGd87MTrPgQtJDGxt7u86iiVAMpU/j34+k3j6OTUQ1lyVh/MauySG9CW61wVZFsWCkL4qWw3y68iKx6kKqj0nDBqCuo2PBHAYXoMadaURhsTO9wZ/ok04QQPnBPs+yOifnYu1nxuZ78z7Hc5x7uLraeEpevFJeAgG8MOJmljkdZp1s8dAE+wgbscArkM56FvwNPORBRaA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e43d71-c231-4272-7bde-08d584b275cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:10.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
