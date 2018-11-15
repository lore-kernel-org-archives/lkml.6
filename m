Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0192146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pF/S3Sty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0192146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeKOUrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:47:05 -0500
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:42147
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeKOUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRHImTQ/S8+E4hnManEkaQCjTcfGDf73+CMv+ZhlI8c=;
 b=pF/S3StyoscTgWlAE1/c7nCSVi0fml7BtQQeIaDETBo1qf92yim5AebSjzA8iuBHg1664rXrsoGFibGqir9qqljjvmpyVFFbpaaPjn4UfpYpCV5lUPWLGc1Pbv9sJsg04FUsTe08xLAn/yhJ1NWUcsbM8sHeoySFctDApmU0KEc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4691.eurprd04.prod.outlook.com (20.176.214.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.45; Thu, 15 Nov 2018 10:39:44 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 10:39:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH AUTOSEL 4.19 32/73] ARM: dts: imx6sx-sdb: Fix enet phy
 regulator
Thread-Topic: [PATCH AUTOSEL 4.19 32/73] ARM: dts: imx6sx-sdb: Fix enet phy
 regulator
Thread-Index: AQHUfGiDp1Sqh31mpESixCiHMNC+2qVQpjiA
Date:   Thu, 15 Nov 2018 10:39:44 +0000
Message-ID: <81c6426b186174a852cf615b4321f4283d9b5fd7.camel@nxp.com>
References: <20181114222207.98701-1-sashal@kernel.org>
         <20181114222207.98701-32-sashal@kernel.org>
In-Reply-To: <20181114222207.98701-32-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4691;6:8zCzJ04FwmPM6MHq5QeQICjxXp0Xdnv6xRo9dydVnbRu5GqKTs1R02GIj2zlNv/jWo60DGQuYQL5ulBKIBiKjNofkX7fWO+rTkzR6rza6rzRdmRcqES+zI7ixqknOzaNy4k/lBely1HSiNyqIOq5a9t8RmKOSQEaCqKlKnykpFnVsZT4hb3i5UumuqWlLathMzEMk7sZPqFqrII0YjWGFb1pSWJ5ffT7aWqnYrNlSodtNKcPZl4ubWXepvLpWtMTRyAchyMRaVdut0S+6cAV1SEKqA5W4e7LKDbvlyR5BovyxaiHsS3GtXS86Szgj14gjQaPjQ9fjQpGES9HQnyCK/o55sifVTxijJ0JkHlfH7U6uf7dJTGVFUueGnx+MGZFsKIx+HzUH21EbtnT+PvDj13lF+KT81V7PCVINLmZPhzqFD0c6ZfiUhWoDW7GSw2CersWsfgT1mrJCNlr2xrSgg==;5:DLUdgtSwePdNxDL6J8nFHD9pSfqKw0FUwBVStA8VOw08gsih3+WwnYx6bgRSAZqxCFj6ZkZuZXTxwTzPyHKU6GPhbkWI/wJx3CMPYTbq3rJ41xSWpOf8L1BbSBSnwcKVGYbXkhNJ9a0+5/XIUGx6TNCYZVrRI/0x2NBB5H4Rdf0=;7:lcpJLvrmauVykPC4jL60VDReiIm7bYT02b1SJfLieYbV0N/nsLn2q9w44R8le1t3wwCUTjEczc5SBJO/VNzl3E2imfJKCT4ANGWCuyK7DIFJC4677pK4KgqJJREwnhG4ZrltcCUZtiPRlpsECRbFrA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6e9effec-6c89-452b-d79a-08d64ae6a860
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4691;
x-ms-traffictypediagnostic: AM0PR04MB4691:
x-microsoft-antispam-prvs: <AM0PR04MB46915430E601C4301EA50AE2EEDC0@AM0PR04MB4691.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4691;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4691;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(4001150100001)(54906003)(6246003)(110136005)(50226002)(217873002)(36756003)(316002)(2906002)(229853002)(6512007)(8676002)(81166006)(81156014)(8936002)(256004)(14444005)(5660300001)(6436002)(14454004)(6486002)(53936002)(99286004)(106356001)(25786009)(105586002)(186003)(6506007)(118296001)(2501003)(102836004)(478600001)(76176011)(2900100001)(26005)(4326008)(7736002)(71200400001)(71190400001)(486006)(3846002)(6116002)(11346002)(97736004)(476003)(2616005)(305945005)(66066001)(44832011)(446003)(86362001)(68736007)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4691;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 89dRyK4gVKJkmVirB7f6KbnymFb+G65dU1k6KX3IzZwZYJcF67kRGbiRuVJSZvlC1LDxqh2UfBrBRlgoGWDNitf2qcMJPdIU/05VCR8O/7tml/hEvX3xyO4wJ5uZa4uNdTIe2DZXx6/jDFlVqFMA+ZVw4iaSIUKp9MV2i4U5H/9V2zdhG1VDusa8okN1nWAZ7oHW5Ie+YdBKWWK4DTG3hvsmZ/K3lXaxI7GmUCPdd1VUCikpvwEFaBFXsMjkvP2PmpmRis10Y7PtZ9c5d4ZJm0Yo+1Kx5XTbNT+w/1ogXwhznBzknbipRz7JYs9MtLxyBYztxiQxefr6DW1ZHotWjcduUc9xSKFrzU08iWXuG5s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C3958D76A449428EE4F9D98FB3AEAE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9effec-6c89-452b-d79a-08d64ae6a860
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 10:39:44.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDE3OjIxIC0wNTAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
RnJvbTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gDQo+IFsg
VXBzdHJlYW0gY29tbWl0IDFhZDlmYjc1MGExMDRmNTE4NTFjMDkyZWRkN2IzNTUzZjAyMTg0Mjgg
XQ0KPiANCj4gQmluZGluZ3MgZm9yICJmaXhlZC1yZWd1bGF0b3IiIG9ubHkgZXhwbGljaXRseSBz
dXBwb3J0ICJncGlvIiBwcm9wZXJ0eSwNCj4gbm90ICJncGlvcyIuIEZpeCBieSBjb3JyZWN0aW5n
IHRoZSBwcm9wZXJ0eSBuYW1lLg0KPiANCj4gVGhlIGVuZXQgUEhZcyBvbiBpbXg2c3gtc2RiIG5l
ZWRzIHRvIGJlIGV4cGxpY2l0bHkgcmVzZXQgYWZ0ZXIgYSBwb3dlcg0KPiBjeWNsZSwgdGhpcyBj
YW4gYmUgaGFuZGxlZCBieSB0aGUgcGh5LXJlc2V0LWdwaW9zIHByb3BlcnR5LiBTYWRseSB0aGlz
DQo+IGlzIG5vdCBoYW5kbGVkIG9uIHN1c3BlbmQ6IHRoZSBmZWMgZHJpdmVyIHR1cm5zIHBoeS1z
dXBwbHkgb2ZmIGJ1dA0KPiBkb2Vzbid0IGFzc2VydCBwaHktcmVzZXQtZ3Bpb3MgYWdhaW4gb24g
cmVzdW1lLg0KPiANCj4gU2luY2UgYWRkaXRpb25hbCBwaHktbGV2ZWwgd29yayBpcyByZXF1aXJl
ZCB0byBzdXBwb3J0IHBvd2VyaW5nIG9mZiB0aGUNCj4gcGh5IGluIHN1c3BlbmQgZml4IHRoZSBw
cm9ibGVtIGJ5IGp1c3QgbWFya2luZyB0aGUgcmVndWxhdG9yIGFzDQo+ICJib290LW9uIiAiYWx3
YXlzLW9uIiBzbyB0aGF0IGl0J3MgbmV2ZXIgdHVybmVkIG9mZi4gVGhpcyBiZWhhdmlvciBpcw0K
PiBlcXVpdmFsZW50IHRvIG9sZGVyIHJlbGVhc2VzLg0KPiANCj4gS2VlcCB0aGUgcGh5LXJlc2V0
LWdwaW9zIHByb3BlcnR5IG9uIGZlYyBhbnl3YXkgYmVjYXVzZSBpdCBpcyBhIGNvcnJlY3QNCj4g
ZGVzY3JpcHRpb24gb2YgYm9hcmQgZGVzaWduLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMgZXhwb3Nl
ZCBieSBjb21taXQgZWZkZmViMDc5Y2MzICgicmVndWxhdG9yOiBmaXhlZDoNCj4gQ29udmVydCB0
byB1c2UgR1BJTyBkZXNjcmlwdG9yIG9ubHkiKSB3aGljaCBjYXVzZXMgdGhlICJncGlvcyIgcHJv
cGVydHkNCj4gdG8gYWxzbyBiZSBwYXJzZWQuIEJlZm9yZSB0aGF0IGNvbW1pdCB0aGUgImdwaW9z
IiBwcm9wZXJ0eSBoYWQgbm8NCj4gZWZmZWN0LCBQSFkgcmVzZXQgd2FzIG9ubHkgaGFuZGxlZCBp
biB0aGUgdGhlIGJvb3Rsb2FkZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGF3biBHdW8g
PHNoYXduZ3VvQGtlcm5lbC5vcmc+DQoNClRoaXMgaXMgc29tZXRoaW5nIG9mIGEgd29ya2Fyb3Vu
ZCBmb3IgZ3BpbyBjb3JlIGNoYW5nZXMgaW4gNC4yMCBhbmQNCnRoZXJlIGlzIG5vIG5lZWQgZm9y
IGl0IGluIG9sZGVyIHJlbGVhc2VzLg0KDQpJIGRvbid0IHRoaW5rIHlvdSBzaG91bGQgYmFja3Bv
cnQgdGhpcy4NCg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
