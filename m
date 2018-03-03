Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123505-2-12425551373764525182
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
    t=1520123505; b=b3GjKlDlVdkJhmZYl3uuaDJWW39jdITCED3ZskI+uYr11uZ
    agReEGoRpvTuFufdtIFI8zxM7qFPynH4dnvwk83ERth5QzIkLhAihyqLmeQn2HO8
    a8pi5LgMI7MTzSGGQLf7OhjycyyxmNBXsrzRMnFv/mx7vsLUQgK+KEqNirg8VLJT
    gJATvfXmUjQ6yOQZxBATi+B/WOtRgCjGYfCAazDBWp9HwaL8w/S50pB7/2vddWCP
    W3s8GBuBpNg4RW+BtDfNuMYOSDT++HKwJnzqMPPCIQoCmztqPLtTGxuuetrRu6p9
    6lUyB1v7qnqr91iJdReQ+M5X/x+HnuXiwRTxn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123505; bh=8fVqj/
    xnYKJmjoVR0XDIZj9OfZW+0bA9unSE8NRVWNw=; b=LxgIXb3KCQcLLd0b2H9IAf
    M9yuKu6qrzjzLvRGHXwU70Wmu0QS7xjuT+egr9mPlbPPwebGAavM26ZsdBO69bTM
    1crTXjpV+hru0k6LgMLN7MEq7XbAD8usjZ2XI8U4mrBGL/7h8Q3TTCzpjkTvMpgt
    yks/dxSRLgV1/udUAuNYiD1VgZXyfNvMFCBPaR99ewoARkKiHHDpcn8rDWElccgN
    9lG+43Qh+ZPa1kUpTm9wACf7BCWz/GYBPdM5ISRiRAAf1h0Ecar5IN0wQ7UXC/G3
    zV7/Ux2+C+Va6KJs76rBFOdg/Q1z62OJcC36ECsmTzyLsHz9woFTpsfpFMUuJETA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BdOFYfmk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BdOFYfmk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeCDAbO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:31:14 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933006AbeCCW1z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 096/102] Fix misannotated out-of-line
 _copy_to_user()
Thread-Topic: [PATCH AUTOSEL for 4.15 096/102] Fix misannotated out-of-line
 _copy_to_user()
Thread-Index: AQHTsz562L/4dcfpFUWcCX0Yng9hgA==
Date: Sat, 3 Mar 2018 22:25:05 +0000
Message-ID: <20180303222318.26006-96-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:fy/+/j0G2VgodFHfHR9C+jWr+Swh6wYFQfdYt6BARYSvO7Ej9dJ91BEuLhruDsgg2qnJ4nSkGAAc6mfUj07d46utVr6Gx8w8nZA2Fhhdss8jaPb7k7jUh4/zTMamDKit3c01veJikArqv522/2Qs2xd6je2cJQKftEevJHQ11PuATIeHVLfN4aUJxk01PK9T49bzQXOyPnsHUzneuC3p48rP1c1E342FS2RIrioKSW944D79G6DU1GeM2gwZdNG5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4587e1c9-1d4f-46a4-6af1-08d5815600fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06A21F7DA558BF321A8D1AFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5b5nqOSbKEJaqt43Vm+Ngto0FE2smbX4zITSPndaK5KA2KauPmbuljSc+IozsvEQnAkETTUnlGYAt/E+cEVZ2jQVSN+2N41vfsGpFohdxiXfMvtPCahwqWmvSQXgpCjoCNl8xqThgybWLOV5EEOgrgqwagqZzttMIi/l23XGiz0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4587e1c9-1d4f-46a4-6af1-08d5815600fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:05.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
