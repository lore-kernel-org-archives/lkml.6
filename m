Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488562-2-7424813272578695576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488561; b=vMbyerZUNRB6X9sqvcvzcWRea6K//+/NTHxt0gWdHoR4Eh6
    +yAgJtylj6HGAUP132x10lA8ctWPgHmdAGEGcgSq94v4g+hn5STJ3H2hssRW3BWG
    sKZJNBikUuhX6m27jFP4HGoSrnqe+txpAMSS3lll+YH9lXot1kRq59mfXd4gZh7U
    3bxFd6BPQNudddbxwiqq/6+usBxiDzRUT7jFv5Q8CIcySRsSsDe/BwG/m70fcs1C
    +3h0V0D4koaNmhD3cmbR4glN4+zXgwgQcwkwzobA30Tq2xX/vpRQYo4sSY9x2PIY
    ay8GvKyrVYyLnGCIQv/oX3ekx7VRq9ONFqcphfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520488561; bh=WdwQBN7x9r/Kjrz/ZvjvI64M4VYTaZ9qARoaTG
    Rl1UQ=; b=MMB+U4BI1gqIFMrw/NAlvK95ow2AB4GO0HMfg42ai5mUuQEnDjJOcR
    aZUPhLrK+lGABz7126LzpGnWW69zoBpNFMfSXgYInAsvqDKXBJaiuor304vhB6Sf
    nqVapkXSXBu7y4tb8oFiNPTYFoWRhroYLAxLOA/GhJ2a6hHQMMHvI3PgxFyEcYen
    2MUF9wuK2JZDLZhqOS3YFgfVKJ7GvS57JDRdCnkvyQZzlA90QoQ1kuckuIObMQ9i
    Qo6D/xhXUEa8kRjIA+B2K/HequIyRgx8RCsARH1uBB64SlHIYQI8GLz7q2yqOkvT
    inQKpSRSrmUO1n/LHYUKZ57EHmbz5W3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGY9CDLg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGY9CDLg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbeCHFzb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:55:31 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965655AbeCHFD6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 157/190] RDMA/iwpm: Fix uninitialized error
 code in iwpm_send_mapinfo()
Thread-Topic: [PATCH AUTOSEL for 4.9 157/190] RDMA/iwpm: Fix uninitialized
 error code in iwpm_send_mapinfo()
Thread-Index: AQHTtppQdlzmbxdwD0ONbfsGOyepVg==
Date: Thu, 8 Mar 2018 05:00:01 +0000
Message-ID: <20180308045810.8041-157-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:aXRLXr2ABh9ecWFuuCoJx31thAlxmdEuWBvPfOCq2j2eRAlSmlW7zqpH9mlNDDqNHyL3n+0uMb+27jTLlMOs+qQjigUjQvLb27e4+AmR9g2rUsRMFbYvXVtFFFe/BBlzBMfrfFnyTnzN+QloKdiXz1hVFq5JPWrdmY/kQ+5nR6Kr/8HsIEc5JjSnU707yO6jk9XHENGCf0jHQEg4dAqgKxdAgSHXrEi1+R5tiqW2heD/ylmbtmQ05dglObkA7yID;20:2iNqLGm/ySE28xCxcLjYDY35mRAJTyaCKYx25K24cs52SBqLcAwP/ICBwPKCbcKLvJBNZHC2TpMVTwj9CfBHYzxyvkiq1YgamnIYq+cV4yBHdTVNoKl7quaZacWDRyhEtJhNwusvC4t7sW9stxXn87NDfVaGiKX+TBmmlQ9D5uc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4442674-04ca-4702-36ae-08d584b1ff29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919DC5F5AA289619A7DDDF5FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vxqN+RfZNPwM5+ZZgQg4ctV+iXORjGze/lHOJUcbC2124gWTFBAbaEqmnF/iTtqfdl3J380b+1mAax8JU2DE1OsHboPsPyLA3MxdSyoTxauylO1trebmAOtgDbOVVIHV/fG0yTL7tbIvf1Mk5LWaNOpuRePDlEhsA6vL4TlKPvvoRVoRO7G6YmbAnR7Vr6xYVIF2FgwxYuCu+paiLYj/KmDtmGAf8cdLVnen+lm5rbgqavbIuplO5XDeTRFBinvnEGtNe4TQI75m+rymzjh4vtHN6bsUrLqpWA6m9beZ1CmihHv6QiQEEmCrU9eco5/5TUJaSmk7wyyz/8j66Bj36g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE5D36E09BF37A4F82F957D33FEC0DDE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4442674-04ca-4702-36ae-08d584b1ff29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:01.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCg0KWyBVcHN0
cmVhbSBjb21taXQgMzAyZDY0MjRlNGEyOTNhNTc2MTk5N2U2YzlmYzNkZmIxZTRjMzU1ZiBdDQoN
CldpdGggZ2NjLTQuMS4yOg0KDQogICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaXdwbV91dGls
LmM6IEluIGZ1bmN0aW9uIOKAmGl3cG1fc2VuZF9tYXBpbmZv4oCZOg0KICAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL2l3cG1fdXRpbC5jOjY0Nzogd2FybmluZzog4oCYcmV04oCZIG1heSBiZSB1
c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbg0KDQpJbmRlZWQsIGlmIG5sX2NsaWVu
dCBpcyBub3QgZm91bmQgaW4gYW55IG9mIHRoZSBzY2FubmVkIGhhcyBidWNrZXRzLCByZXQNCndp
bGwgYmUgdXNlZCB1bmluaXRpYWxpemVkLg0KDQpQcmVpbml0aWFsaXplIHJldCB0byAtRUlOVkFM
IHRvIGZpeCB0aGlzLg0KDQpGaXhlczogMzBkYzVlNjNkNmE1YWQyNCAoIlJETUEvY29yZTogQWRk
IHN1cHBvcnQgZm9yIGlXQVJQIFBvcnQgTWFwcGVyIHVzZXIgc3BhY2Ugc2VydmljZSIpDQpTaWdu
ZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KUmV2
aWV3ZWQtYnk6IFRhdHlhbmEgTmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQot
LS0NCiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYyB8IDEgKw0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvaXdwbV91dGlsLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0K
aW5kZXggYWRlNzFlN2YwMTMxLi4yZmU0YzJjOTIxZGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9pd3BtX3V0aWwuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
aXdwbV91dGlsLmMNCkBAIC02NjQsNiArNjY0LDcgQEAgaW50IGl3cG1fc2VuZF9tYXBpbmZvKHU4
IG5sX2NsaWVudCwgaW50IGl3cG1fcGlkKQ0KIAl9DQogCXNrYl9udW0rKzsNCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJml3cG1fbWFwaW5mb19sb2NrLCBmbGFncyk7DQorCXJldCA9IC1FSU5WQUw7DQog
CWZvciAoaSA9IDA7IGkgPCBJV1BNX01BUElORk9fSEFTSF9TSVpFOyBpKyspIHsNCiAJCWhsaXN0
X2Zvcl9lYWNoX2VudHJ5KG1hcF9pbmZvLCAmaXdwbV9oYXNoX2J1Y2tldFtpXSwNCiAJCQkJICAg
ICBobGlzdF9ub2RlKSB7DQotLSANCjIuMTQuMQ0K
