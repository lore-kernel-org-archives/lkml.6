Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xLz9AJwJGltHIwAAmS7hNA
	; Fri, 08 Jun 2018 04:45:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A588607E4; Fri,  8 Jun 2018 04:45:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NbgaYfnR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 966C96063F;
	Fri,  8 Jun 2018 04:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 966C96063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeFHEp0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:45:26 -0400
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:65399
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750822AbeFHEpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6Mrpc97Y0RvN72VQ/1OxOuKSaJc051uh+PIgngubfo=;
 b=NbgaYfnRfzz+K6Pp+FhCOlH/5JqHkoqdSxnAq8D4RwGRB4JRBl3hzKtD0tTCCbKaJVbAlpwSDFRY4AHAZOjr4E57u4e94GWn6Eg5jdtu/vzsERRwq1ETaNy5hghoQYodWfMii7QXb41Zxk4ZZRIJzy8Dn+Gp6jy2G4uRRaIoe/4=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2485.eurprd04.prod.outlook.com (10.169.224.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.797.11; Fri, 8 Jun 2018 04:45:20 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::c860:bdbd:3a07:8580]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::c860:bdbd:3a07:8580%5]) with mapi id 15.20.0797.020; Fri, 8 Jun 2018
 04:45:20 +0000
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v3, 00/10] Support DPAA PTP clock and timestamping
Thread-Topic: [v3, 00/10] Support DPAA PTP clock and timestamping
Thread-Index: AQHT/kENHwCW8m6oc0KpxB+1JEYWkKRVxWcAgAAEvhA=
Date: Fri, 8 Jun 2018 04:45:20 +0000
Message-ID: <DB6PR0401MB25365FAE0E0C7387CB085B96F87B0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180608042706.7gfg5p6574ntc2lq@localhost>
In-Reply-To: <20180608042706.7gfg5p6574ntc2lq@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2485;7:Iqd85T/urh8HOe+AlcTv7KUzdEPIYiaQNk6jw5i4ggSR9pncc+ITDAfVhnmjx6Pwmdxry/Dvrohs0028RNi7+86ottFIvMxctgZfmIdW0kqbzCBYs6IJoS6C10ujwDdXSU7/t0aB5GV7PXOzP9zJmatyDTmdneJCKKBTzHaKaWc15YKa8+RLL3adlCVLm/BiscKtN68Mn//bTHd+WcPAs5BlxIFSLIrq9m9x8mEFkB/dtLlNLiH0tN+lcCQTxamg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2485;
x-ms-traffictypediagnostic: DB6PR0401MB2485:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-microsoft-antispam-prvs: <DB6PR0401MB2485B863303E3BE640497882F87B0@DB6PR0401MB2485.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2485;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2485;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39850400004)(366004)(346002)(376002)(13464003)(189003)(199004)(25786009)(105586002)(106356001)(86362001)(99286004)(102836004)(45080400002)(74316002)(2900100001)(478600001)(39060400002)(14454004)(3846002)(26005)(7736002)(316002)(966005)(68736007)(3280700002)(55016002)(186003)(6116002)(81166006)(3660700001)(8936002)(305945005)(9686003)(7696005)(6916009)(66066001)(6246003)(2906002)(1411001)(97736004)(575784001)(76176011)(5250100002)(33656002)(446003)(486006)(53936002)(229853002)(11346002)(6506007)(5660300001)(6306002)(4326008)(81156014)(476003)(53546011)(6436002)(54906003)(8676002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2485;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Upi6Wp1KtlwXlcpU9cJ9YktqRABILbCTx4PAvSX/yix1PO/w6t96mNDYOi8WUdpurAL8EGHygxRAEPwiqRe8KmeF1eq2yqd5LRn/gEnNpnVs+cRpfOSyL6/9N98oa9C7LdPP3gAm1oXgkJcSj7QgxtdEMHcM9p5HSCmTL6yKCRYJa6rcuIDBsHoC7uzCxgf2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 95fb3ab3-7553-47c8-b440-08d5ccfaa3aa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fb3ab3-7553-47c8-b440-08d5ccfaa3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 04:45:20.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIENvY2hyYW4gW21h
aWx0bzpyaWNoYXJkY29jaHJhbkBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSA4LCAy
MDE4IDEyOjI3IFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hZGFsaW4tY3Jpc3RpYW4gQnVjdXINCj4gPG1hZGFsaW4u
YnVjdXJAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBTaGF3biBH
dW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFt2MywgMDAvMTBd
IFN1cHBvcnQgRFBBQSBQVFAgY2xvY2sgYW5kIHRpbWVzdGFtcGluZw0KPiANCj4gT24gVGh1LCBK
dW4gMDcsIDIwMTggYXQgMDU6MjA6NDBQTSArMDgwMCwgWWFuZ2JvIEx1IHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2hzZXQgaXMgdG8gc3VwcG9ydCBEUEFBIEZNQU4gUFRQIGNsb2NrIGFuZCBIVyB0aW1l
c3RhbXBpbmcuDQo+ID4gSXQgaGFkIGJlZW4gdmVyaWZpZWQgb24gYm90aCBBUk0gcGxhdGZvcm0g
YW5kIFBQQyBwbGF0Zm9ybS4NCj4gPiAtIFRoZSBwYXRjaCAjMSB0byBwYXRjaCAjNSBhcmUgdG8g
c3VwcG9ydCBEUEFBIEZNQU4gMTU4OCB0aW1lciBpbg0KPiA+ICAgcHRwX3FvcmlxIGRyaXZlci4N
Cj4gPiAtIFRoZSBwYXRjaCAjNiB0byBwYXRjaCAjMTAgYXJlIHRvIGFkZCBIVyB0aW1lc3RhbXBp
bmcgc3VwcG9ydCBpbg0KPiA+ICAgRFBBQSBldGhlcm5ldCBkcml2ZXIuDQo+IA0KPiBSaWdodCBu
b3csIG5ldC1uZXh0IGlzIGNsb3NlZCBmb3IgbmV3IHN0dWZmLiAgWW91IHdpbGwgaGF2ZSB0byBw
b3N0IHRoZSBzZXJpZXMNCj4gYWdhaW4gYWZ0ZXIgdGhlIG1lcmdlIHdpbmRvdyBjbG9zZXMuICBZ
b3UgY2FuIGNoZWNrIHRoZSBzdGF0dXMgaGVyZToNCj4gDQo+IA0KPiBodHRwczovL2VtZWEwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHA6JTJGJTJGdmdlci5rZXJu
DQo+IGVsLm9yZyUyRn5kYXZlbSUyRm5ldC1uZXh0Lmh0bWwmZGF0YT0wMiU3QzAxJTdDeWFuZ2Jv
Lmx1JTQwbnhwLmNvDQo+IG0lN0NiYWFiMGIyMmU3NDQ0Mzg2YzM3MDA4ZDVjY2Y4MWIzNyU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NjQwMjg4MzQ3
NTYzNzQyJnNkYXRhPWpDbU5sd29lV0E1MFBWNA0KPiB3M2xLWiUyRnM0YWtQancwVlYyT3JKM3Q0
Rml6SjAlM0QmcmVzZXJ2ZWQ9MA0KPiANCj4gV2hlbiB5b3UgZG8gcmUtcG9zdCwgeW91IGNhbiBh
ZGQgbXk6DQo+IA0KPiBBY2tlZC1ieTogUmljaGFyZCBDb2NocmFuIDxyaWNoYXJkY29jaHJhbkBn
bWFpbC5jb20+DQoNCltZLmIuIEx1XSBHZXQgaXQuIEFuZCB0aGFua3MgYSBsb3Qg8J+Yig0K
