Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77470C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D84620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="orvGvuAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D84620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbeGXTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:22:43 -0400
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:27488
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388366AbeGXTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyaufhQlX8XddG5ZtTTUfqZ1U2Zbp/YuGQRdhh5V4So=;
 b=orvGvuAHhmpXmEsftLcDciYMvxcavblG/MNJgu3Zk28k/yUtY+jf33qmVucxHNIno7zu76bloOcX2LiqG5Dxp+dOP5ppIU9QlFqsy2XFg2Yrhp2Z36Jvm+aCGt2dqP90bBXYBjG1yhQOwaa+C/smoxjdKS3iK4lMTtGbC/4iY5c=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB2139.namprd02.prod.outlook.com (10.166.190.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 18:14:56 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92%3]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 18:14:54 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
Thread-Topic: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river
 for ZynqMP core
Thread-Index: AQHUHgiyrPpyPLTCbkmEsgOh0EA57qSWW8yAgAhcQEA=
Date:   Tue, 24 Jul 2018 18:14:54 +0000
Message-ID: <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
In-Reply-To: <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB2139;6:C7c72esdKw6BQGPRVLVl/mcBXOcnYBQ+nlQZayATJz5o9FZLUaAteIbKQ3TxTGmhiUIqY+mWQeWs/oI6XRjB1uzRr9HjNv1sJQezDYH4u0UJ9k5mNs5hjzX1yDmWva5QCkw/2eKyX1w7sPyQD9C5OacEL+qWfgsHPMIPUYhog31QI1kIkGjN5CxbwkqA5MNB3pw6rwEymCrAt3RVm3zOA5gnFbSo5plIR2jzFWFf496DW/cypx+aJhbvu34ECLeStJvJnAni125oeErPVT3RPSFTBGtRo5y9dz9yaNmqbmd3BcmYL1OUYxmnE8XEPJin+JcJt5VfzfLW4coHPzlxyxHPoin2h+GlanGOus8/wUKw0m/mGi9dQDWlmC32FIPYHaiWMnILtGNl6VM1rbpe8/38wVTuAu+teSY2Qr+sCC1vjGOZ32sfpP24QLd1ZW30Jt4PYOLUIEHGMuJ7KPlagA==;5:0u+BvBEHyAxT+3kp3OleG3+sFoV5qkTUX9ggQevmlFWLQcfvejytbuSpyeW6DHjJSbaxns++UBL/VoQGevIZffNTPzxS9L2PsVgfjLMLgoFUb76GMWg7FYrMorKB1X+5qLB3kwxQCYNlTzTlTRdi+jiidN1fa7aZZsuvZNJwApw=;7:5gzIt2O+/V9zaxv3mwoOEbdSfHeNTlcexOq5TpTGk2AfqQzr9xUzRAEHzaEiiOsaSTmXcUPulDfO7eRsh8n3KYb/P3ag0TsPmv8FWxPz1RQ5dMTTq8szcLkb+9xEe2dhWbZOMKDZEQFKsW3PlwmA942oKFoBU0A8SqT3ogbBCPFkXC0VOF0q6vRWlX++NJ7BLvXhdNN/Cax6iTOYIdqzDF7SJeaKKW+45s6PwaRhLeZC2e4qhVm6SbtZ8MvMZ8ap
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(13464003)(189003)(199004)(966005)(6306002)(68736007)(74316002)(2906002)(105586002)(106356001)(478600001)(97736004)(53936002)(5250100002)(2501003)(7416002)(316002)(5660300001)(99286004)(66066001)(72206003)(25786009)(6116002)(8676002)(54906003)(110136005)(81166006)(6506007)(2201001)(102836004)(86362001)(305945005)(26005)(476003)(53546011)(446003)(4326008)(3846002)(9686003)(7736002)(33656002)(6436002)(11346002)(8936002)(2900100001)(256004)(55016002)(229853002)(39060400002)(76176011)(14454004)(486006)(6246003)(81156014)(7696005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2139;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4d40ea33-50fe-4bd2-f2a9-08d5f1915b28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB2139;
x-ms-traffictypediagnostic: CY1PR02MB2139:
x-microsoft-antispam-prvs: <CY1PR02MB21396DDCB12AE83288E62400B8550@CY1PR02MB2139.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(166708455590820)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB2139;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2139;
x-forefront-prvs: 0743E8D0A6
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wKoC2/XKi1cvgCUrsLRQsuyY9zIDKP2Zg6P0gGy9pPN+aKrYGTaKXLCGWvKSQUtxjK7v/xFY6bJDY7vgAZKksuAVV9AzYksg7iwhmaBYA8dYLdvUBOdbxODmGDI0p71ittbSOmq4nOEUgyhVmmILl2TKAZ+VJHsi3N9s9v7heJ+Q1jRbotpbo3eyznXBxD4GtKwfB0M909OGXsZgeZ6iMS/nYxRley58T1e1ybFwMIuhhzyofpuSWSqDHwjw8kOIYCc578JqAMMGcy2a5vQfqaESKuu5OEa8mbC2p+WZ3gMt6u/SpRw7T+ReZvqD5mxiSeadaEI5p4fdgwyXzSvyuqUFd1tz5tS7FVM1cEiLG2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d40ea33-50fe-4bd2-f2a9-08d5f1915b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 18:14:54.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layBbbWFpbHRvOm1pY2hhbC5zaW1la0B4aWxpbnguY29tXQ0KPiBTZW50OiBUaHVyc2Rh
eSwgSnVseSAxOSwgMjAxOCAzOjMzIEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54
LmNvbT47IGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc7DQo+IG1pbmdvQGtlcm5lbC5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBtYXR0QGNvZGVibHVlcHJpbnQuY28udWs7DQo+IHN1
ZGVlcC5ob2xsYUBhcm0uY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsga2Vlc2Nvb2tAY2hyb21p
dW0ub3JnOw0KPiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBtdHVycXVldHRlQGJheWxpYnJl
LmNvbTsNCj4gc2JveWRAY29kZWF1cm9yYS5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5j
b20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBKb2xseSBTaGFo
DQo+IDxKT0xMWVNAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMDAvMTBd
IGRyaXZlcnM6IEludHJvZHVjZSBmaXJtd2FyZSBkbmQgY2xvY2sgcml2ZXIgZm9yDQo+IFp5bnFN
UCBjb3JlDQo+IA0KPiBPbiAxNy43LjIwMTggMjE6NTgsIEpvbGx5IFNoYWggd3JvdGU6DQo+ID4g
VGhpcyBwYXRjaHNldCBpcyBhZGRpbmcgY29tbXVuaWNhdGlvbiBsYXllciB3aXRoIGZpcm13YXJl
IGFuZCBjbG9jaw0KPiA+IGRyaXZlciB3aG8gdXNlcyB0aG9zZSBBUElzIHRvIGNvbW11bmljYXRl
IHdpdGggUE1VLg0KPiA+IEZpcm13YXJlIGRyaXZlciBwcm92aWRlcyBhbiBpbnRlcmZhY2UgdG8g
ZmlybXdhcmUgQVBJcy5JbnRlcmZhY2UgQVBJcw0KPiA+IGNhbiBiZSB1c2VkIGJ5IGFueSBkcml2
ZXIgdG8gY29tbXVuaWNhdGUgdG8gUE1VRlcoUGxhdGZvcm0gTWFuYWdlbWVudA0KPiBVbml0KS4g
QWxsIHJlcXVlc3RzIGdvIHRocm91Z2ggQVRGLg0KPiA+IFRoaXMgcGF0Y2hzZXQgYWRkcyBDQ0Yg
Y29tcGxpYW50IGNsb2NrIGRyaXZlciBmb3IgWnlucU1QLkNsb2NrIGRyaXZlcg0KPiA+IHF1ZXJp
ZXMgc3VwcG9ydGVkIGNsb2NrIGluZm9ybWF0aW9uIGZyb20gZmlybXdhcmUgYW5kIHJlZ2l0ZXJz
IHBsbCBhbmQgb3V0cHV0DQo+IGNsb2NrcyB3aXRoIENDRi4NCj4gPiB2MTA6DQo+ID4gIC0gSW5j
b3Jwb3JhdGVkIGNvZGUgcmV2aWV3IGNvbW1lbnRzIGZyb20gdjkgcGF0Y2ggc2VyaWVzLiBEaXNj
dXNzZWQgYmVsb3c6DQo+ID4gCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0
Nzg1NzUvDQo+ID4gCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0Nzg0NTcv
DQo+ID4gCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0Nzg0NjEvDQo+ID4g
CWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0Nzg0NjMvDQo+ID4NCj4gPiB2
OToNCj4gPiAgLSBGaXhlZCBtaW5vciB0eXBvIGNvbW1lbnRzDQo+ID4NCj4gPiB2ODoNCj4gPiAg
LSBDb3JyZWN0ZWQgdHlwbyBpbiBjbGsgS2NvbmZpZw0KPiA+DQo+ID4gdjc6DQo+ID4gIC0gUmVt
b3ZlZCB4aWxpbnggc3BlY2lmaWMgY2xvY2sgZGVidWdmcyBBUEkgc3VwcG9ydA0KPiA+ICAtIEFk
ZGVkIHJldmlld2VkLWJ5IHRhZ3MgZm9yIEZXIGFuZCBjbG9jayBiaW5kaW5ncw0KPiA+ICAtIFVw
ZGF0ZWQgY2xvY2sgbm9kZSBuYW1lIHRvIGNsb2NrLWNvbnRyb2xsZXINCj4gPg0KPiA+IHY2Og0K
PiA+ICAtIEJyb2tlIHBhdGNoIHNlcmllcyB0byBoYXZlIGJhc2UgRlcgZHJpdmVyIGFuZCBDbG9j
ayBkcml2ZXIgdXNlcg0KPiA+ICAtIEluY29ycG9yYXRlZCBjb2RlIHJldmlldyBjb21tZW50cyBm
cm9tIGxhc3QgRlcgYW5kIENsb2NrIGRyaXZlciBwYXRjaA0KPiBzZXJpZXMuIERpc2N1c3NlZCBi
ZWxvdzoNCj4gPiAJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDIzMDc1OS8N
Cj4gPiAJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDI1MDA0Ny8NCj4gPg0K
PiA+IHY1Og0KPiA+ICAtIEFkZGVkIEFURiB2ZXJzaW9uIGNoZWNrIHN1cHBvcnQNCj4gPiAgLSBV
cGRhdGVkIHNvbWUgZnVuY3Rpb25zIHRvIGJlIHN0YXRpYw0KPiA+ICAtIE1pbm9yIGZ1bmN0aW9u
IG5hbWUgY29ycmVjdGlvbnMNCj4gPg0KPiA+IHY0Og0KPiA+ICAtIENoYW5nZWQgY2xvY2sgc2V0
cmF0ZS9nZXRyYXRlIEFQSSBwcm90b3R5cGUgdG8gc3VwcG9ydCA2NCBiaXQgcmF0ZQ0KPiA+ICAt
IERlZmluZWQgbWFjcm9zIGZvciBnZXRfbm9kZV9zdGF0dXMgcmV0dXJuIHZhbHVlcw0KPiA+ICAt
IE1vdmVkIERUIG5vZGUgYXMgYSBjaGlsZCBvZiBmaXJtd2FyZQ0KPiA+ICAtIENoYW5nZWQgZGVi
dWdmcyBBUElzIHRvIHJldHVybiBkYXRhIHRvIGRlYnVnZnMgYnVmZmVyIGluc3RlYWQgb2YNCj4g
PiBkdW1waW5nIHRvIGtlcm5lbCBsb2cNCj4gPiAgLSBNaW5vciBjaGFuZ2VzIHRvIGluY29ycG9y
YXRlIG90aGVyIHJldmlldyBjb21tZW50cyBmcm9tIHYzIHBhdGNoDQo+ID4gc2VyaWVzDQo+ID4N
Cj4gPiB2MzoNCj4gPiAgLSBhZGRlZCBzb21lIGZpeGVzIHRvIGZpcm13YXJlLWdncy5jDQo+ID4g
IC0gdXBkYXRlZCBwaW5tdXggZ2V0L3NldCBmdW5jdGlvbiBhcmd1bWVudCBuYW1lcyB0byBzcGVj
aWZ5IGZ1bmN0aW9uDQo+ID4gaWQgaW5zdGVhZCBvZiBub2RlIGlkDQo+ID4gIC0gYWRkZWQgbmV3
IHBpbmN0cmwgcXVlcnkgbWFjcm9zDQo+ID4gIC0gaW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50
cyBmcm9tIHYyIHBhdGNoIHNlcmllcw0KPiA+DQo+ID4gdjI6DQo+ID4gIC0gY2hhbmdlIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyIGxpY2Vuc2UgdGV4dCBzdHlsZQ0KPiA+ICAtIHNwbGl0IHBhdGNo
IGludG8gbXVsdGlwbGUgcGF0Y2hlcw0KPiA+ICAtIFVwZGF0ZWQgY29weXJpZ2h0cw0KPiA+ICAt
IEFkZGVkIEFCSSBkb2N1bWVudGF0aW9uDQo+ID4gIC0gaW5jb3Jwb3JhdGVkIGxvZ2ljYWwgcmV2
aWV3IGNvbW1lbnRzIGZyb20gcHJldml1b3MgcGF0Y2guIERpc2N1c3NlZA0KPiBiZWxvdzoNCj4g
PiAJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDE1MDY2NS8NCj4gPg0KPiA+
IEpvbGx5IFNoYWggKDEpOg0KPiA+ICAgZHJpdmVyczogY2xrOiBBZGQgWnlucU1QIGNsb2NrIGRy
aXZlcg0KPiA+DQo+ID4gUmFqYW4gVmFqYSAoOSk6DQo+ID4gICBkdC1iaW5kaW5nczogZmlybXdh
cmU6IEFkZCBiaW5kaW5ncyBmb3IgWnlucU1QIGZpcm13YXJlDQo+ID4gICBmaXJtd2FyZTogeGls
aW54OiBBZGQgWnlucW1wIGZpcm13YXJlIGRyaXZlcg0KPiA+ICAgZmlybXdhcmU6IHhpbGlueDog
QWRkIHp5bnFtcCBJT0NUTCBBUEkgZm9yIGRldmljZSBjb250cm9sDQo+ID4gICBmaXJtd2FyZTog
eGlsaW54OiBBZGQgcXVlcnkgZGF0YSBBUEkNCj4gPiAgIGZpcm13YXJlOiB4aWxpbng6IEFkZCBj
bG9jayBBUElzDQo+ID4gICBmaXJtd2FyZTogeGlsaW54OiBBZGQgZGVidWdmcyBpbnRlcmZhY2UN
Cj4gPiAgIGZpcm13YXJlOiB4aWxpbng6IEFkZCBkZWJ1Z2ZzIGZvciBJT0NUTCBBUEkNCj4gPiAg
IGZpcm13YXJlOiB4aWxpbng6IEFkZCBkZWJ1Z2ZzIGZvciBxdWVyeSBkYXRhIEFQSQ0KPiA+ICAg
ZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgYmluZGluZ3MgZm9yIFp5bnFNUCBjbG9jayBkcml2ZXIN
Cj4gPg0KPiA+ICAuLi4vZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLWZpcm13YXJlLnR4dCAg
ICAgICB8ICA4MiArKysNCj4gPiAgYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3JtcyAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2Nsay9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvY2xrL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9jbGsv
enlucW1wL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPiA+ICBkcml2
ZXJzL2Nsay96eW5xbXAvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArDQo+
ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9jbGstZ2F0ZS16eW5xbXAuYyAgICAgICAgICAgICAgIHwg
MTQ0ICsrKysrDQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9jbGstbXV4LXp5bnFtcC5jICAgICAg
ICAgICAgICAgIHwgMTQxICsrKysNCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL2Nsay16eW5xbXAu
aCAgICAgICAgICAgICAgICAgICAgfCAgNjggKysNCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL2Ns
a2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA3MTkgKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFtcC9kaXZpZGVyLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgMjE3ICsrKysrKysNCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL3BsbC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAzMzUgKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvZmly
bXdhcmUvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJp
dmVycy9maXJtd2FyZS94aWxpbngvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgfCAgMjMgKw0K
PiA+ICBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICB8
ICAgNSArDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jICAgICAg
ICAgICAgIHwgMjQ5ICsrKysrKysNCj4gPiAgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1w
LWRlYnVnLmggICAgICAgICAgICAgfCAgMjIgKw0KPiA+ICBkcml2ZXJzL2Zpcm13YXJlL3hpbGlu
eC96eW5xbXAuYyAgICAgICAgICAgICAgICAgICB8IDU2MiArKysrKysrKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sveGxueCx6eW5xbXAtY2xrLmggICAgICAgIHwgMTE2
ICsrKysNCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5oICAgICAgICAg
ICAgICAgfCAxMTYgKysrKw0KPiA+ICAyMSBmaWxlcyBjaGFuZ2VkLCAyODE4IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maXJtd2FyZQ0KPiA+IC50eHQg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay96eW5xbXAvS2NvbmZpZyAgY3JlYXRlIG1v
ZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9jbGsvenlucW1wL01ha2VmaWxlICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiBkcml2ZXJzL2Nsay96eW5xbXAvY2xrLWdhdGUtenlucW1wLmMNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL3p5bnFtcC9jbGstbXV4LXp5bnFtcC5jDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay96eW5xbXAvY2xrLXp5bnFtcC5oICBjcmVh
dGUgbW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJzL2Nsay96eW5xbXAvY2xrYy5jICBjcmVhdGUgbW9k
ZSAxMDA2NDQNCj4gPiBkcml2ZXJzL2Nsay96eW5xbXAvZGl2aWRlci5jICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiBkcml2ZXJzL2Nsay96eW5xbXAvcGxsLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IGRyaXZlcnMvZmlybXdhcmUveGlsaW54L0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IGRyaXZlcnMvZmlybXdhcmUveGlsaW54L01ha2VmaWxlICBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gPiBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAtZGVidWcuYw0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmgNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICBjcmVh
dGUgbW9kZQ0KPiA+IDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3hsbngsenlucW1w
LWNsay5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL3hs
bngtenlucW1wLmgNCj4gPg0KPiANCj4gSXQgbG9va3MgcHJldHR5IGNhbG0gb3ZlciB0aGUgbGFz
dCBzZXZlcmFsIHNlcmllcyB0aGF0J3Mgd2h5IHdoZW4gSSBnZXQgYW4gYW5zd2VyDQo+IGZyb20g
U3RlcGhlbiBvciBNaWtlIEkgd2lsbCB0YWtlIHRoaXMgc2VyaWVzIHZpYSBteSB0cmVlIGFuZCBh
cm0tc29jIHRyZWUuDQo+IA0KPiBJIGhhdmUgYXBwbGllZCAwMS0wOCBoZXJlDQo+ICBodHRwczov
L2dpdGh1Yi5jb20vWGlsaW54L2xpbnV4LXhsbngvY29tbWl0cy96eW5xbXAvc29jDQo+IA0KPiBU
aGFua3MsDQo+IE1pY2hhbA0KDQoNClRoYW5rcyBmb3IgbWVyZ2luZyB0aGUgcGF0Y2hlcy4gDQpC
eSBtaXN0YWtlIEkgYWRkZWQg4oCcUmV2aWV3ZWQtYnk6IFN0ZXBoZW4gQm95ZCBzYm95ZEBrZXJu
ZWwub3Jn4oCdIGZvciBmaXJtd2FyZSBiaW5kaW5ncyAoUGF0Y2gwMSkuICBTdGVwaGVuIGhhZCBy
ZXZpZXdlZCBjbG9jayBiaW5kaW5ncyBvbmx5LiAgUGxlYXNlIHN1Z2dlc3QgaWYgSSBzaG91bGQg
c2VuZCBhIG5ldyB2ZXJzaW9uIHdpdGggdGhhdCBmaXguDQoNClRoYW5rcywNCkpvbGx5IFNoYWgN
Cg==
