Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7576206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="J3ZPScMX";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="N8JSGCar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeLNPaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:30:16 -0500
Received: from sesbmg22.ericsson.net ([193.180.251.48]:63453 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeLNPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1544801408; x=1547393408;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZPlXfV/qwqEGRAq8Knze95+tB657znSbP9WAtwSXqEc=;
        b=J3ZPScMXSeKsXH0lPJ2XE7/FtSRj4NMi2rSnvCcIL4d748NQuesz/46ZO55pm2HP
        6gfxbtCmAOETK43BlkDK26vgkjvCAAlT2UXteIGn8inhwAlsAkkd7zxu+KTTZkmt
        Qo6likUK74a+rdRAEEZaQoFJE+xtQwEul0z4bfOR4Pg=;
X-AuditID: c1b4fb30-41b3a9e00000355c-91-5c13cc808e0d
Received: from ESESBMB505.ericsson.se (Unknown_Domain [153.88.183.118])
        by sesbmg22.ericsson.net (Symantec Mail Security) with SMTP id 05.82.13660.08CC31C5; Fri, 14 Dec 2018 16:30:08 +0100 (CET)
Received: from ESESBMB503.ericsson.se (153.88.183.170) by
 ESESBMB505.ericsson.se (153.88.183.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Fri, 14 Dec 2018 16:30:05 +0100
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB503.ericsson.se (153.88.183.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Fri, 14 Dec 2018 16:30:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPlXfV/qwqEGRAq8Knze95+tB657znSbP9WAtwSXqEc=;
 b=N8JSGCar8OQ+ilUanLVJzp2icp6aXWgjq6ZrOKDo7uVVmy5j7uvZebgkO/OOxigy3lJJ0tSVMNLgpRGE3wCnqwhicWK1BysektJIS7234g8KzbdHt56TaccPX+yxIBHg8lJo3EjfG5XY24ioNUWMDU05gyvLY1rlAZlJNY+8Ipo=
Received: from DM5PR15MB1513.namprd15.prod.outlook.com (10.173.225.146) by
 DM5PR15MB1881.namprd15.prod.outlook.com (10.174.247.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 15:30:02 +0000
Received: from DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::dd9f:cb91:17d3:2bd3]) by DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::dd9f:cb91:17d3:2bd3%7]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 15:30:02 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     "syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com" 
        <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>
Subject: RE: KMSAN: uninit-value in __inet6_bind
Thread-Topic: KMSAN: uninit-value in __inet6_bind
Thread-Index: AQHUkOpCpLOckJXGoUmg4yIjwqTaPaV5PuIAgAFj5ICAA7ShkIAABkMAgAADrJA=
Date:   Fri, 14 Dec 2018 15:30:02 +0000
Message-ID: <DM5PR15MB1513772B19C4457F12B55B709AA10@DM5PR15MB1513.namprd15.prod.outlook.com>
References: <0000000000001568af057cb456a8@google.com>
 <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
 <CAM_iQpUZmbsEPAz9s1bDVHbm08+h4WE4mvoxitttDCsXMQvQ4g@mail.gmail.com>
 <DM5PR15MB15135725A063E5370876EBA69AA10@DM5PR15MB1513.namprd15.prod.outlook.com>
 <2b0f7497-7842-e9c3-c7b0-1b2bf2d5ea59@gmail.com>
In-Reply-To: <2b0f7497-7842-e9c3-c7b0-1b2bf2d5ea59@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1881;6:HQemxvuA+UT71E+82X44Jpo34Mc/f+s6Hkw3bdZwFJlw5HSF8489xBzpXBh7tf2ep2zwSrdpzhqms0uu6rY10kMQsElrrzrgkgUf9V8VjHGhQTj7QvNRSiqEEmGU2o6hIgT88uKTfOgJ1y1UsBSk1CUzVmdlfIeK/2bT2lXxaZRqenGIlqisaPHjz0tCJ+PmR6Z5venW2baSc2knmP2LaP04rmTR/07iHPnmhblFIj0VGXAa++ekeVToTs2BNUYuvIRFOCkIHQelidqQfhIWLkAeE7OQMIM28GRFk/U8v3+8pDEHjRLr0EryLpky3JsEngpoL65YhY0/mIJy0lEPeiCnJaxBcoYXORYRhLBRqNY07FmrwH+DMCfeqnWw2EN9d+hK6whAVN9Ij+9CIcSpC/99zeodqR/cC7QTUOaE0/uXMjTMOpHuZaDi1jafZO7nxMKO4kvhB8YQenFMBhdPzA==;5:kAI3qqdUXz2yPpWtyhnVgabKhLPrPJzT/razcYZzNQNHeyR2qVrdnQARkMfMXxkAQdCiX55LJeQSzyN2MD2lhSpAsPQol6goYwzSEhpdTvCjpai+y24xwxEPJfBDhYkSPxjFhH/66sU8gUa0bUzrNWbAl5vvR8jWXQ2Xmo1451w=;7:0og8U+CTD7HD9gTFFpIEa1qVeapc93qIMNexYqz7TtH2q3U/j94Bs2yakq6K8hq8WXv9ZvGoW3BPjgeM72exZ48o2rf+D1F2HGpfT/7JECAJyew7nsSUE1Mw3KkR8TJIqKy2W7rt/d487wUoId7RXA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa0eb61d-8334-4b23-c637-08d661d9042f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1881;
x-ms-traffictypediagnostic: DM5PR15MB1881:
x-microsoft-antispam-prvs: <DM5PR15MB1881BF87A9E027679C859E819AA10@DM5PR15MB1881.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR15MB1881;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1881;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(13464003)(71190400001)(6506007)(7736002)(305945005)(53936002)(229853002)(74316002)(486006)(71200400001)(53546011)(316002)(446003)(105586002)(106356001)(97736004)(9686003)(478600001)(44832011)(476003)(14444005)(256004)(7696005)(6436002)(26005)(102836004)(7416002)(66066001)(110136005)(54906003)(76176011)(99286004)(11346002)(39060400002)(5660300001)(8936002)(6246003)(86362001)(186003)(4326008)(6116002)(3846002)(81156014)(8676002)(81166006)(33656002)(93886005)(2906002)(6306002)(68736007)(25786009)(55016002)(966005)(14454004)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1881;H:DM5PR15MB1513.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cW01nZkHZGn67+LzuH5iI3fvT7VjduC9g0VHsQBVxk+fJM/ujflTl1BYE3CWzdKkHYb20M3nvG0SgzMMqOaEXE1p0ADTpXrwUVnyVowKmcB8wUD6rnP2FKxRK+NpAlxDrBGHVPGWD5LxQ6ngAN7ksPGYVD6X7i6sNeaAyypFjdn8IFf5hb5Iubcyg/BvXSCfziURklihxWzNgrMnjuSMVBQ4kcjoDX1kdlmGbAhGEX0+BEDBbcMhYY0tGcP8CNShTQD3RWGpa7mx0a8xvhoF5cRpaDNJZCjI/9+seMQ1t845jotJ1zN0xQGm5Bxfw6W1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0eb61d-8334-4b23-c637-08d661d9042f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:02.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1881
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/det+tocJzafix6uGq9KJf0uGGFQcQNMiSisoycddHV2mxT
        e5BlZCITa9YMJ6bDtHCIxlhkTo1Grcx3Qsse1FLRWaYgJWlF2+6C/vuc7/d7zvf3g0OTEk+Y
        jFZrszi9VqWRC0SU5eDDnDV5nZEpyoFJzFT05FOMyVsgZNomugRMb8FYGNPfXCFg3NZ5TFlT
        AvPGcZtkHD0nGNt9I2IGPR6S+d5qpBLmso66AYJ9VP5ByFrt2WxLSbuALXhtI1indYpgHbPT
        AtYyrmCn7AvZRscDIkl0SLTlOKdR53D62G2poowX9jOZ7xef7X5XSOWhyUVGFE4DXg9em5kM
        sAQ/RdDtVhiRyM8//FxkF/BGDQHOV4kBprCJhI6+S3zITIBpZIDgD58RtBpHqUBKgFeA71Yh
        CnAUzoYZdz0KhEhcSkH1YFkwFImV0ND/SciH1sFDp5XgeQ80tn0V8nXLYHh8OMhinAKuDgfF
        t7UT0HCv32/QdDjeCh9ngmUIz4Ppl/XBd0gshbdDVQS/J4aalh6S52jwDf4JC1xFOBk6hpN5
        OQZ67leHIgvgVVVRcGbArwVQeWciZKyBydLSECfCdd8MxYd6EZjNboo3VsHPKy9DxSehyl0b
        0heCrdgbuvCGhJ+2VqEJKcv/G7bcPxSJV0Jjcywvx4C5yCssD+4fAe2WIcqKKBuKNnCGtFPp
        cXFrOb36mMGg067Vcll25P9uTxyzyibkG9nuQphG8rnii48jUyRhqhzDuVMuBDQpjxLvv+qX
        xMdV585zet1RfbaGM7jQfJqSS8W/JBEpEpyuyuJOclwmp//nEnS4LA/tvNaZlKRoXl7Z1Bnf
        ciXXyy1Nzp2uT7qrOKDMdjXVRpVc2tIn1RXtP6Ku27TZom9Ik+buOKg7u2vA6nx27GbCjX1j
        tYolhyutdWNd5t2eX5o28ps7f3RWFr43esQ9teHCUMuNexPF0t9Euy8VDjw6/UU03E3Mccb3
        brycXiZb/VxOGTJU61aReoPqL9PVvnJqAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bmV0ZGV2LW93bmVyQHZnZXIua2VybmVsLm9yZz4NCj4gT24gQmVoYWxm
IE9mIEVyaWMgRHVtYXpldA0KPiBTZW50OiAxNC1EZWMtMTggMTA6MTUNCj4gVG86IEpvbiBNYWxv
eSA8am9uLm1hbG95QGVyaWNzc29uLmNvbT47IENvbmcgV2FuZw0KPiA8eGl5b3Uud2FuZ2NvbmdA
Z21haWwuY29tPjsgRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiBDYzogc3l6
Ym90K2M1NjQ0OWVkMzY1MmU2NzIwZjMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb207IFlpbmcg
WHVlDQo+IDx5aW5nLnh1ZUB3aW5kcml2ZXIuY29tPjsgdGlwYy1kaXNjdXNzaW9uQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldDsgRGF2aWQNCj4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgQWxl
eGV5IEt1em5ldHNvdiA8a3V6bmV0QG1zMi5pbnIuYWMucnU+Ow0KPiBMS01MIDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE5ldHdvcmsgRGV2ZWxvcGVycw0KPiA8
bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IHN5emthbGxlci1idWdzQGdvb2dsZWdyb3Vwcy5jb207
IEhpZGVha2kNCj4gWU9TSElGVUpJIDx5b3NoZnVqaUBsaW51eC1pcHY2Lm9yZz4NCj4gU3ViamVj
dDogUmU6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX19pbmV0Nl9iaW5kDQo+IA0KPiANCj4gDQo+
IE9uIDEyLzE0LzIwMTggMDc6MDQgQU0sIEpvbiBNYWxveSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENvbmcgV2FuZyA8eGl5b3Uu
d2FuZ2NvbmdAZ21haWwuY29tPg0KPiA+PiBTZW50OiAxMi1EZWMtMTggMDE6MTcNCj4gPj4gVG86
IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4gPj4gQ2M6IHN5emJvdCtjNTY0
NDllZDM2NTJlNjcyMGYzMEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tOyBKb24NCj4gTWFsb3kN
Cj4gPj4gPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+OyBZaW5nIFh1ZSA8eWluZy54dWVAd2luZHJp
dmVyLmNvbT47IHRpcGMtDQo+ID4+IGRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0OyBE
YXZpZCBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Ow0KPiA+PiBBbGV4ZXkgS3V6bmV0c292
IDxrdXpuZXRAbXMyLmluci5hYy5ydT47IExLTUwgPGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgTGludXggS2VybmVsIE5ldHdvcmsgRGV2ZWxvcGVycw0KPiA+PiA8bmV0ZGV2
QHZnZXIua2VybmVsLm9yZz47IHN5emthbGxlci1idWdzQGdvb2dsZWdyb3Vwcy5jb207IEhpZGVh
a2kNCj4gPj4gWU9TSElGVUpJIDx5b3NoZnVqaUBsaW51eC1pcHY2Lm9yZz4NCj4gPj4gU3ViamVj
dDogUmU6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gX19pbmV0Nl9iaW5kDQo+ID4+DQo+ID4+IE9u
IFR1ZSwgRGVjIDExLCAyMDE4IGF0IDE6MDQgQU0gRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29n
bGUuY29tPg0KPiA+PiB3cm90ZToNCj4gPj4+DQo+ID4+PiBPbiBUdWUsIERlYyAxMSwgMjAxOCBh
dCAxOjQxIEFNIHN5emJvdA0KPiA+Pj4gPHN5emJvdCtjNTY0NDllZDM2NTJlNjcyMGYzMEBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tPiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IEhlbGxvLA0KPiA+
Pj4+DQo+ID4+Pj4gc3l6Ym90IGZvdW5kIHRoZSBmb2xsb3dpbmcgY3Jhc2ggb246DQo+ID4+Pj4N
Cj4gPj4+PiBIRUFEIGNvbW1pdDogICAgM2YwNmJkYTYxMzk4IGttc2FuOiByZW1vdmUgZXhjZXNz
aXZlIEtNU0FODQo+ID4+IHdyYXBwZXJzIGZyb20gYS4uDQo+ID4+Pj4gZ2l0IHRyZWU6ICAgICAg
IGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUva21zYW4uZ2l0L21hc3Rlcg0KPiA+Pj4+IGNvbnNv
bGUgb3V0cHV0Og0KPiA+Pj4+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4
dD94PTEzY2E2YjA1NDAwMDAwDQo+ID4+Pj4ga2VybmVsIGNvbmZpZzoNCj4gPj4+PiBodHRwczov
L3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD05YjA3MTEwMGRjZjhlNjQxDQo+ID4+
Pj4gZGFzaGJvYXJkIGxpbms6DQo+ID4+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1
Zz9leHRpZD1jNTY0NDllZDM2NTJlNjcyMGYzMA0KPiA+Pj4+IGNvbXBpbGVyOiAgICAgICBjbGFu
ZyB2ZXJzaW9uIDguMC4wICh0cnVuayAzNDgyNjEpDQo+ID4+Pj4NCj4gPj4+PiBVbmZvcnR1bmF0
ZWx5LCBJIGRvbid0IGhhdmUgYW55IHJlcHJvZHVjZXIgZm9yIHRoaXMgY3Jhc2ggeWV0Lg0KPiA+
Pj4+DQo+ID4+Pj4gSU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBidWcsIHBsZWFzZSBhZGQgdGhl
IGZvbGxvd2luZyB0YWcgdG8gdGhlDQo+ID4+IGNvbW1pdDoNCj4gPj4+PiBSZXBvcnRlZC1ieToN
Cj4gc3l6Ym90K2M1NjQ0OWVkMzY1MmU2NzIwZjMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20N
Cj4gPj4+DQo+ID4+PiBUaGlzIGxvb2tzIGxpa2UgYSBidWcgaW4gVElQQywgK1RJUEMgbWFpbnRh
aW5lcnMuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBJdCBsb29rcyBtb3JlIGxpa2UgdWRwX3NvY2tfY3Jl
YXRlNigpIGRvZXNuJ3QgaW5pdGlhbGl6ZQ0KPiA+PiB1ZHA2X2FkZHIuc2luNl9zY29wZV9pZC4N
Cj4gPg0KPiA+IFVuZm9ydHVuYXRlbHkgdWRwX3NvY2tfY3JlYXRlNigpIGhhcyBubyB3YXkgb2Yg
a25vd2luZyB0aGlzIHZhbHVlLA0KPiBiZWNhdXNlIHN0cnVjdCB1ZHBfcG9ydF9jZmcgaXMgbWlz
c2luZyBhIGZpZWxkIHNpbjZfc2NvcGVfaWQuDQo+ID4gU28gdGhpcyBoYXMgdG8gYmUgZml4ZWQg
Zmlyc3QgYnkgYWRkaW5nIHRoaXMgZmllbGQgdG8gdGhlIHN0cnVjdCwgYW5kIHRoZW4NCj4gc2V0
dGluZyBpdCBjb3JyZWN0bHkgaW4gYWxsIGN1cnJlbnQgdXNlcnMuDQo+ID4NCj4gDQo+IERvIHdl
IHJlYXNvbnMgdG8gYmVsaWV2ZSB2YWx1ZXMgb3RoZXIgdGhhbiAwIGFyZSBuZWVkZWQgPw0KPiAN
CkZvciBUSVBDIGl0IGlzIG9rIHdpdGggMC4NCg0KLy8vam9uDQo=
