Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8901FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3564E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P2/Q7M01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3564E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeGYKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:24:49 -0400
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:36859
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeGYKYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBrNTJwpPs9HRkQY/nDBC0wZFbziZYp545M0AboneIA=;
 b=P2/Q7M01HMrIZoIrTILqdlHJmhEVc/C6h+t9Li1/XsSVgIaSK9/35pwi8snBrYZUAAhd1yB0wCHP6e+kjc/oJchr6fLQQkshMbeDwXLcbK7P3GpXU99oX4OGqH8jhNEJirNeQWX7RUXVo6PLMIWLNhTpWixgfVJWcx7XSA9gIrk=
Received: from CY1PR02MB1692.namprd02.prod.outlook.com (10.162.161.26) by
 CY1PR02MB1753.namprd02.prod.outlook.com (10.162.165.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 09:13:58 +0000
Received: from CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95]) by CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95%3]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 09:13:58 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <navam@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Thread-Topic: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Thread-Index: AQHUI1kdQYf467r9ZE6tdqpx/KPVD6SeuD8AgADwUYA=
Date:   Wed, 25 Jul 2018 09:13:57 +0000
Message-ID: <CY1PR02MB16921C8D66930128BAF104B4DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
In-Reply-To: <CANk1AXQ7RH6gwjNMQSXJZ=wCrwTGZ+T6uVgOsb6N+YJ2Y6zR8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1753;6:x7e+dtJAw36V3snjT2NUgoAiv3+UBihSFJ+kkKTbb2CHSrCCFZXAC1guW2iruhUip/tTF2nmG/QhWfVObCbeXkzdAj8uhPpEGOWanBP6TnWVBVhfMM/69Wu1AeVx9GKT6dj9hZpVE9CMcpsDKi3TgSQTIZvullXK53PKkOPeJ2bdRY4GERBXziP8jCj3Cno7+ARwcaziuzlWw8QyPFusK3xShcS6A+Lt/gaR8Dtrt38HgH60vFrQvYfMmKa99p12zrZwDVFEiDh55ZdEun4ISNmyVWLM4wZ/4kJ7AlQLtgc4OIIHFs+AjzhPjobbldPoCB0JTA+vWN7RW/q9B1sogFxczy0iId+Xs6jPND5VKAuHI5j73K9haR8zz9JqlXhDyBREOIbNrbx/TZnvjHOFKhfh5pdi25ykZCy4QCWVJ4lfY5q/f/9cmkAP30N7HNNcXPTjsoBOgOL5YSAFlk1dEg==;5:Q0gfJjAvebFDs2U+A0GXPHSxehW9KkeWuGW9Nk7gqODWhkCHGsWQfXU7Jkhaj30JfjVODCkIlRDPl1lpUVZSZU90yxxKfYqmN+CnfbmuDI6LruHa5g846iwqjKr7KBuB8TZQBjM7zLQGXJVRO+tkOSDfN5oGsJchtVOtd4XRfuA=;7:rb0hdHwWp7gH8W98ShwQ31g9M84Myv1/cHD5z4gvyaqfQ77fO4P/ZlxctroXCW0E3SyCiXJHjgae+6KHd5DFwKE5t97BEGGIvoTIpu0aAyXqo1Yz+L3dWr6p9nxNTXHsPsV8CAFJ5U6aemBkK8nqr1JdzkO5UelDZiGHVGsYafUrg2W3mJBwcG64NG4r+KbKyeroVl4GnRZMlDlr1LOVZwiOcEZXWmvqBe7CnGZ9TofkHtp0InS7qQ3rJ6CZRZ/4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 22baf4f6-93e6-4c20-8583-08d5f20ef404
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1753;
x-ms-traffictypediagnostic: CY1PR02MB1753:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CY1PR02MB1753E4505E1A04D2DC7C3FEBDC540@CY1PR02MB1753.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1753;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1753;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(51914003)(189003)(199004)(25786009)(55016002)(81166006)(66066001)(81156014)(8936002)(33656002)(74316002)(305945005)(106356001)(5250100002)(478600001)(105586002)(8676002)(7736002)(54906003)(53936002)(229853002)(99286004)(3846002)(4326008)(6246003)(2906002)(316002)(86362001)(6436002)(486006)(256004)(9686003)(6116002)(5660300001)(102836004)(446003)(11346002)(476003)(14454004)(76176011)(2900100001)(55236004)(68736007)(7696005)(6506007)(26005)(6916009)(97736004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1753;H:CY1PR02MB1692.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kPVS4rHK6nV0783hmB8TEEdaxSTMHebAtiy/3Okauc3MKmdecoZ0yxf8A43vjDBdUrc29fff6ySqydzgtQK7Ux7Y040F1nYoswrO+B6q+HSW381uANjjxdMfItNMj+YbJOBh3wCDXCnG+s5JKd+K3Zn4hdxfHrw1/k3LDrtOc/kZXVXu1Nsts6aJRJgtISBiDvGBHJTinBkPBkLL7zndCbH2RBNBSiPvkf/ilEXwezw8WIzyefL3mDvrovR7HwPyQ5fyNgK8YviE6zkObsMjDFdTWkBfIbKBY89HM0yOQudnBzhW1zGXz7+gymHLngMQ6rxsfYNTC5qyadhosSt9kOggS1r60RVwpA1W8bsYjoA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22baf4f6-93e6-4c20-8583-08d5f20ef404
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 09:13:57.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KCVRoYW5rcyBmb3IgdGhlIHJldmlldy4uLg0KDQo8U25pcD4gDQo+IEFub3Ro
ZXIgbWlub3IgdGhpbmcuDQo+IA0KPiA+ICsNCj4gPg0KPiArLyoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+ICoqKioqKg0KPiA+
ICsqKioqKioqKi8NCj4gDQo+IExldCdzIGtlZXAgdGhlIGNvZGluZyBzdHlsZSBjb25zaXN0ZW50
IGJ5IG5vdCBoYXZpbmcNCg0KU3VyZSB3aWxsIGZpeCBpbiB2NC4uLg0KDQo+ICcqKioqKioqKioq
KioqKioqKioqKioqKioqKionDQo+IA0KPiA+ICsvKioNCj4gPiArICoNCj4gDQo+IEFsc28sIHlv
dSBkb24ndCBuZWVkIC8qKiBmb2xsb3dlZCBieSAnKicsIGp1c3QgdGFrZSBvdXQgdGhlIGVzc2Vu
dGlhbGx5IGJsYW5rDQo+IGxpbmUgaGVyZSwgcGxlYXNlLg0KDQpTdXJlIHdpbGwgZml4IGluIHY0
Li4uDQoNClJlZ2FyZHMsDQpLZWRhci4NCg0KPiANCj4gPiArICogR2VuZXJhdGVzIGEgVHlwZSAy
IHBhY2tldCBoZWFkZXIgdGhhdCByZWFkcyBiYWNrIHRoZSByZXF1ZXN0ZWQNCj4gPiArQ29uZmln
dXJhdGlvbg0KPiA+ICsgKiByZWdpc3Rlci4NCj4gPiArICoNCj4gPiArICogQHBhcmFtICAgICAg
ICBPcENvZGUgaXMgdGhlIHJlYWQvd3JpdGUgb3BlcmF0aW9uIGNvZGUuDQo+ID4gKyAqIEBwYXJh
bSAgICAgICAgU2l6ZSBpcyB0aGUgc2l6ZSBvZiB0aGUgd29yZCB0byBiZSByZWFkLg0KPiA+ICsg
Kg0KPiA+ICsgKiBAcmV0dXJuICAgICAgIFR5cGUgMiBwYWNrZXQgaGVhZGVyIHRvIHJlYWQgdGhl
IHNwZWNpZmllZCByZWdpc3Rlcg0KPiA+ICsgKg0KPiA+ICsgKiBAbm90ZSAgICAgICAgIE5vbmUu
DQo+ID4gKyAqDQo+ID4gKw0KPiA+DQo+ICsqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gKioqKioqDQo+ID4gKyoqKioqKioq
LyBzdGF0aWMgaW50IHp5bnFfdHlwZTJfcGt0KHU4IE9wQ29kZSwgdTMyIFNpemUpIHsNCj4gDQo+
IFRoYW5rcywNCj4gQWxhbg0K
