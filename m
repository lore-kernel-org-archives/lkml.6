Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F518C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ABC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugxpwCzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ABC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLKIAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:00:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43972 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:00:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so6269357pgk.10;
        Tue, 11 Dec 2018 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bo+uiCGKH4JZ01SzB7fJguGbkV1Zo+WaVFjpkM6LCdc=;
        b=ugxpwCzmTRvaZpKvAWTWKQBHIsfWrwa84SaspO986VRxTbmNzGOfbqBttMVsR27z6X
         AToQTsoXMlLIEeO+/mxMcv4glVPacPRAcLVMaEgVZQxiGwDlV1zTM0ECfpUjC2eieuRa
         oJnHnxfzhAMILmrjwPYpIOHcPM1uNP8VxMamZgcxzQWCPnBljaD5pXamiEf5K3E9pC4Z
         KHHE/arsX5RxUzWlz6OBeadBuRuwaPALG66Mn2+qH3KfY2LxTqk67823qBuhkLJg79+Z
         zewAqTII/KnjLEm3caYNK0G3skPJYO5BEAh1JWLqPJH1dei3Xj+uWRsxnQLFHG8Jniyh
         1cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bo+uiCGKH4JZ01SzB7fJguGbkV1Zo+WaVFjpkM6LCdc=;
        b=WaZUJuK8bDPf3wDGdBA8za6Tfvl9quWGS/S5ttAQF1vs3vvkl+/2ypW3+pOsC7CmG5
         y1s1iQI4MED3gtrH7B4OR3UOiPcwa+8lXnxrjfNHDixqVXW7azhERGQeVOdAtpbaCTPZ
         iB+68he37AJ6Hc6XkAQfHdDlXl1LHBwSwYBm1wf7PhUxaRuABfnhzb8KhG88O4wQCDRD
         sPnQXCl6Em2mWWQhFZqDpCXrhtlOWvZ5t+i+SQl9pohSLwohREPl72Lia20ZjCziPG87
         UbHUtLovnDURE6b6oH8qGT3/AUk4ozizTCF31zKetDVoIIlBhcuTfYLvZcpgOxdE8fQd
         5AQg==
X-Gm-Message-State: AA+aEWZz+DS+WLPmbCsx3i6ymZlBvAG2Pv9iiRGoTN3RrVCHYK+e17m5
        pKqhlrutL3t5LYLlxy502Oc=
X-Google-Smtp-Source: AFSGD/Xx6Vmf8AV7W1JXt3eX/jUj4CaLbfs24QRgxdFae04Cl0Zy8q3HXJVqkuzAgnSVxU1QvNutTg==
X-Received: by 2002:a62:13c3:: with SMTP id 64mr15343305pft.93.1544515248116;
        Tue, 11 Dec 2018 00:00:48 -0800 (PST)
Received: from localhost ([175.223.2.144])
        by smtp.gmail.com with ESMTPSA id d18sm20576631pfj.47.2018.12.11.00.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:00:46 -0800 (PST)
Date:   Tue, 11 Dec 2018 17:00:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        bp@suse.de, keescook@chromium.org, mm-commits@vger.kernel.org,
        sergey.senozhatsky@gmail.com, stable@vger.kernel.org,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211080043.GA521@jagdpanzerIV>
References: <20181204154936.wbgcovzpc54n6dvs@shbuild888>
 <20181205022654.GA503@jagdpanzerIV>
 <20181205024713.nqyt6qiamokq7qtl@shbuild888>
 <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (12/10/18 17:45), Feng Tang wrote:
> Yes, this is very valid concern. And after Petr and you raised it, I did
> some experiments with 3 x86 platforms at my hand, one Apollolake IOT device
> with serial console, one IvyBridge laptop and one Kabylake NUC, the magic key
> all works well before panic, and fails after panic. But I did remember the
> PageUp/PageDown key worked on some laptop years ago. And you actually raised a
> good question: what do we expect for the post-panic kernel?

Yeah.
It used to be case that people expected some things to work after panic.

> For the v4 patch, my thought is, for experienced developers to make
> sysrq/panic_blink work, it's easy to add "panic_keep_irq_on" to kernel cmdline,
> or runtime change it by
>  "echo Y > /sys/module/kernel/parameters/panic_keep_irq_on"
> while for normal user, they can by default see the clean panic call stack
> either on a screen or a serial console.

Before we move on, just a quick question, since I wasn't Cc-ed to v1
and v2 of this patch - did you have a chance to ask x86 people if they
can help in any way? Asking to make sure that we are not fixing a _maybe_
x86-specific problem in arch-independent/common code.


/* offtopic */

LOL, wish this was a "dumb-and-ugly-solutions" contest; I'm pretty sure
I'd take the first prize with this one:

---
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 04adc8d60aed..40f643bb7fdc 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -181,6 +181,16 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 	irq_exit();
 }
 
+static void native_smp_suppress_reschedule(int cpu)
+{
+}
+
+static void native_smp_to_up(void)
+{
+	WARN_ON_ONCE(num_online_cpus() > 1);
+	smp_ops.smp_send_reschedule = native_smp_suppress_reschedule;
+}
+
 static void native_stop_other_cpus(int wait)
 {
 	unsigned long flags;
@@ -250,6 +260,7 @@ static void native_stop_other_cpus(int wait)
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	native_smp_to_up();
 	local_irq_restore(flags);
 }
---

If the system is not SMP anymore (hlt non-panic CPUs) - rewrite
some smp_ops pointers to NOOP stubs to suppress some of those
warnings.

I know it's utterly awful.

	-ss
