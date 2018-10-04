Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97BDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83866213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSy/H2og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83866213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJDQaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:22 -0400
Received: from mail-ve1eur01on0081.outbound.protection.outlook.com ([104.47.1.81]:42496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbeJDQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhTm6l8f0bXWDdxyDUxYbGTa0CGx5Xk7zb4p42yUPC4=;
 b=aSy/H2ogPNGzmnvbAZ08Gqe/9/xzr86YXwl0MYFMGGgI2pvkAk2eCvUeSjDDCuedIYi5kr2r1YPmNyemzKpIDUcHQehMs06QESIxM2rscGqDZsbodmjJlyU26EtGO0Gh0FlofPkrv2ZK+QnQu62xooi7Ineo2MO+FpbEyQVjzg8=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3317.eurprd04.prod.outlook.com (52.133.18.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 09:37:52 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5892:d48b:ebb8:8991%5]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 09:37:52 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, "arm@kernel.org" <arm@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
Thread-Topic: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
Thread-Index: AQHUWdpZ8RiypxId6U6NvarsYsHn5qUO2B6A
Date:   Thu, 4 Oct 2018 09:37:52 +0000
Message-ID: <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
References: <20181001225827.21946-1-leoyang.li@nxp.com>
In-Reply-To: <20181001225827.21946-1-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3317;6:KyuQnVxLIOah0p6kUVkefxMFdjzQcR5uhJjsnO05omBpc0mED8s+etNfaVxpf1CS98CBGo/TC4v1kwCZzMDBYcAoKyqPsU3Fp9vRqHdjODynBkfucLdcnWrSiYu6tmbxnLvJQf+6Juq5hFCeQwAa8qnOm/mAgml0465E7P8SrjTZzaavtY0lmKumNKEanYBz9JFf6W/6CLbwiHKLx7M02AUVmyk1KfeajHvMXO/Hc3iqTEvKM/Y/5mi63hw06lA9E5XsiCSXS3pN4i51GRc0aHDyd/oTM7eaxFadq9diDEIBHu/q3wblqEmevvcze33BhF2wvjFoAKn+HeLiWXwAHpJfvXc4XoeBXC5Yp0Ke8bXDUChP9R9+exfyH6Ad4fs/CjX1e6joIZcS/NLbEqROHCCEH/0Oo2OtLKP1fpGAA91jU1huwkOZmELvj0neuFMzpY/j4cRuX9/r222d3JGFpw==;5:pZX9MmMFPISonYzCFgTHXqgXyScY3bs3KFBVikg2H1wYNxhdx3Dt8/lem76yjzmsk2zw4KnkPVuGRTSxIIfC86o5Jb9SJv+XLGEHLATwpVaBOZHwPvpQbrmMd6VZe+iueTPiJ3/ayaDt1+hLCS9uK45/qcfbraliu+Z8QC5mnN4=;7:hct6uw+PZQcDv1PIqVfASSUm6hEmNw9hv2itZT9V5VHwRNmpPYKDjVl1JvaDhADlf1mvgwUrx+/T7M6kof5cVxRXGYYmWseeUhZXixow4GSTvMBTRwjYOZf5TTU9pkvy39B2f25m/qIOMg9P3StYlzdAwxlbuN3xaF9JJszVxDNu03TSnkEAT26iLidLA44rfdW4a74xPXgMGt4iztsALCKL1NZYS+QnKzPqrqhytE78Xg4E+CyH0bQZHw/tzRDr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f550d320-389a-4941-6cee-08d629dd0e48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3317;
x-ms-traffictypediagnostic: AM6PR0402MB3317:
x-microsoft-antispam-prvs: <AM6PR0402MB33172C4DF70FE20649E7EED5ECEA0@AM6PR0402MB3317.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(227817650892897);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:AM6PR0402MB3317;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3317;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(6436002)(44832011)(6486002)(486006)(186003)(26005)(53936002)(6512007)(97736004)(6246003)(86362001)(229853002)(256004)(2616005)(6306002)(446003)(11346002)(476003)(6116002)(3846002)(5660300001)(2906002)(102836004)(316002)(31696002)(71200400001)(71190400001)(6506007)(31686004)(53546011)(305945005)(76176011)(54906003)(106356001)(110136005)(105586002)(25786009)(4326008)(7736002)(5250100002)(2501003)(2900100001)(68736007)(66066001)(36756003)(99286004)(8936002)(478600001)(14454004)(8676002)(81156014)(81166006)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3317;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rjueBsPRNbk1iMHMo5C/09cYRklkSgnROKzdRJYcjZCrY9TjBApeYrHsNYQMOfktNi5dexeOguuDc1EIhGcR0s1n/95KB5lR70DZRMZBSUik9OqzvQAm3qER9tyiUlYiD08nkLBuFEVpIhksq/aVx0ZHm2uvWNK+KsdqhV5MdePVmiFCluMNCL2J6cYhTlkJy/C52u1QdM6uDIj4ZsWCPKjC2NdDRFz61fmiOEY1ijJcie27fkY0zOAdm0ZXQeLZmKh6+DlAMZwAKTXAc/tl5JgBw2GcGGjuHucoiAsUmli2J1KoZZtaA6gJS5OuUdvuXTiRifkqcwmBg6aoOs82PQP4qheZWRFpvZFDvhp5aAM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <87350D72425C1F4EB2F8586CD5B066FC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f550d320-389a-4941-6cee-08d629dd0e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:37:52.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQpPbiAwMi4xMC4yMDE4IDAxOjU4LCBMaSBZYW5nIHdyb3RlOg0KPiBIaSBhcm0t
c29jIG1haW50YWluZXJzLA0KPiANCj4gUGxlYXNlIG1lcmdlIHRoZSB1cGRhdGVkIGZpeCBmb3Ig
dGhlIGZvbGxvd2luZyBpc3N1ZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IExlbw0KPiANCj4gVGhlIGZv
bGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5NmZjNzQzMzNmODRjZmRmOGQ0MzRjNmMwNzI1
NGUyMTVlMmFhZDAwOg0KPiANCj4gICAgc29jOiBmc2w6IHFlOiBGaXggY29weS9wYXN0ZSBidWcg
aW4gdWNjX2dldF90ZG1fc3luY19zaGlmdCgpICgyMDE4LTA5LTI1IDEzOjU3OjI2IC0wNzAwKQ0K
PiANCj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQo+IA0KPiAgICBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGVvL2xpbnV4Lmdp
dCBzb2MtZnNsLWZpeC12NC4xOS0yDQo+IA0KPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8gNWExZWI4Yjk1NDI4ODQ1OTJhMDE4ODI5YmIxZmYyMGM5Njk1ZDkyNToNCj4gDQo+ICAgIHNv
YzogZnNsOiBxbWFuX3BvcnRhbHM6IGRlZmVyIHByb2JlIGFmdGVyIHFtYW4ncyBwcm9iZSAoMjAx
OC0xMC0wMSAxNzo0Nzo0MyAtMDUwMCkNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gTlhQL0ZTTCBTb0MgZHJp
dmVyIGZpeGVzIGZvciB2NC4xOSByb3VuZCAyDQo+IA0KPiAtIEZpeCBjcmFzaCBvZiBxbWFuX3Bv
cnRhbCBieSBkZWZlcnJpbmcgaXRzIHByb2JlIGlmIHFtYW4gaXMgbm90IHByb2JlZA0KPiANCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBMYXVyZW50aXUgVHVkb3IgKDIpOg0KPiAgICAgICAgc29jOiBmc2w6IHFibWFu
OiBhZGQgQVBJcyB0byByZXRyaWV2ZSB0aGUgcHJvYmluZyBzdGF0dXMNCj4gICAgICAgIHNvYzog
ZnNsOiBxbWFuX3BvcnRhbHM6IGRlZmVyIHByb2JlIGFmdGVyIHFtYW4ncyBwcm9iZQ0KDQpUaGVy
ZSdzIGEgc2ltaWxhciBmaXggZm9yIGJtYW4gcG9ydGFscyBbMV0uIEkgd2FzIHVuZGVyIHRoZSBp
bXByZXNzaW9uIA0KdGhhdCB5b3UgcGxhbiB0byBwaWNrIHRoYXQgdXAgdG9vLg0KDQpbMV0gInNv
Yy9mc2wvYm1hbl9wb3J0YWxzOiBkZWZlciBwcm9iZSBhZnRlciBibWFuJ3MgcHJvYmUiLCBmb3Vu
ZCBoZXJlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzk5MjAwOS8N
Cg0KLS0tDQpUaGFua3MgJiBCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ==
