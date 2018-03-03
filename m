Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124049-2-6561155708166382312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124048; b=IZPJgBm6HU5oe+C9L34VICx7ACI1rjHqQZwbsYB/8WwTg3I
    2vklnI4dSvopOEjnD06WvsdmUKm6icoMJShPUukxo4AiPzv+FS2ibtgcDT5R6eYF
    gOC7EhFhP22eQM3elxc7EC3GFsAm5gfz7YtzxgxwZZ0SCsv5iGBds3nw6H52zKRl
    vVXBEg0vAAhevLFYS5lFOAZUzmQox5wCSs+iBOi8iRoqGBLN+Af2jP3SO3RD4S3p
    n15aDI09iVn0UaaHyhAq1U4iUg2rJviWG8ZuMUqDRBSMyQoc1HKtBi3Q+J8Cne0e
    fBjOFluvfx2HzzZZlA5YYwCqdMz+ePNz7Gtv8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124048; bh=MGLQ1eIaI1F41xo1ANKMwRs5XbrXWb6bje7KAf
    8UBYo=; b=QMvRaHekQ2coCuI8hIJ5+sDKyUN6275FdrZ2VQbRJKTjp8VEVmBVc6
    ji2/R4MszVJmiBiCv9+AINdam19oOrofJB88K4Nc1fq//qlX3IbM1zC8VH5R4hHT
    c5CV9Kq17of35lU1ozbj0i19Deu/OMp8po3GV/35ybqZg0RbzxEeI4QNlEvCuIHF
    Kp82LvZKVeUTHhYp9NrSu8/UBf1T6rT5fNTFmF86+aUH6mgzYm8ZFrgwkoIwdu15
    Wbk8g+QagSt1SeOnYfa/exmdSxg+S6BYWkkp5xAUsl5q8wZzmyQQy23FltAEQ1v9
    sp3sdkBX0Hw5Ckv8Ho6zBuWfkM8DQifg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CAJPFWCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CAJPFWCx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeCDAkb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:40:31 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932656AbeCCW0W (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 055/102] drm/amdgpu:fix random missing of FLR
 NOTIFY
Thread-Topic: [PATCH AUTOSEL for 4.15 055/102] drm/amdgpu:fix random missing
 of FLR NOTIFY
Thread-Index: AQHTsz5szlWiHPXRck6kpONQm8rdsw==
Date: Sat, 3 Mar 2018 22:24:41 +0000
Message-ID: <20180303222318.26006-55-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:eIf7pSq0oFGL05CrqQ+ZiP+3MxT2NnxYp2QM7oLBLXWv6CufbXg5aZdUMm3aq9JRixc89oI7p+JrFIWuKlkZvvUI30qJwXkv1HbwjHHMWq3xYSFQooDSbDcXHhQ7lwUaMbMLgki2BP7212aSe3LYxGes0M80Yltdu8AArWTpvXKnmDQDWl7zFWQWY+XUBJbSrAR2B++8opxAH8EFL0/fjWIA1XlX4ExtRIjsp3moNHGimJJr1EYhvynWWOA47cfn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08fabc02-d7d2-4d61-52f4-08d58155c67d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097094C2D95F13C3F6C9C0C7FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(8666007)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oq0YqL4gRBS/F+cWrdytvFKyG64UsvhlhM+0okzjwkb7TQIP7C6hVRg+HHjV8WuWcXcS59wyXJpmDBflOdgjmEV6Ek5yalpNQKN5CYPiRJSVF2xJIPY73eUsUc2JbBnwGgITTuYnKgtOANd7S1ANHKkWbjDZVzMv4z5wWaEAbZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD6993E101B2FF4F81E5840C11842168@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fabc02-d7d2-4d61-52f4-08d58155c67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:41.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQoNClsgVXBzdHJlYW0gY29tbWl0IDM0
YTRkMmJmMDZiM2FiOTIwMjRiOGUyNmQ2MDQ5NDExMzY5ZDFmMWEgXQ0KDQpTaWduZWQtb2ZmLWJ5
OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8
YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9teGdwdV9haS5jIHwgMTQgKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV9haS5jDQppbmRleCBiNDkwNmQyZjMwZDMuLjAwMzFmOGYzNGRiNSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMNCkBAIC0yODIsOSArMjgyLDE3IEBAIHN0YXRp
YyBpbnQgeGdwdV9haV9tYWlsYm94X3Jjdl9pcnEoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQogCQkvKiBzZWUgd2hhdCBldmVudCB3ZSBnZXQgKi8NCiAJCXIgPSB4Z3B1X2FpX21haWxib3hf
cmN2X21zZyhhZGV2LCBJREhfRkxSX05PVElGSUNBVElPTik7DQogDQotCQkvKiBvbmx5IGhhbmRs
ZSBGTFJfTk9USUZZIG5vdyAqLw0KLQkJaWYgKCFyKQ0KLQkJCXNjaGVkdWxlX3dvcmsoJmFkZXYt
PnZpcnQuZmxyX3dvcmspOw0KKwkJLyogc29tZXRpbWVzIHRoZSBpbnRlcnJ1cHQgaXMgZGVsYXll
ZCB0byBpbmplY3QgdG8gVk0sIHNvIHVuZGVyIHN1Y2ggY2FzZQ0KKwkJICogdGhlIElESF9GTFJf
Tk9USUZJQ0FUSU9OIGlzIG92ZXJ3cml0dGVuIGJ5IFZGIEZMUiBmcm9tIEdJTSBzaWRlLCB0aHVz
DQorCQkgKiBhYm92ZSByZWNpZXZlIG1lc3NhZ2UgY291bGQgYmUgZmFpbGVkLCB3ZSBzaG91bGQg
c2NoZWR1bGUgdGhlIGZscl93b3JrDQorCQkgKiBhbnl3YXkNCisJCSAqLw0KKwkJaWYgKHIpIHsN
CisJCQlEUk1fRVJST1IoIkZMUl9OT1RJRklDQVRJT04gaXMgbWlzc2VkXG4iKTsNCisJCQl4Z3B1
X2FpX21haWxib3hfc2VuZF9hY2soYWRldik7DQorCQl9DQorDQorCQlzY2hlZHVsZV93b3JrKCZh
ZGV2LT52aXJ0LmZscl93b3JrKTsNCiAJfQ0KIA0KIAlyZXR1cm4gMDsNCi0tIA0KMi4xNC4xDQo=
