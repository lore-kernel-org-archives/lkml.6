Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8475C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788D9208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="H7FJh5hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788D9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeLFNlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:41:40 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:3406
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbeLFNlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqQdLv41+HVMU/X62CxYUTvZ034+vlOugC26B4U2VuA=;
 b=H7FJh5hBX1GcMZGnx2/ctTBMk91KsyrZ35XcsEjLF49ouJHAKzGq+DEm3X9sEdvnEqRmzS4lFeVVqvq80FzFcihDDaUoNpKhO+NF20CAaMK3pAATG203LRoLXIexkR/ZyBk8mO8ChrDmooGPT4vclGRNj4DTMK+9mx/cYz/tJmk=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4508.eurprd04.prod.outlook.com (52.135.138.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 13:41:30 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 13:41:30 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Thread-Topic: [RFC PATCH v3 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Thread-Index: AQHUjWll5pNfGuMp3Uu4WqROtFIBpA==
Date:   Thu, 6 Dec 2018 13:41:30 +0000
Message-ID: <1544103655-104466-2-git-send-email-michal.vokac@ysoft.com>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0088.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::29) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4508;6:srdeY4qAZEUq3TMioToCopTJ05+a82d1QBobrUmlhmHGh5JArr4u0k2sSmV/072W14sbg4dS/F/YNKLygQDZG3RLK2ocgw0d8OPTdFK3/9FjVQykKKLFFKn107c/v+a0rM2K9qn8tjcQ9bsJ77g7j9k9NZUEu+WZzTOrd8FFi3MaAreYBi/grbRhfyqkCoDdsUC5T8pIjigeJDsYQn5j8fXSH7imdbmSDQyYripI5mzDAVAs0Y2z8oIv+ikgqjyuf8mVQ+XyM+s+HviSQUVDhahDZEt/D/BGPQ7wiTDGDYIjl4AwwF134pJe8iwESNdTvL3HW1SZNmITG5RXoHb517Bynp1aSbYeAz/GGtQ6wOVVBz/9oefKarUCljIDnAFnc91jhpKesXXh8qujQY6qHIH1AfxjN6iKfUihc+6L0C8nsSHHHNMOWELxxkun3cd+ul8FQTstbG9WmD/UE1qKPw==;5:Zn2MtpSZ39WtpVJB7J8tElXQKaUHmhUIqtvMhu7Zn0U1cr8AhK19Cms4q1cIzMtu/83fsKmd8kanwdj/MVPb4+S9lEmV5hAtM6G0Ut8I4bQL0nXfnKuHC9d9Dm9tu/8hHaWFlX6LD2xdB4fvpNTs2KLllOa7U6wq5meaCygh8tg=;7:QPZ/FvWVPtnawkIpff6wowGiDogkCCVkA1KSy5fhn67O/INLZMxyUZmkaAdh+XYWmQjFavLO5tn3WFLRygqzPlw5Y5VR5p0Ruh1A5A1+VJLiI+fA6x7YjG7Y5o91+QZkklK5kCVELa9d3YGLGLYmbw==
x-ms-office365-filtering-correlation-id: e2b95cd4-c218-4020-61c5-08d65b808766
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4508;
x-ms-traffictypediagnostic: DB7PR04MB4508:
x-microsoft-antispam-prvs: <DB7PR04MB4508977FAD00AA617953F8199EA90@DB7PR04MB4508.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4508;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4508;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(6506007)(26005)(2906002)(106356001)(86362001)(72206003)(105586002)(486006)(110136005)(81156014)(54906003)(8676002)(99286004)(81166006)(102836004)(5660300001)(52116002)(71200400001)(316002)(7416002)(85182001)(71190400001)(6116002)(14454004)(53936002)(6436002)(3846002)(68736007)(66066001)(8936002)(76176011)(36756003)(386003)(97736004)(2616005)(14444005)(6486002)(6512007)(476003)(256004)(575784001)(305945005)(217873002)(478600001)(39060400002)(11346002)(4326008)(107886003)(446003)(7736002)(25786009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4508;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zk90pTqkMroDrgxs1MBTlOsvP1jFfDu+CYJuYaviMLfRizG7F1uVDY5cpFDDAed2iBnM//9yPPCYE/N7FBMHNodHkP3ZQNox1CIHkcWFVoJqkyKzQJF2to84fIyFBdDcTa5xv/FkOZh1CvX+AJftt6RhqSYDPZikX82KnsRzYJikahXKl0S7IYnc5NkRsDIetIZrQuwrCZhNQxNSbufbdKOh5++egcos6PAK1u9/NAXcAy7IBcv6AAlJ26B2gLEFTKMGJEjPHoFGuVC+8LPW/e8Ala2CCJ92lEjfliczaWG7rmY8KU+AN1FBUVWasvoNrniGR9htdRe0VhjSndClQNMbVfQCy4/OMzet4rV766Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B241A74FC2BAC4EB00F74AB4C4D31C8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b95cd4-c218-4020-61c5-08d65b808766
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 13:41:30.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3V0cHV0IG9mIHRoZSBQV00gYmxvY2sgb24gaS5NWCBTb0NzIGlzIGFsd2F5cyBsb3cgd2hlbiB0
aGUgYmxvY2sgaXMNCmRpc2FibGVkLiBUaGlzIGNhbiBjYXVzZSBpc3N1ZXMgd2hlbiBpbnZlcnRl
ZCBQV00gcG9sYXJpdHkgaXMgbmVlZGVkLg0KV2l0aCBpbnZlcnRlZCBwb2xhcml0eSBhIGR1dHkg
Y3ljbGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIGxldmVsIG9uDQp0aGUgb3V0cHV0LiBOb3cs
IHdoZW4gUFdNIGlzIGRpc2FibGVkIGl0cyBvdXRwdXQgaW5zdGFudGx5IGdvZXMgbG93DQp3aGlj
aCBjb3JyZXNwb25kcyB0byBkdXR5IGN5Y2xlID0gMTAwJS4NCg0KVG8gZ2V0IGEgdHJ1bHkgaW52
ZXJ0ZWQgUFdNIG91dHB1dCB0d28gcGluY3RybCBzdGF0ZXMgb2YgdGhlIFBXTSBwaW4NCmNhbiBi
ZSB1c2VkLiBDb25maWd1cmUgdGhlIHBpbiB0byBHUElPIGZ1bmN0aW9uIHdoZW4gUFdNIGlzIGRp
c2FibGVkDQphbmQgc3dpdGNoIGJhY2sgdG8gUFdNIGZ1bmN0aW9uIHdoZW5ldmVyIG5vbi16ZXJv
IGR1dHkgY3ljbGUgaXMgbmVlZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8
bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2MzoNCiAtIFNsaWdodGx5
IGRpZmZlcmVudCBkZXNjcmlwdGlvbiBvZiB0aGUgcGluY3RybCBhbmQgcHdtLWdwaW8uDQoNCkNo
YW5nZXMgaW4gdjI6DQogLSBEbyBub3QgdXNlIHRoZSAiZGVmYXVsdCIgcGluY3RybCBzdGF0ZSBm
b3IgR1BJTy4NCiAtIFVzZSB0d28gbmV3ICJwd20iIGFuZCAiZ3BpbyIgcGluY3RybCBzdGF0ZXMu
DQogLSBBZGQgYSBuZXcgcHdtLWdwaW9zIHNpZ25hbC4NCg0KIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wd20vaW14LXB3bS50eHQgfCA0OSArKysrKysrKysrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtcHdtLnR4dA0KaW5kZXggYzYxYmRmOC4u
MmE1NTViNiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vaW14LXB3bS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vaW14LXB3bS50eHQNCkBAIC0xNCw2ICsxNCwxNiBAQCBTZWUgdGhlIGNsb2NrIGNvbnN1bWVy
IGJpbmRpbmcsDQogCURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9j
ay1iaW5kaW5ncy50eHQNCiAtIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBwd20g
Y29udHJvbGxlcg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBwaW5jdHJsOiBGb3IgaS5N
WDI3IGFuZCBuZXdlciBTb0NzLiBVc2UgInB3bSIgYW5kICJncGlvIiBzcGVjaWZpYyBwaW5jdHJs
cw0KKyAgaW5zdGVhZCBvZiB0aGUgImRlZmF1bHQiIHRvIGNvbmZpZ3VyZSB0aGUgUFdNIHBpbiB0
byBHUElPIGFuZCBQV00gZnVuY3Rpb24uDQorICBJdCBhbGxvd3MgY29udHJvbCBvdmVyIHRoZSBw
aW4gb3V0cHV0IGxldmVsIHdoZW4gdGhlIFBXTSBibG9jayBpcyBkaXNhYmxlZC4NCisgIFRoaXMg
aXMgdXNlZnVsIGlmIHlvdSB1c2UgdGhlIFBXTSBmb3Igc2luZ2xlIHB1cnBvc2UgYW5kIHlvdSBu
ZWVkIGludmVydGVkDQorICBwb2xhcml0eSBvZiB0aGUgUFdNIHNpZ25hbC4gU2VlICJJbnZlcnRl
ZCBQV00gb3V0cHV0IiBzZWN0aW9uIGJlbGxvdy4NCistIHB3bS1ncGlvczogU3BlY2lmeSB0aGUg
R1BJTyBwaW4gdGhhdCB3aWxsIGFjdCBhcyB0aGUgUFdNIG91dHB1dC4gVGhpcyBzaG91bGQNCisg
IGJlIHRoZSBzYW1lIHBpbiBhcyBpcyB1c2VkIGZvciBub3JtYWwgUFdNIG91dHB1dC4gU2VlICJJ
bnZlcnRlZCBQV00gb3V0cHV0Ig0KKyAgc2VjdGlvbiBiZWxsb3cuDQorDQogRXhhbXBsZToNCiAN
CiBwd20xOiBwd21ANTNmYjQwMDAgew0KQEAgLTI1LDMgKzM1LDQyIEBAIHB3bTE6IHB3bUA1M2Zi
NDAwMCB7DQogCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KIAlpbnRlcnJ1cHRzID0gPDYx
PjsNCiB9Ow0KKw0KK0ludmVydGVkIFBXTSBvdXRwdXQNCistLS0tLS0tLS0tLS0tLS0tLS0tDQor
DQorVGhlIGkuTVjCoFNvQyBoYXMgc3VjaCBsaW1pdGF0aW9uIHRoYXQgd2hlbmV2ZXIgYSBwaW4g
aXMgY29uZmlndXJlZCBhcyBhIFBXTQ0KK291dHB1dCwgdGhlIG91dHB1dCBsZXZlbCBvbiB0aGUg
cGluIGlzIGFsd2F5cyBsb3cgd2hlbiB0aGUgUFdNIGJsb2NrIGlzDQorZGlzYWJsZWQuIFRoZSBs
b3cgb3V0cHV0IGxldmVsIGlzIGFjdGl2ZWx5IGRyaXZlbiBieSB0aGUgb3V0cHV0IHN0YWdlIG9m
IHRoZQ0KK1BXTSBibG9jayBhbmQgaXQgZG9lcyBub3QgbWF0dGVyIHdoYXQgcG9sYXJpdHkgYSBQ
V00gY2xpZW50IChlLmcuIGJhY2tsaWdodCkNCityZXF1ZXN0ZWQuDQorDQorVG8gZ2FpbiBjb250
cm9sIG9mIHRoZSBvdXRwdXQgbGV2ZWwgaW4gUFdNIGRpc2FibGVkIHN0YXRlIHR3byBwaW5jdHJs
IHN0YXRlcw0KK2NhbiBiZSB1c2VkLiBBICJwd20iIHN0YXRlIGFuZCBhICJncGlvIiBzdGF0ZS4g
SW4gdGhlIHB3bSBzdGF0ZSB0aGUgcGluIGlzDQorY29uZmlndXJlZCBhcyBhIG5vcm1hbCBQV00g
b3V0cHV0LiBJbiB0aGUgZ3BpbyBzdGF0ZSB0aGUgcGluIGlzIGNvbmZpZ3VyZWQgYXMNCithIEdQ
SU8gaW5wdXQuIEluIHRoZSBncGlvIHN0YXRlIHRoZSBvdXRwdXQgbGV2ZWwgaXMgY29udHJvbGxl
ZCBieSB0aGUgcHVsbC11cA0KK3NldHRpbmcuIFRoaXMgc2V0dXAgYXNzdXJlcyB0aGF0IHRoZSBQ
V00gb3V0cHV0IGlzIGF0IHRoZSByZXF1aXJlZCBsZXZlbCB0aGF0DQorY29ycmVzcG9uZHMgdG8g
ZHV0eSBjeWNsZSA9IDAgd2hlbiBQV00gaXMgZGlzYWJsZWQuDQorDQorRXhhbXBsZToNCisNCism
cHdtMSB7DQorCXBpbmN0cmwtbmFtZXMgPSAicHdtIiwgImdwaW8iOw0KKwlwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfYmFja2xpZ2h0X3B3bT47DQorCXBpbmN0cmwtMSA9IDwmcGluY3RybF9iYWNrbGln
aHRfZ3Bpbz47DQorCXB3bS1ncGlvcyA9IDwmZ3BpbzEgOSBHUElPX0FDVElWRV9MT1c+DQorfQ0K
Kw0KK3BpbmN0cmxfYmFja2xpZ2h0X2dwaW86IHB3bTFncnAtZ3BpbyB7DQorCWZzbCxwaW5zID0g
PA0KKwkJLyogR1BJTyB3aXRoIDEwMGtPaG0gcHVsbC11cCAqLw0KKwkJTVg2UURMX1BBRF9HUElP
XzlfX0dQSU8xX0lPMDkJMHhiMDAwDQorCT47DQorfTsNCisNCitwaW5jdHJsX2JhY2tsaWdodF9w
d206IHB3bTFncnAtcHdtIHsNCisJZnNsLHBpbnMgPSA8DQorCQkvKiBQV00gb3V0cHV0ICovDQor
CQlNWDZRRExfUEFEX0dQSU9fOV9fUFdNMV9PVVQJMHg4DQorCT47DQorfTsNCi0tIA0KMi4xLjQN
Cg0K
