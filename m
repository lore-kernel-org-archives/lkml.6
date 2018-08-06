Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B179C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B5219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ikxFnwuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4B5219CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeHFKGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:06:46 -0400
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:11808
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbeHFKGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7j8WysxZIRPguwLPhOXnV+yGGgpUbNhMwotj+Ng20=;
 b=ikxFnwuM/3psn9LzvxQCMgWtYimfgWGreblvuqbTUb29FVce0s1k9RIKO4aCkU9ChxCJEVrvph6P77pO01Sqag8gAd9PitWZvzTorL4g0mggKH9lry6/eM+qLhpyeOA2yo67AUAa34Ipno8I6kbUqQuoFY7IE9jdfm+P9kvQv3w=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB1026.namprd02.prod.outlook.com (10.161.207.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 07:58:48 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 07:58:48 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqRRyRYAgAAzNrCACkAS0IAAEWoAgDLEbDCAARhIAIAAAqUAgAhMEICAGj1cQA==
Date:   Mon, 6 Aug 2018 07:58:47 +0000
Message-ID: <BN3PR0201MB0993AA3A96D98AA6799C706DA7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180612080256.GA17399@kroah.com>
 <MWHPR02MB2816AE6D9F6C065DADA78D7EA75F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180715080206.GA19377@kroah.com> <20180715081134.GA20758@kroah.com>
 <541ba9a3-058e-028a-2a6c-a5d4334ddf96@intel.com>
In-Reply-To: <541ba9a3-058e-028a-2a6c-a5d4334ddf96@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB1026;6:qWgChHlqAMxRL9mVqRh7PBJ8mkihL/tz3RMme10GMsrgKECpyZ8IFYL+aEifMzSB/zL6vgjcEjRp+1P4sQwmYX2XT4sutyBgo1QLvtfsrwS+nDK6ta9lN27yl18Arbpfxdi41ZVOLRf/u8d7+Rl7JegMZeaQjDBOrk/ejNkVBJtimNpIr8D/qCYIrmix272tEA2uoNG1xJOTlKZB9rhvnqPjG5L7bSxnP4lDG1WdAB9eE0/JKNF6X76RQw5zjb/LHCBIlyesb/w3Lg48P4GQeqZeoSYnTjx2Nb4DiiSYI9a1hhN0/3QZ8OqyM5ZYCyl0lXhSz2T22n0hMHbJuPUxh8Ltxda58zofVah84/FdDQnsdH+NPi2J1+W1G4a74gmXWuJwrEEngJtfK0phP7DSiQFs+vtvMT+sy6ND3i8fYcbF7qWFf7bqJu2AM1PxQ8vnG8rQCiXw1DxlQVpht/NlKA==;5:o4IiQMTY/lkBibj/WrglvCe3WYl3EQzh/7jY3fWTnXxIJmdt7gwLycslr7ANeCoTPlQ8lA6qAfcdDkDvKiuZ0/uKws+qIifQskDbEsOqC30ihn2GLwG1/YEbyLbmkDlSeE1hcOlKx7L2HSyfp9ITM6EB0NX2ltmzqlwnO2IXoYA=;7:boB6C3d5tRSstZZzewUF+OrlEMzuNFaj+ZJuqleAZ+9ItJBFMw0YUQETmNQppHde61D9Pk61IKu56i9F+Bws2VPQQvycmBLkzP0BedvoQARf+L6+4tAHa/nbOCUQs+wvOQJpZn3GHE2KfY66ZMzRooEBtt9OahP0//qItjNW6nS9MUVCF5GegialaV5FeklTPur9T2JDL5GN0pI2K5rc8CmpLx1H/mMpzn1SkmEE7aStWh+GR/DWta1tq8nmyGZS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09580f34-74fc-4579-f0f3-08d5fb7270e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB1026;
x-ms-traffictypediagnostic: BN3PR0201MB1026:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB1026A9B6B2FA4C98F5FE7BB1A7200@BN3PR0201MB1026.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN3PR0201MB1026;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB1026;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(136003)(346002)(13464003)(189003)(199004)(40764003)(478600001)(33656002)(14444005)(305945005)(106356001)(105586002)(81156014)(81166006)(93886005)(2906002)(54906003)(110136005)(74316002)(7736002)(8676002)(68736007)(25786009)(256004)(476003)(316002)(14454004)(5250100002)(76176011)(97736004)(26005)(102836004)(2900100001)(6506007)(7696005)(9686003)(99286004)(6436002)(55016002)(11346002)(3846002)(186003)(486006)(66066001)(8936002)(6116002)(86362001)(6246003)(39060400002)(229853002)(53936002)(4326008)(5660300001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB1026;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a2Fp8GaxXlhzAKbbbTJI3qGIPzg0oYFJ9FH3eVnDrOQifi9tk3JbKfrhbUa0tV/VEGqSFYgihDIaBM4Wjb3C5gcx50vWBtq1dqkFIZX8W0fGkODFusMZ5vgFxOi/xWZ8g7bUEEuFP6AWZaE2wpIcW3rAuZiPX1N3x6AFQIZKo6Bo/kil6BZGKuRGXPoWnRcbxFVqodQo1dhAsJ5TxxcBjVu037XNSL5U3kSJDFN7tG85xkmLJCT/CudbEsV8PELU8xtHl27Od9zQle83NXidpbtwLPjaeVIiCrvaEi0Ysjv+4dvBF5VsRRLJk2qi43qsDKcbIyC+HIHE2ZkWFw+DAAfAs/UUVn86n9aa3ref/AI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09580f34-74fc-4579-f0f3-08d5fb7270e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 07:58:47.9773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB1026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWF0aGlhcyBO
eW1hbiBbbWFpbHRvOm1hdGhpYXMubnltYW5AaW50ZWwuY29tXQ0KPlNlbnQ6IEZyaWRheSwgSnVs
eSAyMCwgMjAxOCA4OjI0IFBNDQo+VG86IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBBbnVyYWcgS3VtYXIgVnVsaXNoYQ0KPjxhbnVyYWdrdUB4aWxpbngu
Y29tPg0KPkNjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPnYuYW51cmFna3VtYXJAZ21haWwuY29tDQo+U3ViamVjdDogUmU6IFtQQVRD
SF0gdXNiOiBob3N0OiB4aGNpLXBsYXQ6IEl0ZXJhdGUgb3ZlciBwYXJlbnQgbm9kZXMgZm9yIGZp
bmRpbmcgcXVpcmtzDQo+DQo+T24gMTUuMDcuMjAxOCAxMToxMSwgR3JlZyBLcm9haC1IYXJ0bWFu
IHdyb3RlOg0KPj4gT24gU3VuLCBKdWwgMTUsIDIwMTggYXQgMTA6MDI6MDZBTSArMDIwMCwgR3Jl
ZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPj4+IE9uIFNhdCwgSnVsIDE0LCAyMDE4IGF0IDAzOjM3
OjIwUE0gKzAwMDAsIEFudXJhZyBLdW1hciBWdWxpc2hhIHdyb3RlOg0KPj4+PiBISSBHcmVnLA0K
Pj4+Pg0KPj4+PiBQaW5nIQ0KPj4+PiBUaG91Z2h0IG9mIGdpdmluZyBhIGZyaWVuZGx5IHJlbWFp
bmRlciBhYm91dCB0aGlzIHBhdGNoLg0KPj4+DQo+Pj4gSSBhbSBub3QgdGhlIHhoY2kgbWFpbnRh
aW5lciwgSSBuZWVkIHRvIHdhaXQgZnJvbSBhbiBhY2sgZnJvbSBoaW0NCj4+PiBiZWZvcmUgSSBj
YW4gdGFrZSBpdC4NCj4+DQo+PiBBbmQgaGUncyBvbiB2YWNhdGlvbiB1bnRpbCBsYXRlciB0aGlz
IHdlZWssIHNvIGp1c3QgcmVsYXguDQo+Pg0KPg0KPkkgYWRkZWQgYSBjb3VwbGUgbWlub3IgY29t
bWVudHMuDQo+SSB3aWxsIGJlIGF3YXkgZm9yIHR3byBtb3JlIHdlZWtzLCBhbmQgSSBkb24ndCB3
YW50IHRvIGJsb2NrIHRoaXMsIHNvIGlmIGl0IGlzIGltcG9ydGFudA0KPnRvIGdldCB0aGlzIHRv
IDQuMTggSSB3b24ndCBvYmplY3QgcGlja2luZyBpdCBhcyBpcy4NCj4NCg0KSSBoYXZlIHJlcGxp
ZWQgdG8gdGhlIGNvbW1lbnRzIHRoYXQgTWF0aGlhcyBoYXMgcHJldmlvdXNseSBnaXZlbiBvbiB0
aGlzIHBhdGNoIGFuZCB3YWl0aW5nDQpvbiBoaXMgcmVwbHksIGJ1dCBsb29rcyBsaWtlIE1hdGhp
YXMgaXMgb24gdmFjYXRpb24uIFNpbmNlIGhlIGlzIG9rYXkgd2l0aCBhcHBseWluZyB0aGUgcGF0
Y2gsDQp3b3VsZCBpdCBiZSBwb3NzaWJsZSB0byBnZXQgdGhpcyBwYXRjaCBhcHBsaWVkPyBJZiB5
b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgSSBjYW4gd29yayBvbg0KZml4aW5nIHRoZW0gYW5kIHJl
LXNlbmQgdGhlIHBhdGNoLiBUaGFua3MgZm9yIHlvdXIgaGVscCBpbiB0aGlzIHJlZ2FyZC4NCg0K
UmVnYXJkcywNCkFudXJhZyBLdW1hciBWdWxpc2hhDQogDQo+LU1hdGhpYXMNCg==
