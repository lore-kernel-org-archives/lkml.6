Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E453ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA272147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VULCg5kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA272147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbeIQIfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:19 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731476AbeIQIdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQr/yfEXA3G9cFb1v88yGqG1kXzQcF9MvvjHy3ZfuwY=;
 b=VULCg5kDo2aN/4Wum5pIO+ef8SUrUaqG3y8RWQHIOXr2lAL/cCQY+M2jybDtChSpfsBkKn1kJrRI8Emhs6S2+tw/XQJvv5CMVlhHW3weECyRKSBnnVBuPuzOH3oonoqwp5Z+pfBY/gpsv+igDGNpky7AKY5IL0UKfdeAUQ7pDAY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/29] x86/tsc: Add missing header to tsc_msr.c
Thread-Topic: [PATCH AUTOSEL 3.18 08/29] x86/tsc: Add missing header to
 tsc_msr.c
Thread-Index: AQHUTjNRPPuoqK5AEU2O8Q5hmc6u/A==
Date:   Mon, 17 Sep 2018 03:05:41 +0000
Message-ID: <20180917030533.592-8-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:NucvSNoqUW9xNq2zXHImSvp1guw2I63dxDrv37auSkcO8gyfTpNLmQBcYf+I3fa/2SSaA0OuuxwQZM1vkFlNryrolnENacuK2ohu8WdF/vK3OzPcq6Q1mTQUnheRv2bzHneTGNSxg+TEwky7fsu0qkOPgqEUhZ8PkWXEBo7PM9Mm2gTN54uE9nE1igqhAYL5gBnBAZB1raGGo6WxEurKHwC8pRWn6OOukU3fbdAnBkXe3/audZZedyg17TPan7U/YkdsYoeo6FDWrAsaaN4+BjeJ0GSni8ZXPSeyg9JnsVcwiDisIbCCSDKC2FfeG8+uIY5Yj+qWyJ5Zy/cRQu+PQ60fdUOa3O9CszfKSdI1vuSLl0z/cF3jxTVbKXjnDORG/R0ByTbJYLkOEFr3u/SfFrZp5OTvcMpOJjHqLvvavQrg4gZSSAWE5Avgk1juK1t6MYxllJCPhcZeww3UrF2F3w==;5:taCzEfZvKQy5t/eZKn3SjzNA8TeXlGt0/Qv91VIESSexpI4+jygoj2cUmlAhRgpZ3dHfNpUrvNklhAFkJwQwwrCKOXCqzfP7x2XM008PLT5e9oZdyJMs/MdtIkxB8nd3L+Nfyu/pmoTeR24P1OCmo6IAmgrhHEA3mE8X6lzeivs=;7:yqiRzBW71WrZnWB32tGUmR5O5ReeDDsxE8twaw7GkoFdAthN8/oNdYjPXPBBqQsqlmyiqdID3/FXhC3jI/K47X4rx5keM1var9YtPyDDYXaNzElKpgBz7XtC4l3xmIrD2OrSAWFLWB2BzyOYVZiN4FWD4o4HT7Vr20+EeszLm7n0UvsR9Eby3lLlTRBeIWv/EEjpqyHuLvZtsr4oGCX4o2JkqvpF1Tun8H2L+fArDdmWnTr54ilLtGO6ZAYBfk01
x-ms-office365-filtering-correlation-id: 1a18cbf6-36bb-4dac-653a-08d61c4ac0c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839E56D3F22ECECA4C58188FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(966005)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(6306002)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: d3URdv/mbTE1JeQkeQHS5fBRlOqscsEehcKXIlPLUQobEVyzIfp3E9VEzoJPjDfHPTp1MuHWwMU3jkefVr6nZhsWzJY0hqkzTwn3pjm1/fVK3lS0i5pExfwIHP1IJLvC2QQGZjq73SOWAz8okAy2ky523kmp4Xu/mLeoAXWyAzrsnARg6pZxp5QfjEqgn5dBLQZXzoTP05tu6B5+aQv/5zsdpKt3WLLtEhKRhlNaWvX9q0gxGGQyb9p0vSDHHAKvLEDdEhEk8jADf2LkF4fKiLFUYrD/otEAJoZ9gqKwewNXZPH0bfR3Iehx0fU2n1AoGevlwE65IkicnIXgOE/rr3ecNsvaVam1AMqOA5w5Ejc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E68C3BB1EC0994487883CFC9352CD4E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a18cbf6-36bb-4dac-653a-08d61c4ac0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:41.5921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+
DQoNClsgVXBzdHJlYW0gY29tbWl0IGRiZDBmYmM3NmM3N2RhYWMwOGRkZDI0NWFmZGNiYWRlMGQ1
MDZlMTkgXQ0KDQpBZGQgYSBtaXNzaW5nIGhlYWRlciBvdGhlcndpc2UgY29tcGlsZXIgd2FybnMg
YWJvdXQgbWlzc2VkIHByb3RvdHlwZToNCg0KQ0MgICAgICBhcmNoL3g4Ni9rZXJuZWwvdHNjX21z
ci5vDQphcmNoL3g4Ni9rZXJuZWwvdHNjX21zci5jOjczOjE1OiB3YXJuaW5nOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yIOKAmGNwdV9raHpfZnJvbV9tc3LigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQ0KICAgdW5zaWduZWQgbG9uZyBjcHVfa2h6X2Zyb21fbXNyKHZvaWQpDQogICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiAiSC4gUGV0ZXIgQW52aW4iIDxo
cGFAenl0b3IuY29tPg0KQ2M6IFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBvcmFjbGUu
Y29tPg0KTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE4MDYyOTE5MzExMy44NDQy
NS00LWFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbQ0KU2lnbmVkLW9mZi1ieTogU2Fz
aGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYv
a2VybmVsL3RzY19tc3IuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYyBiL2FyY2gveDg2L2tlcm5l
bC90c2NfbXNyLmMNCmluZGV4IDZhYTBmNGQ5ZWVhNi4uMGUzN2UzNjliM2EwIDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL3RzY19t
c3IuYw0KQEAgLTIxLDYgKzIxLDcgQEANCiAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQogI2luY2x1
ZGUgPGFzbS9hcGljLmg+DQogI2luY2x1ZGUgPGFzbS9wYXJhbS5oPg0KKyNpbmNsdWRlIDxhc20v
dHNjLmg+DQogDQogLyogQ1BVIHJlZmVyZW5jZSBjbG9jayBmcmVxdWVuY3k6IGluIEtIeiAqLw0K
ICNkZWZpbmUgRlJFUV84MwkJODMyMDANCi0tIA0KMi4xNy4xDQo=
