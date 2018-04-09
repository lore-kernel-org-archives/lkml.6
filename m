Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244266-2-13259286261009459218
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
    1523244265; b=LSof73Z3GxQIzYCz/JywGBTloUnbT627nLwZHGDEA/3EfgITwt
    XxXT4ZRLMkW0ExgEZvKEUQ1A1eYEU55F/8m8iSgh8mzPLyXaBN2wNkkzNiEfEE2z
    cAm6vm03HWzGXHY1QuwN93CvNICgo1HuSBBLv11WlaQILlogt3gRAeql7oUwZVA2
    84L60uHxJLTNiNu6Ku5THdkD48uC6vxic4Xh/aL268W1uiHTskQNrs4D3HW1lt7Y
    Uw6zme/0V74j8F9bYdfux73z+JcvCvIbFmnap3E83LlxnufHyAXEkpUPSBF5F+3k
    cIoVn5NakY5YaoHVadee7O4h/Fyp7h80Qzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244265; bh=uwZWruFT1s
    5izsM4iBlpLiSlqYuatOHH7dlzwegdLFI=; b=J7kyUImXX+gYzKPtBb8WPKwY8h
    /G7/jg54PVQF4t3olksOhiYh30Prb+nymvitSaE2egG7N512v/Lxs1zGysym7WFe
    wPpzo2wf3W2pZ+OOf2cluwM9Wm+HW0f8sqlXjBHJkHUzR021OrN6m2daxbOTC0sO
    M5mQBukYdwMZrcmH19/7yynFURJ5jPiidFPQA3HLH05L9v0ISBYvkbeRm5d0oK2g
    JSrpDlYPAzfRwir0FTxa0MVbLo40d00htjq2LQzq+4HDVx5tOqCPWFlhjNzFOi6d
    qt2fPJU1q22ZVZZwrCRbfIfD0jDKMhXw3LqDQUlw3gnX0Zg5ujSASsDt8jmw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XqiaEc4d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XqiaEc4d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD+htQpT20Xh2VLu/IrAK/Yexxng5nIMKXioqPYvV71pY/mWDp9v8cu8Dzus7Pm4UhUe43Pw59+kL4mrf25YtTlYER+xvr9mufkI6cxvRuw+nrtYuaZ+
    IHI5QnnfXNbty1qPHT/z8BoKMXg87fksayOMqWBSXGdv3fxHoclYc5gmRr4VyXEqo76iR1c3xWKZTAGlJdS6CZpBqD4F1rblm8CC3X4eK9/s69F74Qs7DgOB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=5G0AJqgLdFttAFhcDZgA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeDIDYW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:24:22 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753540AbeDIAWp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 028/161] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Topic: [PATCH AUTOSEL for 4.14 028/161] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Index: AQHTz5iCvKBL1vK1U0G/HCzI7w2c/g==
Date: Mon, 9 Apr 2018 00:20:05 +0000
Message-ID: <20180409001936.162706-28-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:5krUUkYN8bQx+x5YyzzM6U6mPcXzNIGHLgiksFPognjMqHHHLio69udQarhWFOUtKdrMl4MJkW0+Go0gA0CviQXTBS8IOWOuTzO/q5KJ+NJW2go9yVsQ7ZV5CjpbIxXNvGMBM0Gpf/MYF/eyt0w+ZLzkT3lTxcbuHveBc+ubrgsLc+/n1Va6w0FCAwd1PEYbbyg0PPXRq/lbk/AKzSNbadnFns7+W2HWy+h4XPM4qtpiyNLSZpV/iiHC3UCD4T9F;20:r35ViTvKFdkQuamBrGFVNSIpkcTsiSDgFmSQyWUcLN5VqFSZxSN3jYDCzScPLfxJVVR6ic7chQM6ucE/+lTK/3s6kj7/m0ZnGb2Tp/HQQzMgeT9pulXvzGcByH618YSIZBZj7mc+U6OoreQFIU5+aL3ulDC98AeCLWv73t33gGc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bf07abf-b6f3-41e9-4bed-08d59db00261
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966396C493C34CAC243B211FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: q/QKxeVnYG8M/12W8SxIoDEoHb3Rro7Ju4N+F+VSks+4dqZ7oFjEBF/IH1lIPaxNpYKThiAoeIzQizpb+9yqTodmpoWtU9d0WWy8kqnv9aB/TTvf27HNyMk1F1CfXmnKd06NOuZoKhlfJS/9ZnQyWNmkT/ne9/XyZiXdDQHjlfADnXuzZaOlx3HZHzN6DzHLLGFBqnyZRgLEmNrt4qwbCOW7YLQkEpbSfWz25Hledx8KYZUy+NwUVd54T+hs5uszwuOl8mCH1F7fMZFiVpeu7jWKKneK/rGw2aBy+H4J9RZMcvARin/Zj5Zq83AoMysfRQBX/HEQ5YjmdHrIBJ3KqS5Z+vRbsobbiyTqgMYb9VOaeW18W9raDNLN8roygZHvehztG0+QEyR2dW4zzfKQzOI4GHtqFeNPC/fXZFeuYFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf07abf-b6f3-41e9-4bed-08d59db00261
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:05.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 81fccd6ca507d3b2012eaf1edeb9b1dbf4bd22db ]

In x86 architecture dependend part function get_cpuid_str() mallocs a
128 byte buffer, but does not check if the memory allocation succeeded
or not.

When the memory allocation fails, function __get_cpuid() is called with
first parameter being a NULL pointer.  However this function references
its first parameter and operates on a NULL pointer which might cause
core dumps.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117131611.34319-1-tmricht@linux.vnet.ib=
m.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/x86/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/h=
eader.c
index 33027c5e6f92..c6b5204e0280 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -70,7 +70,7 @@ get_cpuid_str(void)
 {
 	char *buf =3D malloc(128);
=20
-	if (__get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
+	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
 		free(buf);
 		return NULL;
 	}
--=20
2.15.1
