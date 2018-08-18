Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E3C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 22:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF7D216F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 22:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP35wpwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF7D216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeHSBnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 21:43:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32871 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSBne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 21:43:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id i134-v6so4107909wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYltZD4gjCjq/mtjT+MifMU6GSVZrDSVf/TNPqh6Cp4=;
        b=pP35wpwqM4yY+ShhDm6YIIJhU6rntLUQD0nUCIQovtDB7UnYvAWT7R3+JWFsXv79vr
         sUomkcfSR5JmR6WiW0tlc9nvxNsyXcZaZimKpBg3P4xZ48z4anbx25CTpnfQAKWLlLnM
         FervUbx2MXSZ/8DSzaXW8cIzsBGnUXbRZ4H2ZfxwypmCmvWnZnGFe5IWSbipdgIVK1HM
         3hvgOQyjzLI9vdo3GFv3kAz7brAP+CKH1f3Q8YG5zn8si5kilMNBg0Ut3bBsT2lTUaWW
         ozbNlyA9EVLd9wyI0XQPZk9bnJ2uxRiZK090HE4z2NL9kGtI9odTTQshhlItWdxjqIvZ
         OwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYltZD4gjCjq/mtjT+MifMU6GSVZrDSVf/TNPqh6Cp4=;
        b=KVY7XD0yfxEXl7iv0bMJZuy53jyGsX0pNKP6gmS6KE+6lnSn7jTqG0FZqH6VFj29hK
         Metj2tseOKhrOp1JpitWiuO0S2Yj9Rb0T0SrQHoU7Wmz7rB8SQHTyPwLwXbsuTHYXo09
         qVDFR9hya8T7NDgfHzKqLbgAolQVf5OOBGgGX5h/P6kWj4NHxthnH+R3w5RxNE6k16BZ
         UhmxSTLe15ZGEFgMDsg2ncLit43KwUiKIyCyIhkK+VtxHd6cl6/5RBXM0En/crIiQ5GH
         gQKVC0bby3Xzc2VHtY4hWWQwRQ6b7nKHwiyeRKqIFbAPZITiKVnB4QSwQbNe/DzcOyKF
         q6/w==
X-Gm-Message-State: AOUpUlGrjIl9mfJKE6vmpC3B6GAq5tnEtCbND2FH+wWf2TfBzF8urkif
        2RSWzkm333lEcbUNVFJ37bc=
X-Google-Smtp-Source: AA+uWPxfW4R+OjTFcQqfAhGtzhHRu0QBXOnjxs0hb3BQ74kybGKlBnM1povjhqUdphJgsfKB3tFZFg==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr20467659wme.15.1534631659040;
        Sat, 18 Aug 2018 15:34:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:814f:8322:e000:8bd? (p200300EA8BD4D600814F8322E00008BD.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:814f:8322:e000:8bd])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm13067618wmd.32.2018.08.18.15.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 15:34:18 -0700 (PDT)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <alpine.DEB.2.21.1808181323430.2151@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7b221782-07ec-6465-9d5c-8c17ec517d5d@gmail.com>
Date:   Sun, 19 Aug 2018 00:34:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808181323430.2151@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.2018 13:26, Thomas Gleixner wrote:
> On Thu, 16 Aug 2018, Heiner Kallweit wrote:
> 
>> Recently I started to get warning "NOHZ: local_softirq_pending 202" and
>> I think it's related to mentioned commit (didn't bisect it yet).
>> See log from suspending.
>>
>> I have no reason to think the fix is wrong, it may just have revealed
>> another issue which existed before and was hidden by the bug.
> 
> Looks so. That seems to be related to CPU offlining. No idea yet...
> 
I checked a little further and at the time the warning is printed the
cpu is still online but not active any longer.
I can avoid the warning with the following change, but as a
disclaimer: I have no clue of this subsystem and don't know what
I'm doing ..

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c..19a030e40 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -862,13 +862,13 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
-	 * If this CPU is offline and it is the one which updates
+	 * If this CPU is inactive and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
 	 * the CPU which runs the tick timer next. If we don't drop
 	 * this here the jiffies might be stale and do_timer() never
 	 * invoked.
 	 */
-	if (unlikely(!cpu_online(cpu))) {
+	if (unlikely(!cpu_active(cpu))) {
 		if (cpu == tick_do_timer_cpu)
 			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
 		/*
-- 



>> Rgds, Heiner
>>
>> [   75.073353] random: crng init done
>> [   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
>> [   78.619564] PM: suspend entry (deep)
>> [   78.619675] PM: Syncing filesystems ... done.
>> [   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
>> [   78.656094] OOM killer disabled.
>> [   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [   78.658177] Suspending console(s) (use no_console_suspend to debug)
>> [   78.663066] nuvoton-cir 00:07: disabled
>> [   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   78.672210] sd 0:0:0:0: [sda] Stopping disk
>> [   78.786651] ACPI: Preparing to enter system sleep state S3
>> [   78.789613] PM: Saving platform NVS memory
>> [   78.789759] Disabling non-boot CPUs ...
>> [   78.805154] NOHZ: local_softirq_pending 202
>> [   78.805182] NOHZ: local_softirq_pending 202
>> [   78.807102] smpboot: CPU 1 is now offline
>>
> 

