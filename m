Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/wwOCBcRLh3GLsdag0Xi4iFanK6o9+rRLr8zTVdQO3nwV/mGdil3kR0Yvg6y3IpAhbNNSO
ARC-Seal: i=1; a=rsa-sha256; t=1524585031; cv=none;
        d=google.com; s=arc-20160816;
        b=bqLb9Vrv24o1+ULwEW6WvmmvDs/tIZSxU7fyogvDsu6s5w6LH7ocS/vzAT6XNcgarn
         jmVmC0i1gra6kIzpM4J1JQAc2RnTx1jfbOjQT3hNwhR539UBhdFCEpFEVYNk1rH6oB8e
         58lUjClLe3LahEKtpfe1336smpGDoHVxG6cJavVBTh9YLi2iv4Z1/DDo3z+DhNQxPg2j
         IpZR87ofRSDuKwwKr85d4hkPaIWDG3KU4YB9cJ0HdkRwfbaYqHgW9XZzgN6Ilcx4/enu
         J7mLrqCR6e2VIXkPrQHEK617UBehggY3RuZxQ2JHn3qh62/jcKkeDrwdz9gOKm9/eQmk
         r+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:organization:references:cc:to:from:subject
         :arc-authentication-results;
        bh=YYsKqXGHkV5pNChgPTto27FrDGRKd7FNQsVkJMvLGoQ=;
        b=bKPFGHzX5kEPcMJMiLj8t3EgeEzlj1+Dg3lrJDOmeKCE9UswrkxdoySL1ERVndhMPo
         RkMoF3Znfi+x5wvzBYzbJ4iOfi4X+Ra4ZhnIoRdI1dk8Ms8X0WGDhaHP/DVOSImb2s5e
         OfIQFRBVy83D+gnijixOyOTRZEgQKI4ufF46KFlvRggt2dlCF+eqSeP/w+OfHxX+SuZ3
         FM9xvEBA9OLcLVEW4mWQ24tejk6eF6z9lH4BejGIvegKn1je7TTmI6kzZYhmRYUCd1KE
         S771yRiE7Q5A+vFZZKdoqIz2+96RXPrFuHXNqVdnuqu5+5VkK8ot4Opdr/dt1njYgL4G
         CQUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeDXPub (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 11:50:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750729AbeDXPua (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 11:50:30 -0400
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Libor Pechacek <lpechacek@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
 <20180423144317.too6ucui37m7oj7y@redhat.com>
Organization: Red Hat
Message-ID: <c3f1a6b8-5eba-84e1-9d0b-8009c9087022@redhat.com>
Date: Tue, 24 Apr 2018 11:50:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180423144317.too6ucui37m7oj7y@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1598643274609632693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 10:43 AM, Joe Lawrence wrote:
> On Fri, Apr 20, 2018 at 02:56:05PM +0200, Libor Pechacek wrote:
>> On Thu 12-04-18 10:54:31, Joe Lawrence wrote:
>>> +	fi
>>> +	echo "$ret" > /dev/kmsg
>>> +}
>>> +
>>> +# unload_mod(modname) - unload a kernel module
>>> +#	modname - module name to unload
>>> +function unload_mod() {
>>> +	local mod="$1"
>>> +
>>> +	# Wait for module reference count to clear ...
>>> +	local i=0
>>> +	while [[ $(cat /sys/module/"$mod"/refcnt) != "0" ]]; do
>>> +		i=$((i+1))
>>> +		if [[ $i -eq $MAX_RETRIES ]]; then
>>> +			die "failed to unload module $mod (refcnt)"
>>> +		fi
>>> +		sleep $RETRY_INTERVAL
>>> +	done
>>
>> The repeating pattern of "while <some test>; do <count>; if <count beyond max
>> retries>; then <die>..." seems to ask for encapsulation.
>>
> 
> Yeah I definitely agree.  I think at some point I had acquired
> bash-fatigue;  I wasn't sure how to cleanly wrap <some test> around that
> extra logic.  In C, I could do something clever with macros or a
> callback function.  My bash scripting isn't great, so I copied and
> pasted my way through it.  Suggestions welcome.
> 

Okay, here's what I came up with... first off, do you prefer this kind
of transition check vs. looking only at a specific module?

  # check_transition() - verify that no livepatch transition in effect
  function check_transition() {
  	grep -q '^1$' /sys/kernel/livepatch/*/transition 2>/dev/null
  }

then wrap the retry/timeout logic like:

  # retry_cmd(cmd) - loop a command until it is successful or
  #		   $MAX_RETRIES, sleeping $RETRY_INTERVAL in
  #		   between tries
  # 	cmd - command and its arguments to run
  function retry_cmd() {
  	local cmd="$*"
  	local i=0
  	while eval "$cmd"; do
  		i=$((i+1))
  		[[ $i -eq $MAX_RETRIES ]] && return 1
  		sleep $RETRY_INTERVAL
  	done
  	return 0
  }

and the callers to something like:

  # wait_for_transition() - wait until all livepatch transitions clear
  function wait_for_transition() {
  	retry_cmd check_transition ||
  		die "failed to complete transition"
  }


I can create similar check() functions to eval for sysfs file existence,
file content, reference count, etc. to remove all the other
retry/timeout loops.

Regards,

-- Joe
