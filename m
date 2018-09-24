Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93639ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478B82098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WDgqrRFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478B82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbeIXUvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:35 -0400
Received: from mail-eopbgr710090.outbound.protection.outlook.com ([40.107.71.90]:26752
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732914AbeIXUve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlvwaPJVquOw9k/ltLAPIL+kvRaBU98/Cf1zUMI/XSo=;
 b=WDgqrRFWdfGJC5iLkgabaFOlaPZicQ0EReQBobzLg5GruFc/RypVprHFzOoyQnhHctfBb8JOak6J0uaKjI9TNRr4jo4unmFDrbRxrxjoVgHk57z3gZQBe8AbZInNEZmecAM2uT4dXZBtMOD7GD3o4ap7STiiHpp94GByV3XhRsk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.5; Mon, 24 Sep 2018 14:48:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Raspl <stefan.raspl@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/76] tools/kvm_stat: fix python3 issues
Thread-Topic: [PATCH AUTOSEL 4.18 39/76] tools/kvm_stat: fix python3 issues
Thread-Index: AQHUVBWlrCuk6e2EEUqnBs4tebB3nA==
Date:   Mon, 24 Sep 2018 14:48:25 +0000
Message-ID: <20180924144751.164410-38-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:4iMUx3Abht2iFTHWNgWT/fVF9igY571yCT8iWQfGsTlZjJ75yOrkk0kY//nxhUBSMMMZXQr9BAS1oh2w/1tZh0FLHD70nbMCFQ+BG3xwb5KWZVDP6ss/eSlQfzhlZw05XWbnSjJ56jNP4SF1lvcLE8TevAdTQWPY2/Myd2lO42Ai+7fqoDHatwgpAMLetuTYabsmVzDm/RXdJ3Oi7lKKOW5/59iLhpp+u+X4bvsmbDHdY9ZpP7gY0tMmMyvZjg905v1+5i77IlHcIjOvJ/PLFGXNqcX7+nKWPwQ/FXdSMLcUAvE3NTCA4oFzTuzo2VNHQM1iSF2Key3C8XNlzR3jWYbfK0WbMiDReuZaMbpKJsBa78ClTHDJiel1hcoyEGEzFvhweAUzcigglve3brhizUvczfrVEDFsMKimmF+rRQRFIo6Acup457Dk9fQWRSPCGrVP5P95FwpW6W/RZcdSMg==;5:ShlZHAZNYDnUhQVa4M0JLjJajyqyGOQoYKE09qMZRI6Z7to0uU+NAV5LkDVp9HprG8JSFGN5PQh2ElR1H89KT3RDZa+ToJ+Yrp9v2WbGYs5bQgWXXQHlfrm7P9xWxOgYYP7wWHZ6Bx4SAE4axSUyEPIsz/Gv6pbc4lcGWQZV9Mo=;7:o0bzoCXUN9m4+rY37fwdHoz1XcU9FcpAx1Xthsithsdp1FevpKlzX3/dyqXIe+usfcqaA/6b7ORA2oXxPUuJQ+4GK2YgzHGu2FNwj0fKlgIb2MptbihWG16MP59yzSA3gYjbzNR6kiQf0D0Vcfh7KRBGogfjEsGpVE0vZfqa4Dlmp9YEtmrgpmuSYUpyu/xgXpfofr5eFT/gtaqSuzsKRYcu/zRFhFu28G2TyxbGNfNb7ImdTSs2Su46jXWtacNA
x-ms-office365-filtering-correlation-id: 5815947e-7734-4435-feaa-08d6222cd94d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB085568A197C46E54D7830B94FB170@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(486006)(81166006)(6436002)(110136005)(54906003)(10290500003)(6666003)(86362001)(446003)(6486002)(68736007)(2900100001)(86612001)(476003)(6512007)(1076002)(2616005)(305945005)(81156014)(105586002)(10090500001)(14454004)(71200400001)(106356001)(316002)(7736002)(71190400001)(478600001)(11346002)(6116002)(8936002)(5660300001)(3846002)(72206003)(97736004)(8676002)(6506007)(25786009)(36756003)(66066001)(2906002)(5250100002)(76176011)(26005)(217873002)(107886003)(186003)(256004)(102836004)(22452003)(2501003)(99286004)(53936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 35Q8ipLi5cer3rqIIY3/FrcVl6AuBs28zv/kFIhtamyaEljVrPUZHvE/maZ++im5osDzslS30j1RIjMM14u453orMiuYy3fKAN7gJVAebNEjtK+vKPk/BlwZbl0OFO6wZBo9D3tkKy41Gzt1+w6SU0x9sfWCO6Gvf+ltpVO+CUQjme+jTfgMuu6eKtnPV69mtF4lxAqs8bcuXF4awYujTE6mtWVNJm2mCrrv13tWVfZ0cfo8i4shNq0b8b/2exljAoGtSB5Mjz12ukI29Ya96JINhQt2Yzid1l63r2s4OYPfbzUmFsZFZaNI+HQkDlzUxbBNmy4EY2xfk+gxlX0wclgZZyLmT67CCpP86IOb2S0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <13BA01D6BCE20F4D94D9C2C319A4EDFC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5815947e-7734-4435-feaa-08d6222cd94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:25.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIFJhc3BsIDxzdGVmYW4ucmFzcGxAZGUuaWJtLmNvbT4NCg0KWyBVcHN0cmVh
bSBjb21taXQgNThmMzNjZmU3MzA3NmI2NDk3YmFkYTRmN2I1YmRhOTYxZWQ2ODA4MyBdDQoNClB5
dGhvbjMgcmV0dXJucyBhIGZsb2F0IGZvciBhIHJlZ3VsYXIgZGl2aXNpb24gLSBzd2l0Y2ggdG8g
YSBkaXZpc2lvbg0Kb3BlcmF0b3IgdGhhdCByZXR1cm5zIGFuIGludGVnZXIuDQpGdXJ0aGVybW9y
ZSwgZmlsdGVycyByZXR1cm4gYSBnZW5lcmF0b3Igb2JqZWN0IGluc3RlYWQgb2YgdGhlIGFjdHVh
bA0KbGlzdCAtIHdyYXAgcmVzdWx0IGluIHlldCBhbm90aGVyIGxpc3QsIHdoaWNoIG1ha2VzIGl0
IHN0aWxsIHdvcmsgaW4NCmJvdGgsIFB5dGhvbjIgYW5kIDMuDQoNClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBSYXNwbCA8cmFzcGxAbGludXguaWJtLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJhZGltIEty
xI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogdG9vbHMva3ZtL2t2bV9zdGF0
L2t2bV9zdGF0IHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0
IGIvdG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0DQppbmRleCA1NmM0YjNmOGEwMWIuLmUxMGI5
MGE4OTE3YSAxMDA3NTUNCi0tLSBhL3Rvb2xzL2t2bS9rdm1fc3RhdC9rdm1fc3RhdA0KKysrIGIv
dG9vbHMva3ZtL2t2bV9zdGF0L2t2bV9zdGF0DQpAQCAtNzU5LDcgKzc1OSw3IEBAIGNsYXNzIERl
YnVnZnNQcm92aWRlcihQcm92aWRlcik6DQogICAgICAgICAgICAgaWYgbGVuKHZtcykgPT0gMDoN
CiAgICAgICAgICAgICAgICAgc2VsZi5kb19yZWFkID0gRmFsc2UNCiANCi0gICAgICAgICAgICBz
ZWxmLnBhdGhzID0gZmlsdGVyKGxhbWJkYSB4OiAie30tIi5mb3JtYXQocGlkKSBpbiB4LCB2bXMp
DQorICAgICAgICAgICAgc2VsZi5wYXRocyA9IGxpc3QoZmlsdGVyKGxhbWJkYSB4OiAie30tIi5m
b3JtYXQocGlkKSBpbiB4LCB2bXMpKQ0KIA0KICAgICAgICAgZWxzZToNCiAgICAgICAgICAgICBz
ZWxmLnBhdGhzID0gW10NCkBAIC0xMjE5LDEwICsxMjE5LDEwIEBAIGNsYXNzIFR1aShvYmplY3Qp
Og0KICAgICAgICAgKHgsIHRlcm1fd2lkdGgpID0gc2VsZi5zY3JlZW4uZ2V0bWF4eXgoKQ0KICAg
ICAgICAgcm93ID0gMg0KICAgICAgICAgZm9yIGxpbmUgaW4gdGV4dDoNCi0gICAgICAgICAgICBz
dGFydCA9ICh0ZXJtX3dpZHRoIC0gbGVuKGxpbmUpKSAvIDINCisgICAgICAgICAgICBzdGFydCA9
ICh0ZXJtX3dpZHRoIC0gbGVuKGxpbmUpKSAvLyAyDQogICAgICAgICAgICAgc2VsZi5zY3JlZW4u
YWRkc3RyKHJvdywgc3RhcnQsIGxpbmUpDQogICAgICAgICAgICAgcm93ICs9IDENCi0gICAgICAg
IHNlbGYuc2NyZWVuLmFkZHN0cihyb3cgKyAxLCAodGVybV93aWR0aCAtIGxlbihoaW50KSkgLyAy
LCBoaW50LA0KKyAgICAgICAgc2VsZi5zY3JlZW4uYWRkc3RyKHJvdyArIDEsICh0ZXJtX3dpZHRo
IC0gbGVuKGhpbnQpKSAvLyAyLCBoaW50LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1
cnNlcy5BX1NUQU5ET1VUKQ0KICAgICAgICAgc2VsZi5zY3JlZW4uZ2V0a2V5KCkNCiANCi0tIA0K
Mi4xNy4xDQo=
