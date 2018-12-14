Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D552C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B4F206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="fSweZ/io";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="HuUHjxiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeLNPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:05:01 -0500
Received: from sesbmg22.ericsson.net ([193.180.251.48]:46874 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbeLNPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1544799893; x=1547391893;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=je4zPJL8vIoU9KadxJMYsj5OEx9rR9t1q435k/NPdlU=;
        b=fSweZ/iouxqqnDl/SfvP8hSiRJKbESy+SsI8HgkgYqN1hXvVPfzabz8w1dJfDd3O
        00/ysFoX3B26iJ2rysI34NEn+9mSypNHuPUbvOMSlBHkm2OJ2KZUtyLSX99A9AxB
        XVdvGnAXACRH/BV//l9GVbWQQ7RdtNxfDM8TAALqGBw=;
X-AuditID: c1b4fb30-41b3a9e00000355c-9f-5c13c695852e
Received: from ESESSMB501.ericsson.se (Unknown_Domain [153.88.183.119])
        by sesbmg22.ericsson.net (Symantec Mail Security) with SMTP id 21.AD.13660.596C31C5; Fri, 14 Dec 2018 16:04:53 +0100 (CET)
Received: from ESESBMB502.ericsson.se (153.88.183.169) by
 ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Fri, 14 Dec 2018 16:04:51 +0100
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB502.ericsson.se (153.88.183.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Fri, 14 Dec 2018 16:04:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je4zPJL8vIoU9KadxJMYsj5OEx9rR9t1q435k/NPdlU=;
 b=HuUHjxiEDoVP3RuaHaSTPijuoRCaIBI/YPL0sYHkvTlFWebJhJW7KaO1ZuVHOU7fm5lfZt9X1RZFpM9WwjeWpHvzGry/ruMFE3q1GrH145p77m2uVHjhNHon1vf49egwcerxf3ftOT+XKPHjbRPrDq3ERiJ6tCGv9jZRsCYmXvI=
Received: from DM5PR15MB1513.namprd15.prod.outlook.com (10.173.225.146) by
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 15:04:48 +0000
Received: from DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::dd9f:cb91:17d3:2bd3]) by DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::dd9f:cb91:17d3:2bd3%7]) with mapi id 15.20.1404.028; Fri, 14 Dec 2018
 15:04:48 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>,
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
Thread-Index: AQHUkOpCpLOckJXGoUmg4yIjwqTaPaV5PuIAgAFj5ICAA7ShkA==
Date:   Fri, 14 Dec 2018 15:04:48 +0000
Message-ID: <DM5PR15MB15135725A063E5370876EBA69AA10@DM5PR15MB1513.namprd15.prod.outlook.com>
References: <0000000000001568af057cb456a8@google.com>
 <CACT4Y+ZtAP4AVX9nARw+3PEdFL_WX3r37TAPuy=zBdZkg-0pRg@mail.gmail.com>
 <CAM_iQpUZmbsEPAz9s1bDVHbm08+h4WE4mvoxitttDCsXMQvQ4g@mail.gmail.com>
In-Reply-To: <CAM_iQpUZmbsEPAz9s1bDVHbm08+h4WE4mvoxitttDCsXMQvQ4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1756;6:hBGvLrJasW/ZLR2QmLar7AwqRjj/d8SmwnpAWJ6zEURgVUPcVMTZJXEvGnj8qzChYYMDIX2mQNqJV+jWSSmTGE38pSIJBxyphVJ8U26LDnBigZ8E7e+e7AnX+qk29+++5T5liJyMrlN2MN0YJmqpwm6s28tD03YkfqGalz+sq6c6HIpHQPxdf+IkdVbVNCpLssCJapx2cR/duTgiHx/0+LmbwtSwMA/C/DDSgL+j4VnLe3K9o6PoOnm2bAHc56l871qnMNPllbb0AekO4stbFI4yxwsUZz0VhHbJvEnYFI1BPg/CxQz+mYR3Grixqj140FgO7trZqHHNcYME/7fishIZRU6ZIbGE8q162CwXhQgfsTSgESH67rtJukMx4DPQsmSrqFQORuyJ/SClgCQi1hvcE3kFzpvg8YDYyTodQKP7Zko6Gyu+Xw8vZZf8xwPSHS7Rkzl/tx2ZFUMUgbhfYA==;5:kdwhO4aoMZNL/tPKNVULO+kwW3LbreCFL25RE2Zy/oJA0eQO+e1292S3G54y5G88VbvftwAmcSHBM1kO6qktqb9cGiG1NjwgKvVRi3DGvfs6zDTgnfB7lTMFVL8ZokxCt8k7H2xu2P2GqJ0+1LV0Bz88k1M1FPRE+KBXWFLwXZM=;7:3n3a0yJISsSybXFLVo2kBnER2N4hXVLpcmSMtOty7KAlg8qMkDORuVvrb5fT3U+paqUIYGB1H9/ndZB4VdsbncRPaNMrZhoyfe2f/u7dQn2dbXUmgg9J1+HjwLofCchz0RtcuknYEAb/b25JQR8VCg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 53b07092-6f89-4e83-f936-08d661d57db1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1756;
x-ms-traffictypediagnostic: DM5PR15MB1756:
x-microsoft-antispam-prvs: <DM5PR15MB175634D208E484DF636A44819AA10@DM5PR15MB1756.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(4326008)(6306002)(6246003)(8936002)(478600001)(6436002)(55016002)(6346003)(256004)(14444005)(66066001)(102836004)(54906003)(110136005)(5660300001)(7736002)(2906002)(76176011)(305945005)(53546011)(446003)(11346002)(476003)(8676002)(316002)(74316002)(105586002)(9686003)(3846002)(86362001)(7416002)(6116002)(6506007)(33656002)(186003)(229853002)(7696005)(97736004)(68736007)(966005)(486006)(39060400002)(81156014)(71200400001)(44832011)(81166006)(53936002)(106356001)(25786009)(26005)(71190400001)(14454004)(99286004)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1756;H:DM5PR15MB1513.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-microsoft-antispam-message-info: WwjslHXLKW/OkgVcHnHNU0f9EGya+o0EHR6ERDKup/LxbfYYVLXwk++x/yZNoIkhS1KwSdCdjljBOcBPg3ErrPOX4OM9e+RHs6CC/uo0YPO+YOu4rusr6zqSfPJYh8QDSzwke0whYbdOqCRI1QeFPKYyq4oz/7VtJAbJA2V2CUFRKd+DzXlPTAE2ldo6jwy++EFnCcSqe1+A7WLZQsZGGLOJ26h3ABMZvXCAvIk+9M/eL9wNsQccBSOs1yk8vTyL+SXdgGlV35vJ2fJLwUBiCYtS8DzyzszrM/6hyWABudFI8uXMqVsAWohfulWIM6m3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b07092-6f89-4e83-f936-08d661d57db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:04:48.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO+dsO65Gn1vqi5XowKhAncvwQCYW/jg/CpLALqzLKU9q2YpN
        S6NMy8QLlZIzJ+pWWpRYLlu4TAsveKnQUtIudpkaYioVZoKmteNZ0L/nfS7fe+GjSWW/xJdO
        1CfzBj2XpJbKKfOu+lNBpnaVTuMso5myniyKKXBmy5iX2V8lTF9DmZRpt3ozJY4o5o29nGTs
        PUeYalseYoYHBkhmuimPilrC2u+8JdhHpR9krLUuhW0s7JKy2f3VBPvYOkWw9rkZKWueXM1O
        1fmxtfaHxHb5HnlEHJ+UeJI3hEQekCcUmC2yE+e9U22tg1QGcnjlIQ8acBh0l9tRHpLTStyG
        oLK82138QtD16apULKoIuPkpQyYUFC4gYaJjWiYqJgJ+Vk4SwmNKPISg8O0GAUvxGhgrzkEC
        Xo63wouiXEIIkNhEwY3hEkoQVFgD9/o+y0RTKNQ/trpMtAtvgUGzVqApHAi9DyokAlZgHdy+
        8JEQG7cimJ2YkwqCB46BK0NPFodA2BtmntUsYhL7wLsRCyFuiqGqsYcUsReMDS9IRBwAPbYb
        bn4V9FryFw8AuF8K5qZXblMQfDeZ3KZtkFn7RCKaXiJwfnvv7rAO/hQ/dweOwp35OXfAD6ov
        OSkx8IaErJEOd2Al3P9YQxUgTel/05a6LkDitVDbECLSAVCU75SVLl7AE7rMI5QVUdXIy8gb
        Dx6L12qDeUPiIaPxuD5YzyfXIddva7bPaRxobHRzC8I0Ui9VpD9V6ZQS7qQx7VgLAppUL1fE
        XnRRijgu7TRvOL7fkJLEG1vQCppS+yh+Kz11ShzPJfNHef4Eb/inErSHbwZi/uTn1gc8X3mv
        ojLEHpaq3zEfmqt+3RZsGeeavUoWuITRy46xCLkqaOKmenbn1zM5P7JU6ZsGxjd3Z4Tv/nHr
        7pp9Z68HL1RZdE+Z6LPXYv35wOiNndq+u4ON/uFalBmy79yyM7b13H7PSNhb2En359SYW7w1
        Ta+dkrAvvYdjWtWUMYELXUcajNxfVeC8p2kDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29uZyBXYW5nIDx4aXlv
dS53YW5nY29uZ0BnbWFpbC5jb20+DQo+IFNlbnQ6IDEyLURlYy0xOCAwMToxNw0KPiBUbzogRG1p
dHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiBDYzogc3l6Ym90K2M1NjQ0OWVkMzY1
MmU2NzIwZjMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb207IEpvbiBNYWxveQ0KPiA8am9uLm1h
bG95QGVyaWNzc29uLmNvbT47IFlpbmcgWHVlIDx5aW5nLnh1ZUB3aW5kcml2ZXIuY29tPjsgdGlw
Yy0NCj4gZGlzY3Vzc2lvbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IERhdmlkIE1pbGxlciA8ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IEFsZXhleSBLdXpuZXRzb3YgPGt1em5ldEBtczIuaW5yLmFj
LnJ1PjsgTEtNTCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJu
ZWwgTmV0d29yayBEZXZlbG9wZXJzDQo+IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsgc3l6a2Fs
bGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsgSGlkZWFraQ0KPiBZT1NISUZVSkkgPHlvc2hmdWpp
QGxpbnV4LWlwdjYub3JnPg0KPiBTdWJqZWN0OiBSZTogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBf
X2luZXQ2X2JpbmQNCj4gDQo+IE9uIFR1ZSwgRGVjIDExLCAyMDE4IGF0IDE6MDQgQU0gRG1pdHJ5
IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwg
RGVjIDExLCAyMDE4IGF0IDE6NDEgQU0gc3l6Ym90DQo+ID4gPHN5emJvdCtjNTY0NDllZDM2NTJl
NjcyMGYzMEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBI
ZWxsbywNCj4gPiA+DQo+ID4gPiBzeXpib3QgZm91bmQgdGhlIGZvbGxvd2luZyBjcmFzaCBvbjoN
Cj4gPiA+DQo+ID4gPiBIRUFEIGNvbW1pdDogICAgM2YwNmJkYTYxMzk4IGttc2FuOiByZW1vdmUg
ZXhjZXNzaXZlIEtNU0FODQo+IHdyYXBwZXJzIGZyb20gYS4uDQo+ID4gPiBnaXQgdHJlZTogICAg
ICAgaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS9rbXNhbi5naXQvbWFzdGVyDQo+ID4gPiBjb25z
b2xlIG91dHB1dDoNCj4gPiA+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4
dD94PTEzY2E2YjA1NDAwMDAwDQo+ID4gPiBrZXJuZWwgY29uZmlnOg0KPiA+ID4gaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9OWIwNzExMDBkY2Y4ZTY0MQ0KPiA+ID4g
ZGFzaGJvYXJkIGxpbms6DQo+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRp
ZD1jNTY0NDllZDM2NTJlNjcyMGYzMA0KPiA+ID4gY29tcGlsZXI6ICAgICAgIGNsYW5nIHZlcnNp
b24gOC4wLjAgKHRydW5rIDM0ODI2MSkNCj4gPiA+DQo+ID4gPiBVbmZvcnR1bmF0ZWx5LCBJIGRv
bid0IGhhdmUgYW55IHJlcHJvZHVjZXIgZm9yIHRoaXMgY3Jhc2ggeWV0Lg0KPiA+ID4NCj4gPiA+
IElNUE9SVEFOVDogaWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcg
dGFnIHRvIHRoZQ0KPiBjb21taXQ6DQo+ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2M1NjQ0OWVk
MzY1MmU2NzIwZjMwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPg0KPiA+IFRoaXMgbG9v
a3MgbGlrZSBhIGJ1ZyBpbiBUSVBDLCArVElQQyBtYWludGFpbmVycy4NCj4gPg0KPiANCj4gSXQg
bG9va3MgbW9yZSBsaWtlIHVkcF9zb2NrX2NyZWF0ZTYoKSBkb2Vzbid0IGluaXRpYWxpemUNCj4g
dWRwNl9hZGRyLnNpbjZfc2NvcGVfaWQuDQoNClVuZm9ydHVuYXRlbHkgdWRwX3NvY2tfY3JlYXRl
NigpIGhhcyBubyB3YXkgb2Yga25vd2luZyB0aGlzIHZhbHVlLCBiZWNhdXNlIHN0cnVjdCB1ZHBf
cG9ydF9jZmcgaXMgbWlzc2luZyBhIGZpZWxkIHNpbjZfc2NvcGVfaWQuDQpTbyB0aGlzIGhhcyB0
byBiZSBmaXhlZCBmaXJzdCBieSBhZGRpbmcgdGhpcyBmaWVsZCB0byB0aGUgc3RydWN0LCBhbmQg
dGhlbiBzZXR0aW5nIGl0IGNvcnJlY3RseSBpbiBhbGwgY3VycmVudCB1c2Vycy4NCg0KLy8vam9u
DQoNCg0K
