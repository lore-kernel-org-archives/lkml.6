Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E8223CE4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="Zgy2mc+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8223CE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeGDPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:36:11 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.5]:14848 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752019AbeGDPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:36:08 -0400
Received: from [67.219.250.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-west-2.aws.symcld.net id 63/28-01611-769EC3B5; Wed, 04 Jul 2018 15:36:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwbZRzH99xd7w5Ct1sB+UFgarMtMmmljZh
  nEaNREy8xM27RmNj5ckhHG9tC2rKBb4HBnNIZCpMSy3tqNjdABnsJQ9igW0GGWxE253AbgTFL
  q26ZNAubUL32tqn3x5Pv8/t8fy/Pk3tYUnGBSWP1JXa91SKYlHQ8ZZifIVTbgrm6bOcSxu1Xq
  mk8sRRGuL7cz+D6unGEv79UTuMKTxeNh8eDFA7s9yDcUF9B4P6BUQpP9jWKtOYXBjvbKki8fy
  RC4LteDa4J/EXhhXOfMti/PCLDU85hMcH3GflcEj8066V5T3+Q4CfPFvPNo5v5k00dDO9oiFD
  8rt5lhr91fYriu45coPgfWk8z/OGxD/mFnjX87kEHwffM/UHw/ukI8+qqN2VGS15hybsyw99X
  uaJqrqRs9490GQqvqkLxrIILINjZ8RuSNqcRBH89Q1ahOJbiviHhzsB2CewhIDLeS0qbqwiG3
  YsxF81lwujvP8V0Evc41DQOxUwk10LDHVcbFQWJXAHc6JwlJJMBXOUNjKSfh8lIH5LarYXQxY
  qYR85thcuhECV1+5mA4559sUJx3GbwBg/ETIjLANfsdEyTXAo0udyyqAaOg6/7/aSkkyF4LSL
  GWdG/BW4ceVsKK+FKWdU9ewZMtDhi5wfOKYOZrkZCApug8riXlsA4gvpwx72iG6DzrouKFgXu
  fTi0M1kK6+D63muMpNfAwS9mKCm3h4TOyr1IAunQ1r6PlEBYBiN/fks5kdr9n0O4xbqkeK1df
  U9I4UfhS8cM445dzGoY/WqOakXUQYTzrMYCg90sGE0qTXa2SqPRqjRarNJqNWrhA5WgLrapdu
  htdpVWLeywqW2l5vdM+WqL3t6DxB96hfj1otvz+V6UyhLKZPnD3U/rFCvzCvNLDYLN8I612KS
  3eVE6yypBvmI+V6dYbdUX6Eu2GU3iq7iPgU1QJsktUSy3FQlmm7FAQmfQs2zzgdpakm321Ynr
  0s3oetnhqiUVlKXQok9LkZ8LiGlcNM1QbHlQ9P5rm0AZaYlyJI6pSCjSW81G+/95CKWwSJkof
  ybaPMFosT/oHRLHIsSx9hzbGB3LLvyL0soQNprHUPcnmqy6St9rh6cfe/2lsTjjiy+cGoy/lZ
  uzbuOxvhOf1y5u2Yq6155NdZ6snfVsL59zW6qfzPku9bzirUst6z+6mZyw8uWq5Ycu7nplyLA
  4xd8+QfoyB7L48zD4xiFfuCn7qfT2j9VHS5nWqdysnPXCKSYrcyFwVPcIt86fTyspm0HQbCCt
  NuEfcBiyB2gEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-36.tower-326.messagelabs.com!1530718561!585856!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16863 invoked from network); 4 Jul 2018 15:36:06 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-36.tower-326.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jul 2018 15:36:06 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 3cac_9c54_5ec94d83_2959_47f2_a869_4c0d9514c46c;
        Wed, 04 Jul 2018 15:35:53 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.18) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Wed, 4 Jul 2018 23:35:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9zND64HHVe/rAfQaaQ/4yHHnzwzj0FCOE7JjQpeQoQ=;
 b=Zgy2mc+wbclm8MzJoWJbh1sQjNvKUy6pszJ8gUHgSlo7A4geciTekPWBWmD/YaFl0kjAhcALBz5vSr+25oxGmOPeDb/6fVIAeDGv5RFIQn6Fo+aUn1WjV2/ypqv/nvP4GMTGmyI30Tj/L3xDerOA5K8FpppfuHr3ioz4QkyPf8Y=
Received: from HK0PR03MB3876.apcprd03.prod.outlook.com (20.177.71.17) by
 HK0PR03MB3747.apcprd03.prod.outlook.com (20.177.70.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.6; Wed, 4 Jul 2018 15:35:44 +0000
Received: from HK0PR03MB3876.apcprd03.prod.outlook.com
 ([fe80::a5ea:2d6d:52ae:9b32]) by HK0PR03MB3876.apcprd03.prod.outlook.com
 ([fe80::a5ea:2d6d:52ae:9b32%3]) with mapi id 15.20.0930.016; Wed, 4 Jul 2018
 15:35:44 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Ross Zwisler" <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        colyli <colyli@suse.de>, Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of
 dax_direct_access if useless
Thread-Topic: [External]  Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of
 dax_direct_access if useless
Thread-Index: AQHUE4p8X7pe4W7zMEGHLlj+P8z3PaR/Ih7AgAABBACAAAvrMA==
Date:   Wed, 4 Jul 2018 15:35:44 +0000
Message-ID: <HK0PR03MB387664A02F65C1FDF73155E792410@HK0PR03MB3876.apcprd03.prod.outlook.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com>
 <20180704113012.trnfzeefao25clri@quack2.suse.cz>
 <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
 <CAPcyv4hPEch02C7UfCGgpXmsCVyT2zwV=4Tr8jv8W1i6_poAJQ@mail.gmail.com>
 <CAPcyv4hxx9JjJZGRTg1NHgN9k0Brwj5yozSWMuNCKBi88wKQWw@mail.gmail.com>
In-Reply-To: <CAPcyv4hxx9JjJZGRTg1NHgN9k0Brwj5yozSWMuNCKBi88wKQWw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.80.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB3747;7:bP5wjhn+pWzy6wJI/qwsa16h4vvkxeirRWKHS18RGpGZ9sBAWHkqeJ8FwrER19QqSpU1LBkcCGkQiuMU2wHXDWdJgCv+H46+0gwZoShz+pZedIRM5l3JzToi4HI2LhSRBpAmzbcVLxDZvuo2FVr4855jvqiGLv6wA5PTRnqoiNpJbBxDclCfYhiP4+wWe2pkJ98IKzY1VnKuD4pJX2L1Pn2n0DtCmMGKdLTfa6IFAtWqw8OGJO3QC32aSbkVO4Rg;20:jZT/E6CkpfVbhSYEU2dmPlxoIMVt34jejO4jOpwcs7PuqnI1qP5MWtCSuDs2jRqaY0IIYtotlJcJt8BHhmWkhCOk3yrUscLjh9yvJNnCNMn2xLVef88BeM0SkcWjI0uA7JJQJQwCCAJA2f9Qgx7dJKymP9xLz7vj67xemRxarKB6AgF/rN07fuZcIT6Z5dsd79iiLuoWg0LVkWXc6qymJly+P20Di0TTZ0LcUsxKFi9eq3V3mJO72RHeKNOKq8vMzGcrRe/dCGQlRhLefDBnL1O61aHRq8WkrcHZS/uutHh2IbuxnNsxSJaAmaZmt9bAA7IgqZpIfdFv3PrOi7D9GQ==
x-ms-office365-filtering-correlation-id: 14e9aca3-f751-4553-6406-08d5e1c3ce81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB3747;
x-ms-traffictypediagnostic: HK0PR03MB3747:
x-microsoft-antispam-prvs: <HK0PR03MB37475D13EB1DADFFB133B75492410@HK0PR03MB3747.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(228905959029699)(247784426924974);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK0PR03MB3747;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB3747;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(40764003)(8936002)(93886005)(68736007)(53546011)(6506007)(97736004)(2906002)(11346002)(446003)(186003)(7416002)(26005)(81156014)(8676002)(5024004)(14444005)(256004)(102836004)(81166006)(3846002)(76176011)(6116002)(7696005)(316002)(6436002)(55016002)(305945005)(54906003)(229853002)(9686003)(478600001)(4326008)(86362001)(5660300001)(74316002)(2900100001)(6246003)(99286004)(14454004)(6916009)(476003)(33656002)(486006)(66066001)(7736002)(105586002)(25786009)(5250100002)(53936002)(106356001)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB3747;H:HK0PR03MB3876.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (HKGWPEXCH02.lenovo.com: yehs1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ICrit3uYF6gi0AvvpY+EKYs9yEI/S+o+5IOXmeynzsV57aMVXb2WRsaIlp3nryQdAdIccQsZHkn5Leeyg56HMhQhjTVACxPQoj8W0kq58dZewqWU3/hFLay1OXmhYVEx4NZfn06zw/KX5svOo2r8PbdCATbRp/BC14uJgZ39GagHAeRJTRC9li2jkkomoJYR9W7eouVuiKNgFaVD/IJr0WjMIBX5pFG6E6i58JhtP5YmwgVRKfObavLa/X8aAw/uei9s/0qbZ7OBaD6TcpZcLBxUl+xoojGAdmby2RtNnLPyjpAMMIzGAC30Y3gZd6P+ldE2ZTDVLnZcTaLTeoKt8XEW1R7z4sefzFp5aXhNgOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e9aca3-f751-4553-6406-08d5e1c3ce81
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 15:35:44.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuIFdpbGxpYW1zIFttYWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXQ0KU2Vu
dDogV2VkbmVzZGF5LCBKdWx5IDA0LCAyMDE4IDEwOjQyIFBNDQo+IA0KPiBPbiBXZWQsIEp1bCA0
LCAyMDE4IGF0IDc6MzcgQU0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
PiB3cm90ZToNCj4gPiBPbiBXZWQsIEp1bCA0LCAyMDE4IGF0IDY6MDcgQU0sIEh1YWlzaGVuZyBZ
ZSA8eWVoczIwMDdAem9oby5jb20+IHdyb3RlOg0KPiA+PiAgLS0tLSBPbiBXZWQsIDA0IEp1bCAy
MDE4IDE5OjMwOjEyICswODAwIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlIC0tLS0NCj4g
Pj4gID4gT24gV2VkIDA0LTA3LTE4IDE0OjQwOjU4LCBIdWFpc2hlbmcgWWUgd3JvdGU6DQo+ID4+
ICA+ID4gRnJvbTogSHVhaXNoZW5nIFllIDx5ZWhzMUBsZW5vdm8uY29tPg0KPiA+PiAgPiA+DQo+
ID4+ICA+ID4gU29tZSBmdW5jdGlvbnMgd2l0aGluIGZzL2RheCBkb24ndCBuZWVkIHRvIGdldCBn
Zm4gZnJvbSBkaXJlY3RfYWNjZXNzLg0KPiA+PiAgPiA+IEFzc2lnbmluZyBOVUxMIHRvIGdmbiBv
ZiBkYXhfZGlyZWN0X2FjY2VzcyBpcyBtb3JlIGludHVpdGl2ZSBhbmQgc2ltcGxlDQo+ID4+ICA+
ID4gdGhhbiBvZmZlcmluZyBhIHVzZWxlc3MgbG9jYWwgdmFyaWFibGUuDQo+ID4+ICA+ID4NCj4g
Pj4gID4gPiBTaWduZWQtb2ZmLWJ5OiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5jb20+DQo+
ID4+ICA+DQo+ID4+ICA+IEkgbGlrZSB0aGlzLiBZb3UgY2FuIGFkZDoNCj4gPj4gID4NCj4gPj4g
ID4gUmV2aWV3ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+ID4+ICA+DQo+ID4+ICA+
IGZvciB0aGUgc2VyaWVzLg0KPiA+PiAgPg0KPiA+PiAgPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEhvbnphDQo+ID4+ICA+DQo+ID4+IEkgYW0gc28gaGFwcHkgeW91IGxpa2UgdGhl
bSwgdGhhbmsgeW91IHZlcnkgbXVjaC4NCj4gPg0KPiA+IFllcywgSSBsaWtlIHRoaXMgdG9vLiBJ
biBmYWN0IEkgaGF2ZSBhIHNpbWlsYXIgcGF0Y2ggaW4gbXkgdHJlZQ0KPiA+IGFscmVhZHkgdGhh
dCBJIGhhdmUgYmVlbiBwcmVwYXJpbmcgdG8gc2VuZCBvdXQuIEkgYW0gdXNpbmcgaXQgdG8gZGVs
YXkNCj4gPiB3aGVuIHdlIG5lZWQgdG8gaGF2ZSB0aGUgJ3N0cnVjdCBwYWdlJyBtZW1tYXAgZm9y
IGRheCBpbml0aWFsaXplZC4NCj4gPiBBdHRhY2hlZCBpcyB0aGUgZnVsbCBwYXRjaCwgYnV0IHRo
ZSBzZXJpZXMgaXMgc3RpbGwgYSB3b3JrIGluDQo+ID4gcHJvZ3Jlc3MuDQo+IA0KPiBCdHcsIEkn
bGwgZHJvcCBteSB2ZXJzaW9uIGFuZCBhcHBseSB5b3VyIHNlcmllcyBzaW5jZSB5b3UgZ290IGl0
DQo+IHBvc3RlZCBmaXJzdCBhbmQgaXQgY2FuIHN0YW5kIGFsb25lIGFzIGl0cyBvd24gY2xlYW51
cC4NCg0KSGkgRGFuLA0KDQpJIHdpbGwgcmVzZW5kIHRoZSBzZXJpZXMgbGF0ZXIsIGFuZCB0aGFu
a3MgZm9yIHlvdXIgaGVscC4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
