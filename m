Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E24C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2DF2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv4ErCb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2DF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeKVMld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:41:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38866 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbeKVMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:41:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so8067353plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2epVFlN3r4vSUrSMhCqN8UTVRoXoRGx7IR4Nswj+Fs=;
        b=Nv4ErCb8tLSWynBLMTXC0W5+WNt1riYnlOEOIp2/KjgMTblw3vqNQfowgplO5hMc0A
         bgkokY8Zp/Y3o5x7xFbnXqF/SbxOaKejtvjlMDtf+RVsimbB88xhKBNKU1TIVTmKj91c
         +ehsFlMHUNgoCXuIKy6LEeKRqLzl9vwBnS4y+rpHGHpduySSd1Y5CB9WnOE8YYT1Zdhj
         zbrB+CdJx98AHuDS4LKgmP8z18Qa3eU2Eqf7w2SdCSrZwoLnyPT1oRVMR/oEnf1y/uG/
         ARJbPmQIXYBOpOlJ3nkOCzzMOHG88yZYWjp+WN0IPP72RV22Hb0KQrd7iKznjZZQtgFX
         BL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2epVFlN3r4vSUrSMhCqN8UTVRoXoRGx7IR4Nswj+Fs=;
        b=QtwRd4z70dNhAVY2x1jbgqN9+pMbEOZAbcKiRWAKC+nptB50s95nLhFzCf+3UGcMYw
         yjmjqfv7Q62CB5j4F5aNOHgkPVpTlxbrKL7xzExglz3bArf3Ftw9nBNGyAkDRMl/ylCt
         9MrAqRVjAiqlJWp5RA08ZE6eFr9YYl7g+SrF+wy5U/sCcNG0TW1HCIoMkuYL8/mrRCVv
         mtB0GAZjprnd0D+UCsJZpp3iwWIhbqUMQRwRF1B5+eUEkg9F2F3Z+/DrsG5RRLJ850cB
         Czk5e2P3zydySmnqW/1oVNWbrCruCiaddZBydDsmiaoT4BRBQ1AJewY1ACrlmMP2eCV7
         0DBg==
X-Gm-Message-State: AA+aEWaWVWhQN91thskvyAO9vHqH8Yc6P0HUW7CbW57pusJlJWe7Om/i
        k9LR/vewhT1P7ekYYjUjhFc=
X-Google-Smtp-Source: AFSGD/VfuzoLn/1/DeJm5DHwFqQbBjydUqzXh9DW6hUID7tPwhI0I7RyavqYl0vXB07INJAcfG6yKA==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3-v6mr9083494plb.223.1542852267137;
        Wed, 21 Nov 2018 18:04:27 -0800 (PST)
Received: from localhost ([175.223.27.1])
        by smtp.gmail.com with ESMTPSA id h7sm50479606pfa.105.2018.11.21.18.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 18:04:26 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:04:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181122020422.GA3441@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/21/18 11:49), Waiman Long wrote:
[..]
> >  	case ODEBUG_STATE_ACTIVE:
> > -		debug_print_object(obj, "init");
> >  		state = obj->state;
> >  		raw_spin_unlock_irqrestore(&db->lock, flags);
> > +		debug_print_object(obj, "init");
> >  		debug_object_fixup(descr->fixup_init, addr, state);
> >  		return;
> >  
> >  	case ODEBUG_STATE_DESTROYED:
> > -		debug_print_object(obj, "init");
> > +		debug_printobj = true;
> >  		break;
> >  	default:
> >  		break;
> >  	}
> >  
> >  	raw_spin_unlock_irqrestore(&db->lock, flags);
> > +	if (debug_chkstack)
> > +		debug_object_is_on_stack(addr, onstack);
> > +	if (debug_printobj)
> > +		debug_print_object(obj, "init");
> >
[..]
>
> As a side note, one of the test systems that I used generated a
> debugobjects splat in the bootup process and the system hanged
> afterward. Applying this patch alone fix the hanging problem and the
> system booted up successfully. So it is not really a good idea to call
> printk() while holding a raw spinlock.

Right, I like this patch.
And I think that we, maybe, can go even further.

Some serial consoles call mod_timer(). So what we could have with the
debug objects enabled was

	mod_timer()
	 lock_timer_base()
	  debug_activate()
	   printk()
	    call_console_drivers()
	     foo_console()
	      mod_timer()
	       lock_timer_base()       << deadlock

That's one possible scenario. The other one can involve console's
IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
and an eventual deadlock on the uart port spinlock. This one can
be mitigated with printk_safe. But mod_timer() deadlock will require
a different fix.

So maybe we need to switch debug objects print-outs to _always_
printk_deferred(). Debug objects can be used in code which cannot
do direct printk() - timekeeping is just one example.

	-ss
