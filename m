Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bVetck8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD3920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeGYEWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:22:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45262 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeGYEWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:22:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P39KFn057176;
        Wed, 25 Jul 2018 03:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=96yVAkYhnOZEteCpzcWbFUXqGCBPdDycThJBrXOZ7Ng=;
 b=bVetck8JVECI6C+aQYFFoJkaJp4tEWrj1etHY0KDYfTx3m29X0/gX5CW3s8awoQfPeHO
 iNBrkyPjfhwjkCjucfAnahfGbN5nTw56w7gPeU9g/Yk84rZtLltAOJAk8tG4sNn0RTHf
 Oo6ma2QQjpBWb+HrRg8f604tGBR/NdQnBTrjuSJmlUFaIODznmu9zOL4c9LQx46Iupv0
 d+WVLmCI11TzoQFO1Uu/qe0kAgx7ll2RV7nIuip8KxPq74Gfc+Ip/hLk/7Poimy4OQFd
 pTL//an7piGBgyg2LpEuSwDSFUfzo5/Oo5IuPawe8/ptHT5/++DLo0b3CQjfbOyFXtfr DQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kbvsnujjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 03:12:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P3CTM8016605
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 03:12:29 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P3CSnf026290;
        Wed, 25 Jul 2018 03:12:29 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 19:41:56 -0700
Received: by mail-oi0-f53.google.com with SMTP id w126-v6so11228265oie.7;
        Tue, 24 Jul 2018 19:41:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlFWe+Xh3x4bi+g2YvKrxqMX6qgLu7h+W78n/A2aq74v+sApEveq
        CS9m5GOjGwOcJ599NL/6EtLTuYloRL46QJyyzsM=
X-Google-Smtp-Source: AAOMgpfpswBvJJ9ZuAL1HevES5a5cn3MixFXBu070RPVEMYQChl++9Ujt6iyoS4O2ryNl4hTmGnmq7j6xqV5IjFMPiY=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr1396194oih.65.1532486515891;
 Tue, 24 Jul 2018 19:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
 <20180724195215.GA22496@roeck-us.net> <CAGM2reayvBs8rs6yHZYV9SvPz-tsNG_Ux8ypHguLLagiS2SkuA@mail.gmail.com>
 <CAGM2rebX7dq_ejNuSotV_0gJZY6pqro-KteXz9zzhDkjtSxaOw@mail.gmail.com>
 <ddb6bc3d-b764-3115-ebc7-54c70c967f24@roeck-us.net> <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
In-Reply-To: <CAGM2reaUEOMbbtfbLY2n66jJV=ZH0Wy7GtX-tfCG62U7Uhn14g@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 22:41:19 -0400
X-Gmail-Original-Message-ID: <CAGM2reYevKGh7pqvK5O7oLB5FYkuU31v7t_AMDYt0=Q+jsVEqw@mail.gmail.com>
Message-ID: <CAGM2reYevKGh7pqvK5O7oLB5FYkuU31v7t_AMDYt0=Q+jsVEqw@mail.gmail.com>
Subject: Re: [tip:x86/timers] sched/clock: Enable sched clock early
To:     Guenter Roeck <linux@roeck-us.net>, peterz@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

The problem is in this stack

start_kernel
  local_irq_enable
  late_time_init
  sched_clock_init
    generic_sched_clock_init
      sched_clock_register
        WARN_ON(!irqs_disabled());

Before this work, sched_clock_init() was called prior to enabling
interrupts, but now after. So, we hit this WARN_ON() in
sched_clock_register().

The question is why do we need this warning in sched_clock_register? I
guess because we want to make this section of the code atomic:

195         new_epoch = read();  <- from here
196         cyc = cd.actual_read_sched_clock();
197         ns = rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
rd.sched_clock_mask, rd.mult, rd.shift);
198         cd.actual_read_sched_clock = read;
199
200         rd.read_sched_clock     = read;
201         rd.sched_clock_mask     = new_mask;
202         rd.mult                 = new_mult;
203         rd.shift                = new_shift;
204         rd.epoch_cyc            = new_epoch;
205         rd.epoch_ns             = ns;
206
207         update_clock_read_data(&rd); <- to here

If we need it, we can surround the sched_clock_register() with
local_irq_disable/local_irq_enable:

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cbc72c2c1fca..5015b165b55b 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -243,8 +243,11 @@ void __init generic_sched_clock_init(void)
         * If no sched_clock() function has been provided at that point,
         * make it the final one one.
         */
-       if (cd.actual_read_sched_clock == jiffy_sched_clock_read)
+       if (cd.actual_read_sched_clock == jiffy_sched_clock_read) {
+               local_irq_disable();
                sched_clock_register(jiffy_sched_clock_read, BITS_PER_LONG, HZ);
+               local_irq_enable();
+       }

        update_sched_clock();

Thank you,
Pavel
