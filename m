Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+1XNMr9ulCqphoV/lp+veKcJuqPFD3Vk/FfCMC+J+pnoS6wUT7XeXYzZsMlnKjliB83UJ6
ARC-Seal: i=1; a=rsa-sha256; t=1524590350; cv=none;
        d=google.com; s=arc-20160816;
        b=YxGPs5y2B7BDgsOMbfw70o9TbwpPUTOCDhZFqUOrFTXljTkLe7fODFdV50XW4hzLwu
         Tqs40LJp+0n75/RJ6uDNAUtA32q8FscDuJY8uR1b1zwXacIzZfZjkd07QfVgmXa4MDlk
         0clBBjIyLg8bTWO4l3Rr9dgqXJuPKMfMt8214ryldUoXFv5BlsPc6LnixfwwwqmvAEqH
         OAzgOD58Y7bPqlAoo0acy+4b/qkruMe06mRGMKxxz0psP0fA3RWEE0nUp8BkTmN9g4zt
         z1ufybyA2/Lw7PIgcjLQ+BOmobLjIzUvOpfRyZkIh2fvyeSRGlk0J5B5DYu84mUf0QpI
         Z3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=efEv5yqmI/LM0q7U4c65UGbcLQ4E6Gnkze9OMjoHRAM=;
        b=n/Xvk0iA+4opdfTdpW8ITwXe7SstnKS4m+SATBaPSAjMGAge82DzfSMhbDkA2n4vCa
         LGZoFEV93xZN795Tn6YL/PhUO3wozgGUNZqFDE8EJnfLGKeUEWkypVTQmML+IXxv6mkR
         qL2n/TYi/KEA8EJXvG4FtwGzi8EHz3C0Vll0/osMBRpbusIxO+U3CGSfkKMd3kz21o0z
         TRIaxecnOvOpwZrnRalNC5kiC5y/leYlqRxrjWghuQbMAOb5Y+ihesstlrvnOJfp6fGw
         J5JrnsSE/1ubn1PijYbOgEHmroHYSLNwRk71QMxRVBccyCFIFxohO8zptwmLRbMx7Ebp
         ZAIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeDXRTI (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 13:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752262AbeDXRTF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 13:19:05 -0400
Date: Tue, 24 Apr 2018 19:19:02 +0200
From: Libor Pechacek <lpechacek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180424171902.z4ymubblh2dtcp4h@fmn.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
 <20180423144317.too6ucui37m7oj7y@redhat.com>
 <c3f1a6b8-5eba-84e1-9d0b-8009c9087022@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f1a6b8-5eba-84e1-9d0b-8009c9087022@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1598648850895793843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 24-04-18 11:50:28, Joe Lawrence wrote:
> On 04/23/2018 10:43 AM, Joe Lawrence wrote:
> > On Fri, Apr 20, 2018 at 02:56:05PM +0200, Libor Pechacek wrote:
> >> On Thu 12-04-18 10:54:31, Joe Lawrence wrote:
> >>> +	fi
> >>> +	echo "$ret" > /dev/kmsg
> >>> +}
> >>> +
> >>> +# unload_mod(modname) - unload a kernel module
> >>> +#	modname - module name to unload
> >>> +function unload_mod() {
> >>> +	local mod="$1"
> >>> +
> >>> +	# Wait for module reference count to clear ...
> >>> +	local i=0
> >>> +	while [[ $(cat /sys/module/"$mod"/refcnt) != "0" ]]; do
> >>> +		i=$((i+1))
> >>> +		if [[ $i -eq $MAX_RETRIES ]]; then
> >>> +			die "failed to unload module $mod (refcnt)"
> >>> +		fi
> >>> +		sleep $RETRY_INTERVAL
> >>> +	done
> >>
> >> The repeating pattern of "while <some test>; do <count>; if <count beyond max
> >> retries>; then <die>..." seems to ask for encapsulation.
> >>
> > 
> > Yeah I definitely agree.  I think at some point I had acquired
> > bash-fatigue;  I wasn't sure how to cleanly wrap <some test> around that
> > extra logic.  In C, I could do something clever with macros or a
> > callback function.  My bash scripting isn't great, so I copied and
> > pasted my way through it.  Suggestions welcome.
> > 
> 
> Okay, here's what I came up with... first off, do you prefer this kind
> of transition check vs. looking only at a specific module?
> 
>   # check_transition() - verify that no livepatch transition in effect
>   function check_transition() {
>   	grep -q '^1$' /sys/kernel/livepatch/*/transition 2>/dev/null
>   }

Elegant!

> then wrap the retry/timeout logic like:
> 
>   # retry_cmd(cmd) - loop a command until it is successful or
>   #		   $MAX_RETRIES, sleeping $RETRY_INTERVAL in
>   #		   between tries
>   # 	cmd - command and its arguments to run
>   function retry_cmd() {
>   	local cmd="$*"
>   	local i=0
>   	while eval "$cmd"; do
>   		i=$((i+1))
>   		[[ $i -eq $MAX_RETRIES ]] && return 1
>   		sleep $RETRY_INTERVAL
>   	done
>   	return 0
>   }
> 
> and the callers to something like:
> 
>   # wait_for_transition() - wait until all livepatch transitions clear
>   function wait_for_transition() {
>   	retry_cmd check_transition ||
>   		die "failed to complete transition"
>   }

My idea was to make the die() part of the retry loop. This implementation is,
however, more flexible.

> I can create similar check() functions to eval for sysfs file existence,
> file content, reference count, etc. to remove all the other
> retry/timeout loops.

I think check_*() functions can be avoided for trivial tests. retry_cmd() can
be passed a more complex command string than a single function name.

Regarding naming, I'd say wait_false() or similar would better describe what
retry_cmd() does. 

Libor
-- 
Libor Pechacek
SUSE Labs
