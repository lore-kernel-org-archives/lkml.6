Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524656113-2-12596050716040610757
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656112; b=cvlgfvpWlUgNu4Cuv/eL2Hn2yKX7zVucC6eigf5LA4DYYHlxTa
    DGaHwyi7X/+4KYtH4mQMIEzlk2rGMaqD/ymX0v1l1tnMTfeAjg6P97Osrhw4gIQ8
    y5dhlp/r9jebaBNuNppDnkjnahnOdx1s8bPBtITIsOaDb5kCS3g9rZ8bYS1PZPDh
    sAf3V2PAzOTKJ/iKR++BvtJoFe4FjhdkQpf8PfXW26eTg/BczCCwapMRCUzSnh9i
    gw1sMd4XrtlhHW9N0a6u1vr8PqS1Q52qVbbkBTM6dVC/h5G1ofV1uJvbeYSkXeni
    SU2nABBnf6HXsAZ7TjEVByd7ymkxjw1a8PoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656112; bh=VMCqsYq/2os1QiqcUjRPNVln/09tHu
    WtFaUPmu0YTrw=; b=BpQFO1RajQi3ugPa2euTJPnQQaQQ2VPISmsOX593ToOeLC
    pcmE5PpONBR4AWJ/K9OKju9x1Rhn3tfogSKlFViI6wl4jmkROcNQVRimo+/4ZAyZ
    IvOgLwTKM/SmttxffYLH9zWWGxRIGgkcw4KseGc+ZkLBVtuUqphaj2BwjuN3l2nL
    IFk6sO7F5RY9FlHHR6CizjW2Uwzm+ISww5UoZdMT0/DzVIxx2AcMn6FK7JfD1S6Y
    BwRXdf/DgJon6j9JHLawQ+VSANVENn6/6ra6N2ehJaWZI490PAH3TghOc++uSFjj
    XHR6CjaDyKZU5R0PtWhgTbcT2jUANyhdf4+cDfsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVDdsL3PqQoZA/P9cYsOtrlVsT0B6uGV1FdOndbCgpG6UW0OE6fFsjX0XR1oYvPFlexXVAcJbzssvZ9OyrX9E5599uS36K2F/bcE5HrmUqS0v9iVBiT
    bnofI5kybNxQa9F6NUVoL3j9Uy6BRwh8mfygdqHz++xO28fhp7dfomTYX9gENTnYza5jEA6nXIJYc8e2TENAvVZhmFVpmVS0TaGKuoOuY/sdtsZBGBrQX893
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=KKAkSRfTAAAA:8 a=4RBUngkUAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=Pk06YCrMqqyFaESMjnMA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=cvBusfyB2V15izCimMoJ:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeDYKeQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbeDYKeK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a3e0726462b2e346a31d@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH 4.16 16/26] alarmtimer: Init nanosleep alarm timer on stack
Date: Wed, 25 Apr 2018 12:33:25 +0200
Message-Id: <20180425103315.495568865@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit bd03143007eb9b03a7f2316c677780561b68ba2a upstream.

syszbot reported the following debugobjects splat:

 ODEBUG: object is on stack, but not annotated
 WARNING: CPU: 0 PID: 4185 at lib/debugobjects.c:328

 RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:327 [inline]
 debug_object_init+0x17/0x20 lib/debugobjects.c:391
 debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
 debug_init kernel/time/hrtimer.c:458 [inline]
 hrtimer_init+0x8c/0x410 kernel/time/hrtimer.c:1259
 alarm_init kernel/time/alarmtimer.c:339 [inline]
 alarm_timer_nsleep+0x164/0x4d0 kernel/time/alarmtimer.c:787
 SYSC_clock_nanosleep kernel/time/posix-timers.c:1226 [inline]
 SyS_clock_nanosleep+0x235/0x330 kernel/time/posix-timers.c:1204
 do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

This happens because the hrtimer for the alarm nanosleep is on stack, but
the code does not use the proper debug objects initialization.

Split out the code for the allocated use cases and invoke
hrtimer_init_on_stack() for the nanosleep related functions.

Reported-by: syzbot+a3e0726462b2e346a31d@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: syzkaller-bugs@googlegroups.com
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1803261528270.1585@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/alarmtimer.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -326,6 +326,17 @@ static int alarmtimer_resume(struct devi
 }
 #endif
 
+static void
+__alarm_init(struct alarm *alarm, enum alarmtimer_type type,
+	     enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	timerqueue_init(&alarm->node);
+	alarm->timer.function = alarmtimer_fired;
+	alarm->function = function;
+	alarm->type = type;
+	alarm->state = ALARMTIMER_STATE_INACTIVE;
+}
+
 /**
  * alarm_init - Initialize an alarm structure
  * @alarm: ptr to alarm to be initialized
@@ -335,13 +346,9 @@ static int alarmtimer_resume(struct devi
 void alarm_init(struct alarm *alarm, enum alarmtimer_type type,
 		enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
 {
-	timerqueue_init(&alarm->node);
 	hrtimer_init(&alarm->timer, alarm_bases[type].base_clockid,
-			HRTIMER_MODE_ABS);
-	alarm->timer.function = alarmtimer_fired;
-	alarm->function = function;
-	alarm->type = type;
-	alarm->state = ALARMTIMER_STATE_INACTIVE;
+		     HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
 }
 EXPORT_SYMBOL_GPL(alarm_init);
 
@@ -719,6 +726,8 @@ static int alarmtimer_do_nsleep(struct a
 
 	__set_current_state(TASK_RUNNING);
 
+	destroy_hrtimer_on_stack(&alarm->timer);
+
 	if (!alarm->data)
 		return 0;
 
@@ -740,6 +749,15 @@ static int alarmtimer_do_nsleep(struct a
 	return -ERESTART_RESTARTBLOCK;
 }
 
+static void
+alarm_init_on_stack(struct alarm *alarm, enum alarmtimer_type type,
+		    enum alarmtimer_restart (*function)(struct alarm *, ktime_t))
+{
+	hrtimer_init_on_stack(&alarm->timer, alarm_bases[type].base_clockid,
+			      HRTIMER_MODE_ABS);
+	__alarm_init(alarm, type, function);
+}
+
 /**
  * alarm_timer_nsleep_restart - restartblock alarmtimer nsleep
  * @restart: ptr to restart block
@@ -752,7 +770,7 @@ static long __sched alarm_timer_nsleep_r
 	ktime_t exp = restart->nanosleep.expires;
 	struct alarm alarm;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	return alarmtimer_do_nsleep(&alarm, exp, type);
 }
@@ -784,7 +802,7 @@ static int alarm_timer_nsleep(const cloc
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
 
-	alarm_init(&alarm, type, alarmtimer_nsleep_wakeup);
+	alarm_init_on_stack(&alarm, type, alarmtimer_nsleep_wakeup);
 
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
