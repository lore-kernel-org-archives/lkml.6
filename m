Return-Path: <kernel-hardening-return-12642-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu1D188JdgBeN4KOpGwKfRioOYMfU1C3TJDoJDJo7gUNwtrC6ic4chmHXgS5AB79136qYaw
ARC-Seal: i=1; a=rsa-sha256; t=1521149256; cv=none;
        d=google.com; s=arc-20160816;
        b=YqYyGkItOOc0yZnmDpsnM575qqP7H4+tJbhyKQwVzbdjoLghEHm6qLsob/NmICLBpD
         qJUlExOAMwqRTdl1rOIppMo9eW2hYqXnpMhSzh8+DCG6x93F0GxuQ2grGkqEJqw0Nj0l
         kAZJna+V34y4WEhxmnBf17vNQatQnK1zQJ9TEqMspoKu5Feeh1hgKxiQ82ieg4UbDCQ5
         kMbqZBqLugT8QCOXRzH/1DxRxrpvm/EOe2GdX81Um0hPRw9dq4lq2ekCMvQEcXynkl58
         GizvDHFpG7vN/B5wG7/x/gZl6rayED2I+gnK68IRTjSBmtb8nu/LEvtY+CmfH3HR720C
         l8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=JFsLnV32EJ5aozyrVLj61pON6EmKjHZEsBYc/zMbuZc=;
        b=cc9hvJ671S99HNcYFDDpGfgR1DrWfTiPVGes3VjTqGQ3Fym/9MDLHQuHaMk1h5tXUs
         FPV981D9N0FzikGhZSRx6+mK5B4MB9Pg3xMhstvHwYAcXfaFrHpcQghdnd5NCYPHujnX
         t9qk1ZQDjhrvr/IDnyza4AeXc3rDnHsYwkuXjPNfcelQSYqAa4feWOXmkW4PYKhzPBxp
         nGcAVMWOoD0l1o6DsrcUV5ymnpDy01EVPMvQEvaSsgXrqMK53gMAHS1wOCUol3zpNZdA
         g6UUAw1QNCOzUEHM1uQPgDbukqPQB2UXL7qQnKUhyeO2TdyPcW/qdI4tHUToN477KM9Q
         adoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12642-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12642-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12642-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12642-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Mar 2018 22:27:11 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: linux-kernel@vger.kernel.org,
    Segher Boessenkool <segher@kernel.crashing.org>,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] rslib: Remove VLAs by setting upper bound on nroots
In-Reply-To: <20180310223450.GA37999@beast>
Message-ID: <alpine.DEB.2.21.1803152226590.1520@nanos.tec.linutronix.de>
References: <20180310223450.GA37999@beast>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594591871028316043?=
X-GMAIL-MSGID: =?utf-8?q?1595040602449272082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018, Kees Cook wrote:

> Avoid stack VLAs[1] by always allocating the upper bound of stack space
> needed. The existing users of rslib appear to max out at 24 roots[2],
> so use that as the upper bound until we have a reason to change it.
> 
> Alternative considered: make init_rs() a true caller-instance and
> pre-allocate the workspaces. This would possibly need locking and
> a refactoring of the returned structure.
> 
> Using kmalloc in this path doesn't look great, especially since at
> least one caller (pstore) is sensitive to allocations during rslib
> usage (it expects to run it during an Oops, for example).
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> [2] https://lkml.org/lkml/2018/3/9/838
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
