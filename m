Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244473-2-16154818434662021048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244473; b=qeDron05o1zY9qTJXYLyTWXO20e+K6hj22ho9T7WrddteQH+aJ
    +2cSPNq+I3oDNXKvk+E7sB1x1RKU4rAAj7xpg5V5hskqOQw3Xq5YuS2Oss7QcfWF
    6IBud0Amo20xytJ3TfRBMvr8keKc/zU5lKXnvkoNPpcnbzZayZnMltMYoha+uXdF
    dxTGMkMNhjZ8Qvfe1p1Yg539aUenkdAMPRwimsOdsIwVssqQ+ANgR7zi5DHKucTO
    ejCCmjE/0MRS3OXvySCBd5xOgqj/rZ5d7jJkN5KUNHDohl+hvhqWlt0t+pEpH7Xq
    kR/vru+VhW/ZxEVeiPMdkz6CKzMrAePYXdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244473; bh=M3yjupSaiO
    N2g6Pk1Y3fvo4OgI4bKco6cfYk6tJA8p8=; b=VfGjhxDAINcNdB0/3FyKctq80z
    ivP/v5lGZv9txS/qapQJzMCgx6zhvUABnmm2ooB9kif+lonUDsLQcSWIxwfTPZ9G
    jwamHsQUtm88VOw+0UP/o2ao2bWBCMIKliW1xzCOrGFD6/VyIf5CFHDVHZDslhsj
    9Uy7m/pBPlT2Z8FCeMi54mPZWIruaJasb7N9JKGdnQduUM04gwQxIBpLgbaqc/Yr
    cB9Id/wAOMM8u5lzjMVmFdfbksTT22/sI41CkCJNp9sRzAW0I4nc9xYbyO64Gm0h
    XrPDhAj+5dnbYEKWSZOP64UxJsOntfczUp9+RAUOGrMeKuZuIdATh6e3rhWg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=myjZ7Dhd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=myjZ7Dhd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbhk7/nrdePKs7j52eUgwDd3HnHDwuhKEzcdyuJnC9B+WjbcM/avzVPUp2lPictc/MtHzcw2FhQ+4oABywdUa1sG4AV16RQH+7cM499mfQwkZiJEjQJ
    gQuvMnc+goZHrPgCn09YPbU9DDt11xwWwQrkBVbuhRD9FpeWxxYrwVate7AXHpeQ8vusqkGX20I8FlBaARJu+c7CHvmnPpg7zXC6aRARtsPf64vBazb9LVBL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=KKAkSRfTAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ebHnuoNtWO8r3t1DvigA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeDID1s (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:27:48 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754622AbeDIAWH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 011/161] tracing/hrtimer: Fix tracing bugs by
 taking all clock bases and modes into account
Thread-Topic: [PATCH AUTOSEL for 4.14 011/161] tracing/hrtimer: Fix tracing
 bugs by taking all clock bases and modes into account
Thread-Index: AQHTz5h5A8QiBykPkUSUDtV829T5Pw==
Date: Mon, 9 Apr 2018 00:19:49 +0000
Message-ID: <20180409001936.162706-11-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:bsM+QWyxbxhEtVCLXUSzDh76Edk2kcBIB/urenW2zmntaYVV4BXH+dI28wKaHFMXsTTnIm3jkIbJCRuL5BDiYB58xuFo836GmOZ7o71HCfC1pP6gYHh/HBrIhJSE3cn8DIasx9IcQiD3CnIzu4zKwa15fm6zl28I9BXkPPB5NEs8gQ8LE6EKTlNU3R9+msvk59m16Kb0LwJ+XXH7U4BiCsH5nO2QBujJ4klcLQ4CxcnDQNL5W7jtD8k8DwwyZkw1;20:1sVmxcefBeLY22x74cOPi+7xsruGsVJj7K+aDaPEnr8V/VkvNV5+99/Jy7MJ3Q2F7I8aUm2Sz+nBpDqdtfP/Ma0da3KSnR/GeObuhytw6jAaY0LIzyuOG0wDOGtRspKgpMIqOkVn1QdAW4CZaY8I0iqOdAIjsk5giC3oNgyJbzk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5ac15bd-ceb8-48d0-3c07-08d59dafe937
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093646A1DA20E2CB989184E0FBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(6306002)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(2420400007)(110136005)(102836004)(2906002)(10710500007)(6116002)(15650500001)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(7416002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(966005)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(22452003)(97736004)(7110500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SAtLMluhfVvDt+jrg52H93GZcln3qbmuWK/QySxvaluzEdr3qQ0k8cBu5TEdLckugSNpj7+ecLggqUQZQButl4Ubsc6TdpOxNfYT4mGD1W7Z1JN/NFflRu8f56hLTl2p3QpTDCRk5mqz0smANXp/42IaAL9KIIpDGCs+cdn8fgpsudU0tGD3WQ+TQI+n6HIbKapDPtmdCG/aFGkPFuf+nExxLswt6bKKUDqgrLiqLMVRrnn/nquKMFvTlJgcPkK8XucpaOKD7iV1sGud+ak94YrVyQzPB52DWIt8S71crvnq4hruGmoPB+OGOFAJ4OUVDoks3ydBK19QJWbU4y9qXAbuo7ARcP9n5p7n9+3x7siYVexv3FuvSD0NFgJwexIbDoFNjyuxqcEMERTeL23bL+So2L7qZwgfv0769Hbu4WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ac15bd-ceb8-48d0-3c07-08d59dafe937
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:49.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

[ Upstream commit 91633eed73a3ac37aaece5c8c1f93a18bae616a9 ]

So far only CLOCK_MONOTONIC and CLOCK_REALTIME were taken into account as
well as HRTIMER_MODE_ABS/REL in the hrtimer_init tracepoint. The query for
detecting the ABS or REL timer modes is not valid anymore, it got broken
by the introduction of HRTIMER_MODE_PINNED.

HRTIMER_MODE_PINNED is not evaluated in the hrtimer_init() call, but for th=
e
sake of completeness print all given modes.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Link: http://lkml.kernel.org/r/20171221104205.7269-9-anna-maria@linutronix.=
de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/trace/events/timer.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 16e305e69f34..c6f728037c53 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -136,6 +136,20 @@ DEFINE_EVENT(timer_class, timer_cancel,
 	TP_ARGS(timer)
 );
=20
+#define decode_clockid(type)						\
+	__print_symbolic(type,						\
+		{ CLOCK_REALTIME,	"CLOCK_REALTIME"	},	\
+		{ CLOCK_MONOTONIC,	"CLOCK_MONOTONIC"	},	\
+		{ CLOCK_BOOTTIME,	"CLOCK_BOOTTIME"	},	\
+		{ CLOCK_TAI,		"CLOCK_TAI"		})
+
+#define decode_hrtimer_mode(mode)					\
+	__print_symbolic(mode,						\
+		{ HRTIMER_MODE_ABS,		"ABS"		},	\
+		{ HRTIMER_MODE_REL,		"REL"		},	\
+		{ HRTIMER_MODE_ABS_PINNED,	"ABS|PINNED"	},	\
+		{ HRTIMER_MODE_REL_PINNED,	"REL|PINNED"	})
+
 /**
  * hrtimer_init - called when the hrtimer is initialized
  * @hrtimer:	pointer to struct hrtimer
@@ -162,10 +176,8 @@ TRACE_EVENT(hrtimer_init,
 	),
=20
 	TP_printk("hrtimer=3D%p clockid=3D%s mode=3D%s", __entry->hrtimer,
-		  __entry->clockid =3D=3D CLOCK_REALTIME ?
-			"CLOCK_REALTIME" : "CLOCK_MONOTONIC",
-		  __entry->mode =3D=3D HRTIMER_MODE_ABS ?
-			"HRTIMER_MODE_ABS" : "HRTIMER_MODE_REL")
+		  decode_clockid(__entry->clockid),
+		  decode_hrtimer_mode(__entry->mode))
 );
=20
 /**
--=20
2.15.1
