Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB08C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA43204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D5PayYKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA43204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIJNcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:39 -0400
Received: from mail-pu1apc01on0100.outbound.protection.outlook.com ([104.47.126.100]:22630
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbeIJNci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7grZBSgBKSCb9amO9vQbn8AEE/UwOkKTjDWgO7f9H4=;
 b=D5PayYKtfljwSOzUQ1E3JX4OqZuQpwHaxgZ564kTmVWSOsCa0/8vQOtJXz9CDFruUouFyYEl01xxeH/FuWGaTnptYzoKKmIBZyxk1KSUMb6hy+HiuQFa0FArvkV5mMICGLhCHBMoGiRYCqzNRoyX0kwkyEaTnQmVBOFnLBooWV0=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:34 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:34 +0000
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
Subject: [PATCH 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Topic: [PATCH 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Index: AQHUSOHN5/FjZvVAJk20Q4a8F8WcXw==
Date:   Mon, 10 Sep 2018 08:39:34 +0000
Message-ID: <20180910083806.65177-12-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:tTSGhUXrddAo2OZUJqsB9V6I2XL1cXxt4CduLr5o1l/TGkfi/5BU7C8tT9O9L9Al9OSQu5VmBygnvwZwy87d/g3Ao0TOj7E2eNH4s/u8I3g4Kz7eiMPDl4Vq/OYqSCdmkf9OD8qfAIK5T3Hf4QOKiaYoyA56h7gGE6Fr0iOYHYzXETAFpvAZBTYcaHCn9X2/KZETi9rbZYpOC1lQN27jhZc124ayp+XAqsAM9GYgaH8b+2U7eT9CFtWotIORRKR7+YlYeqTyFC35TtjcveSa3tv0fzEe8lp16lq/CsNd6Cz2HQV3AUe2igmtw5DL2FAn4LJrTHcL+Pe4zeG12jiHYYtf/ZJQpaj/aVEp38JV5ETq/IgTTvt7CzR8/lPKAk+mcnzUumfACl3hR1Xvm7RTFbmDgzg5BHrhI5c3oguHMukElLTAkPNkmAPpSTfVycIqYUBXm+TU1Zsu3vhCsshENw==;5:9CXq+0MJnsDvGjOPZolmlXFZkHqRmKwrf+kGVN+2fzzmuy3PsRrM7mJ2BT+mMO/L4EMO7GjcC8IZ2d8HvSV2m3BsbksMDzGkdNGmKriEFasLIEBffuAl0il3zETGrgfJ3+PYBMxkOPsrL7T9zX6r1jGF+aJ3teu5tbHeCUtWEGg=;7:i2WQTu76dVrG4JloLuRAm7f64Tnwv6M/gYPX+PqSR1uwQcf6jxvkvlAuNlTO6Euun+vCQQwvOkUB/amAhsCxMwYwFT4/pRYaXL1WD9QGcC4DfNhpO408RoZ1ytTybyMLyKVSOKEJ+gx42oImS7MT/QC19ttt2CRZJPORYl/NCZ5uT/t3C4A5b9dpRwVhhPwOVfFhndfjMeE2fLbG//JmJKFD9BqwD7krMHETjW8MAIz/jMHIuSgyXjq0HBXPfAN1
x-ms-office365-filtering-correlation-id: 888bf689-9adb-45e0-a280-08d616f8efc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0178EFFE3116D0555D3C3B0092050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QFfU/KzGAMKsUSQlU5ktgrIoDlyhNX9Al0I07RzJYUPOMB73ZELdR8huKwaMpFQbmAXaz61CjiPGRvweHjHTfaV3gSEclUbvx+ImG4i4k7D2mEyK7WCYr3syh5rqIJ8tD2wNag7Saqyz+jdBQj37ieAHZGd5wV7nsPLamkmXKqHCfICbr5SKg0/1KfRNKFkPfZut336oVyn1Jx78g1wurrXTw3uxp2870hhX0lP3ioiMemaTWTJkp5Z+nGNZuUCeopQdktj2yDVGYTjjsfS8gdNdg0EhmQvN6AjCu0V383ymGuUN+tKRnzy45Xpqy1Cg1WyagaG6khm4+cR9DyqR4haualJ6RNxf9Cb2pvKDULk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888bf689-9adb-45e0-a280-08d616f8efc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:34.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
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
index bb716ed94320..90e5eee1b410 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -161,6 +161,7 @@ int hyperv_flush_guest_mapping_range(u64 as, struct kvm=
_tlb_range *range)
 	if (!(status & HV_HYPERCALL_RESULT_MASK))
 		ret =3D 0;
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
