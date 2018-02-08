Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790034-1518098495-2-1101064103322119191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518098494; b=CBS6QDAlswJb6nNSqMSTIIG+Thw+MwdewPtnVMC67I3lvx2
    uHyTUeWccVij4RECV2hxXqt27JocgNp7nDifjDM/bWXaPhqXP+YiL3QPykY6QKzC
    ErCvtjjpQa/tyl2ATugD5B7D8MZ13dYndbYOCbYtBGYVDSlaEauxCjpamd9TN+3L
    Ce6OME30bd6+NCPeZRjrFV1jnCgG1etKSQw7W6x8/Rba/y87JE14g9kze7MWae/K
    I7vUfrbpjrLvrxaDJ4lEObD566fgT9g7yiCZeBkP0XR6cayB73qVYWPgKywUsiRq
    vC1t7wBWeXuSRYPvz/JNtxnKZ2cPPkTYIotMflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518098494; bh=kEAq7Ah5WwaGfWvufp52qXfiz32fvA6JsreFwjL+eCA=; b=C
    aTL2SSA4M0/NDGhZgopzjdh2Orjh9W8pedYuLcl1o7zxEMJxM/AZjW1Vq3/RIN+c
    dEBezjGPeWdNr8MdF4jlxHWYeQ8U9e1wkO8FLtsur2uiPDhQvP5wY6CkuJU09iVR
    6NZu8QQfGnGrTjoV7X3v5TFKG5VnKB6deP7sBTQuaDZNRXr8qrLqtb0i5QFM52vw
    oU56WZBa8EGi/rpxKf7SLfdrrLsjG/zGb/AV9WomBQqPxoQg+wJ63uLqO+dZc6ch
    kfEcY0xYKE/upgartgmaO+v/YVWNbXTTblBqX00Co7Ekdy9LkOBIIxN+3UZCw/gd
    7F5Vw7lTSrYUTZPZ3nrZw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBHOBc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 09:01:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeBHOBc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Feb 2018 09:01:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835C221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 8 Feb 2018 23:00:24 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] ftrace: Remove incorrect setting of glob
 search field
Message-Id: <20180208230024.872b140bf6e0707859f40b54@kernel.org>
In-Reply-To: <20180206224541.082571667@goodmis.org>
References: <20180206224338.446477232@goodmis.org>
        <20180206224541.082571667@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 06 Feb 2018 17:43:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> __unregister_ftrace_function_probe() will incorrectly parse the glob filter
> because it resets the search variable that was setup by filter_parse_regex().
> 
> Al Viro reported this:
> 
>     After that call of filter_parse_regex() we could have func_g.search not
>     equal to glob only if glob started with '!' or '*'.  In the former case
>     we would've buggered off with -EINVAL (not = 1).  In the latter we
>     would've set func_g.search equal to glob + 1, calculated the length of
>     that thing in func_g.len and proceeded to reset func_g.search back to
>     glob.
> 
>     Suppose the glob is e.g. *foo*.  We end up with
> 	    func_g.type = MATCH_MIDDLE_ONLY;
> 	    func_g.len = 3;
> 	    func_g.search = "*foo";
>     Feeding that to ftrace_match_record() will not do anything sane - we
>     will be looking for names containing "*foo" (->len is ignored for that
>     one).
> 
> Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk
> 
> Cc: stable@vger.kernel.org
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/ftrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index dabd9d167d42..eac9ce2c57a2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4456,7 +4456,6 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
>  		func_g.type = filter_parse_regex(glob, strlen(glob),
>  						 &func_g.search, &not);
>  		func_g.len = strlen(func_g.search);
> -		func_g.search = glob;
>  
>  		/* we do not support '!' for function probes */
>  		if (WARN_ON(not))
> -- 
> 2.15.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
