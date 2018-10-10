Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B78C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E825B2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q1T4ex7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E825B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJKtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:49:03 -0400
Received: from mail-eopbgr00053.outbound.protection.outlook.com ([40.107.0.53]:41050
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbeJJKtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc68mUPK/iN2429lIsyzLED+tL5mmJT53WGgkqESFbk=;
 b=q1T4ex7AXTTXN16jbSDUbTqK5huw8KvkCxijt1NPEvwC2dednkIs98cBCr8nmstX2UlgpQYSqe758pBF0Ozc37bmJaUlrEp5QsmL5OUTw5dS9eEsKiU01LnenEFwDHI6cCdgPLRqWUihl0HzwbVaecNteBtWyC5sXci6spxwd8Y=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB5151.eurprd04.prod.outlook.com (20.177.50.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 03:28:55 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::6860:c9a6:abd4:b191]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::6860:c9a6:abd4:b191%2]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 03:28:55 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "haibo.chen@freescale.com" <haibo.chen@freescale.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: RE: Pinmuxing and SDHC speeds on sdhci-esdhc-imx
Thread-Topic: Pinmuxing and SDHC speeds on sdhci-esdhc-imx
Thread-Index: AQHUX9Vmbb1546YVQkGAPZ+1/A9ji6UX0pgQ
Date:   Wed, 10 Oct 2018 03:28:54 +0000
Message-ID: <VI1PR04MB5040E64721C3B1EFBFC9A42C90E00@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <CAHCN7xJnqbzyx=wFw4XY+NWRP_Y4RTVjeeyU3wSAsGtSUyG9Bw@mail.gmail.com>
In-Reply-To: <CAHCN7xJnqbzyx=wFw4XY+NWRP_Y4RTVjeeyU3wSAsGtSUyG9Bw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5151;6:QTtkqNwWthITQTPOlXNramiIl9APSbD0wBG21di7ss3NIp9wpu1ZD+MqmOhcIBAQYbi+I/jb3snh2HbOuuL47h6pGDDxv1q8gYOz43weScm+GKaGPx0G0wFOL4oJawszKK8UlkmhSLgPoXc50kxzN4xbnk+bbH/KOooD4rXIaYNlWt13cY587P8XQlnYPkjhpJuXdPzD2ZECW0wBz5kbmMhbe7vgKTVPx0R+ormY5I8BPmPtZDYIB9bX4jMMId8wpfJZKqRkQm98PRxEPJP4v5nU3skstAtTSaoqM697hgoXkrlkbDOllXe+RVentdzOFYjdX5hIarQin8Zv4FbyCJ3Zx4vPF9iq8zNVUbrG4TADuky6SfnUfih1er9t4sSLVzleOEXGxgueFPo7uXnyS99F7xqfTSJRHWjnLa2vb4sWEB/zAIguIO54vGysgzlrgb8uv5zXSEyjeO5/03RhkA==;5:TQJyfCNzozFSTwouPQxYfO+1HQKINxalOQAD8SWnKB7tQqRv8lcZ87nszpcamxSZoTguLxoA9h3nYOiMgCFnuqYJTgodZ3Z757K62xhvlpbAncM3A2ovnYOOJGlPj49LSLK7c1Q4UTiT8vAn68ne93zYTSXB8X+Y2YGHm1vhU0k=;7:uG/UmjCA85p+oiRMSoCcPbIaF+TnJRHg03+/T96Sq/SpBdl4VQ8ichwqMikxdCHP7nuJrtOjS65Skt/o2+fFSd6f7bV2DkfljNsasyx9IziWkcdSxT/OH6ikjBtgvH9gWjJ0PDxUzgdl4PxJadDM4gs9FhZqtGX8MwpsKNFFGhHHjsN8Qs31XLlF/8q7wIJAPLIQ6D0akpP6Vvku++BuK6jdjgcpL2rxobh4mHI11hqku3CfpWiW69wTriQTf7Ul
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a88bfadd-0477-467d-f83a-08d62e6081fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5151;
x-ms-traffictypediagnostic: VI1PR04MB5151:
x-microsoft-antispam-prvs: <VI1PR04MB51513B4737728B1EB22E367690E00@VI1PR04MB5151.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(101931422205132)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR04MB5151;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5151;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(13464003)(189003)(33656002)(106356001)(66066001)(3846002)(6116002)(316002)(71200400001)(71190400001)(105586002)(14454004)(110136005)(478600001)(6246003)(2906002)(25786009)(68736007)(256004)(229853002)(39060400002)(476003)(6636002)(86362001)(76176011)(9686003)(53546011)(6506007)(102836004)(2900100001)(186003)(6436002)(5250100002)(5660300001)(486006)(26005)(2501003)(99286004)(74316002)(7696005)(97736004)(8676002)(53936002)(305945005)(7736002)(81166006)(81156014)(11346002)(446003)(8936002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5151;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wjT3WVVFzbNkW/PzizQRoXno5ecY1jaeMxwKUg6/S7SGvPwyP+Jrtw9pmsO1skRDoXYajE7njuVuX2BSgg1DoPIy2H/J/djaLO3KpXPfoeQ2kq2IyQiyuPDY+naVLyq4rDVrg5qm75suMnwyG51zxi8PRGxjldYZmnNBjWnT/SZHLe+u3Vt712JVEMZNAHFd+mJCUTZDNFAZoIbp/vNrpFHXwtt32eQh7xUZ4UoeqoxazKWw3sU/lW7Nbz2JWAA8Fnwdh2Xre+tS8KRSeG5iFqYq+OwqPUFeodKegbM0a3HIOuDEjnA6h7eYOvr8wUTlf9VcT4cx+t5sksSoEM4PvSFk87OhY6xqNWdlxRj2pks=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88bfadd-0477-467d-f83a-08d62e6081fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 03:28:55.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRhbQ0KDQpZZXMsIE1NQ19ERFI1MiBjYW4gdXNlIHBpbnNfMTAwbWh6LiBZb3UgY2FuIGRv
IHRoYXQsIHRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQpCb3VnaCBDaGVuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9y
Zw0KPiBbbWFpbHRvOmxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBP
ZiBBZGFtIEZvcmQNCj4gU2VudDogMjAxOOW5tDEw5pyIOeaXpSAyMTozOA0KPiBUbzogbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZzsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
Ow0KPiBoYWliby5jaGVuQGZyZWVzY2FsZS5jb207IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2
YW1AbnhwLmNvbT4NCj4gU3ViamVjdDogUGlubXV4aW5nIGFuZCBTREhDIHNwZWVkcyBvbiBzZGhj
aS1lc2RoYy1pbXgNCj4gDQo+IEkgaGF2ZSBhIHF1ZXN0aW9uIHJlZ2FyZGluZyB0aGUgcGluc3Rh
dGUgYW5kIHRoZSBjb3JyZXNwb25kaW5nIHVoc19zaWduYWxpbmcuDQo+IA0KPiBUaGUgdWhzX3Np
Z25hbGluZyBzaG93cyBhIHZhcmlldHkgb2YgdGltaW5nIG9wdGlvbnMsDQo+IA0KPiAgTU1DX1RJ
TUlOR19VSFNfU0RSMTIsICBNTUNfVElNSU5HX1VIU19TRFIyNTosDQo+IE1NQ19USU1JTkdfVUhT
X1NEUjUwLCBNTUNfVElNSU5HX1VIU19TRFIxMDQsDQo+IE1NQ19USU1JTkdfTU1DX0hTMjAwLCAg
TU1DX1RJTUlOR19VSFNfRERSNTAsDQo+IE1NQ19USU1JTkdfTU1DX0REUjUyLCAgTU1DX1RJTUlO
R19NTUNfSFM0MDAsIGFuZA0KPiBNTUNfVElNSU5HX0xFR0FDWQ0KPiANCj4gSG93ZXZlciB0aGUg
ZXNkaGNfY2hhbmdlX3BpbnN0YXRlIGZ1bmN0aW9uIG9ubHkgbGlzdHMNCj4gTU1DX1RJTUlOR19V
SFNfU0RSNTAsIE1NQ19USU1JTkdfVUhTX0REUjUwLA0KPiBNTUNfVElNSU5HX1VIU19TRFIxMDQs
IE1NQ19USU1JTkdfTU1DX0hTMjAwLCBhbmQNCj4gTU1DX1RJTUlOR19NTUNfSFM0MCwgYW5kIGEg
ZGVmYXV0Lg0KPiANCj4gRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRoaXMgbWVhbnMgdGhhdCAgTU1D
X1RJTUlOR19NTUNfRERSNTIgdXNlcyB0aGUNCj4gZGVmYXVsdCBwaW5tdXguICBJIGFtIHdvbmRl
cmluZyBpZiBpdCBzaG91bGQgdXNlIHBpbnNfMTAwbWh6LiAgV2UgaGF2ZSBhbg0KPiBlTU1DIHBh
cnQgdGhhdCB3ZSB3YW50IHRvIG9wZXJhdGUgYXQgdGhpcyBwb2ludCBhbmQgaXQgc2VlbXMgbGlr
ZSBpdCBtaXNzaW5nLg0KPiBJZiBzbywgSSBjYW4gc3VibWl0IGEgcGF0Y2guDQo+IA0KPiBJdCBh
bHNvIHNlZW1zIGxpa2UgdGhhdCBTRFIxMiwgU0RSMjUgdXNlIHRoZSBkZWZhdWx0LiAgSSBhc3N1
bWUgdGhpcyBpcyBPSy4NCj4gDQo+IGFkYW0NCg==
