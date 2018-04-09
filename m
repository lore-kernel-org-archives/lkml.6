Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242258-2-7648957104314703110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daenro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242257; b=hqTEQdFxPsrqnRbdcJkzJufj1+nhsj/yK+fz3RxYsm8JH3FMYq
    5WFsl4y9DIpaptDM54yqVMinD0cJzgfM9q9YSOye7ABsDvQPjWVBJ4Ysi7NTny7h
    i/fL+aeubQARbdteXAOLDSUY2KHsEoNecguag8dw9rRkk8p1EOyJG6Uga3Ix7BN9
    hpsrPzy4bxWgdQiGGLjR59x+qLivXvNif9917CNE7uM+cgZQwhdpvoZjRXsz3ruT
    fFZVb8XGDEF4VwI5YEsne8yey3/wCJh/v+ImRjeZ6tQRV74Kk2bvof3xxh5hX6yd
    OUQDJDIVBNTscqLqScBU+8ItdUIEBGkrVQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242257; bh=ALXKdANQJ/
    GP/idKNpCcuJFsWRWruCyphXBzVm7SZc0=; b=Kp1VEEoKhz0a/0rbGnNk+DWMaN
    0SF//RtCOQwLrkTxUFXEPkvp0/xn0R3iWhiiZA9luO2RAUFaQgBl1/L1TGK8y47l
    8Nx5kHiMTm3y9SWAlyZ1VAp0S9FyqvdpS+eLtGATLmrpxFPqgplWWmtpfnaDSBzh
    yhgzGF44YO1D2oEknhbOPrxh4e2wayQBGVvLdW0E2Gdj9Jb8R042wgdo2n0+DQX0
    SSPwHJV29+5x6oBP+/mzHuDUmVzVH3GeOsIbU+s1Fll+QHMq1e2g+6JFsPaagpOj
    bB7riMTptPEerFM/S0s4Ai0Myd4CgbeCClLPzOb7RCemoOjIQoCLpAGKbyjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eXJ1NFh7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eXJ1NFh7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLL45NKH9+s+FHXG1059a7eMRPbV2ufO+aKVzLHBLqfyWq5Cx1/RHqujg/rYCXz7oyaBtrjKDiOT9b1yeH4vkaVREQ6RQTgxrwZ1OX7WEG5BB/lOstJs
    xhfN7zL2CLQBS29m+6J45TaoMcYD+d7nhkK2QzVjHuL3l/58nQdABtsFbHoBaBcA3hModCD9UA6pYSBemVGUn90r0LJEyaQW2rnv/1hFC0eH1Dt0XKlFT3Ek
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=UqCG9HQmAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
    a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
    a=30ouwem8p7Oa7RGj-EIA:9 a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeDICuF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:50:05 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755358AbeDIA0e (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Michael Kelley <mhkelley@outlook.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 160/161] cpumask: Make for_each_cpu_wrap()
 available on UP as well
Thread-Topic: [PATCH AUTOSEL for 4.14 160/161] cpumask: Make
 for_each_cpu_wrap() available on UP as well
Thread-Index: AQHTz5jKiUg6yOhUVkKzYi+wqhqNcQ==
Date: Mon, 9 Apr 2018 00:22:06 +0000
Message-ID: <20180409001936.162706-160-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:vsLxTB0JXP2AfN24Wag1uBfB/1R6dJ3o7QrwtQXn/WFapt/KntzP2Uyub6l6d5ny9404rZfGcgKdJ628A9owQ74HlyK0gpxdTXjASk/3CR12AKk75xNj1qqdH1jxtkWFxZgVW5rJFMUjUCV9y0Jntdru7jOdsgq6FxxdkHH3yUu8/QsDiHyOCaXSptxBM6LTrdo85nByEnxRGKeorJg8V1DAoWGzygqjqiNQSDa0B92o+Fm/llC98KF1W0DIpoUH;20:NwfQTsMocOtM3f3lJkje0lKKiYPXf+RX6TSYK4UM1cqd5QgU93zRFVltsWTkLD7PZjOt7sMCe3bp9Zk+4r4U1YMcw1qko7dpCEZU9nq3HbmOY5JKxPrQO6FTDItoxsa38RB+UCoz15LhGTi1K99mtuMnuoSppDHWL3eDUtjougI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5759d7d-7e1e-4d42-1823-08d59db088fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015680B4D834D55E18411C1FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(189930954265078)(42068640409301)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nVP2GqR9XVzeCgksTpF38b/EP0LIkZYfcNOHORyQPCROF+ZZCnd8wItZ4sF1zD0HUf3bxqwsLNpkGCrWkM1UN4R9bkrTSjsROEnVN2iw8+27YXL2El+IwI6xHgNGFYubWSkAc9tWy0cJYFxJdTqGXlNY0yVfc5ZiVIQRCewjD+wM+K1AqCKjEltBNcOwyH3CPuEmPzgM9l4MqmerHE7TzxUqj+K8wJFCds9LGFAXtoJvcl7VXj7jTQ7lVVcnxvbH2vWAtGE3+zpH9QsCcO7wiMW69pAFqdo5KY0JmiSXvKZ7Iur7VnOue/on/slU178oKsFGGOn7cNyltSDnSEA3DKJKJgBl+HN+0SnTjoHb9q6j/bjOP5wbZHMf5xpR+MGvXlPBuYKiTNV2SXQf4qYgWbxyVGbADBT1Q89+HkHoKr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5759d7d-7e1e-4d42-1823-08d59db088fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:06.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mhkelley@outlook.com>

[ Upstream commit d207af2eab3f8668b95ad02b21930481c42806fd ]

for_each_cpu_wrap() was originally added in the #else half of a
large "#if NR_CPUS =3D=3D 1" statement, but was omitted in the #if
half.  This patch adds the missing #if half to prevent compile
errors when NR_CPUS is 1.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: martin.petersen@oracle.com
Cc: mikelley@microsoft.com
Fixes: c743f0a5c50f ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Link: http://lkml.kernel.org/r/SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6=
PR1901MB2045.namprd19.prod.outlook.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 8d3125c493b2..db461a07bf38 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -165,6 +165,8 @@ static inline unsigned int cpumask_local_spread(unsigne=
d int i, int node)
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_wrap(cpu, mask, start)	\
+	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask, and)	\
 	for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 #else
--=20
2.15.1
