Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCCCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1B720880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="FK+WDyjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1B720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeGXNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:30:53 -0400
Received: from mail-eopbgr10101.outbound.protection.outlook.com ([40.107.1.101]:18976
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbeGXNax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha0ja3w3a7QiHzQcgjKi+ij+PCWy9u9kzTepaM51urw=;
 b=FK+WDyjfi+hhBlXkWrm4R1GTUa1GSD/Pen2iPSPGCJPd4oA+u3btFVrEbMBnm6mUueM6hQDjfinCEqExLH5L6OJOKN5zuu+UD0ALdZ/rkHqabmYv4N7Kd2sgzklnajA4tMyhfcg53+3tMPTmTL4lfaybZjramUENmEAM9AuAdkQ=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2077.eurprd05.prod.outlook.com (10.167.195.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Tue, 24 Jul 2018 12:24:34 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 12:24:34 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Topic: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Index: AQHUIzsmvhNTA8KQdkOtPSRemoHbvqSeTBYA
Date:   Tue, 24 Jul 2018 12:24:34 +0000
Message-ID: <1532435072.6124.1.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2077;6:L5ThM9iCAurE+cvURBtoBjh7Tf8oNroYavgoMdVoIyWhP/5Hi7sQ8Vl65e/vffX5TcehTeIRgSOtFoDll8Ny2RU85aU2GW6QByFfMyjqKwc755jBzIJXExVknrB0NqpxZmtdHgF24O2yz9kgiENaK4UecdLlyUNAFmy18S1mMzqBMtbnrQMCTPy+SYEA82PBU4+2vuVIz3A0Zce8Zxx5bCddFg6FXY5MDzzpTtWbLVM2drKhOGNl9kCunfR8iqVEhiHpWOugrEJlPcuYr8bO/K6wvVtZ7yaXNFAjY5vrebK36ngxjfQj8BXKFVr+t8KyPN0ykUKlxJezubr7BTWCLXe857JRJHs2s+wouO7j4N67/pxI3hZixyAEVYgwJlEzgHodRGRHjCOcJCFTPzCmRO9tPYyowvm/sSQul2/YL4TxO/8HfkjFyRquFZYCrhwyS0TjxVpMnMt4nfnmoknVqw==;5:5WXUQMIYyj1VlcIsT7uYcDiHHxJE/+oPIaxngOm3v3HKSmdXwaMLPtEZgwwRt7rMWWa1tqnQ8rKYSSXJTCruehK9sN4VjAYXVdP+A5H7BZIEanjH2MB51Vwdh3YyF71maTIciDXwQ+pO6DUCndT2zT8HydFEzQosocET2eDj+dM=;7:mjhE4AxsMPi7vLI+7SE3UGxh2jXVaz3LabmRrC4T45c3Si6R7BS4eJ5pPTnAQtJZr+5bpgL0EPv/gA+hQ9q8Vr5WpduB2h7b4gVE4gtMPwdCqXGJl1XLFkISetO2DPqQfsF+G5csfMtlK3MS4HzaWzqwR2d5blxr6WRxo8IvKkdVgtdvHcxlmkSRH8/4pQl+Gj8MEa61t14Vk+iP14axyP662H9X6VdVEgkMtU+dCnyUtG2Tab07u4wNj0DN8Yj5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0170f305-b501-464d-82a2-08d5f1606a27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2077;
x-ms-traffictypediagnostic: VI1PR0501MB2077:
x-microsoft-antispam-prvs: <VI1PR0501MB207750EF91000AAC7E167425FB550@VI1PR0501MB2077.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2077;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2077;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39840400004)(199004)(189003)(14454004)(76176011)(102836004)(6506007)(25786009)(186003)(26005)(316002)(6486002)(6436002)(2900100001)(229853002)(110136005)(54906003)(105586002)(106356001)(6512007)(478600001)(97736004)(2201001)(86362001)(99286004)(81166006)(5250100002)(81156014)(2501003)(8936002)(53936002)(103116003)(8676002)(68736007)(256004)(305945005)(3846002)(6116002)(2906002)(2616005)(476003)(11346002)(446003)(36756003)(39060400002)(4326008)(5660300001)(6246003)(486006)(66066001)(44832011)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2077;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SCrodAOPGOcRX1RQ6a3jnjT+xX/AMe6xcc8Hc/+Rs01d/8GiOEDx3N7jEuFO6yTT4jt5oUejNWuFOVim5HyK9vO/Rv1GoeNTUVmMqTYssT5+l7WtHL97Ir1wEilmgC2vAr0Silr3ZsChkjGhi2Bys75jBrYkYOCUyyLw0/1piUTaxDimOeUGzJL44cnomtoi5gPahNICpW/mj7oiVUq9F25giEjqnpw/BFHpF33RmSX09Ta/IKCY5hMXowhzi0Ifi1GT1hK4fgz/QF40cM0RutWaNxDfkJuYDnQk2Hqc0FdVx26dxh4YevUjTZFxlPc3BUxXiKJQ64DDk7BXOhrypZitKtfxW7GPMCz4yXhNT8w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA8A2111B93A6C45BBE0D4D2A9CF0B36@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0170f305-b501-464d-82a2-08d5f1606a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 12:24:34.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIEkgbWVhbnQgdG8gd3JpdGUgIm1pbm9yIHJldmFtcCIgaW4gdGhlIHN1YmplY3QgbGlu
ZSBoZXJlIGFzDQpBcGFsaXMgVEsxIHdhcyBhbHJlYWR5IGluIHF1aXRlIGdvb2QgYSBzaGFwZSBi
dXQgdGhpcyBhcmUgc3RpbGwgc29tZQ0Kd29ydGh5IGltcHJvdmVtZW50cyAoOy1wKS4NCg0KT24g
VHVlLCAyMDE4LTA3LTI0IGF0IDEyOjQyICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+
IFRoaXMgc2VyaWVzIGlzIGEgbWlub3Igb3ZlcmhhdWwgZm9yIHRoZSBUb3JhZGV4IEFwYWxpcyBU
SzEgc3lzdGVtIG9uDQo+IG1vZHVsZS4NCj4gDQo+IE1hcmNlbCBaaXN3aWxlciAoMTUpOg0KPiAg
IEFSTTogdGVncmE6IGFwYWxpcy10azE6IGFkZCBsb2NhbC1tYWMtYWRkcmVzcyBwcm9wZXJ0eQ0K
PiAgIEFSTTogdGVncmE6IGFwYWxpcy10azE6IHJlb3JkZXIgcGNpZSBwcm9wZXJ0aWVzDQo+ICAg
QVJNOiB0ZWdyYTogYXBhbGlzLXRrMTogcmVvcmRlciBob3N0MXgvaGRtaSBwcm9wZXJ0aWVzDQo+
ICAgQVJNOiB0ZWdyYTogYXBhbGlzLXRrMTogcmVvcmRlciBwYWRjdGwgcHJvcGVydGllcw0KPiAg
IEFSTTogdGVncmE6IGFwYWxpcy10azE6IHJlZ3VsYXRvciBjbGVhbi11cA0KPiAgIEFSTTogdGVn
cmE6IGFwYWxpcy10azE6IGFkZCBtaXNzaW5nIHJlZ3VsYXRvcnMNCj4gICBBUk06IHRlZ3JhOiBh
cGFsaXMtdGsxOiBkcm9wIHVudXNlZCBwaW5tdXggbGFiZWwNCj4gICBBUk06IHRlZ3JhOiBhcGFs
aXMtdGsxOiB3aGl0ZS1zcGFjZSBjbGVhbi11cA0KPiAgIEFSTTogdGVncmE6IGFwYWxpcy10azE6
IHJlb3JkZXIgYmFja2xpZ2h0IHByb3BlcnRpZXMNCj4gICBBUk06IHRlZ3JhOiBhcGFsaXMtdGsx
OiBhZGQgcHJvcGVyIGVtbWMgdm1tYyBhbmQgdnFtbWMgc3VwcGxpZXMNCj4gICBBUk06IHRlZ3Jh
OiBhcGFsaXMtdGsxOiBlbmFibGUgZW1tYyBkZHI1MiBtb2RlDQo+ICAgQVJNOiB0ZWdyYTogYXBh
bGlzLXRrMTogYWRkIHRvcmFkZXgsYXBhbGlzLXRrMS12MS4yIGNvbXBhdGlibGUNCj4gICBBUk06
IHRlZ3JhOiBhcGFsaXMtdGsxOiBmaXggcGNpZSBzd2l0Y2ggdmVuZG9yIGNvbXBhdGlibGUNCj4g
ICBBUk06IHRlZ3JhOiBhcGFsaXMtdGsxOiByZW9yZGVyIGNwdSBkZmxsIGNsb2NrIHByb3BlcnRp
ZXMNCj4gICBBUk06IHRlZ3JhOiBhcGFsaXMtdGsxOiByZW9yZGVyIFNEIGNhcmQgcHJvcGVydGll
cw0KPiANCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vdGVncmEudHh0
IHwgICAyICsNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWFwYWxpcy1ldmFsLmR0cyAg
ICAgIHwgIDI2ICsrKystDQo+ICBhcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1hcGFsaXMtdjEu
Mi1ldmFsLmR0cyB8ICAyOSArKysrLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtYXBh
bGlzLXYxLjIuZHRzaSAgICAgfCAxNDMgKysrKysrKysrKysrKy0NCj4gLS0tLS0tLS0tLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtYXBhbGlzLmR0c2kgICAgICAgICAgfCAxNDMgKysr
KysrKysrKysrKy0NCj4gLS0tLS0tLS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAyMDggaW5zZXJ0
aW9ucygrKSwgMTM1IGRlbGV0aW9ucygtKQ==
