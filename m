Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118449-5-11677500525804233248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118449; b=skwq4EIZb75xfZF9oqeIbCxXMn4hZNOYeopzvAlafIcQxQZ
    SWpbwXvUjiauS70dYoEg3UN1vCNlGUp2Sv5OTca3/hscnTq6pt9MY4+xV2OiirdG
    PzrWETU5SNNLYQRE1fwhbDp+J3E74wqMFXigLDL0HebrSqEnSSgMvud7lRz8KYzQ
    XFQg0iM/smL3UjIgwsj9EKOx3TiDx4ZdovR52fZVitpEGbw9KaVUWL+69GmN0mM7
    FYJj+fqQdcMotxZ36vPzv7MfAQEmVO3hVmiU2ekZRn0ZX+3QTy9QfWAuGpCP+H/j
    PwFoKNafTnmpEpMcUAzC2u7/2EUs2vWyGyJ5vRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520118449; bh=LFUrDWipVhPQBV49i1WJOhtQIXYbUXKtgDio8A
    Vrle8=; b=X9fH26kprW/ZfHMUHTTcZSoVGg4aVgCnihw+WHHts6eRFLjb/QpXnL
    21FMDwuO2hT7oW7C34DPaWtp+vBdRSo3I/Mr/+ZnrhGMWSLG6hkaGDZ275CHu0ax
    Zpt4VnUtvbvrnaLnejVi/db5aRdRS3akaSfB7YpRk8BUaD9m21NbBb5EMRzZziPL
    KybGSqEiHsEK8c8o3SLg9n1bBAVp4XE/D3Ne2238WFc5zGbDqGaQ6bvYte489FkJ
    O5LHNL2zAzIIJEHVs7BYnfkqUvqbXgqsZiO1iMDt8agfrduBZxuel17p9UJveYj2
    ywj2LFT39dnLD7ISoWSrkBQx4rERj72w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=etfubeXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=etfubeXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935205AbeCCWkN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:13 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935137AbeCCWj6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 065/115] drm/amdgpu: Fail fb creation from
 imported dma-bufs. (v2)
Thread-Topic: [PATCH AUTOSEL for 4.4 065/115] drm/amdgpu: Fail fb creation
 from imported dma-bufs. (v2)
Thread-Index: AQHTsz9eMkm6lhHEUkivySQgmPFu1A==
Date: Sat, 3 Mar 2018 22:31:26 +0000
Message-ID: <20180303223010.27106-65-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:hmcT18ewAp4/rgAW/c1MbyssQHmDdR9Be2Xyp8bVwX3Ak+imCgNUVgdWHLSz2JtghfxumUU3BySpkXKtQEXjIP1YmPPQ7gIeRLiTLmSl/64+/msbYpFr9u09sBbOQ+bjgn39UJa4hk4bcbdmvozJOEk4we4SvrjoacDzB7HlwwfFBixexEuLkSGgvcZQ0fTvuSGIB75YfAQDWAGP+fvfhsfnt/oTBoP8wZ1PcVd/mDtGX1UPeOtydjQl9LJp0qFw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f83b99f-b952-4fee-d5de-08d58157af26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1033BE57199695B2BF389AACFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110)(217544274631240)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(5890100001)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(8666007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: CYnsIAbMqG6ZL7zF+erZoS1rjaqF42yKo7Y8NDZP9nS8XBi/F/WMIohzc7b4auM6Uva3QE4j/fsbTEsmiUMMhwqG8cbwt0gGJvG2KPP7heCBmLEqvEl6i45LcbY8vNPn5+9GjfpbYzLC1Ty8ORqR0ByFQOwjBmXNXbRyO3OOpiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E23B920FF80EE4EAA625F646C0B41DF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f83b99f-b952-4fee-d5de-08d58157af26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:26.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2hyaXN0b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5y
b2dlcnNAY2Fub25pY2FsLmNvbT4NCg0KWyBVcHN0cmVhbSBjb21taXQgMTc2OTE1MmFjNjRiMGIw
NzU4M2Y2OTZiNjIxNjI0ZGYyY2E0Yzg0MCBdDQoNCkFueSB1c2Ugb2YgdGhlIGZyYW1lYnVmZmVy
IHdpbGwgbWlncmF0ZSBpdCB0byBWUkFNLCB3aGljaCBpcyBub3Qgc2Vuc2libGUgZm9yDQphbiBp
bXBvcnRlZCBkbWEtYnVmLg0KDQp2MjogVXNlIERSTV9ERUJVR19LTVMgdG8gcHJldmVudCB1c2Vy
c3BhY2UgYWNjaWRlbnRhbGx5IHNwYW1taW5nIGRtZXNnLg0KDQpSZXZpZXdlZC1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5yb2dlcnNAY2Fub25p
Y2FsLmNvbT4NCkNDOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDYgKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMNCmluZGV4IDgyOTAzY2E3ODUyOS4uYzU1NTc4MTY4NWVhIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYw0KQEAgLTU2
MCw2ICs1NjAsMTIgQEAgYW1kZ3B1X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsDQogCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAJfQ0KIA0KKwkvKiBI
YW5kbGUgaXMgaW1wb3J0ZWQgZG1hLWJ1Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0g
Zm9yIHNjYW5vdXQgKi8NCisJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KKwkJRFJNX0RFQlVH
X0tNUygiQ2Fubm90IGNyZWF0ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIp
Ow0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQorCX0NCisNCiAJYW1kZ3B1X2ZiID0ga3ph
bGxvYyhzaXplb2YoKmFtZGdwdV9mYiksIEdGUF9LRVJORUwpOw0KIAlpZiAoYW1kZ3B1X2ZiID09
IE5VTEwpIHsNCiAJCWRybV9nZW1fb2JqZWN0X3VucmVmZXJlbmNlX3VubG9ja2VkKG9iaik7DQot
LSANCjIuMTQuMQ0K
