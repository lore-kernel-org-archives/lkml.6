Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB78DECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4C214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O9QMwZON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF4C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeIRIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:49:56 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:61168
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729423AbeIRItz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpIPv/V/Z1U0u7suhhmsouyDUzvd8/Tksq9AFaxt5oU=;
 b=O9QMwZONkjbWgfcAMiF0nImtACn10TutKk6qkaAqOS/wo8j7kls07QPNajFKrJIasaOl3QXBUfqAC7SOzFkJSgUVlM4xDQkr0iZlKJC95niPXmSlyrxq9BSGiLO/0CtdtjXfmKL8Xr3poFWwevEdDGwKtPBZR7bbhaG8Ju6eqcQ=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0130.APCP153.PROD.OUTLOOK.COM (52.133.156.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Tue, 18 Sep 2018 03:19:21 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 03:19:21 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V2 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Topic: [PATCH V2 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Index: AQHUTv5k8hBuJTz2+U+LsPtdlD58xA==
Date:   Tue, 18 Sep 2018 03:19:21 +0000
Message-ID: <20180918031754.113013-12-Tianyu.Lan@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0130;6:me6fND9SX0PQWlu+Kb4frP1GLN2+Gzz77BFsGH0hoHSODBrh8Xh5cTfG/bicPf44n7rTxrJijA0n59Qe6XXxguLanqUGvCY/QTd8seqyfi+w/yZcG0jPflEtJFWaAB9ULfcnG1sinDkisQHyYMHyRjbJsvq9gHk9qBxWx5y/pTItqPDUuXEQ4vtfrek9VXJxlUWYyG4du5kD7xFEfl2oMdmRRC3Lyr2dS3fW9rQA0ZQ2fhYJhajyFHqUmHjSbScSBTAIrHh+3DQFQ/nc6cYLxmpqiYVDpSf2osUZSj5eg1HDEtzZcQTmyefSwTHXUehbtOd8OwznePnwxS5m3LLfmyfVPNXX0kw8BA2k1b0Ue2nt7tsPsrENrr6pvgUpJDzXEnR3SoF1NK8SwKIH62myqRD5YnVcrOq6wz/z3POV3zlUQLuk5IC/miYPV3L8ix+fPz3MXojzP3M+b7/YQk7PXQ==;5:BFTk9oykttLP7hU/34LlkTIGifkn3ULIKTsyv7MNzXldorgEnWqIPWP/2Ul4/OsPovfRahQew6hf/SNzlXxSZIKgeTEHy5IACsGJzQ3b4COm4PBNeaA2g0sftJnImAai/YGR1jEJqnv7RKi3aez9Gys1/gaVNPBxGkr7DAKB8Os=;7:sQ7XV+fVXLw4387SCkfIpLc/ssP9RdWywH1g7k9OMRU5yi0btaiVlmJCsLE2Mv26fOMtrXAbbtghu2wBuDuunf418wStwOxi1aZh7LgdiLzfthXoJR7P9ABG+gUWX9Lbytawh3vwxWvwNSlmQwqId1hRzXHkR6p1pj1juZu8yThmiJ/8vkkc5PSjgHIGqlMwjtXQcvEs2DK5wl7Fdo8+Cs+BX87wdT1T08PdAzkLQQi+mP4Mbbe49lTihCc3nDbI
x-ms-office365-filtering-correlation-id: a20b54de-01aa-4f83-6e2f-08d61d158736
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0130;
x-ms-traffictypediagnostic: HK0P153MB0130:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0130CF620E8E3B0CB5B0B097921D0@HK0P153MB0130.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:HK0P153MB0130;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0130;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6486002)(36756003)(59246006)(68736007)(25786009)(2900100001)(5660300001)(22452003)(11346002)(53936002)(316002)(446003)(305945005)(5250100002)(107886003)(109986005)(86362001)(7736002)(476003)(2616005)(7416002)(86612001)(486006)(14454004)(256004)(6512007)(72206003)(8936002)(4326008)(6506007)(478600001)(97736004)(26005)(3846002)(102836004)(8676002)(6116002)(10090500001)(81156014)(6436002)(81166006)(106356001)(76176011)(2906002)(105586002)(1076002)(1671002)(54906003)(66066001)(99286004)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0130;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u3Qz5WWKulTdDuB0hKzNESsFhlg09RpHHgj9NH5G7vPIDshvM/DSgi2p57i+fFLK46LvamnHbEVwyZEePwUdf8aIVQOdvPLy0ugLmZ5/PjoR+vgaM6vemahUUSYdROi+FfhS5yrh+FS3TwnRf0H2RvMP4x0TT08nHiCcnRF1N/ryc2U0QI/il7BVO5jUHs9HTljmLCfABriIjfNUzqTEkubfttW5lQPyCKcmgQZHbXKiK4cxedyVyaMPEbURyJaxCQQMV02RAxdCXkGTD6wPsve8PcPDOKN+/6Q+0dxIAgggNUWkjEe13BRAgS5fBGoBkjYs4w7ZWJg/yC1LFA1uryNi0hINuDhTBnfX6gG03/4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20b54de-01aa-4f83-6e2f-08d61d158736
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 03:19:21.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0130
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to trace log in the hyperv_nested_flush_
guest_mapping_range().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  1 +
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 40ddbfd54573..ae7181c6ede4 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -154,6 +154,7 @@ int hyperv_flush_guest_mapping_range(u64 as, struct hyp=
erv_tlb_range *range)
 	else
 		ret =3D status;
 fault:
+	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/tra=
ce/hyperv.h
index 2e6245a023ef..ace464f09681 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -42,6 +42,20 @@ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
 	);
=20
+TRACE_EVENT(hyperv_nested_flush_guest_mapping_range,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as =3D as;
+			   __entry->ret =3D ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 TRACE_EVENT(hyperv_send_ipi_mask,
 	    TP_PROTO(const struct cpumask *cpus,
 		     int vector),
--=20
2.14.4
