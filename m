Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04FAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="L9m7LoCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEE320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIJOre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:47:34 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:45268 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727353AbeIJOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:47:34 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 10 Sep 2018 18:54:18 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id A026C7DA87;
        Mon, 10 Sep 2018 18:54:18 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,355,1531753200"; 
   d="scan'208";a="292071068"
Received: from mail-os2jpn01lp0144.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.144])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2018 18:54:17 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq1X6NVLmaHdHxiPR7/qWbbe/XBoEHaNN74R8BdxFzQ=;
 b=L9m7LoCQyvF1VTHoYg4ac56pV8r/JQehWsh2ZBngNqDFc4cxMNpJE5ODTep8x2HpxHEALu5Qke9MnZwfDudIB+ekDbK9hWA/5zLL8qFg2uNSSVo6Q9qdfi9ovwQ7EUWZdu5mR2A/yWsEHlHrbwAyk+CBfqjGjmu8Bz0DsCOCMNg=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1085.jpnprd01.prod.outlook.com (10.174.225.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 09:54:14 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97%6]) with mapi id 15.20.1122.018; Mon, 10 Sep 2018
 09:54:14 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Topic: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Index: AQHUQGMu6ROdNPJdbkaf+nPyB2h7vKTeYncAgAADtzCAAxDxAIAABayQgAe35ACAAB+hAIAAAW6Q
Date:   Mon, 10 Sep 2018 09:54:13 +0000
Message-ID: <TY1PR01MB176944F61B503C4BCE7FD03CF5050@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540>
 <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
 <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
 <CAMuHMdUX2Bq+t0yaVYsz6VzX7ZNw_gf_EHc2BuaR9bZcZ=jV7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUX2Bq+t0yaVYsz6VzX7ZNw_gf_EHc2BuaR9bZcZ=jV7Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1085;20:AYi9AowB60RCuEsDCgWswplbnrJpyQNmp7ihEaBw/3AjY3ER3fRZEAyeIPu2Eits6TyuJCnHBjPvahjNTINNKWEtGFiEEW6KphNIYUfWu8TIncUrCi1oRE/+HQs+1nbbnes1znExI8lMZ5110+akmLclPRsrKUsC15ETuQPiNKQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7fe91114-cb46-4984-e16f-08d617035da3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1085;
x-ms-traffictypediagnostic: TY1PR01MB1085:
x-microsoft-antispam-prvs: <TY1PR01MB108573B4D41C2DF38ACA5DB2F5050@TY1PR01MB1085.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:TY1PR01MB1085;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1085;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(229853002)(8936002)(81166006)(81156014)(68736007)(2900100001)(5250100002)(2906002)(316002)(256004)(76176011)(54906003)(99286004)(7696005)(66066001)(5660300001)(25786009)(4326008)(110136005)(55016002)(9686003)(11346002)(93886005)(478600001)(446003)(86362001)(7736002)(53936002)(486006)(476003)(6436002)(33656002)(44832011)(6116002)(3846002)(8676002)(6246003)(7416002)(305945005)(97736004)(186003)(74316002)(106356001)(105586002)(26005)(6506007)(102836004)(14454004)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1085;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1FDXKvVGpDOBj9M0XNWPZ2IFRsSrAdi3xRFzwbQa3A0t5OwOfiYRQapYfuTtiYbZpvr2dAhF1HX6z4gB80P3zlHfbVf2Pf/Xn6J12oqUptWQWzA+BDiK8P9tZweMIKgp/rVb4AJGBBn5nvnK1kR5kyK1RLOIIfI7Ge2lhgrSFeFwtKvQmz2QK3w00N2/njpKSfcfBnhhMxx2Sx3b9emmc0MjKpQ/lNzeubwx89vnCYynxukwdqfmVEx5VFSpNSGlifa5Gp2KMr+8FWi4qqe7zkmSupnoqYRjg2px1yq5ng9CxUS1qKr66/iFsBKUQsJN7Qj1q6UhLQ+LMQw3j9l6UUHPEYXAmfN19KgWbSBtvWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe91114-cb46-4984-e16f-08d617035da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 09:54:13.9913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsIExhdXJlbnQsDQoNCk9uIDEwIFNlcHRlbWJlciAyMDE4IDEwOjQyIEdlZXJ0IFV5
dHRlcmhvZXZlbiB3cm90ZToNCj4gT24gTW9uLCBTZXAgMTAsIDIwMTggYXQgOTo0OSBBTSBMaW51
cyBXYWxsZWlqICB3cm90ZToNCj4gPiBPbiBXZWQsIFNlcCA1LCAyMDE4IGF0IDExOjU5IEFNIFBo
aWwgRWR3b3J0aHkgd3JvdGU6DQo+ID4gPiBPbiAwNSBTZXB0ZW1iZXIgMjAxOCAxMDozNywgR2Vl
cnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiA+DQo+ID4gPiA+IEhhdmUgdGhlIFZ4V29ya3MgRFQg
YmluZGluZ3MgYmVlbiBzdWJtaXR0ZWQgZm9yIHJldmlldyB0byB0aGUNCj4gPiA+ID4gZGV2aWNl
dHJlZSBtYWlsaW5nIGxpc3Q/DQo+ID4NCj4gPiA+IEknbSBub3QgaW52b2x2ZWQgd2l0aCB0aGUg
VnhXb3JrcyBwb3J0LCBidXQgSSBhbSBwcmV0dHkgc3VyZSB0aGF0DQo+ID4gPiB0aGV5IGhhdmUg
bm90IGJlZW4gc3VibWl0dGVkIGZvciByZXZpZXcuDQo+ID4NCj4gPiBXZSBoYXZlIGhhZCBvdGhl
ciBjYXNlcyB3aGVyZSBkZXBsb3ltZW50cyBvbiBvdGhlciBPU2VzIGhhdmUgYmVlbg0KPiA+IGVz
dGFibGlzaGluZyBiaW5kaW5ncyAoZXZlbiBub3QgdmVyeSBwcmV0dHkgb25lcykuDQo+ID4NCj4g
PiBFeGFtcGxlcyBpbmNsdWRlIHR5cGljYWxseSB0aGUgUG93ZXIgTWFjSW50b3NoIGFuZCB0aGUg
b3JpZ2luYWwgU1BBUkMNCj4gPiBiaW5kaW5ncy4NCj4gDQo+IFdoaWNoIHByZWRhdGVkIEZEVCBz
dXBwb3J0IGluIExpbnV4IGJ5IG1vcmUgdGhhbiBhIGRlY2FkZSwgd2l0aCB0aGUgbGF0dGVyDQo+
IHByZWRhdGluZyBldmVuIHAxMjc1Pw0KPiANCj4gV2hpbGUgSSBzZWUgbWVyaXQgaW4gY29tcGF0
aWJpbGl0eSB3aXRoIG90aGVyIGV4aXN0aW5nIE9TZXMsIEkgcHJlZmVyIG5vdCB0bw0KPiBkZXZp
YXRlIGZyb20gc3RhbmRhcmQgRFQgYmluZGluZ3MsIGlmIHRoZXkgZXhpc3QuDQo+IA0KPiBPdmVy
IHRpbWUsIHdlJ3ZlIGV2ZW4gbWlncmF0ZWQgZnJvbSBSZW5lc2FzLXNwZWNpZmljIERUIGJpbmRp
bmdzIHRvDQo+IHN0YW5kYXJkIERUIGJpbmRpbmdzLCBpbiBhbHJlYWR5IHVwc3RyZWFtZWQgU29D
IHN1cHBvcnQuDQo+IA0KPiBJZiBuZWVkZWQsIEkgZ3Vlc3MgYSBzY3JpcHQgY2FuIGJlIHdyaXR0
ZW4gdG8gY29udmVydCBEVFMgZmlsZXMgZnJvbSB0aGUgb2xkIHRvDQo+IHRoZSBuZXcgc3ludGF4
Pw0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIHRoYXQgaXMgYWxzbyBteSBwcmVmZXJlbmNl
LiBTaW5jZSBJIGhhdmUgdG8ganVnZ2xlDQplZmZvcnQgdnMuIGZlYXR1cmVzIEkgdGhvdWdodCBp
dCBiZXN0IHRvIHNlbmQgdGhlIGRyaXZlciB3aXRoIGV4aXN0aW5nIG91dC1vZi10cmVlDQpiaW5k
aW5ncyBmaXJzdCBqdXN0IHRvIHNlZS4NCg0KSSdsbCBtb2RpZnkgdGhlIGRyaXZlciBmb3IgdGhl
IHN0YW5kYXJkIGJpbmRpbmdzLg0KDQpUaGFua3MNClBoaWwNCg==
