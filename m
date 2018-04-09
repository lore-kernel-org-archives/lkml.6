Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234984-2-9008533981476305151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234983; b=WBh35qvIevoCcI1UDXg3Ivv8pNf8sntBzCgby4x6DlhfGKznMW
    z2JbO1opnMbepwuklh3/MAflqSBwaelCVctLJKOOmlPLGOqLAZLr9P1pYJkq6riK
    Xf/rCDLsfqi0lRhmv3uQXyyOEx/nw0KDiiq5vMZWo3kd8ozX0ohr0jQloEAkAUXt
    W85H3a4I+HH3wo47hj10qP0lDE7b62a1cRMdVe8p095OYe+bjL5+0HTcsXAJQ583
    d3Q3A+xySV20EjQCkHAQg2qXE+gJhihsb+ZS17NfNMh6O99GwgqEkyIi3NakpzUw
    ZQhE2dBU1XXD/4CySqRPlFmfS9JRlldKWaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234983; bh=8+RbMEPvX/
    4N/YTY6uMo7/bR2KGzs17IVtgPOWYJ6TE=; b=FNvFPwMspsigKf8BhkEQyX/toN
    LLY05I+6RjhDcURkhjIR95VLRm2HFVVnhbwGFGK/cgADdY6OJdxVR/ffoF4ocKUb
    3GsIj+qbZI+WEJ7SeOjZtxVUXg5PitW6UBKoSc1KmwhdxG1OGl2ebYm2EGwUVpJd
    C3UChETKIFC7zcYKJcJwkE3MWHoMkdRe3cl+tsHNmUqDdrffOecOpu2gsw67dPay
    AX81WFbJRf+Ylv0jQkf7B89bl2uNzSFUYYMKCS98mhMeHZNbAaTEQ5AckhRYYgj7
    M0QVkinr4tV6UU8AsAJJPP2KEIW0mpLxUqvnvsF0x6J4IKYTG7ewWxKJ4reQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oEPJXLJL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oEPJXLJL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOzr0oX3il/lNopztZTpbsR9QI4RBqSc/d6k6wATKlBtq1s5LZ1QtOWE+nSaFNiuym8fkRFeUEZefs2xsRLkg7UhFbbCabc8n/OevVWMvrPTuAiggluQ
    EJH3Q4e+0UpcbXLT7ciuZZ9zAUDx/0MXxWXY2S7ggS2z4YulsXDb9NdzoUfvcK+2LlGhmR56NHBS4tpu96Vap0S/4fyY5WbegyjQ+T91FLS/2NxE+PPTq9+V
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=KKAkSRfTAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ebHnuoNtWO8r3t1DvigA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeDIAth (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:49:37 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933484AbeDIAlf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:35 -0400
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
Subject: [PATCH AUTOSEL for 3.18 067/101] tracing/hrtimer: Fix tracing bugs by
 taking all clock bases and modes into account
Thread-Topic: [PATCH AUTOSEL for 3.18 067/101] tracing/hrtimer: Fix tracing
 bugs by taking all clock bases and modes into account
Thread-Index: AQHTz5t/Vs3DH6FLdk2x6Q+oldDzkg==
Date: Mon, 9 Apr 2018 00:41:29 +0000
Message-ID: <20180409004042.164920-17-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:4KZktqhWn4ijFK17sirsRBHIbaRTgYF9xHo0jUNlKvvYX/p5gBpww95FoqqGrDeuF/BIpC6X7ZSWIqjGR87bCo+nxIaWa2U6po0dEeHSRRs52tViS/wjpk+oYb30fwOAYZl9ddLEUc+JlbnmujUoYf/5zmNRzXL+/+Mz7b4OaApnEM8mi/JMLys7Y8yPZAmS7TKQ0aHrD4acHSRLmQPzeDIolwhom7lMcPrNHVpiiWb1/jep8yVo7+itWZ7dw54h;20:hZCzs7NK409vssJGGkv1uO/PAqwb2i/RtvZDT8Zwfs0gtKu/SuYaq/hZpZ3rpX1KnPo7dnzDPq6eVW3pemltq2BO/tupAUJzZ1TVbJfsgYHw2pHEMSYnST9q2JsNa2aTk9kb7u/SR2kmP5cHz1nmoJ8ByFaNSQoA7Ihj2ZwdZ6s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb8a0472-975f-4975-a7bb-08d59db2a24a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901A053C6A603AC2D3C2906FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(7110500001)(66066001)(97736004)(3846002)(76176011)(6512007)(6306002)(54906003)(6436002)(15650500001)(2420400007)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10710500007)(10090500001)(2501003)(966005)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(7416002)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RtaEHlFVXGnHVeVmRhQXFinguyf4fn6KBC5j0L6nYtF0sdvYMz1rJbDds9s6ap8JnJlH4xfwL+di/pmwCfHk1NSmz/YqGoqgmtMkMrjHOH4ft+oj1aW0Wa1Zh1FJFrJ7LqRIv1tqLYbUh6tu8+GAFymcvJKGkZbBIGah/B5Zg6HB9cYfO5NIBeOqb2gzvByNMSjHSnaw+ty1OamWcoxwZr3gCd8h+gJKmN1OkHCOCMcFi0/ih+xYlJv2MQUnSVA10LpwvFatXwa28Iw1AlZ2djIrbPAqAQxe0MbXW3P17f2f43enzpaEZ5lV/8bDOmQxcX1wLRQwKww5ks7j1Ki0TQCGESJTolQBPt045N+oVJmKPaBEmKVDmoPZ7bb2fciD1mBEjWIjwDLWFO2n/Pnh31FOxOjIrKfESomN4ZmUAFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a0472-975f-4975-a7bb-08d59db2a24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:29.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index 68c2c2000f02..9e4af35b3beb 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -121,6 +121,20 @@ DEFINE_EVENT(timer_class, timer_cancel,
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
@@ -147,10 +161,8 @@ TRACE_EVENT(hrtimer_init,
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
