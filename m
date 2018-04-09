Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237264-2-11880500146132491658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237263; b=o5txnlodWlApkLRSUwgIETOJV/LLhsq1drRDM2WvzpOIO1cwOy
    tkvsID5slswHuPrzuAtGp2akmI7t7Q5wOls2lKlGhTF7W1lFa6PBlQLfPsuxBZI4
    D6q2hlD3J/f1HGkDyb9D/wcK8AR0/6fX6iMn/2eGE/ADCOlJVC3Xpd9npVWjQbhW
    pRAkMNK4PWQfv8WbZLfZfn5kDNiDvBmpgSLQmRC5ONEYzHizhuN629vU35sMVVF7
    LNRMzmm0c31ofvDxtSZc3c4CevQHGvvI+2ztK1+MKHhRHDpR//u9qfsIzLpwniyC
    qQ4n2M6zNCvXKpuGi/en7SEdnjT4MFGRd8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237263; bh=Uir3rg8hvg
    3SpV7UGGXiSYJpcshjV0b7snjb+GlHCG0=; b=Md2LtW1WJQfSE/XoEbTNQjUymW
    Ft2U1Z04rhezJB60rzc8ZCFX5D77GfeCtSVlB4b0cX/6CaLvr3Ah7EZsC6ioRnHj
    v7r5bbI/J5YNNvmKocC+ZLe8g9J0KdR3awmgmfX2oI0m5D9fSVJv7R8mvoFFLO84
    ydk8BRcsO0cOZc9o1yq1jio/WnV5ZHTsMLSqPcw/WTcAMGr9EV0hIFkKHUifHfXO
    xMHWuCS6YFuX02meQ9i/wrwvvEveYo5VdOqUxRnddcIjNjgiFDsWpFdfQ95wsnB2
    Bh3mZQm/FtPBFZMN/sXpHSvN/d4yjjaMS4rXAX0w59x3F4OQP2viJ2oVC7QA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oRVYwCKi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oRVYwCKi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOrb8q5szWhRo/afpmYdz2ScmaLFRt7kUCELEunnA0XBsAd1tmUzSlvRI9OZ4oud03SU4rwI5wu4lOSfWQ3KGuzi7WJwZXVO3zlBPBrzDvIhuJWKQ3/w
    7KRwIpiGUq9+c3+MRY5mJoputZmDPZmQDkgt3ETdjpxQzivV2bBIVguung2XRnMRymAVH+WcOjUWzdFo8J3sizM/gYJlFBy+C9ARKIV6F/ERiBn0fPMLhFRh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=V4A-spE-w-nq4i-AY3sA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756801AbeDIB12 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:27:28 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756702AbeDIAgP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 059/162] kselftests: timers: Fix
 inconsistency-check to not ignore first timestamp
Thread-Topic: [PATCH AUTOSEL for 4.4 059/162] kselftests: timers: Fix
 inconsistency-check to not ignore first timestamp
Thread-Index: AQHTz5msNx0fzLpnzE+0EwO/HbQiQg==
Date: Mon, 9 Apr 2018 00:28:25 +0000
Message-ID: <20180409002738.163941-59-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:lilyAujqHg5hTuP+NsEF73PsWZV58BAb6oHryCABcrAHMnSc2q4B5noKDFP06II+WSGdv41fseynE44Va3JwaUzMFkAnWN2gb5LidoySM971CVqNC+Aq2qbJ4vZgUGmiLBqu/1rTWL6UOlF1JydQRhM5msY6kZbFVqTzOX00h8kztc0A5UZ196zNMs7EyPiELCWJMwWUJDsC4uQVUVvnR5u5fBqtaMVhteIX03eC2pkegazcNmNc/FaY3WXeVsnS;20:eE0StrHLClozlLPPeNXms1HNeENTwv/Fn5fhqN+FbcV03sEn5pqnzl62kNiAPRPQh+OoIzxLzWT4M04Ch0zFJk4WE/BB0+gdP0os9zgI1ICqmJSz7gG7TUVYqf2OH45ZeVx04acgNpXKIcCqxmUPq+lhwHd20Cp14QuUNnBm+Ew=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c3c2785-d0dd-46fa-d111-08d59db1e536
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015C2FADA896F4D3A7B3D01FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(7416002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UzZDZkBgbpyDnk4JGAGQwZUEtRqrU4SS5kh5OI6M7FGhk1/G9rEbB9RWvDjb8u1H6FL4WegJ7UBhmFQHvykpZbTCh7IKtqUjFTOxbf4RECvHmSdb3fNTgXWvy4UZYvzdHKLNzNyYdfZk9aq10M5O/uZj4PMXJKVA6gfgFD6gePLik136iQlv/4mLLi79UDkjj01cchi6RSaaD2V2WFpzirwMAp2d+VB26HY9yVyA4Ii4tMspYo8f0H1sCGmE6ybvSG5vZL1AVYjIRtUAtHNvpJ4VAzGaoi+LHcxdRBNt/ZmfYcog6u/xpdNOyMgIxhwIWQvvpaTqITjcxegUDMIFr4Q1mdgEsJU7z9pwc9yAuTuAlxbmaNhVV9+cirAJxdldcaDC4lMJYShtLZo7PPnaWoJTTsEJb0eBEkLjpAj6HQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3c2785-d0dd-46fa-d111-08d59db1e536
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:25.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 7a5de5512296fd2ab7a497e4a576196b1f046e78 ]

When the first timestamp in the list of clock readings was later than
the second timestamp and all other timestamps were in order, the
inconsistency was not reported because the index of the out-of-order
timestamp was equal to the default value.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/timers/inconsistency-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/t=
esting/selftests/timers/inconsistency-check.c
index caf1bc9257c4..74c60e8759a0 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -118,7 +118,7 @@ int consistency_test(int clock_type, unsigned long seco=
nds)
 	start_str =3D ctime(&t);
=20
 	while (seconds =3D=3D -1 || now - then < seconds) {
-		inconsistent =3D 0;
+		inconsistent =3D -1;
=20
 		/* Fill list */
 		for (i =3D 0; i < CALLS_PER_LOOP; i++)
@@ -130,7 +130,7 @@ int consistency_test(int clock_type, unsigned long seco=
nds)
 				inconsistent =3D i;
=20
 		/* display inconsistency */
-		if (inconsistent) {
+		if (inconsistent >=3D 0) {
 			unsigned long long delta;
=20
 			printf("\%s\n", start_str);
--=20
2.15.1
