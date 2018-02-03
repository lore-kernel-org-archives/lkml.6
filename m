Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1639138-1517683911-2-7683345069590316997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683910; b=d5f3mkrsaSC0gipJMeKkjubmVm94OzvstpeJg4xpU9YBtYJ
    OWybDkNE5OilZtIQjMlUSN3x9VSYdnvEmoj4kbpD6sqn0bkD0nAvGUgsrFmHPao1
    9J4QO+TOXunbmnWCElpzM0FSBJdQcs54zJf5uBBIuN8ozM+sLxlNUVFka9MFc7yT
    9pGQnWB+VHChPVTiIc9eIQwlsfHEvvsrdhyfv0rrkD/DYiE8/cotZX5yzdasFEu7
    KPo1acym3m0aTE0T64W0+2oxB6e0rFm7pRL+N45MuDwIRQ+HzbdMBMBvhLCfxzqD
    QbTbomFTX2tUs7KIkIvwgbCBRVOWq7qSsRdaFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683910; bh=yT1Spp
    594UK1hqaPd9WhSdysY5YE9YM9gFHQeX5flWE=; b=TYol9y+okTlMdllyWGnnaD
    yCxjxdzKz5KJi4qklraDby1r56rIFMwkwefFGbbMXMZupD2WHjyHdQrXFU7CUZmS
    +ggcALm6ytKO0AYxvPxYqr+zwwb6GJ1hmvs7wxjASVmq1YLw4Ka3qwMZOQbmtE8H
    Kk0lEyKf0VqQcGwp+IaDvLZqNIoanRLDmE9G/wpdix0aGLc5YvRGidBiImDJFMUy
    GfFH0AbgN4vcVRgAUHZ6kah1U7EuSk+qNAlCZpVLbzDHz9svi6F1E43O8eXC1eZ5
    O/NY8tlQ6TH/28DGrpk/34QjedvOGqH564KvLW4FT+LD5wqYrPHGp9iZXfgBN7Nw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sler5B+F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sler5B+F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeBCSvp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:51:45 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752581AbeBCSBT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 016/110] parisc: Reduce thread stack to 16 kb
Thread-Topic: [PATCH AUTOSEL for 4.14 016/110] parisc: Reduce thread stack to
 16 kb
Thread-Index: AQHTnRjj3m0Cl89qUkSsCjIzyI54sw==
Date: Sat, 3 Feb 2018 18:00:34 +0000
Message-ID: <20180203180015.29073-16-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:SSPqeGpUQmAXUFJRqflFB2gVUdJkk0Rnm51KAopuwfBw9Qtc3mmufJ+Y8nfsiTql8P/L3NFI04rs2OO0Ld6kYlzeuhbZ3hfrSW53v86h3L4apdNHk613CuqCT/ni945i3oysGa2sivD6bpKGppGpQ6kEwXGZmMbvsNxoa0khD5BKGHc/q8cX8Af1S219kZiD/Tks6FYB9BEkYo9JhtBlt2ESUqJZellxn5kd7gl6hV0rKYrGcIkAJ3nRUpdNpetL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f9ddb63-4472-43ff-39ee-08d56b300751
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB104358544EC557B73A812AB6FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(192391740597602);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(8666007)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2J5YKhEi581AmPv9uRmnXiAwQ5Emq1mPGiNiSQhLjFYPtYLb0kCo2WaaJ6DCMC8g8vYGzQbzs/eoZQrlHeEQQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9ddb63-4472-43ff-39ee-08d56b300751
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:34.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John David Anglin <dave.anglin@bell.net>

[ Upstream commit da57c5414f49ef9e4bcb9ae0bbafd1d650b31411 ]

In testing, I found that the thread stack can be 16 kB when using an irq
stack.  Without it, the thread stack needs to be 32 kB. Currently, the irq
stack is 32 kB. While it probably could be 16 kB, I would prefer to leave i=
t
as is for safety.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/parisc/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/as=
m/thread_info.h
index c980a02a52bc..598c8d60fa5e 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -35,7 +35,12 @@ struct thread_info {
=20
 /* thread information allocation */
=20
+#ifdef CONFIG_IRQSTACKS
+#define THREAD_SIZE_ORDER	2 /* PA-RISC requires at least 16k stack */
+#else
 #define THREAD_SIZE_ORDER	3 /* PA-RISC requires at least 32k stack */
+#endif
+
 /* Be sure to hunt all references to this down when you change the size of
  * the kernel stack */
 #define THREAD_SIZE             (PAGE_SIZE << THREAD_SIZE_ORDER)
--=20
2.11.0
