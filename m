Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED22C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F84214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9anH6VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F84214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQJkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:40:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39025 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:40:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so12353221pfe.6;
        Tue, 16 Oct 2018 18:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MuJDmY+U6qI+A/v46wTNbYVsPBVfuhgLbbDnExQUbA=;
        b=Y9anH6VIRZbj/f/1ylUYmYw/SkEtoa7Gu7HTnhlJWPqcZVSYF6+NYCC6lgXrwXyxTc
         VYc+bx/WZgOLWvl+eqRgtP3oQ93j9EODv1qglqTKcpQP0j31LYjcgk2AscgrWHNsqQxh
         ut/fjzX0fyFB74Y0/G6EC5wX2HvjFggW12Qs/ZGfb1v78G62v02K0gRs6jzCxYzqx/jb
         516dOwBj+VyaVxQ7GCnHtD5r2+QNy+C8bJoRSw40j9uuxo0ufdQxG7eGqnFKzFWbc3Nn
         H8+7+QMFDQd2m6koUEcQpCmAckIpQCJhWKgKSTMKGOVgR8ftDPi9lUXY7VuHSfxn7z91
         N7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MuJDmY+U6qI+A/v46wTNbYVsPBVfuhgLbbDnExQUbA=;
        b=qxuBkUeNEvGsvfUhUtGBK7WzUXtPJoWAml30BRQaXnZf8iLUBM42ZyMtJBCy/4G9y4
         53vrCZv5g9xqLwnSsOjbiljqDIeUYrrkQqfr9LPqs/w72YfwUynxRhvxCh9iP/elSpUd
         LFuUz+qqJb2bvumbc8+lnizAjfHtw3X6WtsUBNmj0E6SGb2IviFdwpNEDw4HlMMDkD3f
         5/UhNjLBn3S70wb+Nt3KHsQoY6O4yxToMxoHh3RiSJSo64qyVyQZM4CE0r2XDnKyLE/4
         PJdtwy6OaNInmftwXYY2Q8zT61ZmB6SBcwy3GEThyYZdyNCUpNlpbSPCgKPksxwTJQnV
         x7dQ==
X-Gm-Message-State: ABuFfojxBoD6kKBc503UvgKlPbqmf2mA+qGNQoaPu1vr1D/2RWbe+bmr
        MDYGTncEgq9Ki0cOKmZ20N4=
X-Google-Smtp-Source: ACcGV62/MWVCwQxpKk7cRzbYlJOOWW+yVQAkfv3dhZk8bzWdkgrjvSQLImZVnWqwliYersuaScrpAw==
X-Received: by 2002:a63:f05:: with SMTP id e5-v6mr21611832pgl.84.1539740816557;
        Tue, 16 Oct 2018 18:46:56 -0700 (PDT)
Received: from localhost ([110.70.53.52])
        by smtp.gmail.com with ESMTPSA id 6-v6sm18234767pgl.6.2018.10.16.18.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 18:46:55 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:46:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.21 06/16] cpu_opv: Provide cpu_opv system call
 (v8)
Message-ID: <20181017014651.GB1068@jagdpanzerIV>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-7-mathieu.desnoyers@efficios.com>
 <20181016081029.GA30363@jagdpanzerIV>
 <1984292897.263.1539717457933.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1984292897.263.1539717457933.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On (10/16/18 15:17), Mathieu Desnoyers wrote:
>
> Therefore, only an internal kernel bug between vm_map_user_ram() and
> vm_unmap_user_ram() should trigger the BUG_ON(). No user input is passed
> to vm_unmap_user_ram().
>
> Now, let's look at vm_map_user_ram(). It calls alloc_vmap_area(), which returns
> a vmap_area. Then if vmap_page_range failed, vm_unmap_user_ram is called on the
> memory that has just been returned by vm_map_user_ram. Again, only an internal
> bug between map/unmap can trigger the BUG_ON() in vm_unmap_user_ram.

Thanks for spending time on this.
Just wanted someone to have extra look at syscall->BUG_ON().

	-ss
