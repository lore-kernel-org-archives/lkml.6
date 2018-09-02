Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09261C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCEE204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BO4JnnmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCEE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeIBRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:25:03 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbeIBRZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3XrUsjekJNXwVe9UqPkb+nY53mti2fpvTvUnNgsVwQ=;
 b=BO4JnnmRTNkR4/thfbhjbljz41zBBOmvy7D14eGPwuY0EQcDmMdAATpTSjBeXwlHSt41bAiCJkKBkWdYTsi/+unQdkDBgwmqXiMyuiCL11ciiMJClGF+KvCA+itHvfSoub5/EcIRVlvX0YXSzmMUhpeSwtyUj9JZgvtXgHN1Ngc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/62] Bluetooth: h5: Fix missing dependency on
 BT_HCIUART_SERDEV
Thread-Topic: [PATCH AUTOSEL 4.9 03/62] Bluetooth: h5: Fix missing dependency
 on BT_HCIUART_SERDEV
Thread-Index: AQHUQr4OBTD3w+vJYk+2nDTT41hu+A==
Date:   Sun, 2 Sep 2018 13:08:36 +0000
Message-ID: <20180902065131.183542-3-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:PXJCGlAO8DMLKPg9irV/DCHejgespPmRJi1/wHS4Ve4v6PjvurVAMDU2AnNxsSWuI5ZlxNEXbz8iQ3H77Bdxax6a3e3x1/+gc2EyCAirr7+4Q/uLFlVAt/OVlTDgmpPxa5EoWoZwI7nVLJtWqim56Zv08HeZCw74+R8kb6SdOX89GBAxNZumdfwnxkZzyNmzsIiHaMeRCckQzSNRQM41WbUFEhwi22LNgb+vq6BwRa1a0qvuGkh50225pCxNFnwSBWeiQj80JLojSEFDS4BEsMoxh4KMOVuNEcqoCAarAWLYFYyBMIjxpzpdvwLCtjdBbxWP99AeAJFSFxBHHY6/gftzTDiLPTULeeXCtiUZ3VXoDWYFmXIp7rlRP5rlr60WJUJTO+G1ErllF8r2as3/nUvm+dxk05/xhhQ7p/nG6mG9ABkHll6liMGAit3E9O39m6T8AECS2NLXEVGsf0Tuog==;5:FMjs+kNVL0dzC7T+WTY4lqBRVntMDaR7WizOt6mtg4+Ye/dZzpZDYk/krwAY6sMo1DiwjxtSHNFTlngRc+3c49LvQVPGrllDWg/9S0wLmjWApfA8Yblr68D5P4ha+vfQ0NADS9ywDN351ZEb1cuRr9VvcWYlorNg8lBnSbRdx1o=;7:Am+K4iGb8IYhbUaWj13PelGhVZtuirzklKVPDXUjjzR4rx1spaQEh8EFU547zFScsDe9RJYbC4vcSJ03xr+brHtB41EbS9Ui1ngreOu2M219KxJrZu0E3WXIP7mrSSLaMZ32TCFzoJ3PBNhhDDmQNwJyiHB893UkL028acOnJnIUHDIzDEDgKQZ0sMBxAd0JJIz79fagCq6Wrzpd4rHujlv/asXvVjMm5sPOQY4B0twYJcekmJqyDjTrd0JDT6jp
x-ms-office365-filtering-correlation-id: 3d4a6c20-4b2d-4303-bfa3-08d610d53bff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469DE3920C57678D915BBB4FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rrw700juk1hbsWqIOrNZhdbMwhl2LVDoDxnmQr+Bd1+CR6M9ee1DvbKwwudsubvK/uq+ObTE+XHD5nCTMCemdlQXEuqqBBx1NdoZw3f0zzqgVVY2Z7iWPriUnxK1OldSOStvt+cTgrgn9R3lZ6vhGETcx8p2lijVzpVdkuI/nBrUMliCjlIFoAB27m/703m8rYcMvHSWJz3JCCKQkXQvuo6DfpipzDWNzgXWYMD7tAXwzQdb75elsrHFlxIRCvmE/nv+r95pY903Ta8MseVpOjpD9MlKvzO10kNfBt71lNvkZquycCyaqkl1idW7ht7kRIet8+wJvi37+h+tSAI6jXa3ghsGealRcjZPTGwm6Is=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A44D98FC3AB942418D514B52FDDEEC39@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a6c20-4b2d-4303-bfa3-08d610d53bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:36.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
b3RoL0tjb25maWcNCmluZGV4IDNjYzliZmY5ZDk5ZC4uNGE5NDkzYTQxNTlmIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ibHVldG9vdGgvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvS2Nv
bmZpZw0KQEAgLTEyNSw2ICsxMjUsNyBAQCBjb25maWcgQlRfSENJVUFSVF9MTA0KIGNvbmZpZyBC
VF9IQ0lVQVJUXzNXSVJFDQogCWJvb2wgIlRocmVlLXdpcmUgVUFSVCAoSDUpIHByb3RvY29sIHN1
cHBvcnQiDQogCWRlcGVuZHMgb24gQlRfSENJVUFSVA0KKwlkZXBlbmRzIG9uIEJUX0hDSVVBUlRf
U0VSREVWDQogCWhlbHANCiAJICBUaGUgSENJIFRocmVlLXdpcmUgVUFSVCBUcmFuc3BvcnQgTGF5
ZXIgbWFrZXMgaXQgcG9zc2libGUgdG8NCiAJICB1c2VyIHRoZSBCbHVldG9vdGggSENJIG92ZXIg
YSBzZXJpYWwgcG9ydCBpbnRlcmZhY2UuIFRoZSBIQ0kNCi0tIA0KMi4xNy4xDQo=
