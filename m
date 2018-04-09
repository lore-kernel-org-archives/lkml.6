Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236575-2-5229448594363114782
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
    1523236574; b=V9qK9DYjL/z2pSHRJ5h11LLqNtS+Usaj1S+qLwMiFDdMwjInnu
    WxWmWmv7zBzZx6ur8WfQPndhaJoIThrx4yaUf4LrD+oZoVx8Q4h/qyUhLxVLroZj
    seK9y0oXD0MAaokAS7oH0Yl/rmagwprYAwRsZFtpxHz4KnmZcLk0t16hDRNBVLRv
    HB4GCMmplcaEyrFuHaLdhUenTJ+/F6SG0QvEymKKkYGgyvu8gc8qLVnW1PY1PSJx
    xOXTSB51vxS8RfNTMk+j9+faoNfkAhWYEEqSsOkQ5mOfJQMNRXkxVlAG+K3OFTix
    6C0noRnFedm8/og9JSOVOlJ+QpbxLr6ZJtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236574; bh=s2qJJ5Tacz
    RuPR0Y07aQUJGRnHkaEejWKBYTAjAL55I=; b=iGU1hCL9hjPOJ0Em044taSB5de
    b1z2w5caZKa3n1tvGNYzeG1nyr9hsAygGFy91TtVHq4ws+ePf8pQpx1y4j/wnMry
    Dxitw1OegEkBhsvMB7uGKCoU1xFT0aE7Cm/CDNqCCxlm2kQdqsyBmqbiuj7jhtdf
    c2KPvNpEUJ8XEuHedDILZxtjtc7/+o9s0qymrjKlQHVPNCRyLtb+P3QIbnBZSi6q
    g8o3kHgdQhwuZlXwrSUtLBLOGELe3UcCm/JMPbJauWhxtqX33TIkJXC2JSdPh1TZ
    qatfSpOsPLDN9Wc7QZzVh/mGw0DwXx58wFO6Mi6lO3jhIS89ODVNKkP+py9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZpfanqGk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZpfanqGk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMIX/GSdkylzDGLlDfuZOStt7w/5PfE+gF/kxQE2bIYZNLBh6D59UikIXc0SyKrHCXjtZAMyx1nZARlIPPphYlrb0rntF0909QMBHK/HOAwUSlIChnxD
    5x/SGlxzIIoyXMrHS9WhQ5cXhWLg2XRMTF3GdJXHkVuM3iozIWuen+tOVJ+7AzmBl+REurIzqgAZcZx4Ivq7o28mxk8GgB2XbToPLyerBwwWhW7CaTCrAEcV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=KKAkSRfTAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ebHnuoNtWO8r3t1DvigA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756785AbeDIBPo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:15:44 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:3232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932871AbeDIAhx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:53 -0400
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
Subject: [PATCH AUTOSEL for 4.4 110/162] tracing/hrtimer: Fix tracing bugs by
 taking all clock bases and modes into account
Thread-Topic: [PATCH AUTOSEL for 4.4 110/162] tracing/hrtimer: Fix tracing
 bugs by taking all clock bases and modes into account
Thread-Index: AQHTz5nGQbTPe5jWA0WwrFBT6EMGlQ==
Date: Mon, 9 Apr 2018 00:29:08 +0000
Message-ID: <20180409002738.163941-110-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:ZnmMYqA3Qi2B0WdLF2E8IA8kZCkghpzk92bmm/CS8QLmAHu5Alhc2VAQ4jcWX2+JrxNK0RRLkiSBYf5wRy3oXlHAzcQwN8aY7GiSY60lZE6aGIIomHR/KyqRcyRzH8+3TRik49Jz4Dral90WCgf36xqyk0IILeL26P6faHZ5+G5zzLIr7flLpGiZh2iqo/Ksj+pBr3hNhzzjLHUSAcqUKv00GkVa06gHNiprOBRPMku8kbdBe5icvabhF+Lxgic8;20:IiwP7ouYkvTr0CHkTi9wFtjZC7UCkrDY2HHRKyqA+0+WUJCrVkO33uzLPoeGNwFuvIjuK1iRyGOb2dYD/iiM7J4Uuq38QlRYtQ9tUHL13jV4M71rdyvceVORqqzZ+c2GHa9iLpMa/u9JajXGvI2VhJX2HbZjpJtb/wZWoN2qjsA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05c82d6c-033d-4b39-00df-08d59db21f0f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11107338E8847F9A90D71710FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(7110500001)(6306002)(186003)(15650500001)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(7416002)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(10710500007)(6506007)(2420400007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: m8HbdwQGjBW8y5Vff12NddOwwFDGxLtNmXrDRwVE+xE4mlNEOom/MdFOq22g7opS8BEyse8gFa+tNGmHY/vQ4hGmk/mD/p4rjiMvmKP21E0LEkJKfowskHTM9yUXsfA+1O2TQ0fNCZRyPDYZGwgknFjqXSqDeQ7qD0lKSww6RR7W5kxoufj1XGdiOWDxrNaa+dUcIMvbVSceKanG3ebHELXV/ButaKvKK7pbAq7p995YOqqTxVxVdpZJPQZ0r4wX8tWJF4Tt6WmJlH33hnOZFkyImq1eF5qEheeWoiSiGJ8kipZa1aI1bEnNjSSqcvhPfJC04ldtuH8ewtiD6x6P/j71t+Au5WwhDZekCmrRQUVVLBq3pnh94Vl3kE7glXf/DxsfBdwETDtpY+4mqnDlBP7PqtUDAJft/Bn6SJHn8ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c82d6c-033d-4b39-00df-08d59db21f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:08.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 073b9ac245ba..e844556794dc 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -125,6 +125,20 @@ DEFINE_EVENT(timer_class, timer_cancel,
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
@@ -151,10 +165,8 @@ TRACE_EVENT(hrtimer_init,
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
