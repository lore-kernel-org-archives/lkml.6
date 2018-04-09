Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239208-2-1186202436935182680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239207; b=qKy40UikNNl1QfXgzwgjeTwjngV4/GluOh2R9Pa0DPiUXxFtIS
    AWteCR6dczGjWjqC+W8MXy8BwNqKFMyzoyy5Stcd6CcSweJvHDPWQkFbCgvpnmei
    8ojiZ3IVUZAZDCAsHm8P8fQu/Gjd4teDfbgflCo7O5RJTCTLafeD6PvQ7DB4jfE0
    sFpMzz+AWPBw83c2d+qlmqyBUeSKN69BzSIQsFE0F1dU99tt5tyulMIzKYNtloWo
    YC+giPd2mpwmUq5FTemb8ZPo5tExF8drx2o5wwduYKObLPCF6AM2qnhCTGlh7j1i
    Hop1PIU41BQmn4q6cCZpVcLAK8zuAMt1qdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239207; bh=qMETmlQbSO
    4VqYDmmqF5X3HvrcKUYIEB13mocydvmjI=; b=aaTsjkpoNeCq75A4gkWXh1szEK
    b1Tky/wuBjMIYh2AppAjOCYkKQ5WmSgX3QSRdIaKUZEqMJLFgyXUtdPmKGkH4QK/
    tvlPxhVXONksIcA0VaUQdWNRH7KjdfDn3rXA5/hPGFCvOGI2Q3oZxinXjTEXI59S
    G0SSMSfRIqY5YksDaCqhUNlZnFGzudlLYvitqkFJzGYjNxJeMCFzcRmYJpQ5f75c
    9A0k16qAUfhDBdrRQUOc6nYEMqgmFjBLyVMnwSnuzAPCPTDR1t8Nn4y/bDedOTCO
    1Vc0ZYWloa8CmvQwO6cpuBvevFly0/aE5+DMDi8VqYk5uSz0w62jBdZ2sZbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B+H53UJ4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B+H53UJ4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOVGIX1zJhKL4n4TdiH8UkmKhxFkUdHqbTIK4B/7ApYDX5wBVpIms4XfCdWZaCgt7RA/PTsxr0ip3bLCg40iNy4wVrbBtKp5U2+OboW8lHiHaO59TNqU
    Om7qe560KqwAPPIDGiwqA30mIMeFLdvDv+qqXjRc9ejLQuAoG2hO4CAPoiCb9hIqQB3/6jJbLCDKslscJSCCq2NAySHStSPO0qWNHxrh/P1ISglxpMP52LSK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=i6SHCG24PLcwl-ztjlgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757472AbeDICAE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:04 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:51937
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756476AbeDIAcQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 206/293] irqchip/gic-v3: Honor forced affinity
 setting
Thread-Topic: [PATCH AUTOSEL for 4.9 206/293] irqchip/gic-v3: Honor forced
 affinity setting
Thread-Index: AQHTz5lG8Xs9oAKgdEyEQ8Dbwiht4Q==
Date: Mon, 9 Apr 2018 00:25:34 +0000
Message-ID: <20180409002239.163177-206-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:HNj/h0hmgBXWQdckqxi+uROKXtxNjBSjKcXpjbGoVqGc8OMvdrkdpYFxgKXBLKyfrlHwKJMkK1aFTnkLKTOZwGFuTPzhWF5r/vBayjy0kRj3SApUT+5Gunaua/9iiNLJ8UJvkzobmd7tFY5ut0yVn5yCR6ves3kB9Goi5M85GtxqjSLxFRJ9EQKvl7DlYg8tkggdbDxZNrGoFfRH8ZvPMyZyiLcgZDxYvdc/8+7LKnf/fM3932lX0R8G5ipyTrfi;20:k6aXD+e1WDzHRwWVamiPF3X610wioSmHAVFNDPY5+qx5aQ61DqnCdQOqJNioTT/Or2WijCceezsPXrEZsbyeU3hl5eSlcnFYUDe2REz6EQ3hXapd7Rl6FU2tDiZ3TW87+cJ3DSTDV3PabWI5SU7FnVnkHSqKgJMmcxUTfMSmdBE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a46fdf6-ffbe-40bf-2de7-08d59db1551d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087084B868D423A61C035BDCFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LhTpJRVhNcNRpP5l+IeqgbVKOsCz6o58buM7zxOCnq1b/12jghTuBbl8aGn52cOoo+whaD/IMQSkwmgVciVCIjQzuLaEC/HqXFdD0rqujIlY2I77lk/0H8cRgOhGbWqZoLA+cKzwD/CPV22wCAScEuvm7KTJCSDPHxmhwk6agIw2uzMONh1p5j0WlQgiHNRp0tR3XEDEMNtXINrSbYJ/SBtEJ1F9PRJElvHRbuGGB/iAuZLLBRZiOyONmcxp1Lh2ZfOH6s/NFrenmFKQoeDrdcIH1qSEF5NtRPwbGrvgDM+borK6zOFJPKDOY8kwmYQdJnqPKEPCHEys/136FNEg4ow8jQima/dy/91IC+P4aKZKKeAtlcuQMVqfeJ7lakItbX++ym2jMyvdAHQwCoFz/rHmtpR7mms5MLqhG+68HTg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a46fdf6-ffbe-40bf-2de7-08d59db1551d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:34.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index 8c7f02318a6b..0ef240c64c65 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -641,11 +641,16 @@ static void gic_smp_init(void)
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
