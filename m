Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118617-2-6169354006738120612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118616; b=SjXyLo3ksq3dzXWyYoM8VlIJsioqoxsx1DzGNjzGDTEDtkb
    t2m84XRMNoi701JJCPgliSoRtr25iexdM5AbqZ7YPUTUDaKdUUZelNmkbL5UqUsa
    ncVPyGxrnxiuz9soah4wf2SG/jLsx93aTgGjxMYno+YmnbpCLtrkwkEPLpjRZ6d4
    ejobJGTems9GikKP1nOuzF7Ump/dOiGvGS2IUd5OUhSYp3W9+2u6CSpIdD7r08AG
    kTnEYgBYRYYBc9rPJguQNXX3j3LA1AtiExRYsa/t/Y/lFmU3EN3kN231yk0J/ZwW
    D1GZXfZWOMjrkmgQHZLe3F8ycv5oupMbD7AL9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520118616; bh=hUKCincDlG1qxFj07X4Nl+KFR1zXLSjFrIixhC
    yBrJM=; b=fVNhPkUcYlH+tID/UdKvSxgaQMSCFIpPXHfW+1bjJWZHmz0q+60uCG
    AjTEhaQP3ss4fRXH79s6/F58hTrWJ8uTWruGd1IMirirTgqxfNsnpwnY7HyDQcuV
    R+3RcLSIG6y0A2b/H8Bbh1OBLV8WT0oYo7cLjrDCsJjhpk7pPL8zi3fmsnxjbzOA
    arWeYiJZ2K3nWPNucEXbxgnaTKgYAYaXjVWuz+UAEABELRfxbK4p0vHldUtRurO/
    qAUdDsdL/IHT6dyjJWobmUes6+5PDjca5M7fFA5RdD3aqos6PHBAddwEKKTShevX
    Qru6VuGSCHJ0Bn1l6+FNJzYzh5QGFBMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=isiyziKi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=isiyziKi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeCCXII (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:08:08 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934968AbeCCWkF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 071/115] regulator: isl9305: fix array size
Thread-Topic: [PATCH AUTOSEL for 4.4 071/115] regulator: isl9305: fix array
 size
Thread-Index: AQHTsz9g9cABIrSmEUuVxasUvxyylA==
Date: Sat, 3 Mar 2018 22:31:30 +0000
Message-ID: <20180303223010.27106-71-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:4w2Uw17g3xqqCJrgF0zqbsMGOUJKJgPSfxSAHsFlAVMS37PKbWL64P49Lx+ZaLwhH6YgbXywV6IoyXEAqpngbpXBDc9S3IyFPrGFdv2MU3uQwm6T00Q09x4JDKPq5ir5C8abG4VzIt9StNk5cz3a/IT2xQbWPyq0qA9GyG3PBtQUG5GrDneUFnT0P8ZYT5RbWpnx7BcQK9OPBG86SXpdbjiowrSFpCaKdAndLL2sidEwBCAIjNccjDDwu+X4Gg82i3yk3rrbKuPjHRERgipLNmA5jAZojg6UjM+jJDIfpFTXtW40Anuy8wMpgHrpuaDd+Vf5t8e8fmDuit5Dsaf8AvDVUQEYGPXZ3j9YsjFBw7qLK8o7Sycd1zzfUoGZX9xw;5:iiEVg8qibLNFrW0sGV80k6x+rqFoe6FelBxR1loBXc7d476B6Eo7efhDtdgDP0fNjkloCblK6BKxuIJja8N+ZXl+vdI0gbmU8YZXD7zU6qkoD1V4iri0vCUlY+AexbHRwWqQbUZ///GGMpElKEo5P7AJgdCpDWOvDXbX7HxztlI=;24:Xw47utTLnYMjGWyv4PjcIHoE2OdPYLEPYQ4JLdaq13sQ986oodKRZ+SOeAKNl7nO3ObzSftip4bxG2XOadxJlN0Du8jqqZIm8zUpebnVX+k=;7:1UIf2Ck1nxjR/48tYQKCnq3bI9ZDJs0/MTjDpbPvIcARntdtgupqd/8+bxTRwJqAyBfu+ht2oDkNDWbWgh4WptBEqgw/Y4ejlZuAdgs/3k/0S2M9NJ1sC0gNYLBkE/iekBQ7+Tt+92lHB9+S8IUJTF247X3hpG5t56+lq0SO233S14ntPS5ZRs/5k50Zf9sgUNcANkByguu2fcQYGFTgfNN92HiI5To10DH/cM52ma8QdJ2Wa0xh6Bmw6QdG/3fe
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7f446a6-0ef4-49c3-bec8-08d58157b135
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10330A6DABC8CAE8C9BC5A48FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(184751874519063)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(8656006)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: n6sQIfhVPBoCceR+88ng0Amt1vkxCizbLkt8BOEh9L/hWR368EOEkJXXIJNagvG+PYrXmxhN8rUG0xGHNxW9lXKCsdKVxyhOtn0Po1y/F0UiBQs/Phg046QKt1kqO11pW7Oe2eeeE+TKzpvjKkRIgluG0QQ7GrJJCgh29SxQE8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F93E9D19E420CA4E966AD8D458290020@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f446a6-0ef4-49c3-bec8-08d58157b135
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:30.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBsYXBvc3RlLm5ldD4NCg0KWyBV
cHN0cmVhbSBjb21taXQgMGMwOGFhZjg3MzE3NGM5NWU2NzRjZjIxZmZjZDA0MWM1ODlkMmU1YiBd
DQoNCklTTDkzMDVfTUFYX1JFR1VMQVRPUiBpcyB0aGUgbGFzdCBpbmRleCB1c2VkIHRvIGFjY2Vz
cyB0aGUgaW5pdF9kYXRhW10NCmFycmF5LCBzbyB3ZSBuZWVkIHRvIGFkZCBvbmUgdG8gdGhpcyBs
YXN0IGluZGV4IHRvIG9idGFpbiB0aGUgbmVjZXNzYXJ5DQphcnJheSBzaXplLg0KDQpUaGlzIGZp
eGVzIHRoZSBmb2xsb3dpbmcgc21hdGNoIGVycm9yOg0KDQogIGRyaXZlcnMvcmVndWxhdG9yL2lz
bDkzMDUuYzoxNjAgaXNsOTMwNV9pMmNfcHJvYmUoKSBlcnJvcjogYnVmZmVyIG92ZXJmbG93ICdw
ZGF0YS0+aW5pdF9kYXRhJyAzIDw9IDMNCg0KRml4ZXM6IGRlYzM4YjVjZTZhOWVkYjQgKCJyZWd1
bGF0b3I6IGlzbDkzMDU6IEFkZCBJbnRlcnNpbCBJU0w5MzA1L0ggZHJpdmVyIikNClNpZ25lZC1v
ZmYtYnk6IFZpbmNlbnQgU3RlaGzDqSA8dmluY2VudC5zdGVobGVAbGFwb3N0ZS5uZXQ+DQpDYzog
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogTWFyayBCcm93
biA8YnJvb25pZUBrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhh
bmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL2lzbDkzMDUuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmggYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaXNsOTMwNS5oDQppbmRleCAx
NDE5MTMzZmE2OWUuLjRhYzFhMDcwYWYwYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcGxh
dGZvcm1fZGF0YS9pc2w5MzA1LmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9p
c2w5MzA1LmgNCkBAIC0yNCw3ICsyNCw3IEBADQogc3RydWN0IHJlZ3VsYXRvcl9pbml0X2RhdGE7
DQogDQogc3RydWN0IGlzbDkzMDVfcGRhdGEgew0KLQlzdHJ1Y3QgcmVndWxhdG9yX2luaXRfZGF0
YSAqaW5pdF9kYXRhW0lTTDkzMDVfTUFYX1JFR1VMQVRPUl07DQorCXN0cnVjdCByZWd1bGF0b3Jf
aW5pdF9kYXRhICppbml0X2RhdGFbSVNMOTMwNV9NQVhfUkVHVUxBVE9SICsgMV07DQogfTsNCiAN
CiAjZW5kaWYNCi0tIA0KMi4xNC4xDQo=
