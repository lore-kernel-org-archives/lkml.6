Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED64C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5B0206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="An1qgBZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5B0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJBT4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:05 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:47180
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbeJBT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT0jKT6jypnVbYx23in6wz6TisMwvGkKsCnXva/HcVk=;
 b=An1qgBZvrk9kSZ9raSJ24ldcH5gITPUq4sCYgzC6t6I4PgCtPHscmYpH4TJSDcawVgwU6+CegA+A3r9pEbQY8ptyKHGr2lO5wCVt4kDnXpIt3syRVrXeSwrmgQZxOXUkg9MzEKfXu2l8vhzNAdOuHeen3cftxIFAGJF7ETB/mvo=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3494.eurprd04.prod.outlook.com (52.133.19.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Tue, 2 Oct 2018 13:12:44 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991%4]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 13:12:44 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Topic: [PATCH] bus: fsl-mc: explicitly define the fsl_mc_command
 endianness
Thread-Index: AQHUWkm47JDUmoDApkiQYO7wBwTqZKUL7qGA
Date:   Tue, 2 Oct 2018 13:12:44 +0000
Message-ID: <868a0ddc-4b80-c866-a91e-7d6bc3af34da@nxp.com>
References: <1538482550-7698-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1538482550-7698-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3494;6:ZILuwb0+Lr4vdKkH3Q34eW42F/zaLQ/DIuzcvr4JvajiD4/jXcf5U3xmUpPPren+zg4w5XJPCSimoxidW+gQzxue9OnDoG1jPvU0YxNe4amK25cqduCT0nvVNecR1lsga49OJIL7aN0a3nQVqSWkQ0C+YhzN5pjFIOdevBuAfX6wpuFN4KKMpM8KnpnJZNKcSQINPIuQboO1cSvUbSHN6D7vyKVfB0Y67C4j2W5JaxZqkdlCO37JT5tYx5tIgO/OBOScYxSixr+croInH0iHIufJijtopMgtp6pHe3aF00NTMGKB0mOyM6kLT2MkNlS6rGBiohoLg3iykOPIScGJMza9jeXNolF6tZMtvHpXdbLmTd82IzPy/hy+/zE+UmkILFjNNxqIYk8LbhfR7Y+DKaEj9j3Pb/RLm8H7uEQ/DoIEZoS2dCVnDOYVIKOnOtYD1SNNNV/GLH741dFIle6clA==;5:JaTW38ZHlPLYpG96+wVK+VimqDTuiX61hConM11wG4tnCD0oZK6uxNxpfFt7rQdyyINkMEzLD0lJHOJ8RX0UJh5JB2hn6VJHG2YuqiIG93o+/DlWLagxIz9rMX+lIHfiloNLep9Z2ZcU08XhvnmKz8osiZGjsDERemM8H+aCWhk=;7:Es3rOVzcUUXXAXkc7DSA3ZkoPSXvCNBxWWFfVqQtAJJUQfeOqChBned3fZxoLs6JQm1UVT81PL83VquQ4tHnpAh25G+89NcUju1bg+Gr9LbPH/w3zNd+xp3oCmRBpHddi7sauTQDzK24tKbcqA8lY9Wr0FZFR8xzPmNsoh9rWrRW8DxgI+EOpJsnyIWJTYFSzy14BCkYt9KHvwa2JsmjBt1v62qsFm9KLOpjS5Fg8r4NbItKHhO/9I3fiVDHPiCD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f14f448f-0cf0-4cf6-2954-08d62868bdd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3494;
x-ms-traffictypediagnostic: AM6PR0402MB3494:
x-microsoft-antispam-prvs: <AM6PR0402MB3494A1A008307318487412B3ECE80@AM6PR0402MB3494.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR0402MB3494;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3494;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(97736004)(102836004)(14454004)(4326008)(86362001)(575784001)(316002)(53546011)(6506007)(256004)(26005)(36756003)(25786009)(106356001)(76176011)(54906003)(110136005)(105586002)(2900100001)(31696002)(5250100002)(229853002)(6246003)(2501003)(2616005)(3846002)(99286004)(6116002)(486006)(6486002)(2906002)(478600001)(476003)(5660300001)(8936002)(66066001)(31686004)(11346002)(81156014)(8676002)(446003)(81166006)(6436002)(6512007)(68736007)(6636002)(71200400001)(53936002)(7736002)(71190400001)(305945005)(44832011)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3494;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jTaKn+mJ8RBMsvezFfUmh95yK5BFNsv5706d+2xs/RlNr/nkKq8JPqIU1KINiHJ3RGiaB0Q4GDO2Y5zK/uwxdNZUNf8O45c8nCK2oI1zBLU//67vr7xUwq94/ISJLhpA+FDgkvekhsyxcVCMPqzJHNCldCkbCHSg3q6cvdS/ZKpnhq+KVFmRoWRg0ejEaFwhkROA6tFqiCIbJspP2a3W8DgJcqd1ljmL1e31K1uiUVh9Z5sdyvbWPv0/gpL6rzMqA+jA+gOMH2LnxYcrVdAkp6DcDKf2b59zbuKuSYELWoJhuoslfAvMfCVGe8dlTnGuPHwo14InZss6+0m0jTfh2vwgxsBYBoBUGAB5FYWPdJY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <53E964DCA128FA46A8C9CBB89CB14CCD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14f448f-0cf0-4cf6-2954-08d62868bdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 13:12:44.5492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwMi4xMC4yMDE4IDE1OjE2LCBJb2FuYSBDaW9ybmVpIHdyb3RlOg0KPiBCb3RoIHRoZSBo
ZWFkZXIgYW5kIHRoZSBjb21tYW5kIHBhcmFtZXRlcnMgb2YgdGhlIGZzbF9tY19jb21tYW5kIGFy
ZQ0KPiA2NC1iaXQgbGl0dGxlLWVuZGlhbiB3b3Jkcy4gVXNlIHRoZSBhcHByb3ByaWF0ZSB0eXBl
IHRvIGV4cGxpY2l0bHkNCj4gc3BlY2lmeSB0aGVpciBlbmRpYW5uZXNzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSW9hbmEgQ2lvcm5laSA8aW9hbmEuY2lvcm5laUBueHAuY29tPg0KDQpSZXZpZXdl
ZC1CeTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCg0KLS0tDQpC
ZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0KDQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvZnNsL21j
LmggfCAxMiArKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnNsL21j
LmggYi9pbmNsdWRlL2xpbnV4L2ZzbC9tYy5oDQo+IGluZGV4IGYyN2NiMTQuLjk2YzU0YmIgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZnNsL21jLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9mc2wvbWMuaA0KPiBAQCAtMjEwLDggKzIxMCw4IEBAIHN0cnVjdCBtY19jbWRfaGVhZGVyIHsN
Cj4gICB9Ow0KPiAgIA0KPiAgIHN0cnVjdCBmc2xfbWNfY29tbWFuZCB7DQo+IC0JdTY0IGhlYWRl
cjsNCj4gLQl1NjQgcGFyYW1zW01DX0NNRF9OVU1fT0ZfUEFSQU1TXTsNCj4gKwlfX2xlNjQgaGVh
ZGVyOw0KPiArCV9fbGU2NCBwYXJhbXNbTUNfQ01EX05VTV9PRl9QQVJBTVNdOw0KPiAgIH07DQo+
ICAgDQo+ICAgZW51bSBtY19jbWRfc3RhdHVzIHsNCj4gQEAgLTIzOCwxMSArMjM4LDExIEBAIGVu
dW0gbWNfY21kX3N0YXR1cyB7DQo+ICAgLyogQ29tbWFuZCBjb21wbGV0aW9uIGZsYWcgKi8NCj4g
ICAjZGVmaW5lIE1DX0NNRF9GTEFHX0lOVFJfRElTCTB4MDENCj4gICANCj4gLXN0YXRpYyBpbmxp
bmUgdTY0IG1jX2VuY29kZV9jbWRfaGVhZGVyKHUxNiBjbWRfaWQsDQo+IC0JCQkJICAgICAgIHUz
MiBjbWRfZmxhZ3MsDQo+IC0JCQkJICAgICAgIHUxNiB0b2tlbikNCj4gK3N0YXRpYyBpbmxpbmUg
X19sZTY0IG1jX2VuY29kZV9jbWRfaGVhZGVyKHUxNiBjbWRfaWQsDQo+ICsJCQkJCSAgdTMyIGNt
ZF9mbGFncywNCj4gKwkJCQkJICB1MTYgdG9rZW4pDQo+ICAgew0KPiAtCXU2NCBoZWFkZXIgPSAw
Ow0KPiArCV9fbGU2NCBoZWFkZXIgPSAwOw0KPiAgIAlzdHJ1Y3QgbWNfY21kX2hlYWRlciAqaGRy
ID0gKHN0cnVjdCBtY19jbWRfaGVhZGVyICopJmhlYWRlcjsNCj4gICANCj4gICAJaGRyLT5jbWRf
aWQgPSBjcHVfdG9fbGUxNihjbWRfaWQpOw0KPiA=
