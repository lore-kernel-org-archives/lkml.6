Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFCAC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483FC2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsz9OsAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483FC2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJWOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:47:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44292 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:47:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id d23-v6so140522pls.11;
        Mon, 22 Oct 2018 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feNBN/Z83f7cN1qmKc5KN3sq7CYt/RKwwp4COAgggF8=;
        b=Qsz9OsAj4QuA3SNJ+YVKft9Hp3OXFJ1i+OTVJluoocS7Qh1w25FP/wPfMfaFCZD4K4
         6Itqdaxy3yPayRHPty8MuyKVPbsmfSuctl1p78eYUo4k4hs2pSCtC/4qUtId5gkgjbk/
         mOwrf8NBKl0X9/62ewEggNt66xZt0Q2/5aI/a6FVS0h4EV65Ygb7bwNNtj5BwGemtRR+
         eY+QcM3rmjuI0SMECqhpAgGXQXj/5EB+79lcvWh8xFFiTw/6wQT8Fv3e8Zm9sN4Tf1Vb
         CggYcqVL9Cv9qqjdeQuu2zhuBOFkjnaCRRNlC4ppx7DUA2O+Faqf69aEim6Zw+3JKmf5
         rE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=feNBN/Z83f7cN1qmKc5KN3sq7CYt/RKwwp4COAgggF8=;
        b=eWrbgNfXEBUA8gqXEjjM0esuboPEXnMZXU8v+TS1idTuQ3peaMTnCfqIrcAKASQezC
         lSN9p65gQrUxff6qry+JrWsbDM2bMzyY/Rc4E0AJdiUMHpBjeky0BHq/8MEMJuY2k5AP
         I4SBM+fJCItQxobK2av1oj8MPW+yIn8cpLh/te0TbOc1NilpeqBlGCY/QtpxMxUwLrUz
         DppTnDKzzt+u1uhzpVZuexaNwc1JXuOV+OXw1nadH7azYDgOi0clRZvW189rjINYsEa0
         OZAeAaPzwm2fV80YG+njBgxIT4dlUzZVQzDNh6FckteKrtiZ6Tk+jlcN83EjmnMDmXP4
         Y2WA==
X-Gm-Message-State: AGRZ1gLgexmdUXHnJNVG0MdrlUJaAo67VA7pD4hGPmY9YxJkfP0vfTTR
        A3ZY2Pd4LL7HmvlCN2a18TA=
X-Google-Smtp-Source: AJdET5cTZSx9MYm6FfT4DAqT+95YSQibbBC8LeB2omdNN6K1uYRvRT67Gxz+NVXV9Vz0NRFmI4WoPg==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3-v6mr8642362plb.193.1540275940763;
        Mon, 22 Oct 2018 23:25:40 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id n79-v6sm937595pfk.19.2018.10.22.23.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 23:25:39 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:25:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181023062535.GA504@jagdpanzerIV>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 14:54), Peter Zijlstra wrote:
> 
> No, no wakups. irq_work to wake the printk-thread, at most.
> 

There are cases when we probably prefer to be in "direct printk" mode.
E.g. sysrq or late PM stages (probably).

Doing irq_work->wake_up_process->printk_kthread from sysrq probably
might not work all the time, so direct printk path may look more
"reliable" in some cases. In *theory* (just in theory), we can do

	void __handle_sysrq(int key, bool check_mask)
	{
		...
		op_p->handler(key);
		...

+		if (console_trylock())
+			console_unlock();
	}

type of thing. So sysrq handler will just log_store() the data and we
will try to flush logbuf immediately once we are dont with sysrq handler.
This will require additional work, tho. Some sysrq handlers can print
significant (depends on serial console baud) amounts of data. For instance,
sysrq_handle_showstate() calls show_workqueue_state() and show_state(),
which do numerous printk()-s. Therefore, those functions touch NMI and
softlockup watchdogs:

	void show_workqueue_state(void)
	{
		for_each_pwq(pwq, wq) {
			...
			touch_nmi_watchdog();
		}

		for_each_pool(pool, pi) {
			...
			touch_nmi_watchdog();
		}
	}

and

	void show_state_filter(unsigned long state_filter)
	{
		for_each_process_thread(g, p) {
			touch_nmi_watchdog();
			touch_all_softlockup_watchdogs();
			...
		}
	}

If we will move the actual printout to console_unlock() then we will
have to start touching watchdogs from console_unlock().

Another troubling moment might be that with completely async printk()
it's easier to cause logbuf wrap around; because CPU which does printk()
in a loop is always async, console drivers don't throttle it anymore;
currently it's sometimes sync (when console_sem is not locked, or locked
but we have active console_sem_owner) or async (when console_sem is
locked and there is no active console_sem_owner).

	-ss
