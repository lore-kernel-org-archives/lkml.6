Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246510-5-5974784248499734963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246510; b=DErgAu5A1NdINv0/jt5D4qcPsjGBO1KF+/XoB5n4hF037HN1/M
    86e0G5K1boYiudFKczhRz/El64YrHD8Ea2gyjOUgnrM+FuqeKlsEDbO4mhRMlYfO
    7dNrYdbskMsQltQ/jTCWQaKPRGMsbdIsM5vclky7+Sx9v0mTF4vysEXMaHOiGct2
    Q/yMCGXyV4aVU2uupipvmoB0e0dgwmb8QU8icbRCUtw/mPIlJbexTMvIUMQTbfu3
    pxVTfiwJZv9yZwJA/aD5Xe3IxYhKkRpkFtL9upLapFpDVkU3m0flZqMqO/WLDUdi
    GD0/AVMHOqrFq01Z5/sCJmrg4994cbbo9LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246510; bh=Ct0oR4BPFh
    zHi9xbTPxcYWuIlnX5MBBLIT1FsMJkM5U=; b=uiOSVa90em57JYpTEO50k+Wtx+
    F4xJPzmzejX7MasT5xVoZ2VwmxFz4O1AepSRbRotaNGXYVLzuNq0hvzeTcnABgWM
    YN+K5XHqhnCgOsxb2yqoC23HNV59vj0eN1hoYLDCCvvM1jfDQJY/WGYBtDW3gxxr
    4xzhkw76LOdPEXMC+O1mpq6t6HcXxtWkTx2lwp+2/SGMpvh3B6xgWLVy3QuevU/b
    W6rTxfCNQxOyHQWIdrhnXNwCkpjMNgrIR2b5xXlBbep493L3YK36xKegOSzZAgmj
    LF01IUoEg9GG8KguHm1+oi1SLAi4mAzprtVHcg/X7uS/iX8s5ZB4m23Wiz0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ULYv3tMI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ULYv3tMI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFmXyZ3X5kzR16UTagfGTwp3cCPfX3UPgzkGTMpw9VT+Wf58ZHjmK8vAGOWCRNsWlFIj/8FISBghVxZETjSe2XiGSXB7uxk60lF0ASTbs6eZT3M1oxt8
    LQJKtbL02Fu771ypgfmxQ1taroaYHeRM7OF8cWbKvVnqYsG+WtvAc99RFQJN3SCvfhnoGCAgERR79QiNkvYevAjn7aHsAMryb6OiN1tFdgY6bjrqH6IzIFyL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=PHq6YzTAAAAA:8 a=yMhMjlubAAAA:8
    a=YO_wFUO48kzikC8MTzgA:9 a=49Wd64SlGjSzMp8J:21 a=8JEQf1qEEDcJYGQl:21
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeDIASJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:09 -0400
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:42112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753394AbeDIASD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 053/189] ARM: 8740/1: NOMMU: Make sure we do
 not hold stale data in mem[] array
Thread-Topic: [PATCH AUTOSEL for 4.15 053/189] ARM: 8740/1: NOMMU: Make sure
 we do not hold stale data in mem[] array
Thread-Index: AQHTz5gku4MueDI2jEOlUumjzuuefw==
Date: Mon, 9 Apr 2018 00:17:27 +0000
Message-ID: <20180409001637.162453-53-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:DLRkMwKmjYp7eVSdxX0inCGd06JsFT2vifXjniew6CXw54kuz04SbXeLXp/okqOEcPaPB4ZCiDloLn3lDt60xEL2f5DbpchCFtopxuXFgUlxch/iH7kRvz1NzsHsuajBXR+tjKTuspl4h6/X4zZ+ZcCYzdIhqKdQy3oSSj/i3V15Ia7cAKCMEQeDTqhQpBP/9qGGFyjDbz7yPe1znpa9qbcLrdPpbyoE+pjsMD594gtXFpZgia53JkOJaeKVsrUW;20:F9YewPYhaL8SGFntXmAHuWLbGKnx7NMD69pSZV6i/NRoyqdknw9jiNLxIzXGieya+FezXAFOn5W5T10bxNH2ZKpliYoL6mkFkP+gXeqEXyGGjklNZ348I0tmEu4eFT8tde0uJ6lYh33aSGkYvKadUpakpp5O0sthh+9N2fDaJo4=
X-MS-Office365-Filtering-Correlation-Id: c85d4ac3-7327-4358-eb71-08d59daf5675
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046FAB1803D6B50990857CAFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: jk2IKWYPL+hFqwvitxn6BCuq/gZuylZpdcDLT2x5K6AE/MQAgTRLYttENdaOWVrpOssop1Nmb24nkb2oGSJapiAROLi6zBquvL+lWh8D8tSkCtbZL0Po7iMIT10V+7ua/H0vcZJsbFfufhYa8DdveTAYi9yFRTUiKfMW9kmFLlQgjVtxL4fh0coAIJ+05FDBRH0kVxm0B2pxjVztzRHJzIBL67ROgRPFZE9reNpatJOR/BXSAfLQpSrAVVcYRmAQvNoFWZ0bpziGZm8nFO8MoI7kC/9G2ULoz3nbAcu+vWC4j+kQdKnpPH1pF4y+HDc/4D5vwor4ZUZsUWA14PR/53EMnAiIv+RoVj6IOAnLXakMV7LqhmmX/NVYK+aazPRhHJnIiZQnez9w23f5JkflaRlv4gLdKiKSbtO5R+L3lCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85d4ac3-7327-4358-eb71-08d59daf5675
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:27.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit 636e645f1f2a5826beacd23548696f1655b0b5d8 ]

adjust_lowmem_bounds() called twice which can lead to stalled data
(i.e. subreg) value in mem[] array after the first call.

Zero out mem[] array before we allocate MPU regions for memory.

Fixes: 5c9d9a1b3a54 ("ARM: 8712/1: NOMMU: Use more MPU regions to cover mem=
ory")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mm/pmsa-v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 976df60ac426..f65c01fba9f4 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -6,6 +6,7 @@
=20
 #include <linux/bitops.h>
 #include <linux/memblock.h>
+#include <linux/string.h>
=20
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -296,6 +297,7 @@ void __init adjust_lowmem_bounds_mpu(void)
 		}
 	}
=20
+	memset(mem, 0, sizeof(mem));
 	num =3D allocate_region(mem_start, specified_mem_size, mem_max_regions, m=
em);
=20
 	for (i =3D 0; i < num; i++) {
--=20
2.15.1
