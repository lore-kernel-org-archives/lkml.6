Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0050C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9CF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7kaJwbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9CF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJWJIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:08:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34186 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:08:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so14992571pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jVfDl9QShSOhyDU0OnYMokfNpBf7N9t+QZFMXfBBnM8=;
        b=Z7kaJwbRAuOG2PnINwZYQwW2YG6lbfoOymU+ESuodEK6rBr896Qbc7hOj/CUyhiSBr
         rZr4VOCvdqPkPt9P5ufM0sPFbEB69vW5Qfaf0yB9GC1uuuUEhw4eiXwBsjrQ/nNwyCXP
         UtSc9gjEw7w9bx0d6xGQFzjVnSMdrRyGfT52kE3ECgtEQ5pJZw2DnisvebZObvnGH77k
         2Ym3baRg9MG40BXsJpDuvbytYoTcHd10ygHK8vwg6iEKSWs5CTaZ+HvutORNRnrWuqhM
         7wppaoZN7mbwB8YI4D68zbIbi6WeP5wVEluURcNIIpQfIFg+XWNQngbmQKJiAmib8N9R
         aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jVfDl9QShSOhyDU0OnYMokfNpBf7N9t+QZFMXfBBnM8=;
        b=AbKazO4h2MkFRC1aPgicQMc+HgR1/HXZUX0cdjlLwHhAMXUz7K1tunQI72roG3LcTx
         HjxC5PJSVcCuboMlY3c0MhjkmZ+15PSH1C0QqBBRDrixianuYKbWDnP657urm7j8ANmY
         4GqtYuUGrLbRTQ7KpiqZOyLiN8BKqP8z8NA2ZnRL804CgXvJ+dtO27HOrQ50MshhRk7L
         3LdW/iB7ywVVUL+htEIidhmIqEFfxO0kNNm98c8ZD6czO6C3CcIhImETdhAhz9q87PBa
         a4iEcLojQCO0j3X2z5Mcq9QKmg91Pguh6xgXGYtby1wIiYDROB7dmbngn2FxECZXzf/g
         nnYg==
X-Gm-Message-State: ABuFfoiacXpWAWrq/CQQ3iAva+eOIaMvegZF1E88qJs/xPhT+eqD38mc
        WVhBHnra4RtFAE1u08TXZrjgTNMb
X-Google-Smtp-Source: ACcGV61t/XDgypTFoBxaXW7WA0HUsP5z0yilmBV+1U6BqEIQ8MK7keN2aaSKo08wczN+Hd1iJl0NNw==
X-Received: by 2002:a62:32c4:: with SMTP id y187-v6mr47649710pfy.4.1540255651053;
        Mon, 22 Oct 2018 17:47:31 -0700 (PDT)
Received: from localhost ([175.223.11.183])
        by smtp.gmail.com with ESMTPSA id m19-v6sm11979305pgv.93.2018.10.22.17.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:47:29 -0700 (PDT)
Date:   Tue, 23 Oct 2018 09:47:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Calvin Owens <calvinowens@fb.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181023004726.GA4612@jagdpanzerIV>
References: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
 <20181018042739.GA650@jagdpanzerIV>
 <201810180526.w9I5QvVn032670@www262.sakura.ne.jp>
 <20181018061018.GB650@jagdpanzerIV>
 <20181018075611.GY18839@dhcp22.suse.cz>
 <20181018081352.GA438@jagdpanzerIV>
 <2c2b2820-e6f8-76c8-c431-18f60845b3ab@i-love.sakura.ne.jp>
 <20181018235427.GA877@jagdpanzerIV>
 <5d472476-7852-f97b-9412-63536dffaa0e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d472476-7852-f97b-9412-63536dffaa0e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/19/18 19:35), Tetsuo Handa wrote:
> > 
> > OK, that's a fair point. There was a patch from FB, which would allow us
> > to set a log_level on per-console basis. So the noise goes to heav^W net
> > console; only critical stuff goes to the serial console (if I recall it
> > correctly). I'm not sure what happened to that patch, it was a while ago.
> > I'll try to find that out.
> 
> Per a console loglevel setting would help for several environments.
> But syzbot environment cannot count on netconsole. We can't expect that
> unlimited printk() will become safe.

This target is moving too fast :) RCU stall -> user interaction -> syzbot

I talked to Calvin Owens (who's working on the per-console loglevel
patch set; CC-ed) and Calvin said that "It's in-progress". So we probably
will have this functionality one day. That's all we can do from printk
side wrt user-interaction problem.

> > The problem you are talking about is not MM specific. You can have a
> > faulty SCSI device, corrupted FS, and so and on.
> 
> "a faulty SCSI device, corrupted FS, and so and on" are reporting problems
> which will complete a request. They can use (and are using) ratelimit,
> aren't they?

Looking at scsi_request_fn(), the answer is probably "sure they can;
but no, they aren't". In majority of cases the reason we replace printk
with printk_ratelimit is because someone reports a stall or a lockup.
Otherwise, people use printk(), which is absolutely fine.

	-ss
