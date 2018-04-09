Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236986-2-12654098647270407288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236985; b=jO5NIaLRjwHr/W0v0e7GO/ghGFdzt1Jhg5fgb8Ji71ykr3O377
    IEvHOLuOx1YYBRZ/FV8wEEWHAT7iAfb21zIa8xKCkMzHA3rzuFyNdO3oKRQ2Hejq
    9GJDSyOLaNwZvlM7iv22Cn0xAYTQeZ2jdvubBfdaw91eB/SedEj8AHMieDyarV4K
    lNRGgBlzQSYxtTZDaCUi80tHgnElI1VUZ7vOmYjuHV5NtqMqbQuUIKQ9dKZdeszW
    71VVPMrhhmDerFhfSE/OGuPpGrtrExuBiUC2LHsqbgI39r2geRSYQ/JNhW/EFKHv
    UP5wJQgC50PqaPkYgM3Hdj3ORj28Shb+kpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236985; bh=rCE1VBW5th
    pq1kK0xdG8bvfsxDIYzDMWPz2xPKh+HhU=; b=LDNbF9OSdaWaBQXG+iVZAH7QLD
    XboDaTWilco1d3rS+o9D7SijPvHBNQw7MqkUvzJP4VfxrJS9pMYw4csDRIJ1xV7w
    jJC3+4rq6pAJdXPOWgJR8GTdNALx3LLFFo49bnO0KtLLf9WJWDrI+zE6fGRdKfvp
    rX9lil9DfYP6pDf1tQF2zaGxV0rSl64e+ZEDdqdpz39NHaF3WNQitLQ/w5py9yhi
    R+xv6ocdY5E73t5ocC928pmBmR/AR5ifNeziE37iJcHBknDTktpIFUL3l6mOzxEd
    vBxxxv611mQndSvn1rG9PYh6yoK5vn1OD/sR5LirYTUMk/JcxeCwAyQBSYUw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ca82Fw4y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ca82Fw4y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhpsmjdPBw3eLluES0LuXYpEQhRpnZzxDt6kuYCm6IyCKB0d+4NSeTts4TTr+Qbyk51F5EpLiACliVej6Ry9EZRI2tTVjW5wJpWTeCFqabt5u/ys2bN
    hMlwC4cbBzKhc0dj9wvvyj7rLL9jqtLr97U0KEfzIOaGLM1uoZmTEBhWAwMHNi1i0ZjMAcT+ipsKqOFZ8V85DC0WEJaFmsUrgj6RQEqYVOoPHpSuEf2dhqtE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ai3CC5yYEeFTzkOI7PkA:9
    a=-jn4McuRXEzgZLuf:21 a=tsfgR5OY89FYqo49:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeDIBXB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:23:01 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932726AbeDIAhE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 077/162] ACPI: EC: Fix EC command visibility
 for dynamic debug
Thread-Topic: [PATCH AUTOSEL for 4.4 077/162] ACPI: EC: Fix EC command
 visibility for dynamic debug
Thread-Index: AQHTz5m16hbC8ZJ/i0uGqWRoBL9mUA==
Date: Mon, 9 Apr 2018 00:28:39 +0000
Message-ID: <20180409002738.163941-77-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:s6ZYxH0F4dL6piYZEOtuYBo7+QKU4p76Djbpx0Y4yCHgp4ctRL1OIkKG2Ld2s3cXWs8od6A4lrPZex6sD7F4KMP7aMW7SzoTCnXOOeOajUJqDvaE3Z0uUmmipuAIpM6LOKDQwsyiGxi9bPFu7CRQxBYyT+Cicx8ge62U+dDWOcqVeO2HLIpWoVhnmchBMdsQ1zJ0M8Il/hPknpQDLyLXI9i4TShPHmzBewQd/1Gxs7hIceTXQJrHbCIq81Z4rBVu;20:OqY+iZBrPIOuJoKSoLWSdcYiUhEAd37ENUJGMMtZPHKZ3gvK9b8/zUYoijvtZVS1wxUxQyaYQq7wldZpQmpJEhjhUihAXMiIIeeEAW7rem7Hb+HKb+t53ruhzoLVtCjz6PpSdrVaRY7BfBltfB3Tf9v2P213xlenpxy+3IMTeHY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25eb88ea-8215-4062-6cb5-08d59db20178
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885595787B42B39F2E95F77FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eiuU2/D8mGvPkUt4aLRyc0RDYSwT6yhcbEDbiaP/57Wvo8NYjdIt2Sne46GNhCA6ziMTL2BZfF6X3e0X05NExw/fM8DbKX2UcxseA/kEwUHSZK/ISkMAN13sIzhmWKNM3zjJpNkHRDcbFealcUn26RNeOdI9LU0+6PpVKbmC7hIbK/mqr3Nc3F++/Glaj4rxlIRsiJqsKe4CDtU2vMtY5af67+tXeSfvM0Qu01YVKBPiDG+8uonOd5NMP9vqo4jp6bOoM7NqFPyuZPVjLlDu/T88sXLkuZtLql+P1rdh6k5E3fSFY5k0IwZdbDmyxyFgZqJvKSHZsEurl9eOoZCdpq4wSl4EydnsuXZ0zpPP8s1SbHgp/c4zweBPR7pL2VF+CAmifOH7KXvV36cbpXqdCeUUYIA0giVg+spD2rg+3gU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eb88ea-8215-4062-6cb5-08d59db20178
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:39.9583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 43f20328f830..aaec2efbe64b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -287,7 +287,7 @@ static inline void acpi_ec_write_data(struct acpi_ec *e=
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
