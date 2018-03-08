Return-Path: <kernel-hardening-return-12222-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv1XiP11mGSsM6/AlQmRqpYrn/Q5NnNIvila4MdVb9irOT4rN9rJKGlJhVCWpaFbK4bWcGs
ARC-Seal: i=1; a=rsa-sha256; t=1520467435; cv=none;
        d=google.com; s=arc-20160816;
        b=QhWEBQaQ3V2pBEQfaOsLn0BEiqwwM6MidsRMkwNJFJB4HKIArZcfDbUCinI4oJS7eo
         nU7cXkXITsfL5PQuwcCHVLlJjuaEaAoXgwo99jIC+aY8MFom+Arm0HF68Eciz2a5nyCq
         vIrnTJaQuBmGdIglsElWCOE4ORjoKUqXO6rKixdOP4PTXg9Rl+/mEbAV4CPc6foPfbcO
         Gcm5xjJ+Kn5lYAa3aDImeXw+r1MxKk/nQ/je9thjIRoJst1F4TPclPQfLbgK+RSvWam8
         tJd7MbPpokIeeCRWhzQXU41dSOEBgoAu2PU6EPWjras+OBvs/9KiU3Nmw5WtSjYNylgv
         imiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=CuooE7rVxnBqIhg7f8alba8bmhQENtA8m8nWIoeRgFg=;
        b=YQntfQIbyPJjaoxaox/PqbbCKYyLaHfyjQ1XWOpgPA5N/IcZg1WDzB1dwKkyITC/Qw
         gwOxKq+7/TbSIH2w8dTAos9vPP1+ltaXX2fxxKWq4cZkRrFoL8oShFKyOyWz1aieBUm0
         QnkVviazMtUmuPBVoH3yZtGNpDJzbB++ouDVU5ubM1GT2MJWXUfTZx4ijix7ss0y+DD3
         kOD8FgN08n5yMwj+oq3YDkwjXDY0CnQjo5upZnkNvv0Ngl0x+RjHaepxy+LpIfH1ghfo
         WAV1g+iFnLVYYlFzI4MEXLPhmk1F4fFm6DAHIRNUjl3HfYy2OjzKTT3QZZYBUn+4xnLx
         DQ3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12222-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12222-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12222-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12222-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 16:03:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Tycho Andersen <tycho@tycho.ws>, "Tobin C. Harding" <me@tobin.cc>,
 Jonathan Corbet <corbet@lwn.net>, Pantelis Antoniou
 <pantelis.antoniou@konsulko.com>, "Steven Rostedt (VMware)"
 <rostedt@goodmis.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
Message-Id: <20180307160322.e9f8a3fb462751d1efa3b09a@linux-foundation.org>
In-Reply-To: <CAGXu5j+d91dqTEPm13CXDvNzzaj01M-CYLYCqyMN5VjrD5Q4ww@mail.gmail.com>
References: <20180307230714.GA20797@beast>
	<20180307234238.yxbbaka35ck2xymw@smitten>
	<CAGXu5j+d91dqTEPm13CXDvNzzaj01M-CYLYCqyMN5VjrD5Q4ww@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594325661907297116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018 15:59:27 -0800 Kees Cook <keescook@chromium.org> wrote:

> I didn't want to encourage a global macro that _lacked_ the safety
> built into the max*() family, though... thoughts for a reasonable
> approach?

I think SIMPLE_MAX() is OK.    Along with one of /* these */ things ;)
