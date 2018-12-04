Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDFD20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="koa6y3I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDFD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLDPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:03:38 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:2400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbeLDPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BuLt6+WvI1j1phTH3yjb4ixIaiF2MLKUTenTXgQPmY=;
 b=koa6y3I1BNGjL/Qh+uYgLQFb1fdGznbcKA46Iatv59QTYZjrD5BG+hXVk7ThHHUiP7UavU+4PDIdz1Qoh57W5p9hlKCtv1vP2htlkBhTmTKFWfybLQzb6KK7j2TO+1Lofbd7ZzMnFiLm6pK/oQKiCt0yPgAIocXFJbev6XsLjKs=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5963.eurprd04.prod.outlook.com (20.178.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 15:03:34 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 15:03:34 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH 0/4] Fix ssd1307fb OLED driver reset
Thread-Topic: [PATCH 0/4] Fix ssd1307fb OLED driver reset
Thread-Index: AQHUi+KGKqRks+x7p0e7WmlGe5nT4w==
Date:   Tue, 4 Dec 2018 15:03:34 +0000
Message-ID: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5963;6:o7PFu7hvtS/jh2eb84Xv1WbTpwo+ep8WQM99Lf2e7+uxg6d3MlTF/0x7G488/HbMI81xb5A2LPi9CrV/IH+8rkaOJfPlIAZVPiKaeeQLB1b8UpdI5twoeRfHhmBB49cUV5jHnrDi0rv0K0P1XbjKYEsDeUIsuHy4Hy9fGMgzOQjZbMdSur7q/ZX0LozXGyEyxEsfr5BuEGk09C5cRuGN1AeQqskGxav1q6a0ZaiarxXAa1nUYMeG/wE8cHqrEg47hoGNNFh5ACHk352qakEVutcHhfN+zL9dEfoKS5QFVfuv9i0C/M2k+PzsYES9BGvDfzt7zzTGTZFA0QH8/eKOuURkkQOOiyxD2jfhmHrgQY8mSjX3vix6IOdU0xpNDS527aQT1UaVl+In/I4ykhZ1Av453GOA2ERwEtESYfr0+Dh1PHyUnesO2aFpfg2AIGs48OOYTUyWU3uvp0Ok/Zp9Bw==;5:e/BUVMtRGF9H/pArmHo923C9ZDcw3OIyGMkzvzrjhAUgoSwBgiKFARBCXvoL12ZuMIZxB9DQ1DtOZxnHZrOKZ2jgToOzHkYMTbFx3Sy1aZhK7naVWZANTqRdL9F0Xqr6RyfQWIXB6xQGM+tsT6yOUHV/R4WJYZC5FMkR5noNajE=;7:QtzLCX1fyMeqxsgy718ztnkYJsnBEP7/EWvh++o7QcYcFMX1rsNeIm57C7yM7fYNTXnQhkg6ea42KR9ERwZstP1bsIH6z/Y52WaMyCs4MwuZfJlzyOr0B7eYvR62z50srek3wtDsk03gOaULsYkydg==
x-ms-office365-filtering-correlation-id: a740d466-98cf-44de-436b-08d659f9a92d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5963;
x-ms-traffictypediagnostic: DB7PR04MB5963:
x-microsoft-antispam-prvs: <DB7PR04MB5963AC4C45AB42152A1D08369EAF0@DB7PR04MB5963.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5963;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5963;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(136003)(396003)(346002)(376002)(199004)(189003)(53754006)(72206003)(53936002)(478600001)(966005)(6512007)(26005)(386003)(305945005)(186003)(4326008)(107886003)(7736002)(256004)(81156014)(66066001)(8936002)(71200400001)(14454004)(71190400001)(6306002)(6506007)(81166006)(6486002)(5660300001)(25786009)(99286004)(36756003)(2616005)(6436002)(316002)(68736007)(102836004)(105586002)(2906002)(110136005)(106356001)(54906003)(486006)(52116002)(6116002)(86362001)(3846002)(476003)(85182001)(8676002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5963;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WKAoEJZWBIHUv4JgIzFBuh/CPgoPmQ0O0H9dwzy/ySa3bhjQW5rInY3vixbtVyeqL3Q/uZWnmTg8Sa10KxqsMs/tePQ7hfGmT8CEhwInHJ2xREc2jMrC+g4kP/sQartRUERw/4UAKqigi8gcuLbLJoyRHX4TE8eMjAfmmcg419f/JD0yxuthn/mBrrX2Vggun9zZc1ZiDd+UbnOrWLRPtXoGKWHUGK46QYVDeLrsi0f2E3WmTBebxQabG8zryXIxRFzGyc7Wc6JKhFYo70pGwpL3LoG8NOSyrBUYB9PhL/mxRWsL7B/xAAynNCEOQ+4Pp9KEyX5P3EgE4e1YYFKhJIp0lrxJwiJETdvkX5JWAmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E53DEEA3565284E837E4EA2D450AA48@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a740d466-98cf-44de-436b-08d659f9a92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 15:03:34.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQp0aGlzIGlzIG15IHRoaXJkIGF0dGVtcHQgdG8gZml4IHRoZSBzc2QxMzA3ZmIg
T0xFRCBkcml2ZXIgcmVzZXQuIEluIHRoZQ0Kc2Vjb25kIGF0dGVtcHQgWzFdIFJvYiBzdWdnZXN0
ZWQgdG8gdGFrZSBkaWZmZXJlbnQgYXByb2FjaC4gVGhhdCBpcyB0bw0KYXBwbHkgd2hhdCB3YXMg
b3JpZ2luYWx5IHBhcnQgb2YgdGhlIGZpcnN0IHJvdW5kIGFuZCBldmVudHVhbGx5IG1lcmdlZA0K
YnV0IHJldmVydGVkIGxhdGVyIG9uIFsyXVszXS4NCg0KTmV4dCBzdGVwIGlzIHRvIGFwcGx5IGEg
Zml4dXAgZm9yIHRoZSBzaW5nbGUgdXNlciAoaW4tdHJlZSkgdGhhdCB1c2VzDQp0aGlzIE9MRUQu
IEFzIFJvYiBzdWdnZXN0ZWQsIHRoZSBmaXh1cCBtYXkgYmUgYXBwbGllZCBvbmx5IGFmdGVyDQpz
b21lb25lIGNvbXBsYWlucyB0aGVpciBkaXNwbGF5IGJyb2tlLg0KDQpJIGFtIG5vdCByZWFsbHkg
c3VyZSB3aGF0IGlzIHRoZSBwcm9wcGVyIHdheSB0byBoYW5kbGUgdGhpcyBzbyB0aGUNCnNlcmll
cyBjb250YWlucyB0aGUgb3JpZ2luYWwgcGF0Y2hlcyArIGEgbWlub3IgZml4IGluIHRoZSBkb2Nz
IGFuZA0KdGhlIGZpeHVwIGFzIHRoZSBsYXN0IHBhdGNoLg0KDQpBZGRpbmcgQWxleGFuZHJlIGFu
ZCBNYXhpbWUgZnJvbSBCb290bGluIHRvIHRoZSBDYyBsaXN0IGFzIHlvdSBzZWVtDQp0byBiZSB0
aGUgbGFzdCBvbmVzIHdobyB0b3VjaGVkIHRoZSBDcnlzdGFsZm9udHogcGxhdGZvcm0uIFlvdXIg
Y29tZW50DQpyZWdhcmRpbmcgdGhlIHN0YXR1cyBvZiB0aGUgcGxhdGZvcm0gYW5kIHdoZXRoZXIg
dGhlIGZpeHVwIHNob3VsZCBiZQ0KYXBwbGllZCBzdHJhaWdodCBhd2F5IG9yIG5vdCBhdCBhbGwg
d2lsbCBiZSBhcHByZWNpYXRlZC4NCg0KVGhhbmsgeW91LA0KTWljaGFsDQoNClsxXSBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjY1NTk3LyMyMjMyNzIyNw0KWzJdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2MTc3MjkvDQpbM10gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDYxNzczMS8jMjIyNTcxNzUNCg0KTWljaGFsIFZva8Oh
xI0gKDQpOg0KICBkdC1iaW5kaW5nczogZGlzcGxheTogc3NkMTMwN2ZiOiBSZW1vdmUgcmVzZXQt
YWN0aXZlLWxvdyBmcm9tIGV4YW1wbGVzDQogIHZpZGVvOiBzc2QxMzA3ZmI6IERvIG5vdCBoYXJk
IGNvZGUgYWN0aXZlLWxvdyByZXNldCBzZXF1ZW5jZQ0KICBBUk06IGR0czogaW14MjgtY2ZhMTAw
MzY6IEZpeCB0aGUgcmVzZXQgZ3BpbyBzaWduYWwgcG9sYXJpdHkNCiAgQVJNOiBteHM6IGNmYTEw
MDM2OiBGaXh1cCBPTEVEwqBkaXNwbGF5IHJlc2V0IHBvbGFyaXR5DQoNCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQgICAgICB8ICAyIC0NCiBhcmNoL2FybS9i
b290L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMgICAgICAgICAgICAgICB8ICAzICstDQogYXJjaC9h
cm0vbWFjaC1teHMvbWFjaC1teHMuYyAgICAgICAgICAgICAgICAgICAgICAgfCA0NSArKysrKysr
KysrKysrKysrKysrKysrDQogZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyAgICAgICAg
ICAgICAgICAgICAgfCAgNCArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjEuNA0KDQo=
