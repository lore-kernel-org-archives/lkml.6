Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELusW+B0VO5a27x97HxbBkpiZZH7H8WWh4iVScyostajqVLQccitFe1wX/yzIQVLGNFrnIMo
ARC-Seal: i=1; a=rsa-sha256; t=1520116446; cv=none;
        d=google.com; s=arc-20160816;
        b=hkbuU97DOFzjlizctn1lKyFr7zk8g5erUdfokvGbnK46QRJyM8TzTqUHqlzlEJnA7F
         4buyuS7poJS+re60XWhkViBM3OZDaGkKlMRtsyTeJNAguIfz24WQm1i1jYVQ4Jdr9KI1
         vFpYwI5O5UxSIZ0YnfSc/jnDl8WZO/V/YQAKHpMmnPhRMALmbQNn9ywIwWFxLiXmVkSM
         28mw6x3+qMR3nQGdte0NN+e1/MaeDxtnL1H7u0FMK48LB4XEV7UEtdDbp6/R7yLGWN5i
         QP+NlUVIbvLFQHnIG9iPZHRDXs34BC22itt3a0RMDGvXqvDS8lb1zfMKVRyXPFzkrXLq
         k6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=RvI0LqMGmtM7PSTNY9XdCoIw+Gw3UrSHg2UrYOP1D7c=;
        b=bVqBpxS4usplZsnAzeCl8BNkg8sCCSnl4CldqbIbTs/E4k2Hxfu2VQ3Y22aUjCuPOg
         WovMgn6aXQt5l67hNy2OuNaChwag+tcPLVcNjVngGu5AQmTiDU9/FvSCde72BlphvgII
         FkYWpF9Die1GF6IOA5lQ28f0MAddy+xxywk1alF6SXtqvqzVVNr+OIas3pFipJ3tTKCj
         T3SYrsObqUzB8S6VitjsiFUfNrkiN9GUv6ARJoNPk1pl/hH+pYrSLX5U4+xYkinQW2dI
         fCyCvt1liEjG0eACYIbj/R+aidXkezD7pucJ3JP8YpucsbA01/iU5d1iQAgUBq2/4YQh
         OQGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=OXDCeAQ/;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=OXDCeAQ/;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 105/219] printk: Correctly handle preemption
 in console_unlock()
Thread-Topic: [PATCH AUTOSEL for 4.9 105/219] printk: Correctly handle
 preemption in console_unlock()
Thread-Index: AQHTsz8EqAqQ68089kK2JQv6+DuQSg==
Date: Sat, 3 Mar 2018 22:28:56 +0000
Message-ID: <20180303222716.26640-105-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:nqYQX2vRYDNTXC9//IWD6Qv9JELsVwamM20gcWCT3EbfkeP/UOisrgrtqSvxawHPO7/Hyi0na8Y8pGxBDHRY0s6MI1gngphyjTuSnd6Hng1gkYcuJI4RDA3OLfy0BG7p6EPoBUZlNJOhFzZzZ0tjnICcNeSB04JRzNTykD6oliF+uB6kL3vyNS+50lwXO7m12c8tPG8Nnlq1utDWNscB3g9v+EOI628p7uUjEB1LkPc+AjZ6+smnH/ggcqMwwE5C
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0e4ad06-eb37-41a4-144a-08d58156db1d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065AEAE7178CED25C685527FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(274141268393343)(89211679590171)(209352067349851)(9452136761055)(85827821059158)(42068640409301)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(6306002)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(966005)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 1UzRtVyRMBwz51YUjOLk3lIeuOiSpfxCxXu0clXnPb09TqIy2c3SkgF/mNEuQu9Ix+KbSTsu0UYLku0UhC8iI4k9zNEIckkxb43y//dAeYu/cwozVZuuKI3QRn75j83sgWReUxchBnMeND5aKxjkT0EHjreGness2RheL7ywjBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e4ad06-eb37-41a4-144a-08d58156db1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:56.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957622895822845?=
X-GMAIL-MSGID: =?utf-8?q?1593957622895822845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit 257ab443118bffc7fdcef38f49cf59be68a3e362 ]

Some console drivers code calls console_conditional_schedule()
that looks at @console_may_schedule. The value must be cleared
when the drivers are called from console_unlock() with
interrupts disabled. But rescheduling is fine when the same
code is called, for example, from tty operations where the
console semaphore is taken via console_lock().

This is why @console_may_schedule is cleared before calling console
drivers. The original value is stored to decide if we could sleep
between lines.

Now, @console_may_schedule is not cleared when we call
console_trylock() and jump back to the "again" goto label.
This has become a problem, since the commit 6b97a20d3a7909daa066
("printk: set may_schedule for some of console_trylock() callers").
@console_may_schedule might get enabled now.

There is also the opposite problem. console_lock() can be called
only from preemptive context. It can always enable scheduling in
the console code. But console_trylock() is not able to detect it
when CONFIG_PREEMPT_COUNT is disabled. Therefore we should use the
original @console_may_schedule value after re-acquiring
the console semaphore in console_unlock().

This patch solves both problems by moving the "again" goto label.

Alternative solution was to clear and restore the value around
call_console_drivers(). Then console_conditional_schedule() could
be used also inside console_unlock(). But there was a potential race
with console_flush_on_panic() as reported by Sergey Senozhatsky.
That function should be called only where there is only one CPU
and with interrupts disabled. But better be on the safe side
because stopping CPUs might fail.

Fixes: 6b97a20d3a7909 ("printk: set may_schedule for some of console_tryloc=
k() callers")
Link: http://lkml.kernel.org/r/1490372045-22288-1-git-send-email-pmladek@su=
se.com
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/printk/printk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9c5b231684d0..ab6855a4218b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2342,7 +2342,7 @@ void console_unlock(void)
 	}
=20
 	/*
-	 * Console drivers are called under logbuf_lock, so
+	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
 	 * console registration path, and should invoke cond_resched()
@@ -2350,11 +2350,15 @@ void console_unlock(void)
 	 * scheduling stall on a slow console leading to RCU stall and
 	 * softlockup warnings which exacerbate the issue with more
 	 * messages practically incapacitating the system.
+	 *
+	 * console_trylock() is not able to detect the preemptive
+	 * context reliably. Therefore the value must be stored before
+	 * and cleared after the the "again" goto label.
 	 */
 	do_cond_resched =3D console_may_schedule;
+again:
 	console_may_schedule =3D 0;
=20
-again:
 	/*
 	 * We released the console_sem lock, so we need to recheck if
 	 * cpu is online and (if not) is there at least one CON_ANYTIME
--=20
2.14.1
