Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2819429-1518098519-2-8387468528698861860
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
    t=1518098518; b=KJoRWwONv8qzPo7VkxPBkgUZEIEo70mdEhS3QBPAiLfuYFX
    6V78niJtTyPvq4hqZiiil66bA7e7vkOUm0VdTA0ZKPu71fLZZdfYsmsz0WrzJgpt
    EQ+HxUn3mA7QbO4kcSv9o6lC8z8Y/k3/4AaqdH9cB2Vva4TxG9ffEgqpvVW6EUdD
    3f3CtpJxWty+fKR11Z2HGiC6GZNld+8uxbRMdA5ZmhlDOwU6WFsR5hHh4IZBZ/xb
    ISqxZ0w8dtYurhtc6NRSn5l+euS9yNeLwBksMaERia9udiochAxeP3CQsaycoCKl
    oQYcAQzpjd5uYsgXAPYhK/Y4KLbNL5Ks0JaPFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518098518; bh=25TqzU2b/1woOet64Qm72urhwc7dX0TOWcGZyrD2OYg=; b=I
    NbnIgmfzw/aAunxNVMfKLOUToy8VgL9f8mOWkEtx//RXDMPs1oxlTnIDF0tnA53P
    ooe0nmBhfrxRFicv1nirCIorcYZzqbKfyGKML4zq3I1FM9d/v1Fw6m5+G79Rpdsr
    aWiZ8V87x3gDbyW6sycVTFmgKkY3jexn8yUrjdJ6+alsYY3em+ecjbTbYaD2AW0K
    WLzSAQEpeO4rlA3fdokMFuI86Pupwou3EewDsqvF0dIn7bTAb9kj0Sq7pMV0jH9N
    VIV45dH3P0BDEkriuaIxVlgWqQFbTA5cAPk5tAucpWOKqFrj3gS3DlTYxpzCV64T
    9bZrpD/RHybs+cu8joG2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBHOB5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 09:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeBHOB4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Feb 2018 09:01:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE1221796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 8 Feb 2018 23:01:53 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC][PATCH 2/6] tracing: Fix parsing of globs with a wildcard
 at the beginning
Message-Id: <20180208230153.182d38de89e2ce56263cb471@kernel.org>
In-Reply-To: <20180206224541.231476648@goodmis.org>
References: <20180206224338.446477232@goodmis.org>
        <20180206224541.231476648@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 06 Feb 2018 17:43:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Al Viro reported:
> 
>     For substring - sure, but what about something like "*a*b" and "a*b"?
>     AFAICS, filter_parse_regex() ends up with identical results in both
>     cases - MATCH_GLOB and *search = "a*b".  And no way for the caller
>     to tell one from another.
> 
> Testing this with the following:
> 
>  # cd /sys/kernel/tracing
>  # echo '*raw*lock' > set_ftrace_filter
>  bash: echo: write error: Invalid argument
> 
> With this patch:
> 
>  # echo '*raw*lock' > set_ftrace_filter
>  # cat set_ftrace_filter
> _raw_read_trylock
> _raw_write_trylock
> _raw_read_unlock
> _raw_spin_unlock
> _raw_write_unlock
> _raw_spin_trylock
> _raw_spin_lock
> _raw_write_lock
> _raw_read_lock
> 
> Al recommended not setting the search buffer to skip the first '*' unless we
> know we are not using MATCH_GLOB. This implements his suggested logic.
> 
> Link: http://lkml.kernel.org/r/20180127170748.GF13338@ZenIV.linux.org.uk
> 
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Fixes: 60f1d5e3bac44 ("ftrace: Support full glob matching")
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Suggsted-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/trace_events_filter.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 61e7f0678d33..a764aec3c9a1 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -400,7 +400,6 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
>  	for (i = 0; i < len; i++) {
>  		if (buff[i] == '*') {
>  			if (!i) {
> -				*search = buff + 1;
>  				type = MATCH_END_ONLY;
>  			} else if (i == len - 1) {
>  				if (type == MATCH_END_ONLY)
> @@ -410,14 +409,14 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
>  				buff[i] = 0;
>  				break;
>  			} else {	/* pattern continues, use full glob */
> -				type = MATCH_GLOB;
> -				break;
> +				return MATCH_GLOB;
>  			}
>  		} else if (strchr("[?\\", buff[i])) {
> -			type = MATCH_GLOB;
> -			break;
> +			return MATCH_GLOB;
>  		}
>  	}
> +	if (buff[0] == '*')
> +		*search = buff + 1;
>  
>  	return type;
>  }
> -- 
> 2.15.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
