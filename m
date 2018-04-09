Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234435-2-8136870775876880499
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
    1523234435; b=WwTpIlz3anmJhZ4kNXh//6ylMhE8z+uE2ngJeT1jjiALCxky54
    S9zkP8iOiA0sSHaqzmRDCGOWyrEIm59SJgyrloOFF7swuihiTP7K6l4UeCjNEBJZ
    RL4eyCUQw7tgjGlXm1v/BN4LWokc/xg4P53LwmQlCtjqSnl25Ao7+N4vR3stTHOV
    SQSWolvNwlo+YXfP/3UvDDCjJHY72fSTuSp4DOqw0gcgZMKyQtk36lffJrXP9MxZ
    idI25J3rMdJEdf0n6jffahfBLQSgM7moto0wHHWlqfGMRl7BeO7j0Qql6PIZILz0
    o0CZhxeUbibui0DdA0CZghism5lRPCXFqrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234435; bh=J3ux/LUmys
    er4RYmCLV4pexbSAIKgkIvQIYDIAiepQk=; b=JeMpl9jWVCLjIbXVhV4nWMTRQx
    JxlPQAlmfWx3HqKyTryuPdW8sR7yOy+debVBU3SWYGzQup/9PibZgX1naLWzHghv
    0qd/MUIeEl67KXNBXrcQmnoDKM1+9mzrnRA8MYO4flVFxItz8WGcJ38Ou+XBawFu
    erMHWyG5SnDKS8OXYm4Tk7cQYT/s1NPQYTPW3fxr4ELFhZszuMx/q8op65qaPWFj
    G5YCphe/E0LgRumoDxLkgYGV7MyLDIS6RquglrHAwwOXntf0xng1/Pi01SQ96S6j
    BcQehykLy5LHxvc6b9+a1PikVNOwS5mvsQQsu7Jp0crXtzuGX++PQZwE7Rew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lq8meXsM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lq8meXsM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvcQeb3ZTMfSmXy48NjeXjCxe2xjo7UISjTZ7py0nBP6D0ApPURFbQS/D6PlmxwATDHxwxe4rvLor1pryURW7AdPOpC2F3c0/m5Q6vnSaoBMYHNS1w+
    YALefhmGojzTbPnEE7FPXSGmR2NO1loE9dtU/Qz+lYrhiuZBIEdLdbtU8Yl629mTgUpW5L6GFQ1+KcJyIowcKt5yDn4FyjI/dRotnfSvAvoUW/UzwvLOaiUZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ai3CC5yYEeFTzkOI7PkA:9
    a=1a-jalBQWz_iY38v:21 a=n0xeJG5_d5LtColm:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933266AbeDIAkc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:32 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933265AbeDIAka (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 050/101] ACPI: EC: Fix EC command visibility
 for dynamic debug
Thread-Topic: [PATCH AUTOSEL for 3.18 050/101] ACPI: EC: Fix EC command
 visibility for dynamic debug
Thread-Index: AQHTz5q7kNQ+tmic80agSyuAa10Z2g==
Date: Mon, 9 Apr 2018 00:36:00 +0000
Message-ID: <20180409003505.164715-50-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:DsjaKP/BVl+t0NihPJuD89vtpHanICWk+b/TbOcSCoIXg/5mFcyYdkR+hDO8D6cajoQR0AP1jgOkchdoX+tRQC15kxAe4izG9E8hgcdLFMn6O29DwF44p91yoN5vio4gC/eoxug7xcByn5GGVz6cxg0/v0qFjrkfTXh4Rs/u2HRc2gN9HssHp5yx+ZVrPomaIZMIHz/1ecEYlIhVSC5ISuZnCok3jB+KKSjAsvQsgqqUePBAlHiNqCzr08Z2GDey;20:nMdkiZrvAVx+djbR9hkUbY8eVegfk7ckonInG0Lb1Vn9JJQtY3zDp70ZVMHixafKURXvmiBNnlD7mD7ibnl8qwMYBElFc4baw/2TOvydFTR2HJtz2Ua4JTBLXwOZNuZUt1p84MRDBs56SEHzc0+8utecQmh8Nao1k9TWDImP2ME=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9131eafe-3b18-4c0b-eccd-08d59db27c30
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08705A3ED619700147B6D2EBFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZU/0QVSzhmKXCHWX1Ou5y7donE27uekUVk+US3l7kcnO0c6F9fYmFSt1rPc3s3ZP6Y4sPY7rSHMB6iLjdy4CY6y3gM6gNn5uTLhyiNi83lyrVkI1J/ZDjVr29k7+5UuvA0/4woQ9buCG1dECLywWCQa/O+8nbXjg1vIr/gIm8zahnQVdluMcdkP0mzWfXNTu1QaRZVlc6iiYX/Ti9FqVwMTDrai4lG8ehtnVL2okWrM4WU9JHFLyGlef1JV1erIedEs2lBJbWlSXnyAqzOQijsNKIUVBXeLbCu7qaIAKSVOk0drhhj5z1r0d8We/Ilo/X2cFKj24V9x4+ZOc4rK/AD175/oUdQKAE3OCgamgXWy8AeHk2Oq5BoVRD+FppxYQtzTqUoQ8xixhHJBeyVLpoKODhpQYNNpuwYkSzz+AQhM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9131eafe-3b18-4c0b-eccd-08d59db27c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:36:00.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index 5f9b74b9b71f..3ecadb24adde 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -167,7 +167,7 @@ static inline void acpi_ec_write_data(struct acpi_ec *e=
c, u8 data)
 	outb(data, ec->data_addr);
 }
=20
-#ifdef DEBUG
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 static const char *acpi_ec_cmd_string(u8 cmd)
 {
 	switch (cmd) {
--=20
2.15.1
