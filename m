Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246914-2-16395882989896538852
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
    1523246914; b=sGvjKy/8aMBWxFNlWo9EPYH8dQI3BXbBzLtvJOfysLKEZrV9ww
    Ptom7jWKNLKvyJ7R/NVMBGlHwJJ8alHrHY1PdyHZkcEaCdXzmdaVp1TKlPMPUkwv
    1qznRzcx+//3+B7ISY9/wN4svM7wRRLPCN6x9f2P/vl3L+reUM/ps37IATSeKuaT
    PGLw20S+faCqKpVGpcf7hVPaL6/mechWPByttkWojq9J1DfU6BElAMhOE6GXLl26
    dWkUd3aI0TUnN+Yp4Aq0jdGUFVrEbTcBZywwm+DGSWL84511XO1PZrWehouRVs55
    4zaC6t5d69Uee8aSUdp0BD4VAChlc9MOg49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246914; bh=94rIDVm4Tm
    hiU7MtYukdxLFzyofvmvYPiKd6WlrmWm0=; b=K7FlRzrTwyg+sAHhsCPwCGgD+0
    zDAzXw+ILchgSbgM0zHVYypf4hnVe8FH0SlZuwtQSouvYXllNXVdn6c8fRgsXpKL
    hKFft8a7xXnJg8xia7abUHFCv4yNdoWvQ8EAXy5B3Je2O5Kv+39hI65Z484rOHw9
    dv328BHXMBmt7XKopZS6xWDqRTD+6pWWod7m6r5sw3niMFm4JahKDZUi39Uw24uX
    f665voAZeyTCFis57sRUgcCbVKMONBba/yhuPq6k5oV2kEY7myKMvaPw9XlOlX5l
    BT4vLFdEaqr7l0HZqxg8m0op0Zg+/kKmz7OEIjxjSf+qRxmQ9Ofcb+7ZAdvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yo/dZugt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yo/dZugt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6Ql1Xb4X5Zws9urfNcDSOO86Vdm+oEuzwkt8N2soIDZHtuX9zOlxdP8F4XESpbcaxJ15sVFCrvb4vB4gX+jqOGVdHZGOdNKhY6Ha5DYGzTHmjfqIox
    IAVGliPCEIpYjSqSq6MR3C5dAxlEhpmtIgwUhX+F731zsFFBfIaLsTT7kvac1T4ao2/E4XcSVQ8ojurVZHbdbeD1UrpeRL4Yo4QpUaQLDwrVYELan20z6czU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=meVymXHHAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=txkOq09wrb2B0RYtGNkA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDIARL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:11 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752946AbeDIARG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 020/189] selftest: ftrace: Fix to pick text
 symbols for kprobes
Thread-Topic: [PATCH AUTOSEL for 4.15 020/189] selftest: ftrace: Fix to pick
 text symbols for kprobes
Thread-Index: AQHTz5gUHZEFDASH3U+/kKuFYpUZMA==
Date: Mon, 9 Apr 2018 00:17:00 +0000
Message-ID: <20180409001637.162453-20-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:+V0h+/ItuSM0cAACqBwX+OUwOM77ILzBf1WB3IwnO/8ZLrg3Gn99SMjwHfAkqgIyzO8GL2DlkBM3zxyh+XlOwUyNqHGnY8iOAdxCSmzgIKgY46jOnzKX+wc6WMJqr+PP8BrKUoyaR6kDMlmyl1XGK0daCxykh0R29uqVmNooyBm46hPXmM3NHs1DICk4TCDeCOt1ayyTOL5JR+TpnvAku7xmOjfinsiAZdbL5Bnqdd649Swae3pc4JtpCkah9YNf;20:DJDbFrfeLCX/JnutbU8s9oAa69p9TB9bJetfQSBrfcMNd5a5lG2VYrS5INe6fuNgd6NyT976PRiMrwhQTJpVUpZQ1XPqvvKQ3ljnVAQ/kjlJ4bcbr1JKjq4QLZR48LZdFx70/shu+1KmJB+oQROQgE+znG+o/vfBpU6yoJHSRcg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8a10025-81cf-4b8d-8a56-08d59daf36fe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11271E459520BFA1C76D90D0FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1Xyz8k48n7y2uV5834Dhr/u+JaYILmuI9Wqvi3VlOutuXJ09aDs/t/r41eFrAx1+LsVQA5n8bLTk+D5BDPmLXq0fBc+vKGB6pQHH/x5IROkWiWgquqLhJFFVWB3kKecmxWO8nzGJLKSFQLb+5ASt91WWA+Cr/IUzDPdumCeR44ZSvvABHJXwMhB5VdKBWEdgaEtAVFWtUJUFO738JFAlBjKwIxi0RYH0/ZcS7amfUsOe7IY3TuBPASd9VNBgYwOZgircdKZp6HpD8+WZaTLSLlhnHozV1A/KTVQRscTKBivkx+CDCXX1UUWKFUXtwELUA/4LDSbeSViE4KLwcmxQujogoJ1jv21X6UOmCxNk0lEPysOiVdQQ7X6/05Va7zo0hTQPAijtetKcCdjeLqR2Oc6JX4hota0As/ZNo0ixkMM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a10025-81cf-4b8d-8a56-08d59daf36fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:00.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 5e46664703b364434a2cbda3e6988fc24ae0ced5 ]

Fix to pick text symbols for multiple kprobe testcase.
kallsyms shows text symbols with " t " or " T " but
current testcase picks all symbols including "t",
so it picks data symbols if it includes 't' (e.g. "str").

This fixes it to find symbol lines with " t " or " T "
(including spaces).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Russell King <linux@armlinux.org.uk>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.=
tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index bb16cf91f1b5..e297bd7a2e79 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,8 +12,8 @@ case `uname -m` in
   *) OFFS=3D0;;
 esac
=20
-echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
+echo "Setup up kprobes on first 256 text symbols"
+grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
 head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events =
||:
=20
 echo 1 > events/kprobes/enable
--=20
2.15.1
