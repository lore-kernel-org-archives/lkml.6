Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116345-2-11957402545086743253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116345; b=WaB4/RXVfnw2NGTO1u99mXjaF6u04XJNYBFMkQ5Ejq6Gda2
    dzjAfvxjVOHM1BSwfRZ2B8n3eguH1hxxO25R0Q0pdGYeYSfDdtvUkeBZNWFFam3g
    BFvnXwUqbmcA6uEotsM6g3/O+fjp8a9cbUelFm2hSW9lsYnS3mHEJKsneSqFAGQ/
    Vbm8tVaedDyb9bGPZYbeJdBpA10NoSLuNsf7qNySV6/pl/jvflZL68h/uFFVcrUy
    UBRiml28pr0CJ6GYb8bre9LlgkABK77rG57qMVExVe4P+cfN8XG6S/LJddOX+i3S
    pxfCdBgjEjpWnB5R1mgPY4eDiYUVERjE3HTkB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116345; bh=8+Yiti
    V4F8kMh4xMLugpP3usQslXMTog7sX/AZ4c674=; b=ox83uJWt4XoiGua6Qi3FxX
    Gpc/VTMayHJe/cSEscxt079NsMzngupAl2lIg50O0Q4QiHwmQPh71uuUOdqq+3gf
    I+SsyFkLBWbzGjW8UzUJUvSO+lZnVGKPchAeGN5W4320+fp/+iBtgZBxQmgOwfp6
    oliOx6/BxuBmk80D9ECCBJY6OQdZU8i5kKijJRhZFLJJv1QUd+v3r/fQk7zsard4
    B80mxuupJ4dojsixUfw7i+RsWznU3IDW/aEJsT80TXqEZcMVAQ+k+x50wvi0HXnv
    n9I7v0yaTMk/PZgSveJr2M28pWsZxobNOkTUEVFiOSyH/QxMNcsilnddZBNG9ieA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JmWvEPQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JmWvEPQH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCCWbd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:33 -0500
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:58832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933690AbeCCWb0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 025/219] eventpoll.h: fix epoll event masks
Thread-Topic: [PATCH AUTOSEL for 4.9 025/219] eventpoll.h: fix epoll event
 masks
Thread-Index: AQHTsz7ohrkKfFiWKUi/xCMuXQuVmw==
Date: Sat, 3 Mar 2018 22:28:10 +0000
Message-ID: <20180303222716.26640-25-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:YwpvnChG9aOMFkMAtb1r4GHGdN6ZmsBT/grg3ACCsxA0I7XpEQgRb5ZUvbv1AS+yO32iOdBpk6sMaLAszCcqwvob6DDdOOKPhl7vUHI0tV7kgKekTaD8W68ZI/nzH0YCRFP45rZE00H6aeYcvXceL8KFFeBTUzaJVshKL4avC5yCYjjcOovXciMdVBfvtfJUZ7cDlQ9QpZBkAUauLFP5858vY3xv99OwA/qBoIJGkqr/1eanO9Qbxk/5dy2T5HBw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32b77442-0b05-4c44-af43-08d581567ca5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970ADE0F670EC0779791E14FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: i2MZYjwDIWdrgEEXg9SnYS/3qN0XvkkBGCZanWY4J1QfNsPWtReaNQSV7QHCGwsnSxAWr9WYat83jAZMUeaYs/0cLuZnhjnvAmytFkDyOxAHsqiTPKY9jRNzn1kSr41V1n5isYGWq3sf0rAhv4pFXTmj7NUv0ZwrsOAFfZjivmE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b77442-0b05-4c44-af43-08d581567ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:10.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Greg KH <gregkh@linuxfoundation.org>

[ Upstream commit 6f051e4a685b768f3704c7c069aa1edee3010622 ]

[resend due to me forgetting to cc: linux-api the first time around I
posted these back on Feb 23]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

When userspace tries to use these defines, it complains that it needs to
be an unsigned 1 that is shifted, so libc implementations have to create
their own version.  Fix this by defining it properly so that libcs can
just use the kernel uapi header.

Reported-by: Elliott Hughes <enh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/uapi/linux/eventpoll.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.=
h
index bc96b14dfb2c..f4d5c998cc2b 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -40,7 +40,7 @@
 #define EPOLLRDHUP	0x00002000
=20
 /* Set exclusive wakeup mode for the target file descriptor */
-#define EPOLLEXCLUSIVE (1 << 28)
+#define EPOLLEXCLUSIVE (1U << 28)
=20
 /*
  * Request the handling of system wakeup events so as to prevent system su=
spends
@@ -52,13 +52,13 @@
  *
  * Requires CAP_BLOCK_SUSPEND
  */
-#define EPOLLWAKEUP (1 << 29)
+#define EPOLLWAKEUP (1U << 29)
=20
 /* Set the One Shot behaviour for the target file descriptor */
-#define EPOLLONESHOT (1 << 30)
+#define EPOLLONESHOT (1U << 30)
=20
 /* Set the Edge Triggered behaviour for the target file descriptor */
-#define EPOLLET (1 << 31)
+#define EPOLLET (1U << 31)
=20
 /*=20
  * On x86-64 make the 64bit structure have the same alignment as the
--=20
2.14.1
