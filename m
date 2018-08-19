Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32753C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5781215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 06:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5781215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeHSJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 05:39:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:41869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeHSJjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 05:39:17 -0400
Received: from homer.simpson.net ([188.174.240.126]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQih7-1fPawq25xV-00U0v5; Sun, 19
 Aug 2018 08:28:37 +0200
Message-ID: <1534660115.6187.4.camel@gmx.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 19 Aug 2018 08:28:35 +0200
In-Reply-To: <1534597992.15909.17.camel@gmx.de>
References: <20180817162340.6e8482fd@gandalf.local.home>
         <1534588142.2516.10.camel@gmx.de> <1534597992.15909.17.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wYuIAjAJ3h3t+ns7gRieQewbmX/XXesaWEsYA7W+XXcJj/R7P54
 x6sSoo83lDo3xIzkPiRt7L13evmmM5nLY7UXR07vZ4Tm5CeuRguxbADFP2Gwiy91jw+rhL8
 61V/KSFhzB98pSLORJqhakgzi0+92nqVgGGvZA7cHY9Wol/0WkWzdaAy5kto/HI5eoa3RI7
 d3WdodVTd35Q9ghpFO5zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/LRdgoCdHoI=:3J7agH4hK1AqBF4SuBN+1z
 Plr4rjL2Ig6RAG5BfFDGOSCkn9z7BARi2aW8uX8wfv18EWN/tSb4Rg4DcetJwYVF6Qp+R7Y54
 bIRyIpSY84AhMpLBAuRKXV+VuOhkP2PFkuGMMCAjztYpJhUqOg83C9UVUIAkN11jllaYSEmPM
 GW/DS33wgkRbV9a22XwEDDB4P8Qsi9s6jQcDK/jvmJKKPFIw3+Wsd/yrugYRJmFk2yZjhtpv+
 XUHx0ZTsn2uVY+wHGk/rfT+f0YulVF6PDg6OhxjjjGtzUR2KazyawsBoZ89KZXfiaPYmwHwv5
 5p13RVOrwUboqO0DJmGRDIPvFPHIAPjRQmf2489lu8smuHwq3GP7kbj002ykev6Lm2MqSl0dL
 1tLzO8+ElrLFd2n8IxmH/K1O7mkjut+0kN/9hH7psCLqzGAfMNEpAMD4qmB/1BKxWHawcFeO+
 F1dmPQ5fO/CjR1dwYRQ1opxzLfENYBa2AMFO1bSpnDXjAECnLC8GQoCJMAmEznHG1gRnueeOH
 ph32VLwsizN6mWjSszUBbtjgZnAVlCP19pCc9LxvbhE+fJyclolwnD3Js+CmxVKUuDF0n2yhV
 s0WEA7sziVCxMJ9BQxGmSbV5/IVjieurU58zB1pSBal2Oab/h/LuJktj0vjD5LpN6Dmi02Ax6
 NyzbHz0+4cIacsgIYDquKbAskJFemFaUkI6MSFAv7dhqxylalsrGfzn1qeYIg+B6ev3Zh+g4b
 WeCNmrs2Z/aMTvAmf8qqV53qkmVLXEmv5INAXS7CL1Cauiy3LAJUmeM08/kPe1DOgd7Rsjvod
 QQsj/Z2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-18 at 15:13 +0200, Mike Galbraith wrote:
> seems it has be something from the 4.17 cycle that went back to 4.14-
> stable after 4.1[56]-stable trees went extinct.

See ("sched/core: Require cpu_active() in select_task_rq(), for user tasks")

Fix it like so?

sched: Allow pinned user tasks to be awakened to the CPU they pinned

Since 7af443ee16976, select_fallback_rq() will BUG() if the CPU to
which a task has pinned itself and pinned becomes !cpu_active()
while it slept.  Serving a 10 megaton eviction notice is neither
helpful nor required, the task will migrate when it can do so.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
