Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AAAC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1A214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFkeyLhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B1A214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJQIU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:20:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:20:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so11803450plp.0;
        Tue, 16 Oct 2018 17:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKdljdK3lZurcsERNuDne5HsmZgQRKXBf3s9e/nz8i4=;
        b=QFkeyLhNKWiTn5zijhVA6Q+/MWVzkoVV75Wbdr3GF0FgobfWfiwmxXhw28BF7FITV4
         W1jyj8eyynTfAduMjQbD4/pNgolazy/TMsYhYTg/4kaEXfDKiMJTpD2ezuzosfCpbspp
         mzMZiVmBTbuipWdICUGVLy8CrWmAqiMgPwr0K80g0NJNvuEqMqfYV6JgZPTX/8mfdePG
         uN65oNoa7PRy8YZ5osTyzwNThioBcBkD4NsffgDphPH/pK5IGIT87y+eV19wsmWVkMHS
         g5XrcLWw4mAeBieV/O+EitSUIEa4TG8FkSg+B2tYvwIOTGIq8kF6JuF4sEpXWsDyR0wk
         F6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKdljdK3lZurcsERNuDne5HsmZgQRKXBf3s9e/nz8i4=;
        b=fQbPCeoLRlRhn8cpkm0g8G6vgAYw+ee6a2EadpA7Vw16W1y9XRVqwMMG0nUsBvYQez
         y1GqrNzoQXhFHc0rVbKLt7NAwQ+DTIJcTDCN0yWnltCQfg4w4nqNWM7ZzAJQPRFsB0lg
         PWp/UNrL7HDgaeW59Eq8dIMr0A33n/fs5Sx6kYiDyMlMKS5r80sRzeL17Kki3d3Dd/eK
         bGTazQV3nx2JXIri+/RWkV5IT/s9qbXmAeFiBoh9FEloJdV0ny+zXlejINTuBP5MWrWS
         jo5RnnQ8l6rH3Qy0zZNEaTp1AzsJAIZ9UA+exHi97Iu015moIb6hc636hdPUM+1lglB4
         YF5w==
X-Gm-Message-State: ABuFfoj3MYN6ZPf116CWk6UmmlzDr83w7dWMkg6i82hipviyQiOJs9zg
        Z5PNMpI1ey+TPH+lJfygEjw=
X-Google-Smtp-Source: ACcGV60xJADMA6aHb+jFMS2YjKcJL4FaW4F3/7XK5ZNLqT9ONP7EJnniCzQe0WLYZ9WslxisXi1grQ==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr23544598pla.132.1539736047246;
        Tue, 16 Oct 2018 17:27:27 -0700 (PDT)
Received: from localhost ([110.70.53.52])
        by smtp.gmail.com with ESMTPSA id b62-v6sm30997828pfa.159.2018.10.16.17.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 17:27:25 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:27:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH for 4.21 04/16] mm: Introduce vm_map_user_ram,
 vm_unmap_user_ram
Message-ID: <20181017002722.GA1068@jagdpanzerIV>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-5-mathieu.desnoyers@efficios.com>
 <20181016143016.10da89bd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016143016.10da89bd@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/16/18 14:30), Steven Rostedt wrote:
> > +void vm_unmap_user_ram(const void *mem, unsigned int count)
> > +{
> > +	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> > +	unsigned long addr = (unsigned long)mem;
> > +	struct vmap_area *va;
> > +
> > +	might_sleep();
> > +	BUG_ON(!addr);
> > +	BUG_ON(addr < VMALLOC_START);
> > +	BUG_ON(addr > VMALLOC_END);
> > +	BUG_ON(!PAGE_ALIGNED(addr));
> > +
> > +	debug_check_no_locks_freed(mem, size);
> > +	va = find_vmap_area(addr);
> > +	BUG_ON(!va);
> > +	free_unmap_vmap_area(va);
> > +}
> > +EXPORT_SYMBOL(vm_unmap_user_ram);
> > +
> 
> Noticing this from Sergey's question in another patch, why are you
> using BUG_ON()? That's rather extreme and something we are trying to
> avoid adding more of (I still need to remove the BUG_ON()s I've added
> over ten years ago). I don't see why all these BUG_ON's can't be turned
> into:

+1

> 	if (WARN_ON(x))
> 		return;

Given that this somewhat MM-related, I'd may be say VM_WARN_ON().

	-ss
