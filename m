Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233876-2-9218919455290766728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233875; b=uX2AgFcTrchVSIYTc8Nm3KoEwWXsY4QYdQYs7dIGSBtkAib51M
    X4ZkmgK2RoP9MYB98sxwnnWug8Yxfd1GN8Vt1IZSyMo7QYz5pW+4L5IR0ISWiGOE
    YkeArShpn4dVe5h51KR6j1tV7wy+6eN4UD5fVSQuZt42m/wV9wSseo+iEKxWy5Bm
    QOXmwexysLokHAn/pUIJ6WcC2/IAZwrkQhngFWv4t6OmMsdESB8EJxi9QYInYzdG
    b80F5JUhrfIw33IJ0sYXjpljWiayhyvRfvkxFA47GAAU5TLkyRYoQNDjBYcv87m7
    vaHcHNTyd8LdpGjIxQoTiJFqnaoo/VcOxn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233875; bh=jT6JNUBlow
    EG8DdLmTS1af8XqPhLuXBn6EYjoXwEQDw=; b=UNWf5mhGXIWIeUIwOOcKAUjjXt
    YU+7T5Lv/ai6zY/+JmVKAqyxLFxSyw0XTQ8nBtAULHvvGaAC8tzNmU0D4iprMG+8
    FdS1t4HuOivMMSiyFqzzWsW9EZwkBiRnYHHuYbN6mqtc0voDnvjiTQyIOQnyC4mg
    eswUiImwSahq6DPPXTbzshLk+etc0voTlXUuNdO5/TV1Ex7YWk2GTb9TKs5AzlBl
    3ns6l/rykOFSsip/6+0Kg4ivGdrM3aHEw5cA55JZ4xO1wRLkoUQyIW6GYEOj1dV8
    DMQwNRzipKtMAPYZDquh6afQl2KIfXbt7j6XUZPHkFi1I9b4yU7Ywc8g/UEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CGcfWwjL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CGcfWwjL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPIBHGSWgHzahyY4Nek3/ze4ssnnx2YKuWOi3novtsJk4gsTjY4lCM9GUa3cFpCvLVgXzTIRRNQYN18lJ6894pQ/I/gOIS6rU8hqxmdRA+EFmK6W9C+Y
    LV9yZ4B3+USuxvdRWoGOQwmpiaec1VYOVCOjNGqW/iysJBsJJ2/j3jFjDJcB1J5bhf0b16bHV5++alSbTHihr1AhCMz+7lYJvL9SG8JoYC7wOUG8SZD7jD3G
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ai3CC5yYEeFTzkOI7PkA:9
    a=-jn4McuRXEzgZLuf:21 a=UgxcP5UigHXLDnlm:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756194AbeDIAbN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:13 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754094AbeDIAbJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 154/293] ACPI: EC: Fix EC command visibility
 for dynamic debug
Thread-Topic: [PATCH AUTOSEL for 4.9 154/293] ACPI: EC: Fix EC command
 visibility for dynamic debug
Thread-Index: AQHTz5kuyBiX6dTp/0ivm2DeCvA+eg==
Date: Mon, 9 Apr 2018 00:24:53 +0000
Message-ID: <20180409002239.163177-154-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:tJHlipPD0AWP07uzwHJ3rns8wqMxr+xtgoS2NI93XVc25tCbyhzySD8yjDdaSctotONPpOZYR97uVrrKO+NwxXIkM5TbOanDWP6pTDTQBIAjub7sSgr0qARJlGcHOGpOiAbO2twUQK1XMRhzMthxhtrwf75lcZhUhYmvRqD4BugsjnMgUj4/gm7YutcSvENhsyRURbu62Vw4YerKMzHNZ7obsv/zwaiL2bpqr09RN0x9B0mpucMTmM7YHv3Z/z5J;20:KF8nciflP8XSAZb9GxPDOSdCcN7Yd+TvJZ0pp9kdexUo6WsZod4eCosw6HGMm5JqQIW6Vzxdm6vGWjGMejdMK4bY5C7FppywPxq1vrvj4aBR+1FdJ32tMrSjJHkk1mJN6z5IDIQS2U/hNltt07LkngQpgQHSa8LmnI2LWCjWuuU=
X-MS-Office365-Filtering-Correlation-Id: f37bb4bc-a49a-42f1-875c-08d59db12f29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917682EA31ACA366CD5917CFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ST2Tqx9ysBcLhWi/iJbT095LSjobENSqs3FUKT6ZFoxZRhIw3PZRHB40eP60pj1de7qRHRUDw6Pzo2H/z1RB6tkWJj8Y5l064FjrP3hlCC+/JI0d5djpDGW2wOM2b7O2BSTxxSRq0rs1TnUqq2dIBjH5caw+HlkpNJj0VbXKYr95zzbFZvPaQ2GnhKk222hUAuNna5gEnk0fhuufumTr2IHyvL15XJ3+qejHed70r18zYpZ5yS7ElDefCxy6Xhitq4y28K4fiLpMl/mWdSre7QCyOC4CL33pUxabJ16wu7QiR7chO0cRHpI+QSXKLN3jq7TIM78bWf8U3nuO8DtU6sOp/7yQeJFMK5x1IM5Ub1OuLRrjSnL6lMRnomXOOoWQRL1/2qtbqmXqy9dC/kLhmM7QUCEhw44XIKCkPM2DGM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37bb4bc-a49a-42f1-875c-08d59db12f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:53.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 4625d752e600c116e6327f9d7fc16e8f5be107e9 ]

acpi_ec_cmd_string() currently is only enabled for "DEBUG" macro, but users
trend to use CONFIG_DYNAMIC_DEBUG and enable ec.c pr_debug() print-outs by
"dyndbg=3D'file ec.c +p'". In this use case, all command names are turned
into UNDEF and the log is confusing. This affects bugzilla triage work.

This patch fixes this issue by enabling acpi_ec_cmd_string() for
CONFIG_DYNAMIC_DEBUG.

Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: Feng Chenzhou <chenzhoux.feng@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38136d608471..217b0bac33d9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -317,7 +317,7 @@ static inline void acpi_ec_write_data(struct acpi_ec *e=
c, u8 data)
 	ec->timestamp =3D jiffies;
 }
=20
-#ifdef DEBUG
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 static const char *acpi_ec_cmd_string(u8 cmd)
 {
 	switch (cmd) {
--=20
2.15.1
