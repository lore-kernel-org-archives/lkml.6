Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E3BF7C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F441208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DbcLlrwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F441208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935648AbeFNMR5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:17:57 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:26976 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755057AbeFNMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:17:54 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 14 Jun 2018 21:17:52 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 8072085D1D;
        Thu, 14 Jun 2018 21:17:52 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="282531411"
Received: from mail-ty1jpn01lp0178.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.178])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2018 21:17:52 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoc8p+oIyk3ESDb9FrLWG4+FbpsIovNWTEE7fiRjkM=;
 b=DbcLlrwVZoTfKqT6/GwFP1adWyKAE3ZVJ+WG6Bqvz80nvKAkhUs7qPOR6nirwfqwPRFWRnJena9a7LzFPW0nZ8MNU+WhGxtyU2QHrru4kvRIKAUZt8ZjW2HcxxKilbHd5JvssqCUGqYxo6mUKHG7vRLmwOVeqYSqFV7af34Hh7s=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB1643.jpnprd01.prod.outlook.com (52.133.163.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Thu, 14 Jun 2018 12:17:49 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d5ba:9747:d01f:427c]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d5ba:9747:d01f:427c%4]) with mapi id 15.20.0841.021; Thu, 14 Jun 2018
 12:17:49 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Michel Pollet <michel.pollet@bp.renesas.com>,
        jacopo mondi <jacopo@jmondi.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: clock: renesas,r9a06g032-pinctrl:
 documentation
Thread-Topic: [PATCH v1 2/5] dt-bindings: clock: renesas,r9a06g032-pinctrl:
 documentation
Thread-Index: AQHUA8+zMzbWyT/5OUi6AQCRVUOzeKRfqCYAgAABmACAAADaMA==
Date:   Thu, 14 Jun 2018 12:17:49 +0000
Message-ID: <TY1PR01MB1562D22174BA4043858DFF248A7D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
 <20180614120446.GA12638@w540>
 <OSBPR01MB2054FBD2836B478B83D96C9CD27D0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2054FBD2836B478B83D96C9CD27D0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1643;7:iDYzsTWWt2oqZNMUzPMnrNtANuKOznfobh+K0yldeKBJjgojxXg5PLndClSxaZnXYszqdXCnO9kl5srBFwbeETJCpDHF69ezL5Z7GWcAqcK529zq7rHtljPmgd2ejxV5jSJbupVbiSU/z8DjNSIy+sJfEPZkXGvKN4Zokuwmc2yet7sZ/uQKiCeNftnmnhq1G1c2j6po5PqtmPcajsyGgcVLJW+ibepnZwpKc54eZVAo5JnYZbNHmPqjQc4gYUWc;20:J8dTH7TcV89kDjSHlowea/DmHKihpcrwyZmeU1NplNIkeHFh0aCvmC8UMfK6kXobTs93FjIxfJsxHGdV0AedT0sIb5cnMD+UiP6phhR7GFN1Dvpx/h7VPOMbWwtDZbr4hD4cxl5PEL3Z5DeXGMrPpCqHiur0vbw7ZV2fzQLhAi4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52765dcd-c99c-41d5-4796-08d5d1f0d885
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1643;
x-ms-traffictypediagnostic: TY1PR01MB1643:
x-microsoft-antispam-prvs: <TY1PR01MB16437C26DACCE9A9B9B3F9C48A7D0@TY1PR01MB1643.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1643;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1643;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(199004)(189003)(14454004)(6246003)(110136005)(54906003)(7736002)(305945005)(68736007)(229853002)(97736004)(93886005)(74316002)(7416002)(5250100002)(9686003)(486006)(5660300001)(106356001)(446003)(99286004)(2906002)(105586002)(53936002)(11346002)(476003)(3280700002)(72206003)(316002)(66066001)(8936002)(6506007)(2900100001)(3846002)(6116002)(26005)(478600001)(25786009)(3660700001)(86362001)(6436002)(55016002)(8676002)(81166006)(81156014)(76176011)(102836004)(33656002)(39060400002)(7696005)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1643;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tuGZkPyUxQcSFagTEPErHOswx8Z/rbfLnKOfIisWOjt6cLavDTpHY4bhaLXqbTkA9bgk6pOpeqQ2DXt0wrVn0jZrTsnmh/grUBO1/jYMLZun/+jJza+iwiSxNegS1JpZigTjon3ErJ1RsBXKH1nXRTgBRD6kTpzt7ORCnXZ6w+NFVDDR4Y0jkWh0xM8xZIfb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52765dcd-c99c-41d5-4796-08d5d1f0d885
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 12:17:49.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIEp1bmUgMTQsIDIwMTgsIE1pY2hlbCBQb2xsZXQgd3JvdGU6DQo+ID4gRnJv
bSBhIHZlcnkgc3VwZXJmaWNpYWwgbG9vayBhdCB0aGUgcHJvcG9zZWQgYmluZGluZ3MgYW5kIHBp
bmN0cmwgZHJpdmVyLA0KPiBJDQo+ID4gd29uZGVyIGlmIHRoZSByemExIHBpbmN0cmwgZHJpdmVy
IGNvdWxkIGJlIGV4cGFuZGVkIGFuZCByZS11c2VkLg0KPiA+IEhhdmUgeW91IGNvbnNpZGVyZWQg
dGhhdCBiZWZvcmUgc3RhcnRpbmcgb25lIGZyb20gc2NyYXRjaD8NCj4gDQo+IFNvcnJ5IGl0J3Mg
anVzdCB0aGUgc3RhcnQgb2YgdGhlIGRvY3VtZW50YXRpb24gd2hpY2ggSSB3cm9uZ2x5IGN1dC9w
YXN0ZWQNCj4gLS0gdGhlDQo+IHJlc3QgaXMgY29tcGxldGVseSBkaWZmZXJlbnQ7IHRoZSBvbmx5
IHJlYXNvbiBBMSBpcyBtZW50aW9uZWQgaGVyZSBpcyB0aGF0DQo+IEkgdXNlZA0KPiB0aGF0IGZp
bGUgYXMgYSB0ZW1wbGF0ZSBmb3IgdGhlIGhlYWRlci9zZWN0aW9ucyBldGMuLi4gU29tZWhvdyB0
aGUNCj4gdGl0bGUrYmx1cmINCj4gd2VudCB1bmVkaXRlZCENCg0KUGhldyENCg0KSSBjYW4ndCBz
dGFuZCB0aGF0IHBpbmN0cmwgSFcgaW4gUlovQTEuDQoNCkkgaG9wZSBubyBvdGhlciBTb0MgZGVz
aWduIHRlYW0gdXNlcyB0aGF0IHRoaW5nIGFnYWluLg0KDQoNCkNocmlzDQoNCg==
