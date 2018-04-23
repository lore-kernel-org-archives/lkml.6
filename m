Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48WqYS9rkvBnnmBcFOoLEynb+mgQsxRmlSXkKUZLMqSOexGzuJ0CpcCgHyJvqXeMr1h+B+M
ARC-Seal: i=1; a=rsa-sha256; t=1524494603; cv=none;
        d=google.com; s=arc-20160816;
        b=PGvD0LpzwQq/hqlRU1GZPijPWNR23v4W2HMRfaK7WiMGF/M+OnlZdqfGWV8ir6ZHuu
         J5Ee7qlokf/o3kAMw1wKazgIy7V4O6Yre+Ahm86ZSzlXln4853ASFSLfHQxo2qIr/aZp
         QHxJAa+nhiSYitcuBwmvC4z6lml3dyjUpUdv3lN0re2QG7O4aS1Ec50RmLG2LYQ9Qevg
         w8VgMFQBOkgBHLZHvuGZBIDsZtH1LOe+f8FFU9qBwBY17boT25Fp5u5RZDeppcFVtbat
         UABmZet5s3pl5gDog8xgs0uZLIBaLKskFmKDn94E5zKmciWtKtyZh0vS4sAIQIiMS02i
         YCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=ou2z2/UPLBivh8Oe27jm+3KaIRrwpFSMv8SSmbf94/0=;
        b=Q/H/xbyZxRlixdA4lnYWQjuwgwC0NOIqF75AMk3nWR2ulQtaOweSBsrPjkfx2GIFPE
         wjWiPULhRhuMD8o1t9kVfxP55MQhILrYc4dcFAmg20aNJBfpUx5cTUmB0tsoDusveRv9
         0f2voCWc5h2rIGhsvvysllb/q/dCsKpYJdfVThEoSEoQHwGv8EtvKrhAFAdtah0fFcFM
         Vu5o1knyDELwgC2+g64rIrSLSCxFLWbxcR9Iq5tYGL47R1UGVHzt0lFk+QfxjKERJgp+
         ZIcLj5vKUSfxQhZjVOOoo00s5+f3uCgfxEMaX+5395Y5wy9+m7ZhoUATZjhNoLpsp1jw
         j/jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeDWOnU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 10:43:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755198AbeDWOnT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 10:43:19 -0400
Date: Mon, 23 Apr 2018 10:43:17 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Libor Pechacek <lpechacek@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180423144317.too6ucui37m7oj7y@redhat.com>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1598548452890559656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 02:56:05PM +0200, Libor Pechacek wrote:
> Hi Joe,
> 
> I know I am late to the party, yet have some questions about the code.

Hi Libor,

I'm planning another version, so you're comments are not too late!

> On Thu 12-04-18 10:54:31, Joe Lawrence wrote:
> > Add a few livepatch modules and simple target modules that the included
> > regression suite can run tests against.
> > 
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> [...]
> > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> > new file mode 100644
> > index 000000000000..7aaef80e9edb
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/functions.sh
> > @@ -0,0 +1,196 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> > +
> > +# Shell functions for the rest of the scripts.
> > +
> > +MAX_RETRIES=600
> > +RETRY_INTERVAL=".1"	# seconds
> > +
> > +# die(msg) - game over, man
> > +#	msg - dying words
> > +function die() {
> > +	echo "ERROR: $1" >&2
> > +	exit 1
> > +}
> > +
> > +# set_dynamic_debug() - setup kernel dynamic debug
> > +#	TODO - push and pop this config?
> > +function set_dynamic_debug() {
> > +	cat << EOF > /sys/kernel/debug/dynamic_debug/control
> > +file kernel/livepatch/* +p
> > +func klp_try_switch_task -p
> > +EOF
> > +}
> > +
> > +# wait_for_transition(modname)
> > +#	modname - livepatch module name
> > +wait_for_transition() {
> > +	local mod="$1"; shift
> 
> Why is the function waiting for a concrete module to finish the transition?
> Wouldn't checking all modules, and therefore watching the global transition
> state, be equally efficient without the need to provide module name?
> 

This code was thrown together to originally test the callback
implementation.  My thinking was that I'd usually load a livepatch and
then wait for it to finish transitioning before moving onto the next
step...

> > +
> > +	# Wait for livepatch transition  ...
> > +	local i=0
> > +	while [[ $(cat /sys/kernel/livepatch/"$mod"/transition) != "0" ]]; do
> > +		i=$((i+1))
> > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > +			die "failed to complete transition for module $mod"
> 
> FWIW, qa_test_klp tests dump blocking processes' stacks at this place for more
> efficient information exchange between tester and developer.
> (klp_dump_blocking_processes() in https://github.com/lpechacek/qa_test_klp,
> file klp_tc_functions.sh)
> 

... If I read the klp_dump_blocking_processes() code correctly and
understand your comment, you are suggesting that reading (any)
/sys/kernel/livepatch/*/transition would be simpler?  No module
parameter needed as only one should ever be transitioning at a given
time?

> > +# load_mod(modname, params) - load a kernel module
> > +#	modname - module name to load
> > +#       params  - module parameters to pass to modprobe
> > +function load_mod() {
> > +	local mod="$1"; shift
> > +	local args="$*"
> > +
> > +	local msg="% modprobe $mod $args"
> > +	echo "${msg%% }" > /dev/kmsg
> > +	ret=$(modprobe "$mod" "$args" 2>&1)
> > +	if [[ "$ret" != "" ]]; then
> > +		echo "$ret" > /dev/kmsg
> > +		die "$ret"
> > +	fi
> > +
> > +	# Wait for module in sysfs ...
> > +	local i=0
> > +	while [ ! -e /sys/module/"$mod" ]; do
> > +		i=$((i+1))
> > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > +			die "failed to load module $mod"
> > +		fi
> > +		sleep $RETRY_INTERVAL
> > +	done
> > +
> > +	# Wait for livepatch ...
> > +	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
> > +
> > +		# Wait for livepatch in sysfs ...
> > +		local i=0
> > +		while [ ! -e /sys/kernel/livepatch/"$mod" ]; do
> 
> Hmmm! Good test! Never came to my mind...
> 

I ran into all kinds of weird sysfs timing races, so I got really
paranoid :)

> > +# load_failing_mod(modname, params) - load a kernel module, expect to fail
> > +#	modname - module name to load
> > +#       params  - module parameters to pass to modprobe
> > +function load_failing_mod() {
> > +	local mod="$1"; shift
> > +	local args="$*"
> > +
> > +	local msg="% modprobe $mod $args"
> > +	echo "${msg%% }" > /dev/kmsg
> > +	ret=$(modprobe "$mod" "$args" 2>&1)
> > +	if [[ "$ret" == "" ]]; then
> > +		echo "$mod unexpectedly loaded" > /dev/kmsg
> > +		die "$mod unexpectedly loaded"
> 
> I'm wondering why is the same message being logged to kernel buffer and console
> when in other cases it's written to console only.
> 

No reason as far as I remember.  I'll clean up for the next version.

> > +	fi
> > +	echo "$ret" > /dev/kmsg
> > +}
> > +
> > +# unload_mod(modname) - unload a kernel module
> > +#	modname - module name to unload
> > +function unload_mod() {
> > +	local mod="$1"
> > +
> > +	# Wait for module reference count to clear ...
> > +	local i=0
> > +	while [[ $(cat /sys/module/"$mod"/refcnt) != "0" ]]; do
> > +		i=$((i+1))
> > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > +			die "failed to unload module $mod (refcnt)"
> > +		fi
> > +		sleep $RETRY_INTERVAL
> > +	done
> 
> The repeating pattern of "while <some test>; do <count>; if <count beyond max
> retries>; then <die>..." seems to ask for encapsulation.
> 

Yeah I definitely agree.  I think at some point I had acquired
bash-fatigue;  I wasn't sure how to cleanly wrap <some test> around that
extra logic.  In C, I could do something clever with macros or a
callback function.  My bash scripting isn't great, so I copied and
pasted my way through it.  Suggestions welcome.

> > +
> > +	echo "% rmmod $mod" > /dev/kmsg
> > +	ret=$(rmmod "$mod" 2>&1)
> > +	if [[ "$ret" != "" ]]; then
> > +		echo "$ret" > /dev/kmsg
> > +		die "$ret"
> 
> Similarly "echo <message> > /dev/kmsg; die <message>" is a repeating pattern.
> How about introducing "klp_log_messsage()" or something like that?
> 

Good idea for the next version.  Will do.

> > +# display_lp(modname) - disable a livepatch
>      ^^^^^^^ typo
> 

Ok.

> > +#	modname - module name to unload
> > +function disable_lp() {
> > +	local mod="$1"
> 
>    ^^^VVVV - mixed indentation with tabs and spaces. Intentional?
> 	     (same in set_pre_patch_ret and several other places)
> 

Ahh, thanks for spotting that.  checkpatch doesn't seem to complain
about shell script indentation.  Funny that shellcheck didn't either.

> > +
> > +        echo "% echo 0 > /sys/kernel/livepatch/$mod/enabled" > /dev/kmsg
> > +        echo 0 > /sys/kernel/livepatch/"$mod"/enabled
> 
> How about folding disable_lp functionality into module unload function? That
> would save extra invocation of disable_lp in test scripts.
> 

Maybe this is just a stylistic thing, but I preferred the test scripts
to be rather explicit about what they are doing.  Instead of a do-it-all
test_it() call, I liked how part_a(), part_b(), part_c() spelled things
out.

In some instances, these functions were once combined, but I ran
into a scenario where I needed only a part of that function because I
was injecting an error.  That experience lead me to keep the test "api"
more RISC than CISC :) 

> > +
> > +	# Wait for livepatch enable to clear ...
> > +	local i=0
> > +	while [[ $(cat /sys/kernel/livepatch/"$mod"/enabled) != "0" ]]; do
> > +		i=$((i+1))
> > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > +			die "failed to disable livepatch $mod"
> > +		fi
> > +		sleep $RETRY_INTERVAL
> > +	done
> > +}
> > +
> > +# set_pre_patch_ret(modname, pre_patch_ret)
> > +#	modname - module name to set
> > +#	pre_patch_ret - new pre_patch_ret value
> > +function set_pre_patch_ret {
> 
> This function is used by single test in this patch set. Are there plans for
> reuse in other tests?
> 

Not now, but maybe in the future?  Even if not, I'd prefer to keep the
bulk of the sysfs coding in the functions file.

> > +	local mod="$1"; shift
> > +        local ret="$1"
> > +
> > +        echo "% echo $1 > /sys/module/$mod/parameters/pre_patch_ret" > /dev/kmsg
> > +        echo "$1" > /sys/module/"$mod"/parameters/pre_patch_ret
> > +
> > +	local i=0
> > +	while [[ $(cat /sys/module/"$mod"/parameters/pre_patch_ret) != "$1" ]]; do
> > +		i=$((i+1))
> > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > +			die "failed to set pre_patch_ret parameter for $mod module"
> > +		fi
> > +		sleep $RETRY_INTERVAL
> > +	done
> > +}
> > +
> > +# filter_dmesg() - print a filtered dmesg
> > +#	TODO - better filter, out of order msgs, etc?
> 
>       ^^^VVV - Mismatch between comment and function.
> 

Ok.

> > +function check_result {
> > +	local expect="$*"
> > +	local result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
> > +
> > +	if [[ "$expect" == "$result" ]] ; then
> > +		echo "ok"
> > +	else
> > +		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
> > +		die "livepatch kselftest(s) failed"
> > +	fi
> > +}
> > diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> > new file mode 100755
> > index 000000000000..739d09bb3cff
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> > @@ -0,0 +1,607 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> > +
> > +. functions.sh
> 
> This assumes functions.sh is in $CWD.
> 

Good point.  In the past, I've used something like:

  SCRIPTDIR="$(readlink -f $(dirname $(type -p $0)))"

but I notice that not many selftests do anything special at all:

  % grep '^\. ' $(find . tools/testing/selftests/ -name '*.sh')
  ...

only the perf tests do, and they use ". $(dirname $0)/..." so I'll use
that convention for these tests.

> The rest looks good to me at the moment.
> 
Thanks for taking a look and reviewing!

-- Joe
