Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123424-2-4829904648660557444
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
    t=1520123424; b=IkvgNYkngsWvhvvTRFIZjpibC5RTcrcVYPYyBbjNgEaCSEb
    wycRkRqltEpFrVxlnBITNpfRMcFdy46Zi4PGO/HDZoF/ImE9BxGxosOAVubLij0F
    HrKwUyYH3XYVc2c/C1+kEDRZOw2Z2tV+k2gu4dVjUs0W0tJQGrLFzgGWCX42I/Rb
    Qfp6zBTw03Xb4VLRWiblxsXyS6w87hiyizyQVE74vnPqbFdYy8gn2rwBt3dTqU58
    wR9V3XDqTGVgk2XxQY1dvR/YTvvDRSDY3/h9FNR5ac19QgnhYtLvE2Qfb1htSwsH
    YfhYN/M5FD4AcwuBgyBFfPP5g4vpiQoZcB5I2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123424; bh=TdVcKo
    +V23a6c/7AZtl1auTyTOIjP82/XY3/+K1Q4Xg=; b=IhtsbGxlrsiYoaozG5YPke
    Ox6qAh0WdJMN3gWZnPPbdLif4eIzBdkpFxlCM+D4p4qgdeULvGuy0T/wOwUgNNxW
    RqWMHMHOmvH7C2KW/sX9OTodAd9dYVCknzQU02NiepXs6LTkLK1jcNhmyBNxR8sv
    GIE9+VFFpBeHx6ujVFTIQIYtEk+RV/pzh5c9mSJBZn7/ATFuXPIfyKPbZ14y5s2n
    ldiR95EvBaxLqAMRKvSyajfcpn1te7SVkLeUqnbAAuUWaqDbd+641wltrDfDXXE9
    vYdhtC24RpXD5UKqKQd93bbyPKyA2GCEzxF+u7im7k63zISyddpYYfp96n5YiBDQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YUa3UsGB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YUa3UsGB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCCW2E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:04 -0500
Received: from mail-by2nam01on0108.outbound.protection.outlook.com ([104.47.34.108]:51456
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933049AbeCCW15 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: SeongJae Park <sj38.park@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 098/102] rcutorture/configinit: Fix build
 directory error message
Thread-Topic: [PATCH AUTOSEL for 4.15 098/102] rcutorture/configinit: Fix
 build directory error message
Thread-Index: AQHTsz57JPDnNVnn+0GmeQQZvxufPg==
Date: Sat, 3 Mar 2018 22:25:06 +0000
Message-ID: <20180303222318.26006-98-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:yLuTVnhpxJF7/OLLIaCah7F/7qNr0lVINC4HSSHIONWq1Z/IXtURhQuZ+G4EwD0ING/A3NV2H496pYHbr6xhOtr2cCSL/fbOkYJ3nfkcPyICjFxFI1Ym9+NUus4Y+L0ptbeQViz5K7oA4ThzYBE5hPXsQ6qyrEQiSSEOCTqxrzgEvAlXi3YtxFIVxLI27jOCmW41C1RyUPUTEW1/Z15WHuWVJY1d2BZBY1/FQFW3882s/k2dagVR5pjgj/DmjDGh
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fdd32ff-7239-4f70-0188-08d581560195
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB068BFA99CDC3A616F871BCFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(39060400002)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(15650500001)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kgyeym67Fl8SK3MbvESJLEmCH9Gh460Ad1UmOCd/ujWvU01XXDCc7x06LXjGDGJQC66m63nGYI5VCKucKSsC8D7eO43DJQzAlgpLk9GUnxf5sRYXyZDOl4UKMrx3zpeqeWr95zxtQuPZc7SgDx4t5qCarbgusJ5GpNUE5YXY6e0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdd32ff-7239-4f70-0188-08d581560195
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:06.5097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 51f66a7ce876..c15f270e121d 100755
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
