Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236675-2-7442418675242587062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236675; b=uwfzGX3TNn3uFu/HdjaxqHThJ9bTndrK+F69iRn/HLyWBWLk0h
    092tg/UpsefuKDY4cG06OK5gcGaUFz43+M0tnIa1pVTGhGYccwp3NDT2ND0U8UWt
    erwOFburFbeV2+f90fLR/eW7UfKrshV2Zro4NX8/XhPz22z1X0giQQw5EeHdUucP
    M6mMVYKMoPG9ADkJfg809dFYOyqogDmWS8hN5ByY16k6H62vKjdVWEFbbndHU2BY
    Wk1d501M57CLrICgO8ZfZKnQB09Ug7Hjq6NtIdfuWqV2FYIY5dzjHpaUiIyYIdpa
    eFVnfXVqp0rkUGYT7cGNSxIC2kw0HroVGXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236675; bh=qUpMHNywz8
    RaLuMAWoHnlxhiotQ1CqpEwNiBJCpHjlc=; b=UtGGEtggQjgzLWcp5lD8xXymqG
    chVDUb+qHSw+PhnT2x9znwfUjy6ZXvy/HrtJw1flfx9VxjIjLtuuUk+vXA/CYs0r
    cyj2fgZlKgrigiipZWf8vwN2bC9ZyVx/Js/PQehyZL3FWaNxEucedGKNEqf56o5Z
    g+KrDqyuV6Ek6GL2pl2bEcjvwc5eUjbjOqB+hxkuDmjdFLjpoYW1r7wOxzQwc4V1
    AafEgN4Hx4CbYtt6MeXryrvf5bo3nK6jEqn8eRTk+1YQZ0gBDh+FWcxyJV4z1jUk
    emyBxANCCUgmOsaDu3BGUiddMMLSvHliABiO4NhJP/Zfemmiph0d/DURHqIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RIKbWkGT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RIKbWkGT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2oPmr2qyITM4QqP1LHbph3eDHfNcY0isiTtvOWqsRVE7mIkHaaeCvzWdghsAPjTP+ap5uFb4XgqIakETKeOBFJkugaJ5LqGvogBRKa6ZPshjMY8eWp
    o/TPOw+E3vNCUq9qVpbPCv1luvInV7GFuuwV4x13ccoBch9ZUpE+akK5IdZ0SrrunjE53UxdVaHprtfQOb58kR58lpfmsqUge7wPQodlhRkRtpCR6ovMy+1K
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=i6SHCG24PLcwl-ztjlgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbeDIAhu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:50 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932844AbeDIAht (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 103/162] irqchip/gic-v3: Honor forced affinity
 setting
Thread-Topic: [PATCH AUTOSEL for 4.4 103/162] irqchip/gic-v3: Honor forced
 affinity setting
Thread-Index: AQHTz5nCSQNxv+AP20eRO/ouWTnrmw==
Date: Mon, 9 Apr 2018 00:29:02 +0000
Message-ID: <20180409002738.163941-103-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:PvRhHCUNerFoQrBZr71TMpHAED3z4fmJRLqJl/wVb4XhEHZozIiklECqQEzasm47sjGJLNhWShGwMpuYm6HXhNYVU0j54elwvhoK2NT4gh8Uqma2z/QSToEwpH6QS4p/fmULPEMz7I/9N5qkjpZERxAY6gZpMndYHaCLRX8UoVcsmqfHYlXXzt15qepD04W/++xPRcLPBn1cO13k8OtTW0DZTSaQ0bn2/UM7EK9S22AswoRvTFSDDssXqNnyyUd1;20:acXkpPWUl1pyZ1lPns0rOcjN7sCUWR6CauF2YqOONbXRwKoBXiCKHthjZfrPi7DO/kbNbSn0OQL/HKyVQdQLhL1raiFNR19nMFUfOoXGp7Di7v++Sc4+VuxLLre2cOsYl4j99Sq4NEBx+nzH5zoJsxxPY6SMF/rR7iAHHHYfoRY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 703f14cc-fbe2-4868-2bad-08d59db21d13
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111026C27C8A77F2B6CBE074FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NRINCUIZ6yUJPlizFDe6zIOY3obNj0jqCbF8l+aXFJa3CYITU5jdhDz5jeuMziMcF71krar2BYnVwPS57e0rUisSTKHSm4E1vbfwIdOHeZuZiTbTviDkQ4gSDYNwyV4ZM5Q5rjkJP/X+tqz1YsacKbVxYqFpY+XxZlustyJsXfhtfRABufGihcRmK+VrvNpF7z/GxA5l1ADEX98ZKHFH1vvrVvRDt6pTDaEpr+icCw3goSasgKKDkij5YwblTszvdE6Wvx4tZtSBzEoDtRoKiaBS9+AQFvcvwNGchLl4rPcnXLzulozPBHFfGDrerjlpwlLxU3i/frJXfrQujH75ME+rItxYcuM1WF1rE9DKxuYTOvJs+UGtNQpUW43dg3IxrCGl/hlLbfiMQkhnnEZy2ts0Wc31wZ3TML6YIqY7OVU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703f14cc-fbe2-4868-2bad-08d59db21d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:02.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 65a30f8b300107266f316d550f060ccc186201a3 ]

Honor the 'force' flag for set_affinity, by selecting a CPU
from the given mask (which may not be reported "online" by
the cpu_online_mask). Some drivers, like ARM PMU, rely on it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5d93e0254d70..eed31f9bee05 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -627,11 +627,16 @@ static void gic_smp_init(void)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask=
_val,
 			    bool force)
 {
-	unsigned int cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
 	void __iomem *reg;
 	int enabled;
 	u64 val;
=20
+	if (force)
+		cpu =3D cpumask_first(mask_val);
+	else
+		cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
+
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
--=20
2.15.1
