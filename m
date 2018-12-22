Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985042192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UKOxYBaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404703AbeLVAHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:07:04 -0500
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:48669
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729556AbeLVAHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUM7gQwDZM1guUCjhcVeCrj7wr3nbm+w4k28GuT2yIE=;
 b=UKOxYBaSJUOIc3c/JF3Dl65VnTNd83JWISkp/HDfHakIN6bC5C840pC1gDJxMIHVoDjBxJqLq9kD2PpyE9gUDwEgK0vysTIxXdvZMWyWMZAvj813lY7xVoEBIk/Zu/cD4vWrypZd280Xwet7DWFXDL8ZV1bUKZkbJXcj9ltMtuA=
Received: from BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) by
 BN6PR21MB0835.namprd21.prod.outlook.com (10.173.205.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.6; Sat, 22 Dec 2018 00:06:58 +0000
Received: from BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::d516:404c:b10a:bdb6]) by BN6PR21MB0466.namprd21.prod.outlook.com
 ([fe80::d516:404c:b10a:bdb6%3]) with mapi id 15.20.1471.012; Sat, 22 Dec 2018
 00:06:58 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] x86/hyper-v: Fix 'set but not used' warnings
Thread-Topic: [PATCH 1/1] x86/hyper-v: Fix 'set but not used' warnings
Thread-Index: AQHUmYpBOctBA7MEWkWTqpPQnRyjsA==
Date:   Sat, 22 Dec 2018 00:06:58 +0000
Message-ID: <1545437169-18069-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0064.namprd22.prod.outlook.com
 (2603:10b6:300:12a::26) To BN6PR21MB0466.namprd21.prod.outlook.com
 (2603:10b6:404:b2::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.159.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0835;6:9sO976XdjAYaEd3WTtHO8LbIywHbfleI/jsKJ9YA6Fs34SMzpu4mVQ4ESb9PkbxRfbxsrzKpraiRqLwE+5QtLoe8TxwxYIhDYHeXq68l1wncMw5cRHa1HFKiaV+w35vRvNjC0HyjQvi8IWMK6UUHHVCtdqY9j0ASec23P4ieDPv3cELZ2/Gu15GvN2SD80mDMAXOcRXu5wm3bVW78pmoJpePrj/qfxKJhbvvz2vy3Ic7mMbWeg7ObpIKbuIFGMPrverm68u6XbDFZ+Nq0OzpEtGexltA1/gWmfLT8LHu7kgs0i7huR5PGWydDu+0UKEloEFERJt3BkYACs1jE/OrMtLilh6loBQc900nXf3tp1AbGh2wgrSYOWzYNKGTtS6t6d4ZEZpQ5lZilmnnQImYeZeeVFfwqjE/iYsM7x/GZk+XktbXBFGlRxo+oryJYIDMCWC/sjPMh4X2f6khZQjR2g==;5:312HV/qNfmS0WSNne2hRVK282QD+9ccHPx56ddsmUxSvdd+BLDqAFZuJY9HBC+8BDkTgnd7mlc2hwiA+vXDMZLyFNTRW5mQj8vmQWt7HrZcom7rpxSauTcP27NnrB0IQWk9hwmeh1kdJ4gjb8r9LpmS6DPO0bpN2kHwjd1XDjkc=;7:m45Y5HuLoRn+w4rAXsdeyBytlpQ4e5tmc37NLDHliWdQfl/zao8fBHxPPVAknHTVZh4mxZoiClj82GKLgMxfU04vdKA92Xzkix00iRJ745biKXbje1wT9JR5NSmjeKU53KivLP0AOiv4Wh0Op48fpg==
x-ms-office365-filtering-correlation-id: 14fe7110-3fc6-47b8-d59e-08d667a1638e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600098)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BN6PR21MB0835;
x-ms-traffictypediagnostic: BN6PR21MB0835:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <BN6PR21MB08357B9C5E12F6D99282CBFCD7B90@BN6PR21MB0835.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR21MB0835;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0835;
x-forefront-prvs: 089473E5FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(66066001)(476003)(14454004)(10290500003)(53936002)(107886003)(2616005)(2501003)(71200400001)(486006)(71190400001)(6506007)(22452003)(316002)(386003)(6486002)(110136005)(6636002)(6436002)(4326008)(99286004)(52116002)(575784001)(86362001)(2906002)(106356001)(10090500001)(256004)(14444005)(25786009)(2201001)(36756003)(4720700003)(86612001)(50226002)(81156014)(81166006)(8676002)(26005)(68736007)(186003)(105586002)(8936002)(97736004)(102836004)(3846002)(6512007)(6116002)(305945005)(7736002)(478600001)(5660300001)(1511001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0835;H:BN6PR21MB0466.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t8BfxntgAdbvcMiAT/Wct1nHUknd6myqepqcYc1PFtCMxdCndoLSRGyp8zY672hxjVjC7oWELSnEe2r0PSiuP45ynSh+3fUtTz61oKneTP2waf44TKveI8yLTzI2feOvbSi7yMRpZjMCLT1dOsh4HaCkGzKHybTOVet8FwOXHsyVO9hH2Aftdy6HQ9npifFKjTZIU9XX9XtZC0j7FB/sF2ez0eFH97Z9fWsQM3JogXLdooZlUcXw+wpMdR4+HxkLksHo47Iq3LZhJzK+b/nrfZc9Iaca14zeiUK03621cJVcyh+JuN6vykvYNaJ/BugY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe7110-3fc6-47b8-d59e-08d667a1638e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2018 00:06:56.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In these two cases, a value returned by rdmsr() or rdmsrl()
is ignored. Indicate that ignoring the value is intentional, so
that with the W=3D1 compilation option no warning is generated.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c     | 2 +-
 arch/x86/hyperv/hv_spinlock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 8eb6fbee..66a0f53 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -55,7 +55,7 @@ static void hv_apic_icr_write(u32 low, u32 id)
=20
 static u32 hv_apic_read(u32 reg)
 {
-	u32 reg_val, hi;
+	u32 reg_val, __maybe_unused hi;
=20
 	switch (reg) {
 	case APIC_EOI:
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index a861b04..e18c63d5 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -25,7 +25,7 @@ static void hv_qlock_kick(int cpu)
=20
 static void hv_qlock_wait(u8 *byte, u8 val)
 {
-	unsigned long msr_val;
+	unsigned long __maybe_unused msr_val;
 	unsigned long flags;
=20
 	if (in_nmi())
--=20
1.8.3.1

