Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117110-2-1652932720806776281
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
    t=1520117109; b=q0W2Zo0UMHZf3UozKqt/ykKxki7FVBbJfhjV1jwo2jvgOE0
    zaN2aU6k8vaLF6CB2rls5PNG5h3qtjCvZkwxN8zeYg9PaOwPCiO44h5nPEIdttui
    JVfsWWPJ43W6m+ppqxEKlIiE5WlFKzY9eRLblz7Ayiw7uyWPEkcYfkekhwW6bake
    mMATlnlCuteeRZYzvorDVTVb4azpa7jSxzIC5gDZVSfXwdiD2cuQTuEHYPjCB41z
    NkhAnzEGVoRoiHWl08dtuUNujCAPQx7flDqg2mALN4joqQq+5y/kgpLyG68OZQMv
    JvQDskZUaseYMnaRv6Ya+FQSv5HZE+vgtudFWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117109; bh=HX4Ux+
    QOXGz88E9jECS1ndl32Pv9laouLNddKYAscRE=; b=PcVD8/65HNsanOm/jyCART
    C2VuMhs3I2HNGdmbUonfPQ1WboLZZeypR6cONXLdHH4PI8WStzBrmq//5Rhax9fN
    zIdGAKmyXn38Qn1g34AULPGuCOntHpEtzWkt+IwEFxNppWzRcAWuKyL5z/dsfLp+
    8QhAiud+sMJfZj4EqmynYUw+HiDoLOD4bb7ZiKT6bsxw2BpNa5srh9sLPy8HByAW
    7GkqecHinqyzRg3gft38BvsQcFh5/scXSoV6PXx5xuVCYEDnTg1uV8aHXV+WwAks
    BMuYRxv9EXDgdU1XKAgzpkPUeCepe+uuYL8zMXNxAGZM1OzZ1lsN2AbwVNmT7kNA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yod8mSHb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yod8mSHb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCCWng (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:43:36 -0500
Received: from mail-by2nam03on0124.outbound.protection.outlook.com ([104.47.42.124]:55195
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935610AbeCCWml (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:41 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: SeongJae Park <sj38.park@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 62/63] rcutorture/configinit: Fix build
 directory error message
Thread-Topic: [PATCH AUTOSEL for 3.18 62/63] rcutorture/configinit: Fix build
 directory error message
Thread-Index: AQHTsz+z1/DjBs1U8EeBXyOYnnQqGw==
Date: Sat, 3 Mar 2018 22:33:49 +0000
Message-ID: <20180303223228.27323-62-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:1LdBOm5om03deT803S3EmRm8bsPTwFaUDII6GeLVtzwKaOnF0QPcPaaj3qNdfCC3uuoiWzjMlgz4tplqbNGULjNrcG/lktFpBsR0KrcOCN3FLY8l7e5TJgb0rZEYgNqP0jNUL4Nls/qQxX0jGLNFrgH67UUOk1+YG79Vy4cn2oVHqZ63yMXHp5wxFK/6+WvKGFxfBp2MlaBff+1PuqV575C+OLUtm3/5NBlUzQkuRYMPuXb0ircJ+mtUIE61Ek4z
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 046a8e66-31c2-4889-fd04-08d58158116c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018510F80A92FB882669F7DFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(39860400002)(376002)(396003)(199004)(189003)(478600001)(99286004)(6666003)(105586002)(1076002)(3660700001)(66066001)(14454004)(6116002)(3846002)(36756003)(8936002)(2501003)(68736007)(53936002)(22452003)(316002)(10090500001)(15650500001)(86612001)(2906002)(2900100001)(5250100002)(6346003)(81166006)(8676002)(5660300001)(59450400001)(2950100002)(6512007)(26005)(25786009)(3280700002)(39060400002)(81156014)(10290500003)(4326008)(107886003)(102836004)(86362001)(6486002)(54906003)(186003)(7736002)(6436002)(305945005)(97736004)(6506007)(106356001)(110136005)(72206003)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: LzegJEHx9ZZtIJbSZPoh7hZmSs84+G1k2q85Se5jv0f5bZLr2UcESNfNXydmFUjgO8IomqvUY1nnpjX9mGAnfjZk156bq2OTrJ4H0qKkCCJLDWKVam+3sKmc1utYdFhOeZfBfH2wluXZ2hkSr3n5wwAJCxR/M38cIi+yLbUmcbg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046a8e66-31c2-4889-fd04-08d58158116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:49.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 15f1a17ca96e..0b679d8382c7 100755
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
