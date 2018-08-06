Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D55921A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QnBmm3h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D55921A01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeHFNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:50:07 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:33088
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbeHFNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtZ3gWiGRIMkX5GwxF9EsxvePI8MadXVc/49jTXEPcI=;
 b=QnBmm3h+WyK9VKb9GNIKf7P08VN3W6zglCPjmh+VCQo8gc9IB0M+8xQJIgJA7c3zJsqFPpZUGwPvaS6vTB9Dj3vimOJZcg4DUUlN6M3Rqz2FY7LTa4qg8aX6jIIduD7Feq9S6GmQiaq6qtdhkjCXzHP3MpkzelZcSm4eUrbPjx4=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB0994.namprd02.prod.outlook.com (10.161.207.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 11:41:17 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 11:41:16 +0000
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
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqRRyRYAgAAzNrCACkAS0IAAEWoAgDLEbDCAARhIAIAAAqUAgAhMEICAGj1cQIAAPDcAgAAA6QA=
Date:   Mon, 6 Aug 2018 11:41:16 +0000
Message-ID: <BN3PR0201MB09936E8B2B5995EAEDF46E79A7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180612080256.GA17399@kroah.com>
 <MWHPR02MB2816AE6D9F6C065DADA78D7EA75F0@MWHPR02MB2816.namprd02.prod.outlook.com>
 <20180715080206.GA19377@kroah.com> <20180715081134.GA20758@kroah.com>
 <541ba9a3-058e-028a-2a6c-a5d4334ddf96@intel.com>
 <BN3PR0201MB0993AA3A96D98AA6799C706DA7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
 <b5078cd5-05ad-7e3f-a8de-f4ae43aa0815@intel.com>
In-Reply-To: <b5078cd5-05ad-7e3f-a8de-f4ae43aa0815@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB0994;6:QJbVBd+emfv3W8c1XyLzkfha5htrbxqDPATWvtai+iURaBeOuc0TmBsLw8v219I5hsJGQhD14MsIzygZmSoHR9ujV6nV2mYPUh26Vxr/YO4ygT4HRwLVRxqyDTZb1SmMRVTcXS9M/6MGPYMznHPYXTSU7J1lNOtatToljZyH2eeLp4Ux9eV2iJgED7q8B1Q4t7/eoxcyeei/2wJ2kcKAPo12A60ok00BHrrP+B6YMvAVzuNrzdKWIr97O7nH2f0vmF4HSGjwYqvOhytw2kyO5u7eyy/hVQnSxCHIQfYl8DQcgLhsGtCQe8nz9q+2y3gZFlYxpgeJvf4Np0O8cyc5JoEG9eGioq/a2RUKkyYdiXGImlHK11o7Hy4zf0yOPQ5eVLQmL4H1b1Lbr1zhvnOvJii78VC63zA88AnqVb+GwFMtXTq5wtgpKW2FFRVtTLDQpkcD6gOq4ipPYayU91Hmfg==;5:NHkckorbgOyqDzMw50uY0KFLZop7w6PQYSUlArYAs+SMz3yKbZYZZDUqNGaQ8TAlfyusjas8lbus7XxAJBZ83yFKNn2s+ZXhE3V0aE/790xXMojFosPV05xC2vACjLIX3BYvj+6fu5HtfC0gRgc3gw23Tt4rRHTukcFqv2W/Wl0=;7:q5Jbc3MYHm5eKhpYgdgugHQiUpWDDQlb1/FmuCtBqNVc7/lqSZR6NXu7r2N99DUZfPuLHVCua6Gx+AzQgphtIkG5yVOeH2jskb3/5CScp1JGv/iiCvLz8zac2+8a5inQdI5H5cmBIg4oExiPQFkza5ju/aLHbYNrSqYBBnRlTgRl5foUFSwWboWMuqkQZDyuaUdnitt9LsBg0aVs2oYgfGeqqduvaD4p6vXBg6DZyBu3yXYWITV8e5zL4HOsR26E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4df97a3d-24bf-4c87-11c4-08d5fb91855e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB0994;
x-ms-traffictypediagnostic: BN3PR0201MB0994:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB09940F388915826606118D5EA7200@BN3PR0201MB0994.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN3PR0201MB0994;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB0994;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(40764003)(81156014)(5250100002)(8936002)(66066001)(9686003)(76176011)(110136005)(102836004)(3846002)(6116002)(81166006)(229853002)(6506007)(106356001)(74316002)(105586002)(6436002)(8676002)(54906003)(33656002)(486006)(476003)(26005)(7736002)(55016002)(305945005)(99286004)(256004)(14454004)(478600001)(446003)(5660300001)(53936002)(11346002)(6246003)(68736007)(2900100001)(2906002)(25786009)(97736004)(186003)(39060400002)(316002)(7696005)(86362001)(4326008)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB0994;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rhzrek9njfjULI72M0/e9UeI2mCHFFjoPksEAzXvxIs5hAwBf9wYZ4m1h5kWhiELFTZ94qveY8dK9stPi/RMk2uFLqyNvFQlhzh6uMf/p+6tekcpr8zTlIhHsWD0QqBPLOgFpjdsTU67yOoNjnRJI0l71Z5Bo07BZOLjbgg71e/TvbIN4R+pvVL351OfPKcQA/3FFAI1umQyJ1CytLXfQQ2stgRTlQHSusF9kIF0RU34dr4ducs8465plN+ff6dKuoQE/ploju3TfiJvy5SpMcQh+GvaTf0kV2+p4umFq0DnZhpTNTnvaYHwOGHMYVnqHic8Puf9gIeoCOp1QbH6xhyQqRVorr1T1UHTFzcsYUE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df97a3d-24bf-4c87-11c4-08d5fb91855e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 11:41:16.7126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB0994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4NCj4+IEkgaGF2ZSByZXBsaWVkIHRvIHRoZSBjb21tZW50cyB0aGF0IE1hdGhpYXMgaGFzIHBy
ZXZpb3VzbHkgZ2l2ZW4gb24NCj4+IHRoaXMgcGF0Y2ggYW5kIHdhaXRpbmcgb24gaGlzIHJlcGx5
LCBidXQgbG9va3MgbGlrZSBNYXRoaWFzIGlzIG9uDQo+PiB2YWNhdGlvbi4gU2luY2UgaGUgaXMg
b2theSB3aXRoIGFwcGx5aW5nIHRoZSBwYXRjaCwgd291bGQgaXQgYmUNCj4+IHBvc3NpYmxlIHRv
IGdldCB0aGlzIHBhdGNoIGFwcGxpZWQ/IElmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBJIGNh
biB3b3JrIG9uIGZpeGluZw0KPnRoZW0gYW5kIHJlLXNlbmQgdGhlIHBhdGNoLiBUaGFua3MgZm9y
IHlvdXIgaGVscCBpbiB0aGlzIHJlZ2FyZC4NCj4+DQo+DQo+SSdtIGJhY2suDQo+SnVzdCBub3Rl
ZCB0aGF0IHRoZXJlIGlzIG9uZSBjaGFuZ2Ugc3RpbGwgbmVlZGVkLCAoY29tbWVudGVkIG9uIGFj
dHVhbCBwYXRjaCkgSSdsbCBwaWNrDQo+dXAgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gs
IGJ1dCB3ZSBhcmUgaW4gcmM4IGFscmVhZHkgc28geW91ciBmaXggd2lsbCBnbyB0byA0LjE5LQ0K
PnJjMiBlYXJsaWVzdC4NCj4NCkhpIE1hdGhpYXMsDQoNCjQuMTktcmMyIGlzIGZpbmUuIEkgaGF2
ZSBjb3JyZWN0ZWQgdGhlIHBhdGNoIGFuZCBzZW50IGEgdjIuIFRoYW5rcyBhIGxvdCBmb3INCnlv
dXIgaGVscCwNCg0KUmVnYXJkcywNCkFudXJhZyBLdW1hciBWdWxpc2hhDQo=
