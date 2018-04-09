Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523247135-2-1518241377797694888
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
    1523247134; b=EXyQ8XP9BjLfigQBzPAuAdcXjgqw3EPg6lg2WhaJSAya9GFuri
    9lu/QWjdSW/3VQge312NFF6aT+epnnu0cdXFjh7/8gS5U5c34mLg6S9l5dKX4nE2
    AoyJZu2t+XwpXy8/MK3RcawLjAtQeorGExdOelpHQRB5Vq21VEJQ75oGZS7oD339
    pgXLlRqcNv3nmN3oAolTFJ8wTPlOH22Kp3ZfeiDq3MA0ouNJIz6yCLjWp2CKgtRS
    AC3LIM1yKbWn0tZ9hniwxhrO+/IWt5tmmE4H7TXip6MaZRi5UaBfCqktKPBuR1KE
    effr48nFuW3suYhcsc9ThzZRHi7YGXZOCluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247134; bh=M3yjupSaiO
    N2g6Pk1Y3fvo4OgI4bKco6cfYk6tJA8p8=; b=IWSgwAwxBIscOLf8nCCsrcYB51
    UWKNadKepWGJtXKl+vw143bIzHDb/KwjKlgriCpAMjLcJDakU6Qn664tlVYwOHVM
    H5FEezplyED6uQz56cLdSx8vmNn51v1kCnUBakxU7VODKXEIdpbYC7Tk3hJ2KlUc
    qLRuE7OlKnxJROTe7km5YtVKMeaSZ7rSVnYJ6N6yHtiVcwa3iN47PaPQE31kSm8q
    9y9MkkcC+uwZmqvo6mue8K6bbflyiZskQ4WFvK8lyyhNzghMMDxkDaC51daseN38
    2eQzk1YYcstoTd9HZJOqwbGP0/2yEF6pNWBtpldRdJATrmfL7vzXjD7vKV9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GgSGRVrh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GgSGRVrh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK3ztsnbKbSy7i11EW+7PQgdF70cyeojDCYsLwhXMKDuXRbbLzyW41W7tgt6Epn5uXoFlcBqco80IPWYDMDGV7z3SwxDzru9JZX0L5+1V0kw8ABHgtbK
    Sw/8ndocpHLmE2IbAKkNMA1Kpk1ggHdB56nkH+w8lwIpNL0Bp6sY4gBZOBNsklgvZNcG06bVrNhIB6pV+C4FWxfmkT+GVXulnAtYzVnDoSxCy3nikRpE4M7V
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
        id S1754474AbeDIEMB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:12:01 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752978AbeDIARA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:00 -0400
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
Subject: [PATCH AUTOSEL for 4.15 014/189] tracing/hrtimer: Fix tracing bugs by
 taking all clock bases and modes into account
Thread-Topic: [PATCH AUTOSEL for 4.15 014/189] tracing/hrtimer: Fix tracing
 bugs by taking all clock bases and modes into account
Thread-Index: AQHTz5gRAGd5HPN2fkyehcUcps9GSw==
Date: Mon, 9 Apr 2018 00:16:55 +0000
Message-ID: <20180409001637.162453-14-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:lghP1cWr16Jab8cV4nuywLOVJvd3uqoVE91GoWyyR/XwXV4VxsRbjFpcfgP/0QD5gBM1t4taClM5N9Gpt+GHB2/Mdtbji8qSpEWw78932VYRHAZAvNQNXXb12qHFkgN6JMB4V4bnt0L6no7P8A8MbKyan7WFc2AnZgn3qmMsypx0olKoWvgLAQFnfpD5MBKR7xERTQuyHljO+LujBwQtVn31F1BPlTmez+9oiefxgI/PA0+mk09XO9226gPE6VPo;20:nLinXipG6eLjKfVnPLUHjDWdD2I0FM9bX/CnsGsVjMqd5G+uaXn0STAqJLOzRpPL2hpYzfsFzqst65R0B0Mi2z2SWSOjHfgVTsXiWxcCwMfTArfmJUdVrllA0o7jRWrEFtmprQgpmuybFDiSBBNw5Os2rhwNjaEE3DzNzTue3X0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 020d59b9-2e6c-410d-8803-08d59daf33b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127287C70D418A53148FA06FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(15650500001)(105586002)(186003)(7416002)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(2420400007)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(7110500001)(81156014)(14454004)(10090500001)(68736007)(10710500007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UCRQmAIPj+i95DCq+JSyWvJ+ripU3W1OVWLLL7HjOguY6W+XZcRY8er5ayrvwooTt2K8WD5Wk86SAAf/bPI8FYCK+f50CSzy7kkPmXGCjnYVfRaE1YXDgirQ7081p8ULcULfw8Yvt3BWw0cDZF8bJHhd9blrYatl9I8/lNisuioZuF6nVBsDf5402WC+PBtMG5+i2Np+Gl0/XLrNWDN7B8srP13EWgUB5bvaFRn24My5M383cOIbfP+4YXbcPBaI5MQiMXSEsjs9GVo5UfBJRBBBlqGqgX9655iNuIBLe4DbAucvci9+Sg8uo6yjzJ1VNcgTCnmRQWNkAHVmtbT5NEDd1Dby1rPM6lUz8Cep9i1dZy3n/jCgTjYgp9u44FMNJyPSmhJT0Vc35yOpO4bAkUilQtL6uHgcXj6D5ZR+CTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020d59b9-2e6c-410d-8803-08d59daf33b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:55.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
