Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008D21581
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YZg8BDOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C008D21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeI0KGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:06:08 -0400
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:62352
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbeI0KGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fExMD0sswRiAIOKTfeFl0nAQwQtANpOg5Zf/a96e6gY=;
 b=YZg8BDOlGlof2XP75bSpzfLR+hlnY5XUR33YPP+mZqfpuJMk4pdGf26YnwixUbss751kumxjCwG/gkduE5rdMpZsZ/mOris63wYcNU78Uq3me1tOFYuTbfEEDNf9aZdS0sOvEqEuFDqMHLHPvQS+7/wOd91ksqBHMg6vyXMS46k=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:55 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:55 +0000
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
Subject: [PATCH V3 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Topic: [PATCH V3 11/13] x86/Hyper-v: Add trace in the
 hyperv_nested_flush_guest_mapping_range()
Thread-Index: AQHUVhUnRdB/cs+unEyDmyOmmLWhjg==
Date:   Thu, 27 Sep 2018 03:49:55 +0000
Message-ID: <20180927034829.2230-12-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:+dX2mR/cuuQ/pKjMPO9YzMbVU713yEVWD9fzpUyNUlXfIOHePg0Cl1mVvxWbB3qu/g0lFA0EhjnSgEJ9ANAk7KnfNHQYCucN2fbLFU3I8CXSVtPyDKGclfFUxBjjQZSDyKet9Vulv/LymhO+1qHhD1bQ1Vj+DB2n8KEdHS3OKk5obCnAjL+CyCeGwpvqNEU3/x7fDr+VUerjSam6SfDIqx7EhoUYhU1WZSLajp+yzzPrRkuUTfdfBDJikfLvBaW1yGkc3ljv3AZnHT8i8AfxtpJLmC5PCU3wRXDCjMwfrlz1B5VJ5+axeaANLaYKvJt1gPuSPtecq3QKJa5N0Tj3P9gbBXCjlpm4U4AYIiwm/0KgukELcnt5u5sAIKbnMpB06xvRYe1xu/fjBCFu4bG5UqULzIasdAcVQfejJeNSc48ZCLuDD0IF75Y6HSwUy9Xd+ATwpIO/0itcnpUhVfPXfA==;5:pVrlMufg6EG/VihX4LWKZcUIl0yF1M4IoA118ypxWUHdc922PLt7wGAcz6kAe0H8wy4nsilZ5kS1Pc8dqudiPIB0FpUFX6WYERczqHhOFhWZAa4A6FFA9DTV4MorYeELipwyxJEpuwxtO5issRIuPTQPv7FIFrmmjqZ7iAF1R1s=;7:aKxjbCiJe46RAOJo66mBybWtXHSrIXbxBslAxZ2p63xKKI11IOBkVACBHRzyPIV/LMEArLZGT7Yk5BOYASjnEHaCy7/lbUY0Js1jTvSnLomljY2hErla64Iot/iukG/EbIdMDGhkL2SFD0cj0Ips7YHkiLXeSKXWBJ5bkNAKLBJh2rN3fJO0muofgVTtB50f+srxt+IlQLTbqK/WloWKwWvrk3KeAxdjI4cV4Pzxqwk7a44quSU/nC9j2nTRR9H3
x-ms-office365-filtering-correlation-id: 009fe92f-ae80-4b5e-a042-08d6242c49fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB01772176E940FEAEAAAB775D92140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mCwj+wHPNwX9JsgdfwYmnY4Y3cmHOw0jufAOKOp6KozpJXKbm+mXx0dcU8UM2YtjguSidlsEOR2u3YDwP/WZCWLpQyBfcdsa/ED2KzteOmB+p/y4qL6H+gAtucLF2B7XI7bVmcQVLgJ4gt718Bw1lCMaRGEhDfgBJIlll83Ag8Yw6D3ly1p9XwxLYFXElPMAk7wFfQHHZ1R/mtVVW8acnpukyAK8ebihDbpc09H+NvcDwtfFjqw5fNcfL3+65grgUiEGRrpUbwZsqPrrF68ODQNuXPnPQWstsE0asvwqc/lPDSvdVoIuRi8QgQCEJRVZNIv5BSISGeHWQ9zTm80Fw7zLvN7L9YkTTg5Y/iTEoN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009fe92f-ae80-4b5e-a042-08d6242c49fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:55.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
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
index a6fdfec63c7d..4850c74508f3 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -135,6 +135,7 @@ int hyperv_flush_guest_mapping_range(u64 as, struct hyp=
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
