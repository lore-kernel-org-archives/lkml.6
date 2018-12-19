Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0798C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9289521852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrxo5pCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbeLSBrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:47:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbeLSBrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:47:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so8670591pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 17:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8kD6cyP/Yz34GPRRH9k/hxKKfUdquCjTD7Rsnl/hgoI=;
        b=Jrxo5pCoIxYnnIhXMkapTJyEYhdcKSeTbnC2CWAwtJKfPlnxjsb8PIUX5FQEFglMZt
         9ShNwEpdsGG7CtUTYTiCDyyfTn6E/iQmZMi43+xtOe3JaPOrRR7BitT7A9cToJQ0lWfF
         yJUa5YbbA37jqB3aDCLztRutIh/OIbsiKiflDkune7qQLHDpqe4eLjy2qqqf6VOOPXs2
         rZvwsKnnRACd+pesLHfg46FQtPyfK4t68aBd8vTPShAMGmC7AaY412ObQEVXhK7/wsN9
         7JnJAJfiF+7cR3iUFoMBzx82Ns1k3VyC3Myp+WbVOnQbe+6UfhV06h0H0rK9pYwrbXtR
         7Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kD6cyP/Yz34GPRRH9k/hxKKfUdquCjTD7Rsnl/hgoI=;
        b=eIF7nsaGrzTZhk4NlugYodLhClGqf3CredpmXxbyq43qouHgkX1HUadfY1KXWzk2jh
         S+L0MdkjqiTLSATxaI+WrR336N2WUru2Qt3of6a2Mc3T1l/9U7SXuLFcW0JmrJRudGpJ
         nK86m1iXNsb3YK/d46N7y/iuVjmRhznX345KvG2bZ+dz1AMzfw+q3Cr+DFG/+CdRcYi3
         8Qxtg1vJwXpZgGDSr8WIrf5nCjcXEoQT6jx1UlO8mJIaP2wbifhnZGSi2HKG1Sertj7c
         FrYcoMIsoX2/Nx65PJXvn1UZGdmt1uQOTqYDMjYnHRc4e4iAEeiJ7wa935KiV0gyPLua
         vMvg==
X-Gm-Message-State: AA+aEWZNpyqp1ArK8TLKkJJVtl7HA9ejsiZJ3YzFYHJoCNgop1Hn1BuR
        9hOMkEZd66cpYE/1FcWZJak=
X-Google-Smtp-Source: AFSGD/WzVIO49eenKbZCKABTe36huh+9kZhWamzDGHpp3n0B7Kgyz63D0geYPUJ2yo9imXRbS2AxMw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr17318544pgf.402.1545184022203;
        Tue, 18 Dec 2018 17:47:02 -0800 (PST)
Received: from localhost ([175.223.26.207])
        by smtp.gmail.com with ESMTPSA id t13sm24257014pgr.42.2018.12.18.17.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 17:47:00 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:46:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181219014657.GA3720@jagdpanzerIV>
References: <20181218111701.GA32522@jagdpanzerIV>
 <20181218114709.GF7485@zn.tnic>
 <20181218130750.GA665@tigerII.localdomain>
 <20181218142623.GH7485@zn.tnic>
 <20181218145558.GD665@tigerII.localdomain>
 <20181218150313.GI7485@zn.tnic>
 <20181218151455.GE665@tigerII.localdomain>
 <20181218152413.GJ7485@zn.tnic>
 <20181218165217.GA534@tigerII.localdomain>
 <20181218174723.GK7485@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218174723.GK7485@zn.tnic>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 18:47), Borislav Petkov wrote:
> So how much is not strict?
>
> And what happens if you raise that ratelimiting level and the *one* line
> which is most important for debugging an issue

Like you said, for debugging devkmsg=off works just fine. I don't mind
the ratelimiting and want to keep it; I just don't want errors to be
ratelimited.

> All I'm saying is, gradually raising the limit is the wrong approach
> - there will always be a case where something important doesn't get
> logged.

Well, OK.

> What we need is a different solution, maybe what Rostedt proposes or
> so...

Sure, a different approach and idea are welcome. This is RFC thread.

	-ss
