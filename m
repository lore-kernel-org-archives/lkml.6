Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92DC65C22
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F262A20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GT774ZZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJHRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:54:10 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:25376
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbeJHRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EObf8ZYHmch7CHvCgSOTBSrxPxdgKie7v2ZEIovj6wI=;
 b=GT774ZZh/ScVzpeJ182ZhngJtr1kjdCGt9Q4rOBUfnwmyBccR6JG9sL9HIdhJyUioNh2/DBxI5NE6pBx071GyfHRJnah64uvFqRdP1geNH0hJvNcE42YqZznfF/KhPuoNrMBc8aVSwAjboQU4llbFYN/t5YpJ/WYXsYmZoHyOLE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.126.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Mon, 8 Oct 2018 10:43:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::25a0:3167:d718:91c1%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 10:43:01 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHUQOYAqzg0fl5c6km76P92aepQ6qTin9AQgBBfjVCABM4uAIAAv5kggBzYKaA=
Date:   Mon, 8 Oct 2018 10:43:01 +0000
Message-ID: <AM0PR04MB42119BD28DDB7826DEE577F180E60@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
 <AM0PR04MB4211B170CAC1B3F9E7356AF980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211B170CAC1B3F9E7356AF980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4337;6:3na37N/kH32MxdZxHi07JQC0SZ0WCQehYNzZolzN4syYECprtdpmnX23fzvuIm+EB/Iv2rvsoifV+2PpNZ9OaF0FM+4fL8hKz2wwTDCm6DwFjw4Y9Se0WOCcpdSll8eHTYfmqMsUhYdI1+0Ln0AU1jK8ejj0lgXYogOrvlPdcfPup908ds38+S2RI1Phje27+0qa91RGm6eB4H20tMHziuwUB51hJR/fYjM/gtuT/TqnNgq/xwq7BWlMK0wnGx3glGMvneefKm0ZfEHmeuMMvBoAlaVbk+M8KcbMJSbb2Uv6YZNAtE+17/UM75ctAVCsSggQqP3rbzR/Se+dSsLnVhnjfCDNzo31PW14d7vnsPZhrILMs/srCgi93Cq35Zf/qIn0b8ttUTz/WcxwspT3Y0E4326jMKI6qNr2x1kigXgNLGAtzG2HIjxAa4mjvEHbMF6D2XecAKRrvAhqq5Y5tQ==;5:Dto6BBVYe8RcNsnL32SrYc4sDoGPcpgPCXlLZhrwFVyNo/4ImPW+Jz5OdUOtJiZVXBd/FTrSaLMqynpvxLaVM0NTxnkmVJocHRCxUTjrtANMy0iiB09IiC529tC8pkQWIyWQPtzGzaoU1lb55IviM8QcC4hcZQcaIWEav9ZIYrM=;7:Wpqv44kJBi+NjaQ5bwXxjbizJSq+8vxIT4YebgfXkThk8geI15isKdMoS/bJg7lHZzZb7d1gnp1j82n9yW6hhK3Ip091vATPbHDbTm7VA2HBlw6HjrzIscJzcWHU/nMGyGFx+wdmyMfal6K0CJpoIZ/i5EkPDHwsF8NlfxX9n3J2wG1i05bmWCiepzcozaLmypSoaQ4obg/vs/XXXNF67KSjqIl17gDeSxiQUg7VTTyzny+iBoMhwTmvSbeb4oHE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9ef37f3b-104f-4a46-7a2d-08d62d0ad1e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4337;
x-ms-traffictypediagnostic: AM0PR04MB4337:
x-microsoft-antispam-prvs: <AM0PR04MB4337B363FDA8D53FF872C7DA80E60@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4337;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4337;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(2501003)(25786009)(8676002)(256004)(6436002)(478600001)(3846002)(6116002)(99286004)(2906002)(8936002)(105586002)(229853002)(110136005)(2900100001)(33656002)(54906003)(81156014)(81166006)(71200400001)(71190400001)(5250100002)(106356001)(5660300001)(93886005)(305945005)(7736002)(66066001)(6506007)(102836004)(68736007)(6246003)(186003)(26005)(7696005)(86362001)(97736004)(486006)(4326008)(53936002)(476003)(9686003)(55016002)(11346002)(76176011)(2201001)(316002)(446003)(14454004)(74316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yat/+7w22JmXvNhfTGVLVWwm7+AB8jPNbk955loxq/A3UG/OnoU50yXDScDjiM4n4NepuzcTanPtWVY1k/QNU34IrQL8ra2QYZh/wZas7cQIIl38f/ihFGihVzOFCKQkUeJ5t5PIcACBwikozujOnReCiH2OyEspDXUgHjjJTIlds3TNREVf7UqLVXFrs+MTt34/7CJWitGftIME62MTzcJ1J5DXKB61THzw+ErWr0Mozk56oa4JNZTJhNM0/7n30jJgqYE0h/714lvtYH/RwRmDKSS7SB/vqG/KtpgK42Ju3QPLXRIOBShOu1S3C1XHvpkGXRCXYif0H3CnfEyXoauiKufBBGOe4paVXp5ju4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef37f3b-104f-4a46-7a2d-08d62d0ad1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 10:43:01.3266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KR2VudGx5IHBpbmcgYWdhaW4uLg0KDQo+ID4gPg0KPiA+IEp1c3QgY2hl
Y2tpbmcgb24gdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoLiBUaGUgY2xvY2sgcm91dGluZXMgKHBh
dGNoZXMNCj4gPiAxLTMpIGFyZSB1c2VmdWwgZm9yIG9uZSBvZiBteSBkcml2ZXJzIGJ1dCBpZiB0
aGV5IGFyZW4ndCBhY2NlcHRlZCBvcg0KPiA+IHdpbGwgdGFrZSBhIGxvbmcgdGltZSB0byBiZSBh
Y2NlcHRlZCwgSSdsbCBuZWVkIHRvIHJlZmFjdG9yIG15IGRyaXZlci4NCj4gPg0KPiANCj4gVGhh
bmtzIGZvciB0aGlzIGluZm9ybWF0aW9uLg0KPiANCj4gU3RlcGhlbiwNCj4gV291bGQgeW91IGhl
bHAgdG8gcHJvY2VlZCB0aGlzPw0KPiANCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQo=
