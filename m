Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120508-2-11113032088567142087
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
    t=1520120507; b=tzNnJB1YC50ZyY7yv5OIXK/RNo3w7v179/cjwulaPgyb8eG
    pnjt6dXWiplp/gJbhbDQPvQEkaFRAULcMjGfZzwDm7yQPuh9XH3Y+ESezpHA2Mqc
    zgcDUTnvZ6p0jfyR2MS4smtSFH0H287Zxf+EDEAysuBpGopAeIxujvgwGxmXu3a3
    AxzZAoS0z5LihnpUEVMDLM4ElCBB27JnlFJ9ew7An9FGxS2kQXNK4aHdJ25wpHzy
    aoRinzcmIRuiRUsVWd5kOtQc4PWCaZpe2WekDJQQsUm+lF9tO9N0hRPfKrkv76Zu
    rzCaHK2I4/cMJFV+jfhm1901sKTLP8XDDao4pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520120507; bh=7DuiMljz2MtcXFL1VDPTUAi38RYnuxd1qhcJYq
    P3THY=; b=AUaI6f1NW4PnP39bNhlTU0jH/QGAJITAyuZyxuBTkJso1fG6Ro743S
    ivZnSgvzagWw7NzyGg2aO8F/DkiaJ8aUchbz0rA3z1heKSedlHefkF61VPPgnQJs
    zUE6hqBCmaBs6WzFcGQtxb7fsMU+gB2Wc3farqvrEZmjjE0C6ofCpKIUTYuRKxgl
    3EJJcQI/Fj41pttiuwaqyIxvgPwHjg6m6hS6VINEfsxSEvrbjreyKkBB8V3QjNOt
    vOyL1Xi4pwr4bQi2XRONMV3k9rCsW0zLUC6iR8s8tr70K6wDikc/0Z4vf5cG/Kc3
    nRBJCXUJNTN5WMa7UqAq49xIn77ou1Yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cdrZ8f2k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cdrZ8f2k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeCCXl2 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:41:28 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934291AbeCCWe4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 129/219] drm/amdgpu: Fail fb creation from
 imported dma-bufs. (v2)
Thread-Topic: [PATCH AUTOSEL for 4.9 129/219] drm/amdgpu: Fail fb creation
 from imported dma-bufs. (v2)
Thread-Index: AQHTsz8NvL4gT2GcUk2M577Rr0MbRA==
Date: Sat, 3 Mar 2018 22:29:11 +0000
Message-ID: <20180303222716.26640-129-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:+OaRjcSiwQ975oc2AlJW05Vq3Sc3Xry6QG2Z1oDC7YMc26yVItWWQrviBbtmsCRTpaNdjtJp627NO3qR2wtKXxTftbk9uWQJAsxWkiBtwOCM2HsKFjN+djULRxsFAZvxqJYn/14nSPHFDpcIdWQZyUvUYEfEccI015vMUDOK38l3HJCYdLohsK/XJ9pmglOKuMDzmlQ/6YzZXxyFLGOQu3HrUC89bDHquS/AxOiN/nN0MVuppxU4u7jPf/qfocB8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fecf3a69-e9e4-4c57-c6bd-08d58156f8a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068451ED1F6B57BAB05DDEFFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110)(217544274631240)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(5890100001)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(8666007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cAEB4AswZZjrGFaylwJfS9rUEeVzHdxxLRRIm5xqKGXYhDP9tWVhIKv3lwEEt2BGFBlCBB/bHxjKfUL6lNxOMV/B9AhvHJUDI/czXCm7qPwNUZuRVaW9fm/wJz+v8XZd6ovSuGAYQf/CcwCA+te5veWu/e9v3XBV54c5lMrK7+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B456F077E476B41B21E0ED42D31049E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecf3a69-e9e4-4c57-c6bd-08d58156f8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:11.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
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
Z3B1L2FtZGdwdV9kaXNwbGF5LmMNCmluZGV4IDA4M2UyYjQyOTg3Mi4uMTVhMmQ4ZjM3MjVkIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYw0KQEAgLTUz
Myw2ICs1MzMsMTIgQEAgYW1kZ3B1X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsDQogCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAJfQ0KIA0KKwkvKiBI
YW5kbGUgaXMgaW1wb3J0ZWQgZG1hLWJ1Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0g
Zm9yIHNjYW5vdXQgKi8NCisJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KKwkJRFJNX0RFQlVH
X0tNUygiQ2Fubm90IGNyZWF0ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIp
Ow0KKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQorCX0NCisNCiAJYW1kZ3B1X2ZiID0ga3ph
bGxvYyhzaXplb2YoKmFtZGdwdV9mYiksIEdGUF9LRVJORUwpOw0KIAlpZiAoYW1kZ3B1X2ZiID09
IE5VTEwpIHsNCiAJCWRybV9nZW1fb2JqZWN0X3VucmVmZXJlbmNlX3VubG9ja2VkKG9iaik7DQot
LSANCjIuMTQuMQ0K
