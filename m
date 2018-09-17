Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C526EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F8214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IpVr4Qy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbeIQIbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:00 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbeIQIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnkyAxujqFH6gcOQxW10uTBqWLjbvD/FcfUOojddAAo=;
 b=IpVr4Qy26NlVlXSWX2Pko+RcqJbttgSSP1fPKAu6hneXxQPcNMA017RBuIi8yBZwnbMSgZIBBLp8yh5jkOzwTgldWjn9RGZjr6oA1JapSQNqU3AAm2WjU5n+AT61k1+N3+oyZJlK+vYtG81oMfIAvobCxFGbHNY0ct3cPGRCfeU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 21/57] x86/tsc: Add missing header to tsc_msr.c
Thread-Topic: [PATCH AUTOSEL 4.9 21/57] x86/tsc: Add missing header to
 tsc_msr.c
Thread-Index: AQHUTjMS9pPutSUvaE6WEVPmPg141g==
Date:   Mon, 17 Sep 2018 03:03:56 +0000
Message-ID: <20180917030340.378-21-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:/x8rJJYX7CT8GkKkUTpuAqRjnJO+B3H7W3LTy5DBCZ/J/Mju29g+960TnK4XmO2QNdycAQwdKTixEMS7o6/4PTnHybBUTu5yPNS4gB9USVEU40hqw55zRhnULv3GqsLp5ekeCoqInz7lkCAVBgm3XOo5yFjfDKDBVDxPaZLwo3DD2O9lml637/8H6anXAcFsD8iR6bdYerK/ycI17C6XlWYFimxvg06Hbn0qbsEvR1zU9lc8aXzrwx0VjRu22DIz8achdEG4kLr3c/EP1bRES3bQcN0F2iJjw34Cer43UXxO0msJ71E/p32nCSQQJ1WaTF8Y8prZ2Z+YZ4u4Pmmw+ywN3P0wUP72KDWrUjidjkaRKUQmfKwQ7d7CzVVGXmygrPMjSmrBoOfuqPycx3muH08e9s80elI0uuhZ6UFFTJ/slkaSi20pzPvTQ3UaHDmnmredVloagzpGKJppns57Uw==;5:zaU/PZv7GMhV3qgzJJvBv5k+80SYxpnWtq2Wih73JviJy+2yJS2LfI3dVDMuXETPKtyfCBHoBxQk5LJqdzxU4pCTt3V1uQiZBfa47RfKlgJOvnvPMweiVkYiQcZnyLhBAwKkjObmWhUeaxWDGgYRO/0LOk9l+CE4UoCKhbpBlQQ=;7:jNFtb5nBXR89XdUKK6xU3Q+e9o7EzN5nG4pbUFNouETA55DYy3wxEpyVRco4vR5mClQOnnlSO88ygvQmdygzLCk86LkIPNwolJkjxUmI9Nax2NKuaMaXV/d7lyIxYagUZ7FfExlDNuufql38ej3Eb6bGNynS8s2e1vy0aYyxvwQSbeNYSbWFebtO2dflUVO2D9wJjt2z49d4WQ+K4kXmXU4O1UDkd8r4imPlUda2BbfpEnoyRelLqdXm1nfKj/pz
x-ms-office365-filtering-correlation-id: 70519a28-caf1-4056-60ae-08d61c4a748b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757D6E97C338AA29A21A776FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(228905959029699)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(575784001)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(6306002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(966005)(25786009)(6346003)(6666003)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XFtYfj8S5F7T8trOQCvJnpp6qU08PZupt23y0Xiw/xDhLqxCcIFJ7Bm9v36e83/GpJNCPBuvJT0ARjmenW264Bh3L/VAE2D/NscyXEVty75E3HOytb6J6lEETWaAgRQJbjGI4Hbbr9qiQKmvfKZ8gsDgY+zGSivtS1H8DYqI28QXmeeebpCbbQDznwrU9lorL2kVizjETNFg3UvbWcPEcIRAIPM/2izYD5DhKs5uJe4E0VW5r3ofdnM0Z5LzWB3Ri+oqXVPmq9vnXZ6u0ULYciHz6H31fqDTTFX7g7EfwBcxaTwLEnbHPUJNfN/a+8STuct0uXKX8zZzIhaGIw4t0neXratlh7qttcOCbvd3N0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <39E5F2F5580E584FAF01A5CC15522F05@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70519a28-caf1-4056-60ae-08d61c4a748b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:56.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
bC90c2NfbXNyLmMNCmluZGV4IDBmZTcyMGQ2NGZlZi4uM2Y4MThjZTk4NWMwIDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYva2VybmVsL3RzY19tc3IuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL3RzY19t
c3IuYw0KQEAgLTEyLDYgKzEyLDcgQEANCiAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQogI2luY2x1
ZGUgPGFzbS9hcGljLmg+DQogI2luY2x1ZGUgPGFzbS9wYXJhbS5oPg0KKyNpbmNsdWRlIDxhc20v
dHNjLmg+DQogDQogI2RlZmluZSBNQVhfTlVNX0ZSRVFTCTkNCiANCi0tIA0KMi4xNy4xDQo=
