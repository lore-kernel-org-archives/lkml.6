Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239041-2-655732039407207167
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
    1523239040; b=v6SwY3hJHyHd+VJb6l9usf9u1408pcY9Ts2J1tSy6q86kpnc6U
    txm0tWJoiNDkRqx+V9ETtYpCgajzzgciVzA4IkuCeXDwcSoA3F00fh5cLw1fLVjS
    VgOZpXj2ftsEmstJ2crKqsOL1eHx/kfWzOwcyqRActSNwszmeMWHWxpdhmcHGj41
    5nQiNYsN4kSaiNUaRjCiDMjqk4ylAHBYkCdoRgZlycVL5CYqVKZYRJnUjJI4oCt4
    kMh0UZ0kbX27BxUds7UPyCyCnAf40nc2reXWMzGY6831miQTonSbcWwtjGAlAHIA
    rIqHLaIktZzLHcihpzMRWtEwWFRlwx9VvR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239040; bh=mjqDMT5hXw
    dTaVj0RRsrDIS+OueQ+7P57VoGYuXm6Qo=; b=b6BNw9UkcOxeSgl/yg/q+RlmPL
    yjoEsfk+t1NqbSwK0G7VoXAGUfRypkroUaxf9mmDvCRxba3PWX+8LavWGoURRbIN
    /KzlxWHU+7xn81KSSvK29WajVbbojVUgRqt+mvYw9dR1hMLAwekqpx7yQ2yj6qH8
    wvvbk5XgFdRWc4YOjMJtMN+lpEIu+LrW/8PkrQavFc/9Xg7dXfGMpr8vk4e3LWvB
    mRYxttK0l7D7+xyjrIAsRyu829i53It04gGFEhWiFlHf07tNoa2pB4Z2duka/UAT
    7vd0nfsm0F/27C8ds5HT939t+Us9cX2hrhA0uIZMkh+ArmQnh6q1dB0pfr8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PaXj7VJC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PaXj7VJC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDRqbk/yeRvLI05cePFPg4WzRY4ME/GUxiOT3BrIuMSCnU/30xEgN2FCcO98ppI2+0jD8VMdzjqWc+wUSxBPhmM2rbqRGkrw10z+Y9+yZJ/h2T/JuqOs
    l42VjlbEhh4Y/4RNOTUqm6lMW7cAqQqj+VOJyDaxf7hbgWgi6kEfEmUd5aS7ELa7Gs52aTmyn1z7Q1pyhn+NrL61FvQOB/xaOGksMX5J8f9gfJ2n8r+PokTL
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
        id S1753720AbeDIB5Q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:57:16 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756526AbeDIAcx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:53 -0400
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
Subject: [PATCH AUTOSEL for 4.9 217/293] tracing/hrtimer: Fix tracing bugs by
 taking all clock bases and modes into account
Thread-Topic: [PATCH AUTOSEL for 4.9 217/293] tracing/hrtimer: Fix tracing
 bugs by taking all clock bases and modes into account
Thread-Index: AQHTz5lMt+qFpl3ptUO1dihiKq3jNw==
Date: Mon, 9 Apr 2018 00:25:43 +0000
Message-ID: <20180409002239.163177-217-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:8jQrhbwZh0xJE7SiIez+42pqOnhMXh3sJQi2b4EVOXxUTBk8ogcTe3Rr09VKufYNix+IbWDvBVzpZ+rXMR/FOHvsJUks5wNbhl3EcZGLj8sZaL8HbNHXBAZtdeinL1qd45klbXw38R+V6HE3LiUh/RFgLpqX50NotXmSMtlcC4gsYjOqk05gpwpeFxCBPTc/tqp58GgQEFFYHlDzIYV6iLSHmLrjKLnwVTqwuFV8tkii1p+QnR7vCqtb7TN3tqG/;20:LnPy5ubYFOZgn1FiHDorX7lS4yN8fYOcJbdaAZtXz+igsFTAexqmsTz8OF2Xct5Y0tkpSy+eeJX2F8VrjV/yXJF/2naEoKqvQh/hMoGbFIzkgsAyHLTLp74nLuWRkPejJLjoopeYRPp189U/eyHeYvmS0NhIkIOKAEYMOFGJ/wk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06a21ee8-772e-4a13-653f-08d59db16c57
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998233792B40435852B7B28FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(10710500007)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(966005)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(7110500001)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(15650500001)(6306002)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(7416002)(1076002)(6436002)(53936002)(2420400007)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Pcb+YSYx1HIKetfQ0V68Fn5w2IJS9IH8jK90Kjo8BdUgnK0BvHqglvJBR7F2/xOhjl+zsjtFoaFdECTN6Pq+187MnZJtXoNO6Db/m1xFpkjtfSHS+ImYDxFYfiypAkEgTW1pYuN7Nd+ud6/Zm7YvOElM8XXzhXt1hu3agb7GdilTk4ToJPMSq0DgFsNrMa37M41u3d1q+gJ0RK/Ehd+gPRpHfKtIyB1CdEpoFrPdsWa341ilogYp7qCKWbmLMZtmcRGGsynhbIHmDYJsp/W5EezgV/opd+bAUOiLx64IoGJBDDpE7opsC+Emaez9oloZ/eg8SDd3owYgsw/ZzvmQOjRb9TvULIs+AMlJCRD3AMcHnsaZf3bXILfAhm5FXvziWO2igjv8BbJHOSp+9FspwA3G3nUHXLgiZKCsrpRkTcE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a21ee8-772e-4a13-653f-08d59db16c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:43.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index 28c5da6fdfac..3411da79407d 100644
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
