Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9AECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07906204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="czeuml6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07906204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJYJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:14:50 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:39184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbeJYJOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ/qRKRJf5Cnqt5eZSQ2pU2hmwiJduzLXU/pm8CJstE=;
 b=czeuml6yLpNDYYNnsnfnBfcWe3A+Nf2F7SlRVFKclZU2k4RV0k8eluUzPflPIlEu0TH8+7BHm6+vvpXX4IqptAuNAjIJS5DzrJI+AtF8dtBfqtuAC+tds/gZX4DYelzf78YZVKr6/RyBwK6evc6Y71SUbiz8/0kHCC1Y1YhdYjk=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5532.eurprd04.prod.outlook.com (20.178.106.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Thu, 25 Oct 2018 00:44:24 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.032; Thu, 25 Oct 2018
 00:44:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Topic: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
Thread-Index: AQHUa4rCncfeoBYpBkmKYYSezC6GH6UuP+OAgADgS7A=
Date:   Thu, 25 Oct 2018 00:44:24 +0000
Message-ID: <DB7PR04MB4618CEA5069E3A276E92D22AE6F70@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
 <20181024111213.2724-4-qiangqing.zhang@nxp.com>
 <CAOMZO5Cm2U4dR982vYTmb5zfdjfXbQ95B+mDt2Fp8D-QtvT6FA@mail.gmail.com>
In-Reply-To: <CAOMZO5Cm2U4dR982vYTmb5zfdjfXbQ95B+mDt2Fp8D-QtvT6FA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5532;6:bxeTlyMBFxj35dhezLldoQNyjq4E1nNISxMjbrYmzmmv9TM+JEMIEZMHgQG0Pj24EDq9G63oJ53xmquZvc86HJN7yz+zukrvurKcpkVOtn+IOGlyml+FqVhgcpIBJYW2Wk8bqU7AD3ydkPGl8hSpydPkbQz8Zrg+kFMDZNm2LMCOIFzCaN2GX/F7Ga+Uu3WAuoCrQi1Au29JdAacuZlK5z58hnYKE/7T6C9TVnFkk6kRPPgrDIJzQHtp1tBzp6vxlcalfluf+qC3HzOXkP+UtwHpcXeJn0xxYyD0+2oC/TQGh/+MxbHzkEqL2By/v3AW1uPIqp9x0kkHG6HRba1+1pwFJXplbHdeo39Hn62hQMp7UWBxEI4TRCelcHw3RVK9CBWwdBxVIOYbnJVsq+pCWSKl6HUZMAvDuN7izpHixYBmmsalVdY3iKyS7LE7j7oaMY1iO4pkdabmGvaTTGDFmQ==;5:iGAFbofJzDcrWhSySkdSvKZSccmugvrT1Xm5hOi93OTDoioAtDGe9Xum5pZJZfxFJ01wrIqhNh4ODoJSGDsi0YoxNDKEw22W2BHo2kP2WB4fCnJVrSBUqxBZVzKjyPrhYsix7w40gtzbmzqIBrHuoZHkmyNgl7YWYKxQEy+hryg=;7:QCaEzeLMwv5hh3EHn8m08xQrC2XSjNbHIReuKCOsK6biiknjG99wcljB2wHTV59/VuHMvsEWLDVcXdBtuNtt5UfuvIYdMGYMF9edm5kxPiyc1rD/T9Zii1xNIXOEX4jcnIwGHl9wzpzCzmEKqzdCrFArXxqchK7VFgDazbiT8l9n9FSetihy/AZepvLEadSlD/0tO64AY6TWhIgs4106+Q2N9EYz5/PH5jikIbuH6DJDzYwDqmIk6VhL3aTrzcTx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c2b0ac5a-8530-4559-81e5-08d63a1302b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5532;
x-ms-traffictypediagnostic: DB7PR04MB5532:
x-microsoft-antispam-prvs: <DB7PR04MB553215E0A97C50F7E9D6466AE6F70@DB7PR04MB5532.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(185117386973197)(258649278758335)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5532;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5532;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(13464003)(199004)(189003)(76176011)(68736007)(2906002)(11346002)(6506007)(53546011)(7736002)(102836004)(446003)(1411001)(99286004)(97736004)(316002)(2900100001)(6916009)(7696005)(54906003)(5660300001)(5250100002)(4326008)(6436002)(26005)(486006)(86362001)(575784001)(39060400002)(6246003)(53936002)(186003)(9686003)(25786009)(66066001)(33656002)(476003)(55016002)(74316002)(81156014)(81166006)(8936002)(3846002)(6116002)(105586002)(305945005)(229853002)(106356001)(71190400001)(71200400001)(14454004)(256004)(478600001)(8676002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5532;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /uxcyJw421RYB87FSF3V5tz23oU8+jzkopv6vxjGZeknES61RN3T26ylKvptL5v4vjJo0SB86SuZ5EXYdR1Mgeag++mPMS0lZI0QUSO6b05lCf5DZLuUZGBIYkxsS2SgSQPdDjDRYYE21F/hskznsKtnHEI24W1cN/4KJC208GTL4VRYOq1xJctW/ULTGi4rf/EL+qHILkNI7P1CGA0KrGhyX5eLo5mM/V6TieIxu+z6pihn8retCyJY2CP5rmwd59M1snztv4CH4imoAdf21wqVhw+a94KwQFwZXwexuwjMScv3uVZwjpbCsXzpgk/YWmaFJCTSuF9iLdykLs4AtbUwevP7MiaRKgGFjXbv6uM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b0ac5a-8530-4559-81e5-08d63a1302b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 00:44:24.2896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRv
OmZlc3RldmFtQGdtYWlsLmNvbV0gDQpTZW50OiAyMDE45bm0MTDmnIgyNOaXpSAxOToyMA0KVG86
IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQpDYzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsgU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxm
YWJpby5lc3RldmFtQG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
Um9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVF
U0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZz47IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVW
SUNFIFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2Vy
bmVsIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQS5zLiBEb25nIDxhaXNoZW5nLmRv
bmdAbnhwLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEgMy8zXSBBUk06IGR0czogc2FicmVh
dXRvOiBBZGQgZmxleGNhbiBzdXBwb3J0DQoNCkhpIEpvYWtpbSwNCg0KT24gV2VkLCBPY3QgMjQs
IDIwMTggYXQgODoxNSBBTSBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPiB3
cm90ZToNCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLXNhYnJlYXV0
by1mbGV4Y2FuMS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtc2FicmVhdXRvLWZsZXhj
YW4xLmR0cw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk2
M2UwYjU1OWQ2MA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZkbC1zYWJyZWF1dG8tZmxleGNhbjEuZHRzDQo+IEBAIC0wLDAgKzEsMTkgQEANCj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChD
KSAyMDEzIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ICsgKg0KPiArICogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkNCj4gKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgdmVyc2lvbiAyIGFzDQo+ICsgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbi4NCg0KWW91IGNhbiByZW1vdmUgdGhpcyBwYXJhZ3JhcGggYXMgeW91IGFy
ZSB1c2luZyBTUERYIHRhZy4NCg0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1zYWJy
ZWF1dG8tZmxleGNhbjEuZHRzDQo+IEBAIC0wLDAgKzEsMTkgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDEzIEZy
ZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+ICsgKg0KPiArICogVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4g
KyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
dmVyc2lvbiAyIGFzDQo+ICsgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4NCj4gKyAqLw0KDQpEaXR0by4NCg0KPiArJmNhbjEgew0KPiArICAgICAgIHBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhj
YW4xPjsNCj4gKyAgICAgICBwaW5jdHJsLWFzc2VydC1ncGlvcyA9IDwmbWF4NzMxMF9iIDMgR1BJ
T19BQ1RJVkVfSElHSD47IC8qIFRYICovDQoNClRoaXMgcHJvcGVydHkgZG9lcyBub3QgZXhpc3Qg
aW4gdXBzdHJlYW0uDQoNCg0KSGkgRmFiaW8sDQoNCkkgd2lsbCBtb2RpZnkgd2hhdCB5b3UgaGF2
ZSBjb21tZW50ZWQuIFRoYW5rcyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5n
DQo=
