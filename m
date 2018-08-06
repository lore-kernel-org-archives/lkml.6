Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E5AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AE221A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PJv5MNh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AE221A03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeHFNXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:23:04 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:65506
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbeHFNXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPLRSk3z8zUwDFz+o3zzNe5Ha5uthQR7HHguCdW//E8=;
 b=PJv5MNh0cqbGb79wsATR5R0NX27Y2VyteidyiJS5BTd75Ri5Q0pHRg7DLtyMDCd9NPn7e4DyrK7E5S+A3TyVjAsMVdlZx0VIVyd+SAHCUIL+c+7RervXG6AICTajDEdKXrZy3ZEaRuAbcF6L884Q499iAfG5UokCuWeN8YYG6fQ=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0980.namprd02.prod.outlook.com (10.161.207.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 11:14:26 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 11:14:25 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqSYdgMAgAAE67CAGnHvAP///6Sw
Date:   Mon, 6 Aug 2018 11:14:25 +0000
Message-ID: <BN3PR0201MB09935DC6F4A0BA4876DF82A4A7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b819a5fc-82aa-dc9c-4272-fecdacbd5880@intel.com>
 <MWHPR02MB281619CD8CFDA93B9ADB3D89A7510@MWHPR02MB2816.namprd02.prod.outlook.com>
 <51566ca4-1002-5c62-71d0-9da610bff368@linux.intel.com>
In-Reply-To: <51566ca4-1002-5c62-71d0-9da610bff368@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0980;6:ZdfFBIc6NKwKmvwE8gh732vHSuOoAI/BMXirn3JqfUzCQOSn/rpmWJT2Lj2gr+tWvntLE3XrzwnkBUsBhKDIBGjlokmCAxJF17ccDp36HWRivgfoIK+v2cyF7N50DzOKv1XkYib41nBDhH1NA0mUjAvhKiOE1GHedt/uivxY7EEn+67TzysJyQLciwB0juua/R8Yk2mEU8k5OP0aph+SagYVGWorXYB+ZTgxlALtD1iXcJXBDsjRx5R4Dp3nnna7RXM3uBhKRiWbduldBFLwtp36IKmUk/AW9kb2GuSadwXGCw01xuyTdpTa3MQt8U9zBlOln5v4GdwaQYzT43+lXYbHtMIgcZTFcXHdXz37EGBdsMop2PuM5QQhOs4AlabjmH+JcTnyWldxum38/RyHbwf5iYSJGsHYxjDltkMYRGbHhXsqCRJmU1iCBhURGvLJRCsWBVUEfKf81prUL9gjYw==;5:MclBURUjnPWZ9qxoEeT5GEGvX+MAxYNmz2NX63hd57Yppj4sk30NCzqTSBpioKsiht665oCSbcknPxWM0HXbzQSPcYdjx8+fZIB18ffFkcywnVx/KtCqC1jWMJojCQ5P0dtEraO5m7/1FybLMhOdUFCgLdsvJEb45eTbZxJhzPQ=;7:ey3OhK/Z6s21LOtYYc/x0e6irO6IvwgVUX1BOHR3ySmNDWKzIEPpIviIqOBHNZYcM1CUmJ34ky+gYJYWFVbctNT3RUKvk4QvpdnvnOihergDPqpyC8qnrP2biht6zb5hT3Jvy8uqKcAM2hXjnPiTpy5sP9fxrIV1bSWdTzWK8cpyYUlYQKUF1v/hIjFQzz+m7u92eJ5uABnr/jFyK9AEw0etHs+8L2cku8tRF/FT0wMVkx6P/lnJZkXbIjBypsgv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 89028f9a-125a-48b5-5610-08d5fb8dc519
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0980;
x-ms-traffictypediagnostic: BN3PR0201MB0980:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB0980E728F8AB1BCA941DD394A7200@BN3PR0201MB0980.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN3PR0201MB0980;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0980;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(33656002)(8936002)(81166006)(7696005)(81156014)(25786009)(68736007)(4326008)(256004)(53936002)(6246003)(8676002)(106356001)(55016002)(9686003)(76176011)(2900100001)(97736004)(99286004)(6116002)(3846002)(5660300001)(66066001)(14454004)(2906002)(305945005)(110136005)(54906003)(5250100002)(7736002)(6506007)(105586002)(93886005)(102836004)(478600001)(6436002)(446003)(186003)(11346002)(486006)(316002)(26005)(86362001)(229853002)(74316002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0980;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VwlCJ/kzb/yBjk8zATRH6EdRs11IK483SAsLz5mQErHSu5v6mhFEhL6atdqaVIk2+Dy1Q2uL/g/5K/CqShgc31FMIDE7ajT7eQHlmapwpb419P9TjQXF2xkg5YsGo8DMHjvkYorCBUy7AbiAn90nXdqksqqYDfbamThJ5T56b73iJJ7edc2Fs4kGXBl6cutyhVbeFnXsHdl+poH0pI7HEvagar6hMdP0w67a/69kjyBVUrav0TjZTxV9dY4nS2Eu+yiNKveZYUBAjAB3qODYLvCHrhWN5P8onKs1TwmuEAsuom0QGFpHPK5hM77zqvCUTeQMgLcBnfK5I15cth2BfWXxZJEZpOrgvMzPTCRlcOM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89028f9a-125a-48b5-5610-08d5fb8dc519
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 11:14:25.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGFpcywNCj4+DQo+Pj4+DQo+Pj4+IC0JaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jv
b2woc3lzZGV2LCAidXNiMy1scG0tY2FwYWJsZSIpKQ0KPj4+PiAtCQl4aGNpLT5xdWlya3MgfD0g
WEhDSV9MUE1fU1VQUE9SVDsNCj4+Pj4gKwkJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2wo
dG1wZGV2LCAidXNiMi1scG0tZGlzYWJsZSIpKQ0KPj4+PiArCQkJeGhjaS0+cXVpcmtzIHw9IFhI
Q0lfSFdfTFBNX0RJU0FCTEU7DQo+Pj4+DQo+Pj4+IC0JaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woJnBkZXYtPmRldiwgInF1aXJrLWJyb2tlbi1wb3J0LXBlZCIpKQ0KPj4+PiAtCQl4aGNp
LT5xdWlya3MgfD0gWEhDSV9CUk9LRU5fUE9SVF9QRUQ7DQo+Pj4+ICsJCWlmIChkZXZpY2VfcHJv
cGVydHlfcmVhZF9ib29sKHRtcGRldiwgInVzYjMtbHBtLWNhcGFibGUiKSkNCj4+Pj4gKwkJCXho
Y2ktPnF1aXJrcyB8PSBYSENJX0xQTV9TVVBQT1JUOw0KPj4+Pg0KPj4+PiAtCS8qIGltb2RfaW50
ZXJ2YWwgaXMgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIHZhbHVlIGluIG5hbm9zZWNvbmRzLiAq
Lw0KPj4+PiAtCXhoY2ktPmltb2RfaW50ZXJ2YWwgPSA0MDAwMDsNCj4+Pg0KPj4+IFNldHRpbmcg
dGhlIGRlZmF1bHQgaW1vZF9pbnRlcnZhbCBjb3VsZCBiZSBtb3ZlZCBiZWZvcmUgdGhlIGZvcigp
DQo+Pj4gbG9vcA0KPj4+DQo+Pg0KPj4gSSB0aG91Z2h0IGl0IHdvdWxkIGJlIGJldHRlciBpZiBl
dmVyeXRoaW5nIHJlbGF0ZWQgdG8gaW1vZF9pbnRlcnZhbCBpcw0KPj4gaW4gb25lIHBsYWNlLCBz
byBrZXB0IGl0IGFzIGlzLiBJIGNhbiBmaXggdGhpcyBpbiB2MiBpZiB5b3Ugc3VnZ2VzdC4NCj4N
Cj5EZWZhdWx0IGltb2RfaW50ZXJ2YWwgbmVlZHMgdG8gYmUgc2V0IGJlZm9yZSB0aGUgZm9yIGxv
b3AgdG8gYXZvaWQgb3ZlcndyaXRpbmcgYSB2YWx1ZQ0KPmdvdCBmcm9tIGRldmljZSBwcm9wZXJ0
eQ0KPg0KPlNvIGEgdjIgaXMgbmVlZGVkDQo+DQoNClRoYW5rcyBmb3IgY29ycmVjdGluZywgd2ls
bCBmaXggYW5kIHNlbmQgdjINCg0KVGhhbmtzLA0KQW51cmFnIEt1bWFyIFZ1bGlzaGENCg0KPi1N
YXRoaWFzDQo=
