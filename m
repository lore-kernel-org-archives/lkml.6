Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E362C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0652208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NS+ITn/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0652208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbeGLEOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:14:33 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:62440
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725748AbeGLEOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koARTjksy1ORxyg58FT1AG/nGxl6tLJBi780AwOzSvg=;
 b=NS+ITn/H5Qvp1gl935kc3nSMvTPIlFK9AVQLFzSuRC2B3AWRR/IvGd8a/lSy4F1/Nlc9vVP2q+814Ukbe+wrTO0AiNxwfOmpbqk4eShvBBbpvo9e2Ft1w7WdvzE9jXzLgp+Nq1BoXwMaNfnCNSjZ5/FLYtr9cZdbTrTuJKrplQ8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5156.eurprd04.prod.outlook.com (20.177.40.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 12 Jul 2018 04:06:49 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 04:06:49 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Topic: [PATCH V4 3/5] mailbox: imx: add imx mu support
Thread-Index: AQHUFsxVRb7g/AGotk2h6FoTYgzkeKSIhHsAgAEHGTCAAB+9AIAAGVgwgAAV8QCAAB88IIAAQe4AgAABAxCAAAb7AIAAucyg
Date:   Thu, 12 Jul 2018 04:06:49 +0000
Message-ID: <AM0PR04MB42112EEF9BC36AD54C1B90CC80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
 <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
 <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0XQwXjVUMiXcqFVVCTR2jRWA343d220LqBYmTp+s6J1Q@mail.gmail.com>
In-Reply-To: <CABb+yY0XQwXjVUMiXcqFVVCTR2jRWA343d220LqBYmTp+s6J1Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5156;7:uzfnXhHGjFfEfHBp0viEV60iFuYiuzEbdep2qO03neNHscRe8bRtJZvHufm0ZiKBV+eKxhzjCJ2eJwcXuj41V8AnHjWRfoVr+Srh9bEqJCLUUZYtlbQ72iw6duXspx+dzPP4JN7DTI/hg1SWAA0lLN4Y+tjRuaoCy4dTtYw5cGxYqJc7IXgwe4Sj5PFIwYUXsRVxkRLX4eTxQmcT97pJabpOfvc0EDcjBpvxmMmH5W8XQlZbTHQnWnwEtw1dzJJo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a6c2338a-da84-46db-b117-08d5e7ace44e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5156;
x-ms-traffictypediagnostic: AM0PR04MB5156:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB51565ABEE6136B77934F725580590@AM0PR04MB5156.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5156;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5156;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(13464003)(55016002)(66066001)(476003)(478600001)(74316002)(86362001)(305945005)(14454004)(2906002)(486006)(39060400002)(5250100002)(446003)(9686003)(33656002)(5660300001)(11346002)(7736002)(6116002)(4326008)(53936002)(25786009)(106356001)(6246003)(105586002)(3846002)(81156014)(186003)(76176011)(8676002)(7696005)(2900100001)(26005)(1411001)(102836004)(316002)(81166006)(8936002)(15650500001)(6506007)(256004)(93886005)(54906003)(53546011)(99286004)(6916009)(97736004)(6436002)(68736007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5156;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JpMWjs8hVaIY01/sX4r4oL/bKl+3DQuQISMtBaRxfpzo5Sh8KNFy9oECnXIS3HDIUZrrpM1Cm1EJuAkZ1nPph8XvCU7KtrjCefqtmV2pemYcbEJ8QGqhULc6Ihsae5qfsDpvKAKEpWtiyH2XWzCa2h6v5R55XDjm5T7zCf4KP9JXMOdi/zYEVtR+sIcgFz+tQhVUo/HbidePbIfQcAU7O98RVpcZJpGHCKKqi9piJ6bAbGhNeKEZe+kDqSYtOSvgmD23t4D3/EAh6GLPE6b3ADSgNYDP/L27hqvwIwhoM30yTCc8jQ9dUQ+10H0AqRPML0GZ3ym3h4ll9ShFUmaGZtzSoOfmITrsVtNlcRZy/oM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c2338a-da84-46db-b117-08d5e7ace44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 04:06:49.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzc2kg
QnJhciBbbWFpbHRvOmphc3Npc2luZ2hicmFyQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXks
IEp1bHkgMTIsIDIwMTggMTowMSBBTQ0KPiBUbzogQS5zLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhw
LmNvbT4NCj4gQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IGxpbnV4
LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRvbmdhczg2QGdtYWlsLmNvbTsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBl
bEBwZW5ndXRyb25peC5kZT47IGRsLQ0KPiBsaW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtDQo+IDxmYWJpby5lc3RldmFtQG54
cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMy81
XSBtYWlsYm94OiBpbXg6IGFkZCBpbXggbXUgc3VwcG9ydA0KDQouLi4uDQoNCj4gPg0KPiA+IGJj
bSBzZWVtcyBpcyB1c2luZyBwZWVrIHRvIHJlY2VpdmUgZGF0YSwgbm90IG9ubHkgY2hlY2tpbmcg
dGhlIGRhdGENCj4gPiBhdmFpbGFiaWxpdHksIHJpZ2h0Pw0KPiA+IGRyaXZlcnMvbWFpbGJveC9i
Y20tZmxleHJtLW1haWxib3guYw0KPiA+DQo+IEFzIEkgc2FpZCwgaWYgZmV0Y2hpbmcgZGF0YSBm
cm9tIHJlbW90ZSBkb24ndCBuZWVkIHRvIHNsZWVwLCB5b3UgY2FuIGNhbGwNCj4gbWJveF9jaGFu
X3JlY2VpdmVkX2RhdGEoKSBmcm9tIHBlZWsoKS4gT3RoZXJ3aXNlIG5vdC4NCg0KR290IGl0LiBT
byBpdCBzZWVtcyB3b3JrIGZvciBpLk1YLg0KVGhhbmtzLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hl
bmcNCg==
