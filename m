Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC9FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RORHxIv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCE22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJROJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:09:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40384 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJROJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:09:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so7370800pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d6UyIJUDY56Iz0czXnjyJ3Ta5bTYfLXl+SolwXxU6VU=;
        b=RORHxIv/qdF/xqYWc1J2H55HlXxVzIjuv1NT2/0vdLZfty5DliWRrTiGg7ru+S48P/
         /+XLENC2aubRwc+a57LoLw0DneeUpJImLimbMyWVJo0u3PcsVSflFTNiWKuSLwzmPQ4r
         rXl23DwIn75O9fVA+At7VryBt+qghPoLKTEjqGAV/YI08sYv45zZ1oL7iJCC+YnZSgCU
         c9DtwQSYa/u5q8GLY0EG5LXBxe3MxQ1c4llmQvLCaDdrZBlm+zRkDRLbrJGO4Z3x+7oA
         Fcp6BtNSovlv/JBT+5krJD15R0N5O8+jZIqKykAsI9yLJDkscCStrSHs5/9RLCwV8cP/
         oydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d6UyIJUDY56Iz0czXnjyJ3Ta5bTYfLXl+SolwXxU6VU=;
        b=UCOZz5XsG3HeuKYIjnl1vCne4eue6WqTvyi8D2a/Q5l9HIWS39BnDFQA+Q7pjLWpsk
         MZOsfVAoI7Hohg5066CfHkXRt+Wa5l539gOcoFqnN6QzuvkVvNJ3x4Nn5YBiNkzC1BGh
         6hJpLuay7C5uHqy/dsnfvNtWI3bbE70EU7khrOtmUN564soqlCGjG1Exi+DXzZF7muzL
         A931m1sTAo7s/yDuJXFQq1gFdi4IquvsmV2wG0a70JEbJKsNt2W3Vw0ZiCjUsLrwKdqs
         1J0VOnv5YvKTup1TREMrHXZWBr3gto/ZRSPiLsKEWY2xJYMrGPKYF/22rtAqtrajzxV6
         HQnQ==
X-Gm-Message-State: ABuFfoj20fJYR0u4tkNzzPaBKNJJttrvYcvk4yCObNmjVgWrcq/Gndza
        /WuB0bDNqWr5cqmJxv1t/HU=
X-Google-Smtp-Source: ACcGV60tYJTy6qGaq8jngeV/XPXXD+XSaqp7ZuHbARfY8Iu92OmaA4Jp8JQ9zlM515gn/hlE3seKRA==
X-Received: by 2002:a63:1752:: with SMTP id 18-v6mr27823020pgx.131.1539843023674;
        Wed, 17 Oct 2018 23:10:23 -0700 (PDT)
Received: from localhost ([175.223.3.251])
        by smtp.gmail.com with ESMTPSA id g123-v6sm36860877pfc.67.2018.10.17.23.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:10:22 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:10:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181018061018.GB650@jagdpanzerIV>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/18/18 14:26), Tetsuo Handa wrote:
> Sergey Senozhatsky wrote:
> > To my personal taste, "baud rate of registered and enabled consoles"
> > approach is drastically more relevant than hard coded 10 * HZ or
> > 60 * HZ magic numbers... But not in the form of that "min baud rate"
> > brain fart, which I have posted.
> 
> I'm saying that my 60 * HZ is "duration which the OOM killer keeps refraining
>  from calling printk()". Such period is required for allowing console users
> to do their operations without being disturbed by the OOM killer.
> 

Got you. I'm probably not paying too much attention to this discussion.
You start your commit message with "RCU stalls" and end with a compleely
different problem "admin interaction". I skipped the last part of the
commit message.

OK. That makes sense if any user intervention/interaction actually happens.
I'm not sure that someone at facebook or google logins to every server
that is under OOM to do something critically important there. Net console
logs and postmortem analysis, *perhaps*, would be their choice. I believe
it was Johannes who said that his net console is capable of keeping up
with the traffic and that 60 * HZ is too long for him. So I can see why
people might not be happy with your patch. I don't think that 60 * HZ
enforcement will go anywhere.

Now, if your problem is
     "I'm actually logged in, and want to do something
      sane, how do I stop this OOM report flood because
      it wipes out everything I have on my console?"

then let's formulate it as
     "I'm actually logged in, and want to do something
      sane, how do I stop this OOM report flood because
      it wipes out everything I have on my console?"

and let's hear from MM people what they can suggest.

Michal, Andrew, Johannes, any thoughts?

For instance,
   change /proc/sys/kernel/printk and suppress most of the warnings?

   // not only OOM but possibly other printk()-s that can come from
   // different CPUs

If your problem is "syzbot hits RCU stalls" then let's have a baud rate
based ratelimiting; I think we can get more or less reasonable timeout
values.

	-ss
