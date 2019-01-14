Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37389C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADD20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l45stBf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfANT7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:59:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33296 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:59:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so362032wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XvJXcAMyikUUgw6Dc702RSeCaVIx+EYt85czs0yeFWg=;
        b=l45stBf4ftpDewV/h5ENvGLYl/h/aNkq9zsLZPCbokKMhtCSjRF0HzbjbGlMKbUg1T
         MuS4gvCVLAz12rX9n0i2/ceU3FBc0DhxOaoPWuxlVSx6ulv4bR8QLQrfPZ4SX9IL6t+p
         oWNisLzpqCNLgW0TEQu7sQyHT9aGT5LjY/Ao2Xd828jC+EVT88dwdoguOa2xAXPMEpqP
         W9l6fWpgPiTkN2t0aqF6Y+gyk4q7p+bVtuTI9aaVt25LO7BuNm+VWxuA/PNT7iqUuG8u
         /LM/tELdg7cxUlVJE5vWALxGOEQLwgR34a0IFXO2d7crlOcC8r8mkg6jCkleuWdc/+LC
         riOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XvJXcAMyikUUgw6Dc702RSeCaVIx+EYt85czs0yeFWg=;
        b=WLcUBabhf5L4DpASXtSlHbc+9ShqjfWNpJkpUvrJzUKowpb0cjsdwiJB1MPwGaLAc0
         T8UbDbkQE/gJrRUshaxgheRg14PzW3cmr34W9CSpekqUrOjsSsVNQRtCW9Y0vzHmfwjM
         0VRNgZN3aeMx3KDmDn33iZOfxrlT9aX72kX1zM9lYLT4tXjnblTpMxRXX2zco+A4tYR1
         TMqnbvM/esv+V5zG3ibn8nhs6zLEXn7LcHBhdE6nP3qn3HaEuuYGaAPkiYn7BYZey35f
         egSZ+rTeTT0Fit15f3FfMufFPbLlB6pEfvJrXaVrl41+IOOIuCrVtTXWs65QOqXCBMd2
         Nf3w==
X-Gm-Message-State: AJcUukeQRHbkr24s8mcYgaYlpF2Li/noGECk0Jp3BCw/sCRpLHV7Y05g
        7dAMlTchVm+WsRU7G9ByFCPDKwo=
X-Google-Smtp-Source: ALg8bN4wICQmaTLoOe2+2VnabGZwJu19Rkupj6eLRdc/YnTOj6XxnozhXsIvrkEnM4igNatzY2Kx5g==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr100495wrv.121.1547495949794;
        Mon, 14 Jan 2019 11:59:09 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id c1sm27437067wmb.14.2019.01.14.11.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:59:09 -0800 (PST)
Date:   Mon, 14 Jan 2019 22:59:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: read kernel cpu stat pointer once
Message-ID: <20190114195907.GA9680@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help gcc generate better code:

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../vmlinux-001
	add/remove: 2/2 grow/shrink: 0/1 up/down: 92/-142 (-50)
	Function                                     old     new   delta
	get_iowait_time.isra                           -      46     +46
	get_idle_time.isra                             -      46     +46
	show_stat                                   1489    1477     -12
	get_iowait_time                               65       -     -65
	get_idle_time                                 65       -     -65

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/stat.c |   60 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -23,21 +23,21 @@
 
 #ifdef arch_idle_time
 
-static u64 get_idle_time(int cpu)
+static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle;
 
-	idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
+	idle = kcs->cpustat[CPUTIME_IDLE];
 	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
 		idle += arch_idle_time(cpu);
 	return idle;
 }
 
-static u64 get_iowait_time(int cpu)
+static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 iowait;
 
-	iowait = kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
+	iowait = kcs->cpustat[CPUTIME_IOWAIT];
 	if (cpu_online(cpu) && nr_iowait_cpu(cpu))
 		iowait += arch_idle_time(cpu);
 	return iowait;
@@ -45,7 +45,7 @@ static u64 get_iowait_time(int cpu)
 
 #else
 
-static u64 get_idle_time(int cpu)
+static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
 
@@ -54,14 +54,14 @@ static u64 get_idle_time(int cpu)
 
 	if (idle_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
-		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
+		idle = kcs->cpustat[CPUTIME_IDLE];
 	else
 		idle = idle_usecs * NSEC_PER_USEC;
 
 	return idle;
 }
 
-static u64 get_iowait_time(int cpu)
+static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 iowait, iowait_usecs = -1ULL;
 
@@ -70,7 +70,7 @@ static u64 get_iowait_time(int cpu)
 
 	if (iowait_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
-		iowait = kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
+		iowait = kcs->cpustat[CPUTIME_IOWAIT];
 	else
 		iowait = iowait_usecs * NSEC_PER_USEC;
 
@@ -95,16 +95,18 @@ static int show_stat(struct seq_file *p, void *v)
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
-		user += kcpustat_cpu(i).cpustat[CPUTIME_USER];
-		nice += kcpustat_cpu(i).cpustat[CPUTIME_NICE];
-		system += kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
-		idle += get_idle_time(i);
-		iowait += get_iowait_time(i);
-		irq += kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
-		softirq += kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
-		steal += kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
-		guest += kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
-		guest_nice += kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
+		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
+
+		user += kcs->cpustat[CPUTIME_USER];
+		nice += kcs->cpustat[CPUTIME_NICE];
+		system += kcs->cpustat[CPUTIME_SYSTEM];
+		idle += get_idle_time(kcs, i);
+		iowait += get_iowait_time(kcs, i);
+		irq += kcs->cpustat[CPUTIME_IRQ];
+		softirq += kcs->cpustat[CPUTIME_SOFTIRQ];
+		steal += kcs->cpustat[CPUTIME_STEAL];
+		guest += kcs->cpustat[CPUTIME_GUEST];
+		guest_nice += kcs->cpustat[CPUTIME_GUEST_NICE];
 		sum += kstat_cpu_irqs_sum(i);
 		sum += arch_irq_stat_cpu(i);
 
@@ -130,17 +132,19 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
+		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
+
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user = kcpustat_cpu(i).cpustat[CPUTIME_USER];
-		nice = kcpustat_cpu(i).cpustat[CPUTIME_NICE];
-		system = kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
-		idle = get_idle_time(i);
-		iowait = get_iowait_time(i);
-		irq = kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
-		softirq = kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ];
-		steal = kcpustat_cpu(i).cpustat[CPUTIME_STEAL];
-		guest = kcpustat_cpu(i).cpustat[CPUTIME_GUEST];
-		guest_nice = kcpustat_cpu(i).cpustat[CPUTIME_GUEST_NICE];
+		user = kcs->cpustat[CPUTIME_USER];
+		nice = kcs->cpustat[CPUTIME_NICE];
+		system = kcs->cpustat[CPUTIME_SYSTEM];
+		idle = get_idle_time(kcs, i);
+		iowait = get_iowait_time(kcs, i);
+		irq = kcs->cpustat[CPUTIME_IRQ];
+		softirq = kcs->cpustat[CPUTIME_SOFTIRQ];
+		steal = kcs->cpustat[CPUTIME_STEAL];
+		guest = kcs->cpustat[CPUTIME_GUEST];
+		guest_nice = kcs->cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
