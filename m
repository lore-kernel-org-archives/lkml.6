Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487710-2-7750395650368591818
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
    t=1520487709; b=u+51jv6WFaF9m9J30R71RQ4r4TEwkmB82jFXT1KQqAcA4dY
    Khj7b+36H363kFdhddO/ckPghG5XBN5R3voOjNJKKSU5X9M5xDVIm+l5/CbOwjLJ
    btrmBBP2/3s/8erKD/CcqpCxMb9WUyGuSm3/3LzAOoQ0+3bZw8/7RwH0TbcU6QZZ
    ITyDWXQc5w7zL2IcWHmZrhEW80c36ccLwTP52z/1dzR0CRVJcD+UySR2tOu0T4dN
    +iqyv37XGaiwAqEdfYaNShOCJsRgpRfCtxMi9b1Cf1/Dc9JLquf6O0WrzGcMRhXB
    Af85mdQnKI7DSUSdYHCfds9qmiHTrxZ9tR7sMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487709; bh=Af8wef
    Xtnz/CE0WvT6z5PIy+Zo891y21BEme/AYZnpA=; b=hToJCL5ZpU9Ym6YfchZb1L
    vfeiUn+y5cow8Uy/gqE0aRUhkGe71kpebMtODO0qhtPXECPorjfcn4tr0GOIFjgB
    MQyOzCrxSu/EqZJah4J1xwhvITUqRsB7Drz+AJ9rCtBZxrmZc+xzlo8NOFi6lrID
    +a5CTUlHr3rRgvBHLEqapPCF0YnI7JL2t0Dd8GBsTDaOsUe/9InTRpCcavwwg3VE
    lQm0jScoaRrfcQ3xKmubifW+kFBBnJmrb41iO4kD7xwyuFq5YPoayhuYMQku+LNL
    OBIuLJOiHYaanPXQTrhbii0dAxoM4yL6V7WxcIMNgf/a9QV1ewDifgdnvRfM3PIg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nVauQPyc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nVauQPyc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966639AbeCHFlG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:41:06 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:45409
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966217AbeCHFFW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Abel Vesa <abelvesa@linux.com>, Abel Vesa <abelvesa@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 029/101] ARM: 8668/1: ftrace: Fix dynamic
 ftrace with DEBUG_RODATA and !FRAME_POINTER
Thread-Topic: [PATCH AUTOSEL for 4.4 029/101] ARM: 8668/1: ftrace: Fix dynamic
 ftrace with DEBUG_RODATA and !FRAME_POINTER
Thread-Index: AQHTtpqJ60zEOpzWEESBnHdAWEITtA==
Date: Thu, 8 Mar 2018 05:01:36 +0000
Message-ID: <20180308050023.8548-29-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:ezFFpnu9EUBI+9e8GHmw3grlJEDUTQqIKhbtiYprYycU0ZgPM2CprMUdqShL9BeT0wBZcwnjCxaBCXnGr+WyK8KIE3aCMNdrVa6MrXhuHLTJLcvXiidD1hixUZX0LZgtZyCfR7qXJF8SgR9geFEpKn3rzfoi5bYz7IW0w/Y//pviEbacrB1nUTdQM1F0o2Xd3gqJ5mR2h/M5gPpbnfMMdNhajSoPs1S1XJYFLOUvT2SOsaySJwS++90CeVIVxKL1;20:mtZI2QsJv9+hr9HkSzOnGI4liw0janRr/ooag7bJRxO9w+3RQLhVH/hzKwYZAtjyyPd9nmDJHmqNCWo2GlE9yZwpiiMN9o5zS6aFUI6vHK3/gQ7lYbDt5+TwFce/EnCLRn3Se53l1TChkLktWzWSJxVE1uXqDEEGdvO9u2UUpGQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afe619f3-5fa0-4fa9-b602-08d584b22ef5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10468AD2137A1E5622FCF960FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(39060400002)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: UqYzcoWp9l4U6hKC7muTEvrlFZzIxtkQLLMO6bgZUIbt1jhqVlICc0Cnd8lbf27R4EamOkzX3HdkDAc9I0l3WY5vUhs3K+twOUTuC5A9v6RaLOq+giWdc4+lubSwmVRMLVm4fYT9SozAIRpgOhZuKPHUpdAMmf2j7lsvMghQWrthSfeJ8IV9EO7tvSJ8e0lhF7jzSWQttfJo0zO910rAWBbIXBZwjxdqrH7wbJIDxGYl85YNDHtpyH/DR/8SyDrF1xt2Ti6Fh0mTs8ki7gt5Ii+nMI8O7yp2yLhSLeJnqek4zPVtcfPsfak3Q/TAmADgczw/Dyb2VjdpSM0S3n1JvQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe619f3-5fa0-4fa9-b602-08d584b22ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:36.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Abel Vesa <abelvesa@linux.com>

[ Upstream commit 6f05d0761af612e04572ba4d65b4c0274a88444f ]

The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
overriding the weak arch_ftrace_update_code() with a variant which makes
the kernel text writable around the patching.

This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.

This leads to non-functional dynamic ftrace (ftrace triggers a
WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
is not.

Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
ifdef where it belongs.

Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-o=
nly")
Suggested-by: Nicolai Stange <nicstange@gmail.com>
Suggested-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Abel Vesa <abelvesa@gmail.com>
Acked-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/kernel/ftrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 709ee1d6d4df..faa9a905826e 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -29,11 +29,6 @@
 #endif
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_OLD_MCOUNT
-#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
-#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
-
-#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
=20
 static int __ftrace_modify_code(void *data)
 {
@@ -51,6 +46,12 @@ void arch_ftrace_update_code(int command)
 	stop_machine(__ftrace_modify_code, &command, NULL);
 }
=20
+#ifdef CONFIG_OLD_MCOUNT
+#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
+#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
+
+#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
+
 static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
 {
 	return rec->arch.old_mcount ? OLD_NOP : NOP;
--=20
2.14.1
