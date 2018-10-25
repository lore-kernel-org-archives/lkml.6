Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7475ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48015204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEa/NIrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48015204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJYJLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:11:52 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:63439
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbeJYJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El3cKaWS9dEksykYhOKou1qbcycVjrdAkcWrgbmf1zs=;
 b=LEa/NIrcKOOLwuoPBZltRzT0fshmf2f0x3v/CpK41D9Bchs3C9F5vOHSc2RhaKFDmshBj18HWoUVIEhIPa8N6ltMpB+DnwtLhZVhQJjM4cY4Itl3SBH6cQmSjVUeiKmsVMpgq+mqQZCWzdu6udUnSHMd28RJSRu1KpjRB80bbrs=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5532.eurprd04.prod.outlook.com (20.178.106.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Thu, 25 Oct 2018 00:40:48 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.032; Thu, 25 Oct 2018
 00:40:48 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode
 property to device tree
Thread-Topic: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode
 property to device tree
Thread-Index: AQHUao+mI3l7tN6zL0KclxHnH2Att6UvFWkAgAALtdA=
Date:   Thu, 25 Oct 2018 00:40:47 +0000
Message-ID: <DB7PR04MB4618F0289926D923EB908A14E6F70@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
 <20181023051449.2116-3-qiangqing.zhang@nxp.com>
 <20181024235706.GA22938@bogus>
In-Reply-To: <20181024235706.GA22938@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5532;6:hhGg196n2tIsz9ktX/mj3qXW4gtdrjB/XeeQgE0vvrUEpkYzL2/8EaU0HZ6hM6QLf/+U8ebpx6eFIrP3zzyGLI0BU255YacCtoSDSbdVUOeY8Dw739phwXegLX5xP/zm09QVE5f0dB+28luO1zQyiUG1jznMNndox1BTdTass6LlnasFV3FBGBZW4a6HHa+UP5g+PIEV7nsnbZoB5K9MyyFm7BOadTpQk0NEIBhUSEyIbGM2sKaTgKLn7rcfYbnljRtdroaKHpu1L1OGuX46a5ZaFEFCuHBW1k0Q6MgCybhfw5G9Yf96LCR5HgQAdPzvY4y1WIdLwwPmNtWuWTuWiHWRnAEJodvek4Qj4adaPDGlhs2hjj80oVw4gwt3jDe83Orl2zLVoNyrb1bkRukLVMlH1P2ZCBVxbOHntF977oL965ad/JAGjDQjwjccxIhaDdwkJMxsv4syaq88H0gwqQ==;5:5937xky2lVZhsJGMmUMHJuvyDo4W7xFaIQz++6E6vV+LeBsANtColzvnxMbLrO++CVUF6JBN227cRTYP9Y7OUEF2AjMGedvbfbYhrdbG+JCCHEsiISiyyzhWSDmrDK1a1HmSWCcYfDwXUDoY5PA+LhX6aYwyGcmdXNsiKRvFL2U=;7:sftwxAvd/fMZFYlCtD3B2Wn3MCABJX1EDikpcTLV0s5feBDDYLHWLV96QN92Q69IcvRaZ9VJs7VaoPs5/QMNRa2ZuN1nG//3bG7ikk4gpVWfXpeSQxPQa1cT0Xg2iZiUdMCKQ4oaCeAJm5B9Q6LST4NVhvAN56VI2FEFff3iJEZ20KDL9G1KYNvJEV/fK3RaXZBeFmDbtw8REo3SXkE73Oo/VvjNsB74edkV71jdi0Tc1UV4l/+7a7ilQ7WzhjmL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd4158c8-c8c7-47f6-b841-08d63a1281c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5532;
x-ms-traffictypediagnostic: DB7PR04MB5532:
x-microsoft-antispam-prvs: <DB7PR04MB553245041F3650E1658512CCE6F70@DB7PR04MB5532.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5532;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5532;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(13464003)(199004)(189003)(76176011)(68736007)(2906002)(11346002)(6506007)(53546011)(7736002)(102836004)(446003)(99286004)(97736004)(316002)(2900100001)(6916009)(7696005)(54906003)(5660300001)(5250100002)(4326008)(6436002)(26005)(486006)(86362001)(575784001)(6246003)(53936002)(186003)(9686003)(25786009)(66066001)(33656002)(476003)(55016002)(74316002)(81156014)(81166006)(8936002)(3846002)(6116002)(105586002)(305945005)(229853002)(106356001)(71190400001)(71200400001)(14454004)(256004)(478600001)(14444005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5532;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /ioLVSmi1VZdrsOT5AcyXuPOoJbqPyknaXufYdV/dMqIqpGz8/f/JnOOQpT+zm6a/yXuRrHCbO+sHx1ctPkiFj3OHtU7KtBsbj/LNgGeqECEIhngx2qWLLOsJOdbgm362GVkYJXYZ1kE8fLHA6Q0RhOq7nf26eNhhI38Fq2kZtHKqbCsv4illQeHHFzrDEiU6qcdQTnpwmcRMLnKnG5BRtBziPYTutB1q/3soMrm4aUfzZiTnRme4lbn415gVogvsSng0yGYBqnS23sw9KWVXTO3bBEotMapJD3ndIW5AUcJgcdIaTI8VqcTyHf/OQQxutRyL26bi2S1coTfQmeOpDwVrWB0Y5lfTHUzjV7xG4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4158c8-c8c7-47f6-b841-08d63a1281c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 00:40:47.9879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpy
b2JoQGtlcm5lbC5vcmddIA0KU2VudDogMjAxOMTqMTDUwjI1yNUgNzo1Nw0KVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQpDYzogbGludXgtY2FuQHZnZXIua2VybmVs
Lm9yZzsgd2dAZ3JhbmRlZ2dlci5jb207IG1rbEBwZW5ndXRyb25peC5kZTsgbWFyay5ydXRsYW5k
QGFybS5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgQS5zLiBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEgMi8yXSBEb2N1bWVu
dGF0aW9uOiBjYW46IGZsZXhjYW46IEFkZCBzdG9wLW1vZGUgcHJvcGVydHkgdG8gZGV2aWNlIHRy
ZWUNCg0KT24gVHVlLCBPY3QgMjMsIDIwMTggYXQgMDU6MTc6MTBBTSArMDAwMCwgSm9ha2ltIFpo
YW5nIHdyb3RlOg0KPiBGcm9tOiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0K
PiANCj4gVGhlIEZsZXhDQU4gY29udHJvbGxlciBjYW4gcGFyc2UgdGhlIHN0b3AtbW9kZSBwcm9w
ZXJ0eSB0byBlbmFibGUgQ0FOIA0KPiBzZWxmIHdha2V1cCBmZWF0dXJlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQg
fCA4IA0KPiArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2Fu
L2ZzbC1mbGV4Y2FuLnR4dCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gaW5kZXggYmZjMGM0MzM2NTRmLi5iNWNjZmM5YzE0
ZmIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL2ZzbC1mbGV4Y2FuLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gQEAgLTI0LDYgKzI0LDE0IEBAIE9wdGlv
bmFsIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgICAgIGlmIHRoaXMgcHJvcGVydHkgaXMgcHJl
c2VudCB0aGVuIGNvbnRyb2xsZXIgaXMgYXNzdW1lZCB0byBiZSBiaWcNCj4gICAgICAgICAgICAg
ICAgZW5kaWFuLg0KPiAgDQo+ICstIHN0b3AtbW9kZTogcmVnaXN0ZXIgYml0cyBvZiBzdG9wIG1v
ZGUgY29udHJvbCwgdGhlIGZvcm1hdCBpcw0KDQpTaG91bGQgaGF2ZSBhIHZlbmRvciBwcmVmaXg6
IGZzbCxzdG9wLW1vZGUNCg0KT2theSwgSSB3aWxsIGFkZCBpdC4gVGhhbmtzIGEgbG90IQ0KDQpC
ZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiArCQkJPCZncHIgcmVxX2dwciByZXFfYml0
IGFja19ncHIgYWNrX2JpdD4uDQo+ICsJCQlncHIgaXMgdGhlIHBoYW5kbGUgdG8gZ2VuZXJhbCBw
dXJwb3NlIHJlZ2lzdGVyIG5vZGUuDQo+ICsJCQlyZXFfZ3ByIGlzIHRoZSBncHIgcmVnaXN0ZXIg
b2Zmc2V0IG9mIENBTiBzdG9wIHJlcXVlc3QuDQo+ICsJCQlyZXFfYml0IGlzIHRoZSBiaXQgb2Zm
c2V0IG9mIENBTiBzdG9wIHJlcXVlc3QuDQo+ICsJCQlhY2tfZ3ByIGlzIHRoZSBncHIgcmVnaXN0
ZXIgb2Zmc2V0IG9mIENBTiBzdG9wIGFja25vd2xlZGdlLg0KPiArCQkJYWNrX2JpdCBpcyB0aGUg
Yml0IG9mZnNldCBvZiBDQU4gc3RvcCBhY2tub3dsZWRnZS4NCj4gKw0KPiAgRXhhbXBsZToNCj4g
IA0KPiAgCWNhbkAxYzAwMCB7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg==
