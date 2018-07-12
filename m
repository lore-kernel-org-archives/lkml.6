Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B29C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B3E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFnhuC4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B3E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbeGLONP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:13:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeGLONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:13:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so21801888wrt.1;
        Thu, 12 Jul 2018 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oo4MTHtPM3FPeComRGsuoSH+yFENFOETOKYT7x5UkWQ=;
        b=bFnhuC4cVWodoFpen9TpO/Lgb2xzFwM4UUvJcnm13o4NbduOBW6ETf1orFotCH5JfZ
         KD/yMwTC7MHwNGi8r7uBgXPWaKqyxsKE3udhwbrPHM5QpaizX+ZHegD4F9QxAy8D0iVe
         K8EGMSmnPeJSmDKYYQWFDMdxc123jc2fUd+BfvYnALliDve6gP79mf6ch8KdHyd2H7GC
         GQ4OMNUarZILfXylbhc53Az9InPvVvEYdi9LZ+IAId/7PjWUlehDUKCCoQ914Nuy/TW2
         EL3Wpag4YJXga7AlHqeceevbO2VwqSofAGSQ3zv9ruiV0vbgitovjaWne4OWQXqyJl8s
         x/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oo4MTHtPM3FPeComRGsuoSH+yFENFOETOKYT7x5UkWQ=;
        b=CI6JWyxlYwVY4Emje8xQ2ZIKIH9dWKAqk4xqXr+1onQ3kFZQs3rtqqe9MmbpkqMlet
         fGs7zP0vAGwJ7I8iV1WwalrWkgrVfiXfUIKhJB5lKYTyZQpUUDGxTs65ba30s6YFRqcg
         dWWJKHQmRUMGIevsgZ6vkDfouQh628lO0rglkYdjQVBJ+YXjCvWRNIDvfO9fHQN5N/FY
         s5Mpzfbf0F+dXPyQqwh0Z3FL+kXQqobp2RXva+YoxVrkxZD7M1kea2dvZXf/7g0yl5ci
         N0ShdDd74MPtw2EjppIpD7W+Xg4zVoU9xkqDPgrjh04r4GeQDyLjOChiaOs5HVkhthro
         tEuw==
X-Gm-Message-State: AOUpUlFy+VZP2PR5QymlJKK6YNcEqhlAGz9og6eUBA1RcdXZHzzP26VU
        pa4blS+304s6K18wWlwHgzo=
X-Google-Smtp-Source: AAOMgpeZKmicQB6vRw64POjiKUKAHt7mvYgUWU2VJortb0ELl9IcVj4mAo6ttecbuPYSbFYZ6rV/Ag==
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr2010358wri.139.1531404211360;
        Thu, 12 Jul 2018 07:03:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z193-v6sm6678513wmc.14.2018.07.12.07.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 07:03:30 -0700 (PDT)
Date:   Thu, 12 Jul 2018 16:03:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
Message-ID: <20180712140327.GA7810@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-26-yu-cheng.yu@intel.com>
 <20180711102035.GB8574@gmail.com>
 <1531323638.13297.24.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531323638.13297.24.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> > > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > > index e2ee403865eb..ac2bc3a18427 100644
> > > --- a/arch/x86/kernel/ptrace.c
> > > +++ b/arch/x86/kernel/ptrace.c
> > > @@ -49,7 +49,9 @@ enum x86_regset {
> > >  	REGSET_IOPERM64 = REGSET_XFP,
> > >  	REGSET_XSTATE,
> > >  	REGSET_TLS,
> > > +	REGSET_CET64 = REGSET_TLS,
> > >  	REGSET_IOPERM32,
> > > +	REGSET_CET32,
> > >  };
> > Why does REGSET_CET64 alias on REGSET_TLS?
> 
> In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
> cannot handle holes in the array.

Is there a fundamental (ABI) reason for that?

> > to "CET" (which is a well-known acronym for "Central European Time"),
> > not to CFE?
> > 
> 
> I don't know if I can change that, will find out.

So what I'd suggest is something pretty simple: to use CFT/cft in kernel internal 
names, except for the Intel feature bit and any MSR enumeration which can be CET 
if Intel named it that way, and a short comment explaining the acronym difference.

Or something like that.

Thanks,

	Ingo
