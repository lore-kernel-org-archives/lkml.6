Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122325-2-6846616011959185754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122325; b=VIvc9PCl7VAdpE2mhtGf8CMC7vnxjPGLYjp3iOWEGR5IRY7
    +twQ1a8lcW2UIdxExdWJe5RlQuGtXsFFD3jGjCaBy/o88AtcWbg4oBpZkmVnbkrH
    rZ38x/6NwoL3a/Ehnyfa+o9sOh+euHDJ1s7uorik7Q0f12Po9Od2iz+pZoNG+bUg
    /LFIAoHekM/IwYqRSU3PYfUojVQ4vlGJpYrsxFt+6E3RNtVRAWHMZmM4QAOBcM6b
    pqt1EQWHwGCjpP82i0x/HUPh+uCKB2MUvRd1KGzFclskYtv/VOeaUl2Lx9s12rEs
    w5ijKQN1EGKW0QxV92XqGXUR05py+5G2WZpc3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122325; bh=8fVqj/
    xnYKJmjoVR0XDIZj9OfZW+0bA9unSE8NRVWNw=; b=oB8v9t/fzTgBNZ7TBTzQL7
    i1gWieSAVzouK2h5jdzatv2YGYL3M276tmALFSx53yQ5g5iGDMS28UDBmqbf4huC
    FDMSDRlSdKWqrrIyr5WtLtcgZfvViJm6AHH5T1BAS+ibECNlaJv3eAQ4Js9dnIKQ
    WELz8s7ckM8QCQBwIT7zQaRQTs8KKjolNhF86kUOBlhCabhipy2N/9RH7vmvMuay
    FTI3hCoJUAquJfcZ/mz21WsYmEeOodfZc40T1Gtrnt0cODvoAEDSoWUpmCCk0OFr
    FreH2gq0dtDCT4A7P1QUWVSgKjHO90AXvyBQm807CAh4D2g0VIdlWcHgbbi8R/MQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AK1EGeb/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AK1EGeb/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933548AbeCDAL0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:11:26 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:32496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933175AbeCCWaz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 78/84] Fix misannotated out-of-line
 _copy_to_user()
Thread-Topic: [PATCH AUTOSEL for 4.14 78/84] Fix misannotated out-of-line
 _copy_to_user()
Thread-Index: AQHTsz62nnPBic0NMkWu7j6meDlxDg==
Date: Sat, 3 Mar 2018 22:26:45 +0000
Message-ID: <20180303222518.26271-78-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:rKpVtrLrrsCP8ubBH8Zro2yk0w7wAWy3dYFBecqYZMFdwuHntpcJxCCMU+elJYThfHVVUnJbidAApozJLvLkvduZPTZb9wbhgKFIWBnbM+hEP6fB0iOEBF6G6DG0kfQmTpxVmf9Qn4TfCyCh+jSzfQuuKC+YcyUEm104+Tf9zSSelxXSklnFZrC5n9rvLEzRNvdn62WGduT5ljXYE1YgDsKFdVFkODDyvculzdbJIolOhq0izbvZOax9r3DIO2/S
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a84a7ec8-d7a5-48fb-2a7e-08d581566b66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115D2F9E9284E1BDD25BF63FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7wz/xNFQ7rmfoSTp4EAUTHxGPbcy3EuiMOm1+bumZ37TmFuJv5Payi2wJ8mTfy6zCvgaPsES9vPm+ZCHa0O1loBZhMZ2fSbHcCe8O+QNDA/C/7jUvPPZJ7z8ywmR0STPlwX6kg+lKHNa8XbIRRBo/c3meBmlcEHtKCz1SzOjPrs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84a7ec8-d7a5-48fb-2a7e-08d581566b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:45.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit a0e94598e6b6c0d1df6a5fa14eb7c767ca817a20 ]

Destination is a kernel pointer and source - a userland one
in _copy_from_user(); _copy_to_user() is the other way round.

Fixes: d597580d37377 ("generic ...copy_..._user primitives")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 lib/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/usercopy.c b/lib/usercopy.c
index 15e2e6fb060e..3744b2a8e591 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(_copy_from_user);
 #endif
=20
 #ifndef INLINE_COPY_TO_USER
-unsigned long _copy_to_user(void *to, const void __user *from, unsigned lo=
ng n)
+unsigned long _copy_to_user(void __user *to, const void *from, unsigned lo=
ng n)
 {
 	might_fault();
 	if (likely(access_ok(VERIFY_WRITE, to, n))) {
--=20
2.14.1
