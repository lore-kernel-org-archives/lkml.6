Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119387-2-13540801071088913762
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
    t=1520119387; b=UoILTuEKN6GhAZ9ksNKLz1v70l8Rs7Zn3VYz7M34VGkMiHX
    LwgpudOpx1+mPwiOxi8wkiT5bN365v1gPnoUcmdkcVKmBWO0EIgLgLGh2NZrTaht
    Q+evfFTYfaNsp7yCFZiPIBp0/Cow2S7j+kXyPHKXRwKljEAm1ONqgTvhG6+87Jsp
    YaoJyVlnHQgzVKniPbwpY+ahRrAD7775vF6ITnq1prnwZQWOJ7q/8dQjUr3BVydn
    b/oq9gJRQFiTlJJ8z2W7PKRQJbgmqXSivhwDWNOA/IuKdnOgOF/jYfwjJj0vAIU0
    1PvgjOJtYirO522YYWDekZRul1KkTse0VmT7MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119387; bh=SZuRgh
    N20NMFejqxziYWfihlHyhSe4dJ3nFfiJKY4Go=; b=vyXtso4kVH9/aGTK+VLm7C
    EPUAO2j7Lj5w8p9M0No0cs9n+dSUVlIbSn+YQJLo48V3ZAJ27+lkghuya1stvqtU
    KZOA6CGYEE47UGDaMGreDPhhkQ9L2hr6C/6dv9WbhAH3/E29frFfcqTu7lLFMsmL
    HAibsv8LbwzJhj+BRhz3B3a0sHopBs6pJrfB7s88kcfcvDC7uFyYj4gmL2WdJXD6
    sCIc57VWhw92tSgnhZ+vnHOhMsr6I+zk0B1RJ11bsXNBnm00dFwi0gY/jhq7ZEYQ
    m2SojB+fCpxC4U/syrEsfFk6QSJBWsYgKbIEYrN9Z/QRMJwqK6WLTkRNYi4KmW1w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a8P8rAE5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a8P8rAE5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCCXWo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:22:44 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934734AbeCCWhx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: SeongJae Park <sj38.park@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 217/219] rcutorture/configinit: Fix build
 directory error message
Thread-Topic: [PATCH AUTOSEL for 4.9 217/219] rcutorture/configinit: Fix build
 directory error message
Thread-Index: AQHTsz8riuoWK2ApGEysO8JZh7rhRA==
Date: Sat, 3 Mar 2018 22:30:02 +0000
Message-ID: <20180303222716.26640-217-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:JYOFDUKtfRGB2jDIog4eAq8tzvzUEonU6/JWCNFsnbBMsn41dfUOMy/MmA6wWA+NLDqFWeyQFaWpi8CGB+7tRhEMOiit4Q5laqEOBB3vLFVJrlzEwPcyZzQyMN7i7/Yqg4Hows3/Y7w6Ryq2UjlwKHaqIx+JIiwpJspR+JkcF5d8MNafR7GGBjNeFD1O/yVmRN66zQl6UwfOK1hyaHKTkRcM4zjQxQSgJW7wuG+t+wmuCJKiZ335MKph77VqnJZj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ac415ae-7093-422a-6384-08d58157654e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100486692242B81278151F9FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(39060400002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(15650500001)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zIJBsGlLGgJZeGpmYRSvCbHT+a1jRFtAxk3MUZFItgY/Y4SuFjDa5n+5hi6niQA6ayyuU7lFzpGvE8bRIjzf3p9GHnyZMExfIfwKBe6QJAK+zRPGo08F8gDXNMBq1JP70+FSnOxvr3iw+AQrB8Ix62ztn7/9a5+LNM4J6hmVZI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac415ae-7093-422a-6384-08d58157654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:02.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SeongJae Park <sj38.park@gmail.com>

[ Upstream commit 2adfa4210f8f35cdfb4e08318cc06b99752964c2 ]

The 'configinit.sh' script checks the format of optional argument for the
build directory, printing an error message if the format is not valid.
However, the error message uses the wrong variable, indicating an empty
string even though the user entered a non-empty (but erroneous) string.
This commit fixes the script to use the correct variable.

Fixes: c87b9c601ac8 ("rcutorture: Add KVM-based test framework")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/t=
esting/selftests/rcutorture/bin/configinit.sh
index 3f81a1095206..50a6371b2b2e 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -51,7 +51,7 @@ then
 			mkdir $builddir
 		fi
 	else
-		echo Bad build directory: \"$builddir\"
+		echo Bad build directory: \"$buildloc\"
 		exit 2
 	fi
 fi
--=20
2.14.1
