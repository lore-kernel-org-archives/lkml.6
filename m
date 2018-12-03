Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B65C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3920881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="na37Xu4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB3920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLCPwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:52:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51426 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:52:17 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so10012489itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JF5ZHq5jYX7ctXx6B8V/rZq9pCcsLqMqEPFd89f+GH0=;
        b=na37Xu4vo6LzEm3DxXWc/rZYBXfVojbg58nxCeTWkH6H4cVKVxnI/341YDl//S5bdJ
         MdjPSK4T4XOKbllNYvGCP892ARC2GpJFrcHFWiVuG5vcTFXQF3hrstajYCHzf19gh5bk
         3NwAA5u7gis79MYqvHfp3xPs404TvAEMrC0wU9PLz1TZBog/QJp0TWyF/M/N7gIh9T9t
         0dTqR1ajHqoOrHIWez9TBpkqdQD0SSy0cc1gpQSTMZV0NFNBKeXUgjhSSXnwqun5C17S
         darZw92mN372eNwLIwHXCoDJOtzeaIt3nAgJJkJHjcPaXLjtr2iCILgDgxqz2PkGoE92
         atpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JF5ZHq5jYX7ctXx6B8V/rZq9pCcsLqMqEPFd89f+GH0=;
        b=J0zYjOY+mgHhF83bsymw2CB0ukFpf1tC355ZXMK0LP3wue8nYP4YZ7Ag4BjGh9NrJC
         sGr9c3ecEHPekUAyQ7DEuScyNA2n0gETZngOHUxNE8c9swLpWIlmMmU2xViur+uKO/xR
         +JJVMMDlWM05LVbRe7ma2OUPzvWGhTHwKzlMOHCtGRTfQJR6L37puLyPzx/mcOCCtnsy
         VCEALMyvJKK//1AwNz5fheTF6SE3EvfrvB7tjgGOrVevCinkcJmYpzg+/rvPE/0JAAfI
         QbkZZ90VT6m4SUagjnKbKeIGQE7wwCob+xEeH4TsYxR3rItu38viFXr3TIOvPTP212UG
         KSXQ==
X-Gm-Message-State: AA+aEWb+AjTI6B5VZN7ZPCVG0cWIix5/SW3IRw4Zrg5+6ehwkX5Zaz/p
        XGU3M4im5rSWZMKoE5SOSopZHg==
X-Google-Smtp-Source: AFSGD/WVpiQY4GnJa4/hkG5/RHa11rheSBZRA4cxFsvQ2DsmS33+mTFkkHI8CcOr58YZcpjjaBc+Yg==
X-Received: by 2002:a02:158d:: with SMTP id 13mr14634828jaq.97.1543852333681;
        Mon, 03 Dec 2018 07:52:13 -0800 (PST)
Received: from cisco (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id 21sm5543554iou.79.2018.12.03.07.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:52:12 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:52:11 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v9 3/4] seccomp: add a return code to trap to userspace
Message-ID: <20181203155211.GB3504@cisco>
References: <20181203032827.27978-1-tycho@tycho.ws>
 <20181203032827.27978-4-tycho@tycho.ws>
 <20181203052650.GC31406@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203052650.GC31406@mail.hallyn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:26:50PM -0600, Serge E. Hallyn wrote:
> On Sun, Dec 02, 2018 at 08:28:26PM -0700, Tycho Andersen wrote:
> > +struct seccomp_knotif {
> > +	/* The struct pid of the task whose filter triggered the notification */
> > +	struct task_struct *task;
> > +
> > +	/* The "cookie" for this request; this is unique for this filter. */
> > +	u64 id;
> > +
> > +	/*
> > +	 * The seccomp data. This pointer is valid the entire time this
> > +	 * notification is active, since it comes from __seccomp_filter which
> 
> define 'active' - is a notification in state REPLIED still active?

Yes,

> Actually while looking at that, I came to wondering - when are knotifs
> freed?  Seems like only during seccomp_notify_release(), i.e. when the
> tracing task stops polling for events?  Is that going to be a problem?
> Or am I misreading this?

they're stack allocated in do_user_notification(). So "active" in this
sense really means "somewhere in do_user_notification()".

> > +	if (ret == 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
> > +		ret = -EFAULT;
> > +
> > +		/*
> > +		 * Userspace screwed up. To make sure that we keep this
> > +		 * notification alive, let's reset it back to INIT. It
> 
> Is keeping the notification alive the right thing to do?
> 
> If userspace has messed up in something this touchy, it seems unlikely
> that it'll to better if we give it a do-over...  I'm not sure whether
> killing the whole thing (victim and tracer) is the right thing or not.

I suppose we could do that too. I just didn't want to get into a
situation where the notification is lost and the task is stuck because
userspace screwed up here.

Tycho
