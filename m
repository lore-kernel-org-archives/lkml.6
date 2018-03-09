Return-Path: <kernel-hardening-return-12347-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu2/isU2x3y2OCiBZYowFw9NHmMst+LvyVH3E/GDJRdtlCPMSyKtElHJwm8SNeJedx6nN3n
ARC-Seal: i=1; a=rsa-sha256; t=1520636283; cv=none;
        d=google.com; s=arc-20160816;
        b=jN8pETOHTrXvDOO26TdadfHYi5HdvmHwEB1kntlXP4048U+bRHSeRRrnaqSH9kkM6O
         yScO9hpdfQR/ECMT98XTKMnSZd7vrHvw1dpoZxvg2s3RvHQiHhIYbftOIfkjMsDCqD3P
         xWl8BXacdQ0b0EbLsmsCiqA/ffLwlCTZPF635pASIqVZajHOGk5Qk3RLMOvlvI7cjUs6
         WJL8nzQxKFCuTlXP08izd6y0xd2BnbrTHHmu/8GzsfgDaVfkR4yJb+RqZgjaIhDCurcl
         ctCRuNpZ1L9rjWgwLXJpTMS/SHyIsOhDuE8dpymvvKOv7X8Gw4IMBtUUKs66Tz7IvuE6
         Ch6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=hB+YV0ElaYMHZmLtQMzn+PVVKDIjdzc7F3pLN66p/ZI=;
        b=oBphotM+7+CQHqMVe7xNBaNq460+w2NjDT1fsrUKLlBUH1tj4ZiEX7TztMIEDnQTNf
         82cO4ptG9ASb8+Aj+LVPK2m1Eyctzc3VVqrHKnw9tjyfcrRhOH0CxlSr2JnAPM7qiMgE
         s2rTwIY8fV+7ZFQQBrKNQ0dZIDdehbDAUh8d8dXRh/HhliZJLcMgW9rcSsSezGGsJnlj
         seMv/C7yqEa6+EorN0lECRlGJXHlofODBrBFn67ec9+9TkGrLIEOdRtwHrkZ3HZFqOfg
         pAI3H/wz1O3JLEMGjrOpfOV3blF7gjP4Hhf4UVx5UPSD4FUVBwPWjkglI3QnWrbdTOVe
         HKqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12347-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12347-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12347-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12347-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 23:57:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: LKML <linux-kernel@vger.kernel.org>,
    Segher Boessenkool <segher@kernel.crashing.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH][RFC] rslib: Remove VLAs by setting upper bound on
 nroots
In-Reply-To: <CAGXu5j+hySkn5dHpKeRAf8NBm6p+iWDG+eVqs_HGDmu2naTdTw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803092356210.1570@nanos.tec.linutronix.de>
References: <20180309144613.GA48965@beast> <alpine.DEB.2.21.1803091610120.1364@nanos.tec.linutronix.de> <CAGXu5j+hySkn5dHpKeRAf8NBm6p+iWDG+eVqs_HGDmu2naTdTw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594471791016821837?=
X-GMAIL-MSGID: =?utf-8?q?1594502711043446126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 9 Mar 2018, Kees Cook wrote:
> On Fri, Mar 9, 2018 at 7:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 9 Mar 2018, Kees Cook wrote:
> 
> Maybe I should just go with 24 as the max, and if we have a case where
> we need more, address it then?

Works for me.

Thanks,

	tglx
