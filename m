Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B33C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7659220866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTcMvj1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeJPP7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:59:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44171 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:59:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so10459244pgu.11;
        Tue, 16 Oct 2018 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrJU7mnzGqHAGFzu+0kjKnPwrCeK0SgDkjo1uxW+WXc=;
        b=OTcMvj1/333Np+E7cXFW4Rh1I7QvzptHjglp5SiNQ9MDemj057iG0XIozB7LXHG0Y0
         Kh8IiBgPBj1Zfsmokp1dNixy/xP99cPcxkS7R4QKEsDrxHuLYKqK8pDsm74LgDpTinM+
         YVeUKrpu04hlogzgrfhBsBMkuKAgXdNzveCXazwe9crl6lD43JKxAq6OapHOvyKlMeXA
         fz/5rM3aPWCxV+c8VtJ1OHAHbLcvoEbWtYmHJPtiq/CTUMCGXhihoHCU40ogFh3f9qxA
         VoVil4K5M+B36w0qmQRsdPJRqxU0POpitPo4DMFlMl3Q/kd2qbkLtuDTOm/1rl3KSjmG
         u4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrJU7mnzGqHAGFzu+0kjKnPwrCeK0SgDkjo1uxW+WXc=;
        b=gqDICZAc1KqNurSkWSMpcVonJP52M2Icok4EaczqiqrzTPahY8xrWrOkVZLvbHeuIu
         NP6ZFKU6Z5k6oSkhdZ6CDYNMjoMJZaxzYTsDgO6gsDhsFourLMqyu9TwOpvHRiOccXLb
         Dugf5htietLofr1wrwwDKgSBxblvVqL43T8nLAh2RfGkbrw5ELGedjTVvj0hDTOqQvgG
         6I5jlSx+bgJ932WpyiCad0fABYr8baAQta5UOpCE528ZK0L5O4trg5hmo5s8jjhtyoYr
         zipA3B38rrsUtZHVUJQA81+kREecDMnK/MeP2v7dskCSzVUlJtx9YH9TYv+1vW2VlCxp
         Sg3Q==
X-Gm-Message-State: ABuFfog/JkbQYwbJg/WpQQKMdM4/YXLflZVQ2tBRAR2grGROqB9Q9WDj
        SNxabxPBzOi4vn2VFxiw0KA=
X-Google-Smtp-Source: ACcGV62RzbLC/23pbuUiPQsVSMxsTm8gNurbMRntS9g8S7VRwyr61CqCRBo77jO0Pg5vdEpRhtItTw==
X-Received: by 2002:a62:75c7:: with SMTP id q190-v6mr21291094pfc.137.1539677434896;
        Tue, 16 Oct 2018 01:10:34 -0700 (PDT)
Received: from localhost ([175.223.10.117])
        by smtp.gmail.com with ESMTPSA id z14-v6sm21681359pfi.4.2018.10.16.01.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 01:10:33 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:10:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.21 06/16] cpu_opv: Provide cpu_opv system call
 (v8)
Message-ID: <20181016081029.GA30363@jagdpanzerIV>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-7-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010191936.7495-7-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On (10/10/18 15:19), Mathieu Desnoyers wrote:
[..]
> +SYSCALL_DEFINE4(cpu_opv, struct cpu_op __user *, ucpuopv, int, cpuopcnt,
> +		int, cpu, int, flags)
> +{
[..]
> +again:
> +	ret = cpu_opv_pin_pages(cpuopv, cpuopcnt, &vaddr_ptrs);
> +	if (ret)
> +		goto end;
> +	ret = do_cpu_opv(cpuopv, cpuopcnt, &vaddr_ptrs, cpu);
> +	if (ret == -EAGAIN)
> +		retry = true;
> +end:
> +	for (i = 0; i < vaddr_ptrs.nr_vaddr; i++) {
> +		struct vaddr *vaddr = &vaddr_ptrs.addr[i];
> +		int j;
> +
> +		vm_unmap_user_ram((void *)vaddr->mem, vaddr->nr_pages);

A dumb question.

Both vm_unmap_user_ram() and vm_map_user_ram() can BUG_ON().
So this is
   userspace -> syscall -> cpu_opv() -> vm_unmap_user_ram() -> BUG_ON()

Any chance someone can exploit it?

	-ss
