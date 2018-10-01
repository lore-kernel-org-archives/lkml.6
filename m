Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B261C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D487D20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gi2hM9XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D487D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeJAHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:06 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729862AbeJAHQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yMSwQUC9PG49V8MUkKTsE0jJowMLAcml7733rHP8aY=;
 b=Gi2hM9XUySMHwVVNsrxLKsej2X0a6PS2xZywhPfXdb4uTaPkdJ5iuH++9c5P3ZIvAzrzI0IcvsObbAt1Grm3N59fb53WHQf6BvwOzY15B1eMX6NOuCDXYyyrfhmu9EfY+Johv4W8kuaLsmg888X4xm635V10tDgZxeE6CpFlnzk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Josh Abraham <j.abraham1776@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 26/26] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Thread-Topic: [PATCH AUTOSEL 4.9 26/26] xen: fix GCC warning and remove
 duplicate EVTCHN_ROW/EVTCHN_COL usage
Thread-Index: AQHUWR9jUXKVYn7oFU6BQOiIEAP9kg==
Date:   Mon, 1 Oct 2018 00:40:45 +0000
Message-ID: <20181001004026.147201-26-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:+q8lqRzoztRwYNljthyzgobLr/qvqyA3aogA9jgCgmXVEophnBKefusQKwdAcR4EcwMS7wya8iOSG6mR+OK37wMjq3LE8XyRba0BqIMvEAyrmiAPdnoHIy+ZZecl/pq70eA6+8nTn0NmY7HGP9L5Rghdy+OLcjZFKfhzyarDGSzmyWWFhmW/81Y9pceDTbIQdxoxGnS406h2JL/wl40UJUP6xhh6b7LdPT/gmUSe536KOoEViX/tXfAhrU57gNw0+IfWlg3m5pGLdkw2HKPllE7exe9yfLICaTrbMgFZqSh7/+6N3iF9HjUszBCmwTFPjB/Dg6uII1AIH7HbHd7vV7m2adezbOqqoaJhR2ZHFASlo2pYPAxtY6RtfK8aBLE95nYOoIVCYAfy40U6jzzTKG64j0NI2Ysiuqc84HOf4yaObESCl8+xQyqy4tuPuHaEzyrKYaPCWZwlu1f42Qk17A==;5:Om58txHmf1oKb9yXQ2jEcSc+B8JbsUUPbe1XePvha/oN1sOzYMpXH6mtJznrmePHteEk9Fr/4RhWtpao1q5NwSULHMr93Tqwt/sqvKGCDA0qjIEvBRWscGjKsFl4VSIWpMGmNMWDDzyhqOiqXIzmeFG/zhIFqppEczD/2Y5BTzg=;7:lNCysiqDQqyrXiFRfyYIco69jB0HwAciUKzDacU/yo+0uBZDg+8nkhmUf/MR5G3C4WQt5WlOeaetE9wuVw7KPNklWOL9Pw5rzwB2noR7bnHHhoY8diGjvcoJGk/jJoCqSpsqyo/mJ2oBgkzVRbsIQubNrlVS/PlRL/SiFzLTKZuWGjNCpF1SgwmYPLNrAeu2Ho+Aoot33h5IGDGsTvHvd0cshRIhP8udE1Wf4jHLj1u2Lw2Wz629Z1Ph03Yku1ce
x-ms-office365-filtering-correlation-id: a6aef57a-04d4-402a-4fee-08d627368635
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165338EC9DCAB5ECECEF866FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(39060400002)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: DiNv2y/StNM2csZUhG8zZUXo3q2RBvsBv1AcSVWeucKEZN99/vY7NMVZQt3yJacgQt5sfVnOBAj9D9XKuP4tnkjYhR2AsaoMy6PBH8NAKF8JbGAOYLCkn0/bFmlnm9jOPavs+zgIic+aqL/1eHlC9aSjh2CsZLFst8pbeqfrJScl3ka0usABg+8bGTi0pdwPQnfmDmDnIk1PQHL55iHxi5al9yMqrmVVTNBv6u3GqVo0f8h7ml8RLBi11creUaAfrgdsDw5Jr+ZCg+QLHPHWDTPoO4N/Xhyv0YbXSx/4lvXyrF+AovefkViN4ovPQ0Een/IK41OoLH6XHqEGbyUB6IfnlUoIT7SjwkmYVuP7Qug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3724F09ED5807498A2762308635B56F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aef57a-04d4-402a-4fee-08d627368635
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:45.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBBYnJhaGFtIDxqLmFicmFoYW0xNzc2QGdtYWlsLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNGRjYTg2NGI1OWRkMTUwYTIyMTczMDc3NWUyZjIxZjQ5Nzc5YzEzNSBdDQoNClRo
aXMgcGF0Y2ggcmVtb3ZlcyBkdXBsaWNhdGUgbWFjcm8gdXNlYWdlIGluIGV2ZW50c19iYXNlLmMu
DQoNCkl0IGFsc28gZml4ZXMgZ2NjIHdhcm5pbmc6DQp2YXJpYWJsZSDigJhjb2zigJkgc2V0IGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCg0KU2lnbmVkLW9mZi1ieTog
Sm9zaHVhIEFicmFoYW0gPGouYWJyYWhhbTE3NzZAZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NClNpZ25lZC1vZmYtYnk6IEJvcmlzIE9zdHJv
dnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCmluZGV4IDE0MzVk
OGM1OGVhMC4uNGIwY2M5ZDBjYTUzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2
ZW50c19iYXNlLmMNCisrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQpAQCAt
MTM5LDcgKzEzOSw3IEBAIHN0YXRpYyBpbnQgc2V0X2V2dGNobl90b19pcnEodW5zaWduZWQgZXZ0
Y2huLCB1bnNpZ25lZCBpcnEpDQogCQljbGVhcl9ldnRjaG5fdG9faXJxX3Jvdyhyb3cpOw0KIAl9
DQogDQotCWV2dGNobl90b19pcnFbRVZUQ0hOX1JPVyhldnRjaG4pXVtFVlRDSE5fQ09MKGV2dGNo
bildID0gaXJxOw0KKwlldnRjaG5fdG9faXJxW3Jvd11bY29sXSA9IGlycTsNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KLS0gDQoyLjE3LjENCg==
