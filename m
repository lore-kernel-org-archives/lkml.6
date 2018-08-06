Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2289EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C158E21A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3rIUHzRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C158E21A34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeHFQOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:14:25 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:37856
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeHFQOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqgC3rBg2w0iGBVjlWt7k1JVwxGXIT8lmiyVHITUoAs=;
 b=3rIUHzRgY7K/d7ZxT4jZniUdWrdZZNdg1mXO9Q3598LDfCh0gjc23v7qPqYZO55uKRnGWs9eRvPJf8CyRkDB7himZ+FtRJnByCO+yNQnh3/e44TFnzr3wXZ0MdHeuPSCkcIuIRnc+/3l53eABu+i/pcpY9fgCtnwwkVaSjIWGsU=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB1012.namprd02.prod.outlook.com (10.161.207.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 14:05:06 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::d4fc:b478:dd6d:55c5%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 14:05:06 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH v3] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHULYYP1XPehd/Dd0Ss9p2pehlIZqSywBwAgAABPAA=
Date:   Mon, 6 Aug 2018 14:05:06 +0000
Message-ID: <BN3PR0201MB0993A760010FC4EC8345F274A7200@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1533560671-32640-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <532f004d-8a79-e61b-e668-958c162599aa@linux.intel.com>
In-Reply-To: <532f004d-8a79-e61b-e668-958c162599aa@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB1012;6:8HjIw8Yx+MogIUuNkR5bbt217n+8vmstQEIEHGGHNI7OatKwalSERHkgyEDHaMKT3roQogL6Utan8FzidE1ffjGcEXJxgcFQIPp1PXiIWkrH+dZBXDZmY8iOWhvUHSoWogD/IDrobfvmQpCcjlybl7VCjAj1GK2ui2T7czLaE7arh7u3PX1fz45xqrx4eD9KWPfCAl+7V6b8mfMpRdy/hxpgbVmyG1TWBify6shWSr5+EOQ2gQAixHiuyki4xz6vl8vzBQOBMDUf1gLjizgsed0nApxHd0xCTiw7pulzbvZljUch/x30ZW/Ueb8WkFfalrWWsv0FICzF91Jr1TdYIyytXFpkpGwfXYN1r8Eih735GsnDnLwA8/WTBvzFBhmChp3FYeHEBgVMKCJdFB6J8f33yp3Boj/oJR16fmAvYd7v31sEX8h5Om720xx0xRpNnIMBPTgma4C5wo61lMb/YA==;5:CsiVxbTvUJo4+uo08Wf0Nw6l775Neavk6+UwVa3kRLBfE0TJjUWr9iW6fac19FxjM/AaMvS1v9t5kOQrwqXUNhExcsavSInTWHu1Gj0U+SdKQUC00NVMH6Vk1vEdzfzPqtDehiwB0Mi4JmFjwQBcEoF1vXu9Zbl3y8XFo4nrcfU=;7:v45HebaMfTH+CVWgEE7aj1anUmvVwpcIDVrsFnrSqiNfq+Zodgc7uxG9k4JzszvxlEtkLD0+qkI5StQXA0v5EPTenQQt7rs8NQqjdVyCWvWp/JAp/BE1/MnoBpQnQ/iyZXePdxj7mIJaSV9Lu4wxXuK9zvzG+i0PxY/NbzQzgmWtibqtF8FP3LtBQ4d4qnDIujGvG267xiGtUW9w3+GW1TPvpDan3uliIRjI16fe6lpaeHTNrEKOZxiz9an7sUkf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f3b2b51e-2ebf-49d1-307b-08d5fba59cff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB1012;
x-ms-traffictypediagnostic: BN3PR0201MB1012:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB101273520DE5E7E08540FC59A7200@BN3PR0201MB1012.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN3PR0201MB1012;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB1012;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(97736004)(2201001)(14454004)(478600001)(5660300001)(2501003)(53936002)(8936002)(2900100001)(86362001)(66066001)(39060400002)(33656002)(105586002)(25786009)(5250100002)(106356001)(6506007)(186003)(2906002)(102836004)(76176011)(26005)(3846002)(81156014)(81166006)(8676002)(6116002)(6246003)(68736007)(11346002)(476003)(229853002)(9686003)(4326008)(446003)(55016002)(305945005)(7736002)(110136005)(74316002)(486006)(316002)(256004)(54906003)(7696005)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB1012;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: quzaNrXBWlZLZ6f28CS0C3Mr9qSBvyRyrNDnGUclRGcGtI3Pd1GPqwF3B8WcM7prMK1+ftHD0A1JdPZfddaHnOPvdklIdE88ePN0MCkNNfqvqfXYNnDdEzWAfEcIZCw4PcsZgYjz/nhts/XZtHB0MchZ4o7infZapYZfJXNOJM5r8S7jdtKdFjGHHIGL5I0WaBpAAURlSVCCFQP9slRn0Ym6O12wIYfqYvN3zjcLorBAPDmuMj5NRUi2czJdL6DjNjCPGqoXhTPhsUjlKC84fCACuZpNAxD3urdjCqwFN/8UG8O1kNk1+i1trpffhe7SJdu4NJhe0akIh5fViDaGAOYEc79rn42PHPg2lYNrduo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b2b51e-2ebf-49d1-307b-08d5fba59cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 14:05:06.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB1012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnVyYWcgS3VtYXIgVnVsaXNoYSA8YW51cmFnLmt1bWFyLnZ1
bGlzaGFAeGlsaW54LmNvbT4NCj4+IC0tLQ0KPj4gICBDaGFuZ2VzIGluIHYzOg0KPj4gCTEuIEFz
IE1hdGhpYXMgc3VnZ2VzdGVkLCBtb3ZlZCB0aGUgcG9zaXRpb24gb2YgcmVhZGluZyBkZXZpY2V0
cmVlDQo+PiAJICAgcHJvcGVydHkgImltb2QtaW50ZXJ2YWwtbnMiIGludG8gZm9yIGxvb3ANCj4+
DQo+PiAgIENoYW5nZXMgaW4gdjI6DQo+PiAJMS4gQXMgc3VnZ2VzdGVkIGJ5IE1hdGhpYXMsIHJl
c3RvcmluZyBpbW1vZF9pbnRlcnZhbCBjaGFuZ2VzIHRvDQo+PiAJICAgZGVmYXVsdA0KPj4gLS0t
DQo+DQoNCkhpIE1hdGhpYXMsDQoNClRoYW5rcyBhIG1pbGxpb24gZm9yIHlvdXIgaGVscCBpbiBj
b3JyZWN0aW5nIHRoZSBwYXRjaC4NCg0KUmVnYXJkcywNCkFudXJhZyBLdW1hciBWdWxpc2hhDQoN
Cj5UaGFua3MsIGFkZGluZyB0byBxdWV1ZQ0KPg0K
