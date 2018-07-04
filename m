Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CCE23CE4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="G0XdlAs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CCE23CE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeGDPfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:35:32 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.208]:18716 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752158AbeGDPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:35:29 -0400
Received: from [67.219.251.54] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-west-2.aws.symcld.net id 50/F1-07043-D39EC3B5; Wed, 04 Jul 2018 15:35:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTbUxbVRj23HvbezcpuZQtvIDMWBcTMbdQiPH
  gmNEfJjcxmmH8YQSmZdS2rhTS227dZgwLbk4Ko1ApoWNzC8u6DRZmRV2WkvKRgQU3PpYZh2zl
  o5MPh2aDxMigeG8vm3p+nDznfZ7nPc85OYch1UE6jTE47QabVW/RKDdTprkpgts5n1+YXVf3A
  m67U6fEY6vLCDc1jiD84+3DSlzV2qHE/SPzFJ71tyIc7ApT+ObVFpGo/5XG7jNVJPYPxAi80q
  vD9bOPKLx04yiNh9cGFHjc3U/g4LVj5Otqvme6V8m3BucJ/uZ1B38qXMCHTrbTvOtEjOKPXFm
  j+Qf3xim+o/MWxS8FtvFfdLsIPhBdJPjhSIzepfpAYbaWlDs/UpgW7kapip9YZ+3gNF2JLrPV
  aDOjZqMI1oeOEdVok7joQTDlL5YIij1Pwpr3rEJW1RDgWTqvlBd3ETSvfkdLFiX7IoTv/0xKe
  Av7EtS39JCSiGR/V8Dg6CMkEclsEfg9jZQsKobQ8W8VMs6Bjstt8b0pdjsc7T8eb6QS9UvrUY
  Wc6RD8MtEc925iC2CoKRTvidgM8E5H4l6STYGTXl9cDywLZ4PDpIy3wvxMTKwzov5d+KNzt1z
  WwJ3K6g15Box97UJSZmDdCmhen93w6mDgQoiUid8UcLiuYcPxNnge9illYgRB03L7hiMTLq14
  KRnvhcZrD5CMC+GeZ4aW8Ta4WDtFyeYACZc+9yA30vr+cwqfmJYUr7XjapZcfg6+ck3RvvjFJ
  EG4OUqdRtRF9EqJzWw02cv0Zguny87mdLocTpeLudw8rf4gt0frELj9BsHO5Wj1+wWtcKBsj6
  VUazXYA0h8vU+J4wqq6ivtRakModmqevabHYXqxJLy0gMmvWD60OawGIRe9AzDaED16Vx+oTr
  JZjAanB+bLeIXeEwDk6DZorJKtEqo0JcJZqNMDaI85tSFhgaSWf2zUZwnXN4GUk1Zy62GtBSV
  UTKwksHksD5p9/hTjaGMtGQVEgOqEyoMtjKz/f/8AkphkCZZtVPqkmC22p/suiAGIsRANd/nS
  YHs+n+ptEpUdD3rs+W/u+/PLYb7bGcSb3ziyW6zjVoS04voI11jb6U638wKBgaMe2t3pe9zvM
  +1HAqV0hPUwx0t2Ns1Xj9969zKq++dLtBNRnYvr93+8q92b+fT7yhzXxuMcW/4J/N/eDmSktC
  UZ90Xi9QmZRZPLqBFt/FgOqpJnRl6vnvUZzqhoQSTXpdJ2gT9PytkkfFPBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-32.tower-366.messagelabs.com!1530718520!393167!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24307 invoked from network); 4 Jul 2018 15:35:25 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-32.tower-366.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Jul 2018 15:35:25 -0000
Received: from USEXEDGE01.lenovo.com (unknown [10.62.65.4]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 3cac_9bb5_276ea471_42b4_47b7_887a_f2dbd0fb1aaa;
        Wed, 04 Jul 2018 15:35:14 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.16) by
 USEXEDGE01.lenovo.com (10.62.65.4) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Wed, 4 Jul 2018 11:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8DEBt5LiT9p/yC+jICV6LXznGWOLRpyvszoMTidiis=;
 b=G0XdlAs+Q16XlB9kkwthmNNOuz/87BsEEFzs9o6WJu+59i8SHCur6J6sXieglp9RhugHBnCBzJ1DzxFLHeu0n1xlcrZQdirZTS+hbRgWXcjh7VI/x5cNXzmFHU00MKo7EGf2CgYr24fNBERLWNCNySJs+/JPoJaCimji4EKmOLE=
Received: from HK0PR03MB3876.apcprd03.prod.outlook.com (20.177.71.17) by
 HK0PR03MB3747.apcprd03.prod.outlook.com (20.177.70.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.6; Wed, 4 Jul 2018 15:35:08 +0000
Received: from HK0PR03MB3876.apcprd03.prod.outlook.com
 ([fe80::a5ea:2d6d:52ae:9b32]) by HK0PR03MB3876.apcprd03.prod.outlook.com
 ([fe80::a5ea:2d6d:52ae:9b32%3]) with mapi id 15.20.0930.016; Wed, 4 Jul 2018
 15:35:08 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Jan Kara" <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH 1/3] nvdimm/pmem: check the validity of
 the pointer pfn
Thread-Topic: [External]  Re: [PATCH 1/3] nvdimm/pmem: check the validity of
 the pointer pfn
Thread-Index: AQHUE6UIrH6E5E+Khkmyh6Urle0GfaR/MZCg
Date:   Wed, 4 Jul 2018 15:35:08 +0000
Message-ID: <HK0PR03MB3876228A8E0CE4BE9F6EE24D92410@HK0PR03MB3876.apcprd03.prod.outlook.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.80.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0PR03MB3747;7:45EIPJffHlPjt+96HmJDmA3X/1RVk6V1/XuFFd+BNzqsjtA9JI0mUY44JCAc+vnOd/w8aVOYZfeCej+3jLd2uPaR7uFE1guj9e1O9+/hwMBmPbEcKwqs9TULyNnZT0YDSxSPcXidqSe0f+Gwbds3C6nTaQuiPlTQmddZC5BAaJTJSXFzgSmIlof4Lnz7w8Xm+m0A/HJzBKG1fz/k+ccC35Pig6C440V6YFpBzfG6TxdJfQ/ntcQkzYrzJQwSFNe3;20:kymKdvLRikbh9IPRMp9BxvVfLpBhdKZ/EjTZkdO829UMmJQ6oGaIF9sD4ANhvydTFHiNsb4ZOYVGPOe1kYNR9GYi2490CqHqR/1UFcw5jJ/0RRoNeeCr42uvbL79og0OUhSbQdhncwzayW/iUO4BI0fg2wONZbYTfkibfgoCqdfb+H1TkBOjSdvR0nqSARtMFvKb20nmlK03wsyOjDRGexTnBUV6L6VVSu8MEFV8s3CHopPrQENRBdx8ci7AQarPfsofLcdjkOiMNTEATRJ049lz/NdAE5LAAOKDj2nFH/p6mipHc0Rd0CtgJXfSzrqU+oL4kKEgbiQ5Nf75oTMRKA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(8936002)(68736007)(53546011)(6506007)(97736004)(2906002)(11346002)(446003)(186003)(7416002)(26005)(81156014)(8676002)(14444005)(256004)(102836004)(81166006)(3846002)(76176011)(6116002)(7696005)(316002)(6436002)(55016002)(305945005)(54906003)(229853002)(9686003)(478600001)(4326008)(86362001)(5660300001)(74316002)(2900100001)(6246003)(99286004)(14454004)(6916009)(476003)(33656002)(486006)(66066001)(7736002)(105586002)(25786009)(5250100002)(53936002)(106356001)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB3747;H:HK0PR03MB3876.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 84ba8b45-bab6-426a-5d02-08d5e1c3b925
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HK0PR03MB3747;
x-ms-traffictypediagnostic: HK0PR03MB3747:
x-microsoft-antispam-prvs: <HK0PR03MB37479DE8DF7FD768405BB25F92410@HK0PR03MB3747.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(228905959029699)(247784426924974);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK0PR03MB3747;BCL:0;PCL:0;RULEID:;SRVR:HK0PR03MB3747;
x-forefront-prvs: 0723A02764
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zeolmeEmHjqxO6klw4qrdhovH1jfafkXSc6Zf/OH9mtFnx0BR1pZMJxPr3YRNFyw3/iyPadqtIMjdv5kl8kc3lAC/JOT/rl0XLxs4nYkJrB35qLed1Ig5rkMlP4uHbbvGI46qY9pKdE72kDYejLA/ZSaNHGj8NsStgaJsXxabD62x2p7VSSSumGL6WA51H/hSLE2fk98BRrCeeHV1qNL6aP1v0QL107JP/BOUlMOt0JhPGjwlw9b6l3zrd3MFPpSxsx30erexsXLB4afWAuhYlrMj7ZxLWYvP1DEI0lmuarbLjA+J2V9DQFUhwc9cvEVvgdvU1exnHspGOA6RndW/GNp8/K4VWI3ZxHX10b5ww0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ba8b45-bab6-426a-5d02-08d5e1c3b925
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 15:35:08.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgW21haWx0bzpkYW4uai53aWxsaWFtc0BpbnRlbC5jb21dDQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAwNCwgMjAxOCAxMDo0MCBQTQ0KPiBPbiBUdWUsIEp1bCAz
LCAyMDE4IGF0IDExOjQwIFBNLCBIdWFpc2hlbmcgWWUgPHllaHMyMDA3QHpvaG8uY29tPiB3cm90
ZToNCj4gPiBGcm9tOiBIdWFpc2hlbmcgWWUgPHllaHMxQGxlbm92by5jb20+DQo+ID4NCj4gPiBT
b21lIGZ1bmN0aW9ucyB3aXRoaW4gZnMvZGF4IGRvbid0IG5lZWQgdG8gZ2V0IGdmbiBmcm9tIGRp
cmVjdF9hY2Nlc3MuDQo+ID4gQXNzaWduaW5nIE5VTEwgdG8gZ2ZuIG9mIGRheF9kaXJlY3RfYWNj
ZXNzIGlzIG1vcmUgaW50dWl0aXZlIGFuZCBzaW1wbGUNCj4gPiB0aGFuIG9mZmVyaW5nIGEgdXNl
bGVzcyBsb2NhbCB2YXJpYWJsZS4NCj4gPg0KPiA+IFNvIGRpcmVjdF9hY2Nlc3MgbmVlZHMgdG8g
Y2hlY2sgdmFsaWRpdHkgb2YgdGhlIHBvaW50ZXIgcGZuIEZvciBOVUxMDQo+ID4gYXNzaWdubWVu
dC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEh1YWlzaGVuZyBZZSA8eWVoczFAbGVub3ZvLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9udmRpbW0vcG1lbS5jIHwgMyArKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0K
PiA+IGluZGV4IDlkNzE0OTIuLjAxOGY5OTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udmRp
bW0vcG1lbS5jDQo+ID4gKysrIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+ID4gQEAgLTIzMyw3
ICsyMzMsOCBAQCBfX3dlYWsgbG9uZyBfX3BtZW1fZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgcG1lbV9k
ZXZpY2UgKnBtZW0sDQo+IHBnb2ZmX3QgcGdvZmYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFBGTl9QSFlTKG5yX3BhZ2VzKSkpKQ0KPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTzsNCj4gPiAgICAgICAgICprYWRkciA9IHBtZW0tPnZpcnRfYWRkciAr
IG9mZnNldDsNCj4gPiAtICAgICAgICpwZm4gPSBwaHlzX3RvX3Bmbl90KHBtZW0tPnBoeXNfYWRk
ciArIG9mZnNldCwgcG1lbS0+cGZuX2ZsYWdzKTsNCj4gPiArICAgICAgIGlmIChwZm4pDQo+ID4g
KyAgICAgICAgICAgICAgICpwZm4gPSBwaHlzX3RvX3Bmbl90KHBtZW0tPnBoeXNfYWRkciArIG9m
ZnNldCwNCj4gcG1lbS0+cGZuX2ZsYWdzKTsNCj4gPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAg
ICAgICAqIElmIGJhZGJsb2NrcyBhcmUgcHJlc2VudCwgbGltaXQga25vd24gZ29vZCByYW5nZSB0
byB0aGUNCj4gDQo+IExvb2tzIGdvb2QuIFlvdSBhbHNvIG5lZWQgdG8gdXBkYXRlIHRoZSB1bml0
IHRlc3QgaW5mcmFzdHJ1Y3R1cmUNCj4gdmVyc2lvbiBvZiB0aGlzIG9wZXJhdGlvbiBpbjoNCj4g
DQo+ICAgICB0b29scy90ZXN0aW5nL252ZGltbS9wbWVtLWRheC5jDQoNClllcywgeW91IGFyZSBy
aWdodC4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
