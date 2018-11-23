Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A13320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVV2ghZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A13320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407971AbeKWNXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:23:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeKWNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:23:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2406276pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Wy8CQ3X8SY/C9/CSYvkmwYCm8PZOvVaoL1d3mWNPC8=;
        b=vVV2ghZB6yYcq80oTFa48sKNgJYv/fPahoGUH83qAMnVROm3SUY1aMpZr79K+4iKaz
         80njRIztvoL0D/KNVs4W7iIgu0I2aE13lpyoubX6+oihtr/27zbPib1Lb1Ty7OT0l0Er
         1Iw8sVjpnXlF9lHVsg1YszM8yM8IhM5sssrFGXPeI+zxpqaz/h5xVThJHCmjB130BCOk
         ajm5LR1uY33Clx+GFtvgeLspAoo56N559Vi3jpKJUK1eWiJA5dWDUXp63RYjuy0lX9YQ
         7ApNoUW5bwvc5ev2noXLcHFiTCwDtGAW/iHIrG5pbVd6h++IvN7Wm+3DyfnNIkmZ71eI
         PQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Wy8CQ3X8SY/C9/CSYvkmwYCm8PZOvVaoL1d3mWNPC8=;
        b=RlrxL5gMRw2l88rpbOXsBZW8s/A6Y+cjHH64W4sOry53hTB/H8IzpEl7LuxWuFHhNl
         EAV6ueBWmLQDO3+bXKANkCxvzv/6rImGkr9lWJsOeqLkEzhbPwBbpZq7278/0hPtTaDw
         /rq0bH6vjl32LMbLzfeK0DBM1bg6HfLwCTaivQsqF37tw7k1LCuQpgaC251FkgBsmN6f
         qIGnmkZAH6bpf73irkYKX/n8IBHet0JMNN+172lL+B8YCVjlpzCKnWUHiaD7i63AFa30
         6VhI4gVgaCuu5V3RSJul0kKOLRemexIHw3TfDJc2QBRvB3oQGLZ7QJhvI/MzmRecYaU4
         2SbQ==
X-Gm-Message-State: AA+aEWZ4QyhBKNu6eU6CG6E0G7e65oqIYsaDaAa0TjF8s3Xg1bFM2UDi
        fZ4T6cIcvnfg7UuwrFJTGYA=
X-Google-Smtp-Source: AJdET5ctTEbSx3x8h0RTbUSd7jFBB9lZdxyTcwFbiNVOrOGTAm0baeJ0kfkH3qRi00BdKDxYv4t7Wg==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr11912750pgg.347.1542940852599;
        Thu, 22 Nov 2018 18:40:52 -0800 (PST)
Received: from localhost ([175.223.19.111])
        by smtp.gmail.com with ESMTPSA id 128-v6sm58545735pfd.64.2018.11.22.18.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 18:40:51 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:40:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181123024048.GD1582@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122101606.GP2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122101606.GP2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 11:16), Peter Zijlstra wrote:
> > So maybe we need to switch debug objects print-outs to _always_
> > printk_deferred(). Debug objects can be used in code which cannot
> > do direct printk() - timekeeping is just one example.
> 
> No, printk_deferred() is a disease, it needs to be eradicated, not
> spread around.

deadlock-free printk() is deferred, but OK.


Another idea then:

---

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 70935ed91125..3928c2b2f77c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -323,10 +323,13 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
 		limit++;
+
+		bust_spinlocks(1);
 		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
 				 "object type: %s hint: %pS\n",
 			msg, obj_states[obj->state], obj->astate,
 			descr->name, hint);
+		bust_spinlocks(0);
 	}
 	debug_objects_warnings++;
 }

---

This should make serial consoles re-entrant.
So printk->console_driver_write() hopefully will not deadlock.

IOW, this turns serial consoles into early_consoles, for a while ;)

	-ss
