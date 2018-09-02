Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE34C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2A32077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e3BvlIXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2A32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIBRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:53:12 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbeIBRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCqtjQCl2jR73QnVrlqK/l6CZ1VmD4K9YbVYCTya6nk=;
 b=e3BvlIXNJCaGl67Ipppkq8kcqK19AWfCLhrtQ5pK4lS3qXn72WnL89t3e7eJ63zddt8dnxdig4CHhhQNSiUb3ElTy0at9yJAmdXtDiGtnyeLqndvuYoDQ9VrvKhSTlgQsj7zCNTmQySLIlCSIbcFTQDffDDsEW/8yApua+yf0mI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 007/131] Bluetooth: h5: Fix missing dependency on
 BT_HCIUART_SERDEV
Thread-Topic: [PATCH AUTOSEL 4.18 007/131] Bluetooth: h5: Fix missing
 dependency on BT_HCIUART_SERDEV
Thread-Index: AQHUQr1KleXMWwHw6ESM9MzhXRcdXQ==
Date:   Sun, 2 Sep 2018 13:03:06 +0000
Message-ID: <20180902064601.183036-7-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:Qiq2Nll0shwI0D/VzYouneOHa99tA5I1Wfy2vDFjJEPlUt5MFuAVHDJNDy82m+TMz9lCzZ7riQ4rfzEk70TAUoECs4hUVlHmEPL7Q/G7nnL/8wIj3aZLaXrHw4PSD9GqIPWmQ6qUCN6IdrVJrwFjuJHgKgBY7WaktAveusXuFSrt7GoT17hJTwjycy5sKznfas3ZYumRXeG7ZJuN9rIY87KSxyRktBp8eCyBXXQhQo9/HgwWkAZNPy3SqtRxTZ0jdToJExtWrjouN5QaB6Ay3E4WQSNEPwskxW4lg8GLTb0AapS3jR2TECiKyLiQPXn9TtGnlnQXj3XuCHQUGxnX4IKpApLLkGigpxEm/SiTdJ3X3/bLUb563G7aYaEdhk6aPwnyle9UxTxk8oQQGDyDi72DT8PM4IRR3yRyLmpcgSKrrrIZjxm/PIJxd0vMWPekTuXNgSJmDEEiCKYrxrYlHw==;5:sS337knUIBdvUDosWUCChgW+yJXaDYb6cON/vqWF0dguK/QoT7ZqgoiYYFr3MpzH/MtnR+rzQdiTzrLVkoDM3MmjethWObilvTSst6XzdyjjcuaCGUp427C6Z6/Cj6eb6YNf9yhWvr7vC8G10RzfsHcJZhoGrvrtU1jkQvmPSKo=;7:1acJaVczkwAcROOqlCKnrV28ybZ+7i1h7FSJyVJc3KVcNAVMpVMK6w3wrLQV2xL3jLqsutBdaoJ9TTO5+SqZO8RzgYjEaAg39+S/Op9IXvoLDW0NrAjSiHo6Ms5e3908DN9i8rwR7oPvRyZ3pNDWrk8I5t+XfgRQyuK48xQ6xaCHdwOxTjIRbKu4VB2mFyFlSYOPQ9wOkKTc6NyUkkYbJpsYpx70Z4c/Jad6TgBtM0rpM3qG8G9yzixpIFQWCS3L
x-ms-office365-filtering-correlation-id: 76ef0a15-7bd1-42f0-add7-08d610d46ce9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837F7FDB70567282DD2F73AFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n2wgg9+JuP7IhxDKhxLa7iLnQA71pjRLq3QwXdI9gnxiXXEzj5PIoPG/6EOrLqGPkDHB4P5j8AjT3TsRbxAGWhNwfigostYrqTAX8/8IEFDzeA5SZyghExvL8aubn7oaLiS1Q3r4LmXqdWYUu5gdy1thac2n0726FIa2kStYteN4I4GPHjsiPaV0YwNdoLQVrh63xxs7NJt1HXHuiu8JpcXncJZhNeNPwM9s6v+nrlTt6eQdo7JF50jAui780zJPgO+K47v2nCY1BP+EaUE/8B2zvNVx0tNDDL7O0WPmGbQyYa7HAWLuAEJbdDksmurHh2iD7uGEkM4MVZQwOBAzDAg6JonzqBqZjLBa8WKJx80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5633EE3BE63DA0418BEF80D23D7C5793@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef0a15-7bd1-42f0-add7-08d610d46ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:06.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BpbnRlbC5jb20+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDZjMzcxMWVjNjRmZDIzYTlhYmM4YWFmNTlhOTQyOTU2OWE2MjgyZGYgXQ0KDQpU
aGlzIGRyaXZlciB3YXMgcmVjZW50bHkgdXBkYXRlZCB0byB1c2Ugc2VyZGV2LCBzbyBhZGQgdGhl
IGFwcHJvcHJpYXRlDQpkZXBlbmRlbmN5LiBXaXRob3V0IHRoaXMgb25lIGNhbiBnZXQgY29tcGls
ZXIgd2FybmluZ3MgbGlrZSB0aGlzIGlmDQpDT05GSUdfU0VSSUFMX0RFVl9CVVMgaXMgbm90IGVu
YWJsZWQ6DQoNCiAgQ0MgW01dICBkcml2ZXJzL2JsdWV0b290aC9oY2lfaDUubw0KZHJpdmVycy9i
bHVldG9vdGgvaGNpX2g1LmM6OTM0OjM2OiB3YXJuaW5nOiDigJhoNV9zZXJkZXZfZHJpdmVy4oCZ
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC12YXJpYWJsZV0NCiBzdGF0aWMgc3RydWN0
IHNlcmRldl9kZXZpY2VfZHJpdmVyIGg1X3NlcmRldl9kcml2ZXIgPSB7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQoNClNpZ25lZC1vZmYtYnk6
IEpvaGFuIEhlZGJlcmcgPGpvaGFuLmhlZGJlcmdAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
TWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9i
bHVldG9vdGgvS2NvbmZpZyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZyBiL2RyaXZlcnMvYmx1ZXRv
b3RoL0tjb25maWcNCmluZGV4IGYzYzY0M2EwNDczYy4uNWY5NTNjYThhYzViIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvS2Nv
bmZpZw0KQEAgLTE1OSw2ICsxNTksNyBAQCBjb25maWcgQlRfSENJVUFSVF9MTA0KIGNvbmZpZyBC
VF9IQ0lVQVJUXzNXSVJFDQogCWJvb2wgIlRocmVlLXdpcmUgVUFSVCAoSDUpIHByb3RvY29sIHN1
cHBvcnQiDQogCWRlcGVuZHMgb24gQlRfSENJVUFSVA0KKwlkZXBlbmRzIG9uIEJUX0hDSVVBUlRf
U0VSREVWDQogCWhlbHANCiAJICBUaGUgSENJIFRocmVlLXdpcmUgVUFSVCBUcmFuc3BvcnQgTGF5
ZXIgbWFrZXMgaXQgcG9zc2libGUgdG8NCiAJICB1c2VyIHRoZSBCbHVldG9vdGggSENJIG92ZXIg
YSBzZXJpYWwgcG9ydCBpbnRlcmZhY2UuIFRoZSBIQ0kNCi0tIA0KMi4xNy4xDQo=
