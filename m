Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244874-2-664991731829939963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244874; b=KSceAp/IZcIQUeTMehjbtbwGWQAOquQB6+FPNbslTOdnjJW/wr
    pKpqMxaFx2l7ue/4HdKoFxhArKxdZBlchv+qvQN1boNqJ4Hnw+GJxAvqFlhv06FS
    1qyhAZVP/yOAKWeNP9/WrtpE+gOQKzwLDgO8YMUcabLYFCXG/YJiIQ3/KgEFifbK
    167EU2LTxQxeNNsr0REpcNBX0sVgIQfDPXqOOt2ptToHif8mJi7K4fD9vBKByhYH
    s57WF4eIYonY2lah6P/p3bDmwQAHo1Guqf44/amFgwL2ZQAXBpfAgum61pWEVUK5
    HIXENUUWOioLoEUc66FxA8oRLC0iMR623SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244874; bh=Slf2OwMK0l
    wJ/oHNzqeUjh2YNbkTnGqTNNo1YRNnWao=; b=N4dIQgfA8Kr9GO/rVSxD1bjDyP
    LpUlhbG6SJGuaT7yqOd+gesEUR9g5wFJGfXBIL2cIHBtynwcTp3hBh1SbobCI2N7
    67RHfJjMypjjeRq7f0/CWjqzp5125fA2zRoE9AubDVUAgvKtkyUjTz69XgRFNRVx
    QpoIIkSjHo6sau7Osu0Pep38oPOaCNnBePv8Ltfdn+Raro6/R0P3hpRLCh0OQXXG
    eXgKc71uqO/T0PeN6stNpDkn4vi2qaCmgJqo614Y99HCaP09qSAFvCH/o9tpc42k
    RJZZy8S9Qc7wNnc2LisxOngzoVl0U/VZZgfdDNxMz7m33hCesQSHok5jemeA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CrRR98yM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CrRR98yM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKcIixpaVVnBIkoP4NKWW3mjfoWJNyfUhGzhWfHD25L4Dp86Q+UZ9pRlAkzk43HTnDQWv8dC4MxX1Zohx5bC9KLfqcwHhzXJxUstBeW5kOtdHQu/8e6a
    qWKa4PNn68GWBRptNPd5gCG5kQqwdvHoF8JSD/p5YT0jBOdqiv/N3brdpwvZAlASMtFEEdWRVu/uRXkQPQOAUTuX38H6/1AD9A+5BlIbMMyLSMLAvlIrFXQW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=yMhMjlubAAAA:8 a=UhSkpe21RigDWVNyvmIA:9 a=wPNLvfGTeEIA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDIDec (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:34:32 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com ([104.47.33.124]:4000
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754420AbeDIAVR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 167/189] selftests/ftrace: Add some missing
 glob checks
Thread-Topic: [PATCH AUTOSEL for 4.15 167/189] selftests/ftrace: Add some
 missing glob checks
Thread-Index: AQHTz5hcBSHGoyrOuEKxJ1DiBxDZLA==
Date: Mon, 9 Apr 2018 00:19:01 +0000
Message-ID: <20180409001637.162453-167-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:Y5MmyOXbCOnabYj59irBe8YBZU53Gekf/+MNTAHGM48yIYAyoB3o1RD16hqZaX1vrRW4exbiNIlycCdzQVqe2kkJCkvgnHZW3f+U+MDpkJ4wKUVhoaNfhucJbaVx0KHWzh6SuxH+Ubjnzxs2ZAmaL8GGp2coD/tLubV7G6PbyrQ4nyT3sZQY3jJ/4lAl+kqHESxzg17KaYrd7J/w5e39xM2R+O7KesFHpsGoBaf+gj31/31TDf8rfqEyGHWugt6n;20:/GJfHLiolPo+ZAKcph4oFfeUjEGqk6qMjRGNG0eXLtgJsqUaDJYV4s3n0R7ZaN/wcON1kAOgcmNYUmOGnGpIsQLukuBEJ+Ie+CCgooIpx2qsb3zDSE/M8QTduYSpfFGh2kQaGPhsDjLhdWJUmp7C9riyqYxE4jNdnX6BpSW5ib4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f06ba3b5-5702-4eaa-d6f7-08d59dafcabb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110ECC5F187E20FC6798381FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8Tugn9Weh9uIGYDAZYQb/+PeoqSL65dlG/0QTQ5uMlmADLT0JWKmNJuDhylw998TAVuJaMR66HBek8UmEtylwp+pla2Z+GZfO5r6O4miD6l6wuAENEmc4VdEoAcLLW7f84hSqsw7m9x+6heL1t3UGKdwyaHB9XeVFOTiVOmZ6OoYbKB8wEoOSDV31t2u9SiyvaFVnHIhY+BXl7CxM6NCxCK3njx931d2dy0ESbnlyHexcQP7X3DXk4gQjVtab33bDPGLHI+HIQua7DwpjFMnIZqgMzD+Rfba+mCiNOFDjZ2Th+Y9I2C+e1NGTY3m7SpbKJ3MglCDsalrnu9QcDxP4jR7Wqs/SI/88pJHfCjUqswq7u9bxcK1LbFv3t7szBX1sC83HzNZXjrV72jg24+cpIpvarkW1YpkMUG3d8SNQ3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06ba3b5-5702-4eaa-d6f7-08d59dafcabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:01.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 97fe22adf33f06519bfdf7dad33bcd562e366c8f ]

Al Viro discovered a bug in the glob ftrace filtering code where "*a*b" is
treated the same as "a*b", and functions that would be selected by "*a*b"
but not "a*b" are not selected with "*a*b".

Add tests for patterns "*a*b" and "a*b*" to the glob selftest.

Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk

Cc: Shuah Khan <shuah@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc | 6 +++++=
+
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 589d52b211b7..27a54a17da65 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -29,6 +29,12 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
 # filter by *, end match
 ftrace_filter_check 'schedule*' '^schedule.*$'
=20
+# filter by *mid*end
+ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+
+# filter by start*mid*
+ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
 if grep -q 'accepts: .* glob-matching-pattern' README ; then
--=20
2.15.1
