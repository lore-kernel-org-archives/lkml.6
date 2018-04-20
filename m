Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+f+s6J3gT2XZ2bSH+0q68EQdm5uPHQuo+Ls84N0khD3t5zK6Dg9gOAcIYVkQDmO2TJ5fuF
ARC-Seal: i=1; a=rsa-sha256; t=1524219431; cv=none;
        d=google.com; s=arc-20160816;
        b=yU3382RRFhfJZyhhmYe3hoH6ssVhg9MscHx1erQ3ntNNUOufTo4uCsZ8H9TaLQoI3A
         waMn/ygPB29nUYoOaNFe41mGYDZ1lgwm41bKkeBoTnV/etbL2onO2JkoNzqPyOO04fyv
         p5uGIT52n3xJnQ70GFnT3GNAvDxI+lrjY40RSBFLXbg4iOxAcpcLm0aTcp6tTwvvuHgK
         NIdMOys/Qv9DMa4ym7T6m+4VCDw5WiwnpSY6ahFAikYeiK6ax8FVQg4aw/1HZF8ElG8i
         ZTDYC48O74YM8f9bVRmnQmULb4GIlCP/cPpS4TClEfjYucYSzdstPNLFBfZ/xp7TvQcj
         cdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=ws6KjC/xV52IPoOdu3mLnL541K0/0FaNZg2eePKKeUE=;
        b=n49xUXYLIEJUSgF++4D3yQ0MDvVdQbnl4YtPkgOASknOmWN/vUnBVsDdLaFVXBNX4A
         LMFPB3OhU0tTeEDZGFzPrjv5byn4WnruxoxbtPcS9x5a8zwXLjb7AQsme7J4NVzFSdpE
         RwrBN9xKl9sEL1CaeKt1wJ6kTokW5+swKZt2ukNBRyDcf/w6oi7RbIZ7rar2bq7tLJkE
         A9sSGYdr+Cnkxeu8+jizF1rrt06Yb6arjYcEYy9z+nSuI4IAEJwTZkI6zkD6AfUtLnX0
         kl4zMvumQ6y4La1OQmAEUHNBwYxht2oTd8cS5kzePAvZMYGdX0e8mReu9Yna88+3GlEr
         GqnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Fri, 20 Apr 2018 12:16:46 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mceier@gmail.com,
    aaro.koskinen@nokia.com, aarcange@redhat.com, luto@kernel.org,
    arjan@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
    dwmw2@infradead.org, gregkh@linuxfoundation.org, hughd@google.com,
    jpoimboe@redhat.com, jgross@suse.com, keescook@google.com,
    torvalds@linux-foundation.org, namit@vmware.com, peterz@infradead.org
Subject: Re: [PATCH 2/2] x86, pti: fix boot warning from Global-bit setting
In-Reply-To: <20180417211304.7B3F1FDB@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1804201215170.1683@nanos.tec.linutronix.de>
References: <20180417211302.421F6442@viggo.jf.intel.com> <20180417211304.7B3F1FDB@viggo.jf.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029619129049046?=
X-GMAIL-MSGID: =?utf-8?q?1598259914183553615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018, Dave Hansen wrote:

> 
> These are _very_ lightly tested.  I'm throwing them out there for
> folks are looking for a fix.
> 
> ---
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> pageattr.c is not friendly when it encounters empty (zero) PTEs.  The
> kernel linear map is exempt from these checks, but kernel text is not.
> This patch adds the code to also exempt kernel text from these checks.

Bah. Changelogs should tell the WHY and not the WHAT

> The proximate cause of these warnings was most likely an __init area
> that spanned a 2MB page boundary that resulted in a "zero" PMD.

This doesn't make any sense at all. 

Thanks,

	tglx
