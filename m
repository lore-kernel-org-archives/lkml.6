Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B19C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E2220837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SYHtnUgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E2220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeIBRbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:44 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:54352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730127AbeIBRbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrXVb+JjvYHEwp556OM2UfmaXbOlhs1TkMvHEm/gLlg=;
 b=SYHtnUgw0tGvKP0bMfYaBAVmT/wZDYUtd45gkVhRxOr6uWKnSTL860bMBMfTyCGiulmRGq2q7fW+0is2YiZMckznMaTQk5r/sdxYD0X914mosx6PiecbkmxAv+zH1YnQxHqB+zP0+9p12WpqjGsULf2XlpsPivsuD46ATYGAL+A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/47] Bluetooth: h5: Fix missing dependency on
 BT_HCIUART_SERDEV
Thread-Topic: [PATCH AUTOSEL 4.4 03/47] Bluetooth: h5: Fix missing dependency
 on BT_HCIUART_SERDEV
Thread-Index: AQHUQr8MSuf6ywB15UO3piyJDne2vg==
Date:   Sun, 2 Sep 2018 13:15:41 +0000
Message-ID: <20180902131533.184092-3-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:fvxTLPS+q6EM3bMJr9M/FOLiHH0VCkW4v+gl2rdOD8ZPtbRPjAI5GzpoAYeyPYgnVuH7Rp8j76etHEcuO21e5pU21BSu8FXB+DAq8N1WEUWLkbvb4TWdsPAG4fN5ykViIVewuh8wTZjlH6Go1l7RPQrTPZopQHiooxoNUikQgHr2EW3Y3gSJPnUpfpjMK3yWd59KNEkTcYejRWvCeOeOC+M/+uW8+qbLumAIy52ZYasid9F5vbNN5M6Vek3BU24zG4uiID2Zu9PcL+3SWcFtOtIUosUImEYf4MrSH4djWo7gx69OCkW0dWmVqDuhZSK11Snoy9QI7eR346fulTjh2jMZbYUbRrEk8pFulMq6CvyHIvUFrD+0z4oCbmtbTINWjXN0IcBlCyXwC+ZhlPwDU2vURaB6nclZNVN54phLB5aQnGPj8i6vkoL/COgM4l/k5NZYSeCxfz7fJhjH79JmOA==;5:5Jral+QcoiJsr0ULCahZycSht6YzJFatpf3DxTjVQNQEOh3AL2NdMoUDsBHKV9F29jy334v0CfyKgpq/Tmer41XmyNv4P+ZTEmnaWNPD8y/+43sXod+UwunJty5SIjp2zuN1NuIMefm55XL683R7ww87htfS0vwhEFLEiuFQlh0=;7:OYvXEwwybozGBRfH/4BnHSBvjGVbYJh3TVHgEgRiM0YIiRfFIIfYTFdyOPvlMwoY5+as0MJrlesvxm8lZ/tSCFHSDHpNAdOm6fHb4ECDhnE4ork4u+OtSxRKy/Q+nezhK6ObNNQgsmKAoGShRCwkdao/Xb34Klp7LTkCFYQW4NhLSLlmMQD3LwnXha0kl2TYvB8D8mO3eBfPbhnuTOmAnbo767Hrk9by+PaZovSCNluPLUBBqV5tWKx33Ht5nONq
x-ms-office365-filtering-correlation-id: ee43979b-1924-4a8a-2290-08d610d62ec3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184F167C8532057E777B4CAFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aV3LoqTh4WCJ2ZZq5oacuEJNaUArzEjaSmd27Kib85G4cHFY+hJOuY8UvjARfyyfTnKNO9M/VCUMUP6WGp7L61W3jMrYaS5H9H4Y+YDMlskeoUsROrMvj5tAh18SWbxn9xwh0NVlZK7oWhw4aAs5R4wL0tmgy4GNKyUlylVx5a6tsfAkM/aEY4GWTxv4/uzIAGVc61jfqNQAnwZO1wROmnYkgmN271jv5Dcn5xdeo3rmPvFIU9pd+qbK1fl072k8+yBm5GMiQPQBM5DmL4nq0tvjB/RxCuoP0J202MmpvrBmTUsleItp/0AuRE1G44ZnOJLPAeyo0KTEvqu0BqUHTLw10F7eB68zeOCEnKtzjUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4543590209E8B842AF2EAD8CC1786DBB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee43979b-1924-4a8a-2290-08d610d62ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:41.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
b3RoL0tjb25maWcNCmluZGV4IGVjNmFmMTU5NTA2Mi4uNDY4NWJkMTBjNDczIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvS2Nv
bmZpZw0KQEAgLTEyNSw2ICsxMjUsNyBAQCBjb25maWcgQlRfSENJVUFSVF9MTA0KIGNvbmZpZyBC
VF9IQ0lVQVJUXzNXSVJFDQogCWJvb2wgIlRocmVlLXdpcmUgVUFSVCAoSDUpIHByb3RvY29sIHN1
cHBvcnQiDQogCWRlcGVuZHMgb24gQlRfSENJVUFSVA0KKwlkZXBlbmRzIG9uIEJUX0hDSVVBUlRf
U0VSREVWDQogCWhlbHANCiAJICBUaGUgSENJIFRocmVlLXdpcmUgVUFSVCBUcmFuc3BvcnQgTGF5
ZXIgbWFrZXMgaXQgcG9zc2libGUgdG8NCiAJICB1c2VyIHRoZSBCbHVldG9vdGggSENJIG92ZXIg
YSBzZXJpYWwgcG9ydCBpbnRlcmZhY2UuIFRoZSBIQ0kNCi0tIA0KMi4xNy4xDQo=
