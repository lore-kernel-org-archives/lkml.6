Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217820869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqqpAoxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F217820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeIGJAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:00:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43619 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeIGJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:00:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so6301252pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 21:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fra0f4IM62GzCAudgmpz51/+YNq9Yk5nYvfnV0wPtSY=;
        b=EqqpAoxVjImgibdRMMrZz2os+SA1jJpMq8JjSl17Tq4d6Mpos4dwd497r0Me0lEVAM
         5uPj7Bt3n2ijhDetpyXv+yFJNnx1QBC4vsmx1HclYmDZ5s1gl1JHLu0HqCCDYwi/j0+H
         TY8O+XDsbycHmmm9LJwf8b2tlAJp8YIghpMnppMJhQpHNEtjeeSS5wmxTbCQfA/6Q4ZB
         zJPar5AxjCnCEkrzZyAfEM3jWbNwWIHVV1EdMSo9ERwPBmQorkx7bMFQkBfXwk9KXIAE
         GOeKnBLKSYbIjCRf2AH20emBPGgyeZ2C4f7h54fixRPBZEMbApveeeFijXXZxF6ZL4RQ
         u8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fra0f4IM62GzCAudgmpz51/+YNq9Yk5nYvfnV0wPtSY=;
        b=cKzdTqYqDqTabO0Yorta0O37ek9gezxuxinBOWnblkccFldHTX+aBQlcDehYA2+7+u
         elFKEVPR6aWos/qbcMcU0DJogFOxAbECWHnkSxoY022+5RCus4snQ8bE+HCA+xcfAO9o
         leBszGpDtZ1cFDotPdBsqlFZNTFYojy9A7PhjSB2Crqur1RoSmhp67P+Vf8lLET4S5wL
         kntMbD7OXY3cAY4wAQZ2M+o15qdcMqUwSC0J/LWrBJgh50O9BFhGQZeHNQBnN75jfSpK
         Te6Edwy1HSFmGAg7fFeLWxBIKnnHZw45uw3wKWFQxb2o/VmG/b7ezWtwOqVJzec1IGjp
         RTsQ==
X-Gm-Message-State: APzg51ALVgvm2yPHx9gIRv6mw2LyrrZZGrSZc6vLiACZs88/MBL+3/rs
        CfHN/WtM0DmNqaGWTzx8xTw=
X-Google-Smtp-Source: ANB0VdY+RP8coen4zdR7sXh6lRjY0aGjBBq7KYYl/4m0Z84/uH062ZP4c7+yCEq4uELjJEFZqSLAtg==
X-Received: by 2002:a62:ac12:: with SMTP id v18-v6mr6507279pfe.126.1536294097048;
        Thu, 06 Sep 2018 21:21:37 -0700 (PDT)
Received: from localhost ([39.7.51.34])
        by smtp.gmail.com with ESMTPSA id v7-v6sm13465518pgh.57.2018.09.06.21.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 21:21:35 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:21:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180907042132.GC2394@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/18 16:28), Petr Mladek wrote:
> On Thu 2018-09-06 16:29:40, Sergey Senozhatsky wrote:
> > On (09/05/18 13:02), Petr Mladek wrote:
> > > Note that the first registered console prints all messages
> > > even without this flag.
> > 
> > Hmm, OK, interesting point.
> > 
> > I assumed that the first console usually has CON_PRINTBUFFER bit set.
> > Or even a CON_PRINTBUFFER | CON_ANYTIME combo. E.g. 8250. It sort of
> > makes sense to have CON_PRINTBUFFER for the first console. Any later
> > consoles [e.g. fbcon, netcon] don't necessarily have CON_PRINTBUFFER.
> > 
> > And the first console has CON_PRINTBUFFER bit set. Well, just because
> > it sounds reasonable. Those were the main assumptions behind my code
> > snippet. Was any of those assumptions wrong?
> 
> This assumption makes sense. In fact, I was wrong. I thought that
> console_seq/console_idx were not updated until the first console
> was registered. But it is not the case.
> 
> It means that the hack with exclusive_console might be usable.

Yeah, it is a hack. But not as dirty as it might appear, I think. In some
sense it's aligned with what we do for exlusive_consoles - we treat exclusive
consoles specially. So specially that even if the system panics while we
re-flush logbuf messages to a new exclusive console, we flush_on_panic() only
to that exclusive console, ignoring the rest of them.

Not sure if it's totally right. There can be a netcon, for instance,
available, which will not see panic flush() because of a exclusive
console:

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c036f128cdc3..ede29a7ba6db 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2545,6 +2545,7 @@ void console_flush_on_panic(void)
 	 * ensure may_schedule is cleared.
 	 */
 	console_trylock();
+	exclusive_console = NULL;
 	console_may_schedule = 0;
 	console_unlock();
 }

---

Opinions?

> But I would prefer to do it a cleaner way.

OK.

> But it is rather complicated, still hacky, ...

Right.

> > 
> > I can agree, definitely. That's one of the options.
> 
> I prefer the revert for now.

OK, agreed.
IIRC I didn't see any upstream code which would have been fixed
by the commit in question.

	-ss
