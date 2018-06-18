Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2CFC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32AE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="B/CCQcEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32AE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935932AbeFRScu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:32:50 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:51856
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935390AbeFRScr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amQpqtAIK+SnJQWj0keOBGutbiZBoSS0+iyfgJ4h5Hc=;
 b=B/CCQcEG8i9aFKWB5gOF2vD9hHn8AoZF9Fc50cScDRXBLsHzqk5sIEpCErfiD/X31ozA7k2qAngoX857G4O/3byhXngOpOsEWxRlwjFHtnUkZeO74OWu9j4urgqMdfH3/hSP58lurBArYqVA3nSe5zkvtbR6Q7wtFVWTFcEa7B4=
Received: from MWHPR0501MB3913.namprd05.prod.outlook.com (10.167.173.32) by
 MWHPR0501MB3867.namprd05.prod.outlook.com (10.167.173.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Mon, 18 Jun 2018 18:32:45 +0000
Received: from MWHPR0501MB3913.namprd05.prod.outlook.com
 ([fe80::1c19:b99c:b5bb:90ba]) by MWHPR0501MB3913.namprd05.prod.outlook.com
 ([fe80::1c19:b99c:b5bb:90ba%3]) with mapi id 15.20.0884.010; Mon, 18 Jun 2018
 18:32:45 +0000
From:   Jim Gill <jgill@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 102/189] scsi: vmw-pvscsi: return DID_BUS_BUSY for
 adapter-initated aborts
Thread-Topic: [PATCH 4.14 102/189] scsi: vmw-pvscsi: return DID_BUS_BUSY for
 adapter-initated aborts
Thread-Index: AQHUBt9aobKp5LrmNEedIgYeOTV2XaRl4veA
Date:   Mon, 18 Jun 2018 18:32:45 +0000
Message-ID: <EA21F664-6574-4321-B2FC-3CC602EB7363@vmware.com>
References: <20180618081209.254234434@linuxfoundation.org>
 <20180618081213.356911104@linuxfoundation.org>
In-Reply-To: <20180618081213.356911104@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0501MB3867;7:jwNqS7CYVcYGpMBQBSY9+jVEwUYDCIwx8pK2G2xnKs6zJJGMDpLdqtDlUHW2Iv22Qw9RMt0l+Jib6EXMZPiP9VW9TFql9noNT4NxNULW3XAukWPB8NVkf3icncoq/a9dP9Ly3XqzivUq1EwNoAudpMG5Q6RY5YxpG9uau+INZKxAa4vtj8f8EcG1hm1aJfAhRuEzSmXn9M60vB3R5ze32egT6KkLzGaYvBvJiO5FMn+AByzHFa0Zkr7JysXvhOkP;20:kYyDL/tWcPb4R7TUWARSYZ2dvLCw//3CD5tV9cpyDCxgrv2Cl7HiSzMk7yS63mnsnDeNmzO30B3zbNY/E7CGt+Eoc28wLc7X4wIOCv+eKJfb24qQyp132VmGtH3pANbm8dx6ul91mfrdjE+7O2tRcKZqAn6560d8QAqZFITUdkA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 41c9a5be-e03a-49f6-6400-08d5d549e2ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0501MB3867;
x-ms-traffictypediagnostic: MWHPR0501MB3867:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgill@vmware.com; 
x-microsoft-antispam-prvs: <MWHPR0501MB3867A07D1D4D0D84B94B0123CB710@MWHPR0501MB3867.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(61668805478150)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0501MB3867;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0501MB3867;
x-forefront-prvs: 0707248B64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(51234002)(59450400001)(6506007)(2900100001)(53546011)(186003)(66066001)(8936002)(14454004)(2906002)(6512007)(102836004)(110136005)(476003)(446003)(5250100002)(2616005)(33656002)(54906003)(26005)(83716003)(2501003)(486006)(11346002)(105586002)(3280700002)(106356001)(86362001)(478600001)(81156014)(4326008)(305945005)(6246003)(25786009)(36756003)(5660300001)(3660700001)(6486002)(229853002)(68736007)(99286004)(6436002)(316002)(3846002)(82746002)(8666007)(76176011)(97736004)(81166006)(7736002)(8676002)(6116002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0501MB3867;H:MWHPR0501MB3913.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g1r1NtzBRPu8VkkWXEG0ZDZd+bBlFLzdPPVNAx1Qeh+uXIC5YFWHyfSga19qBX56X9eb8T5WaIuMmrQBXdhlVSez6I4Qi2vERaJjQ2GPyRjis6nu/G0WORbX8MuVvoXkeVdQsVCTMqdaHlxMy+KdCXuNksvdwFOL03nA3Dy8rdYO47g+xhRWxAfR0sKFXBxM1fIux7r1jDEx27KaQEyGiPYjOZ85HhF6HTvq77OXTABWSmFni8sydPfV/C3B8/2LOXoaL0c3qKD+1sYUuFTiqJ6EReJejY/f59cOd9CfJxr5NwGT2OiX761E796L1Bl+IbE8/hw4xZlKtBiAdZtTiw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA2DA94F0864F4FA44CB41DF060B572@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c9a5be-e03a-49f6-6400-08d5d549e2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2018 18:32:45.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0501MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmluZSBieSBtZS4NCg0KDQoNCg0KT24gNi8xOC8xOCwgMToxMyBBTSwgIkdyZWcgS3JvYWgtSGFy
dG1hbiIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCg0KPjQuMTQtc3RhYmxl
IHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBsZXQg
bWUga25vdy4NCj4NCj4tLS0tLS0tLS0tLS0tLS0tLS0NCj4NCj5Gcm9tOiBKaW0gR2lsbCA8amdp
bGxAdm13YXJlLmNvbT4NCj4NCj5bIFVwc3RyZWFtIGNvbW1pdCBmNGIwMjQyNzFhZTNlOTc4NmU1
ZDZmMWMwNWIwMWI1N2E3NGUxZDZkIF0NCj4NCj5UaGUgdm13X3B2c2NzaSBkcml2ZXIgcmV0dXJu
cyBESURfQUJPUlQgZm9yIGNvbW1hbmRzIGFib3J0ZWQgaW50ZXJuYWxseQ0KPmJ5IHRoZSBhZGFw
dGVyLCBsZWFkaW5nIHRvIHRoZSBmaWxlc3lzdGVtIGdvaW5nIHJlYWQtb25seS4gQ2hhbmdlIHRo
ZQ0KPnJlc3VsdCB0byBESURfQlVTX0JVU1ksIGNhdXNpbmcgdGhlIGtlcm5lbCB0byByZXRyeSB0
aGUgY29tbWFuZC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBKaW0gR2lsbCA8amdpbGxAdm13YXJlLmNv
bT4NCj5TaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBv
cmFjbGUuY29tPg0KPlNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5A
bWljcm9zb2Z0LmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPi0tLQ0KPiBkcml2ZXJzL3Njc2kvdm13X3B2c2NzaS5j
IHwgICAgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4NCj4tLS0gYS9kcml2ZXJzL3Njc2kvdm13X3B2c2NzaS5jDQo+KysrIGIvZHJpdmVycy9z
Y3NpL3Ztd19wdnNjc2kuYw0KPkBAIC02MDksNyArNjA5LDcgQEAgc3RhdGljIHZvaWQgcHZzY3Np
X2NvbXBsZXRlX3JlcXVlc3Qoc3RydQ0KPiAJCQlicmVhazsNCj4gDQo+IAkJY2FzZSBCVFNUQVRf
QUJPUlRRVUVVRToNCj4tCQkJY21kLT5yZXN1bHQgPSAoRElEX0FCT1JUIDw8IDE2KTsNCj4rCQkJ
Y21kLT5yZXN1bHQgPSAoRElEX0JVU19CVVNZIDw8IDE2KTsNCj4gCQkJYnJlYWs7DQo+IA0KPiAJ
CWNhc2UgQlRTVEFUX1NDU0lQQVJJVFk6DQo+DQo+DQo=
