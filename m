Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/hmmFcsuecrU2Sih+Rh9YZBKnyph2Bkr6Q2z/7wa3XXAbOY7TuFA4GqNpxa1Kl2ZUKmYHW
ARC-Seal: i=1; a=rsa-sha256; t=1524591316; cv=none;
        d=google.com; s=arc-20160816;
        b=L1HR2RLAFODnmHh8iVBDLIM/Sakz1e5qSEVxHx7oB9vLzS5icePgy5B19AxF3D4vyY
         +atOmsaXDpdR5Tjh3YpC9lyVI+l48KCNDWq5FYJX6FafPAI+0aPnjkpmiOB/apQSaCRh
         /XWXaUW5XbSmjrtDX4UPtBuD4uHR8QbF1H5SUKCqK762Rk9wy5iSV7G4/JvN0HOccHrN
         ZcK8OiSyPTwyHIDhcQ4lt8YixW/GJcOmmg3E+HmA9NQaBKdTLgOoEHyaUyu5iY0LmcF9
         o/7vEpoYuy3ZAXCu2CK4ggieS/jv8DPRiC1s2wod/Te7aqbFOm6bOkj54tFxWzl9YIrR
         rAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=UsJBTZPtYlkQB1UnWup2oaWUyUtbH7qrrdGSBvVBSRY=;
        b=ZSVtvUkgKC11ennxR19BHbNlEglP6u01avB965bolEGmthhID9p4bmeDMrEXA74zfS
         9Bvlog08jzcjzWbqT/JwHTBKElK0aobPuVSVO6dDpQogn/sYE6lWiYsBzaN+2axse1xw
         WmGMcRYVUamjHSG52YxEPB/K/BLartFAEQhghZjW6VKRaV8vZnN/ftMvYyRL8xCkLMTP
         wttw0/rmEv4dCy2ws3hLQ38RpfmSKXFb3fePguysGfB7FfRkNCgxF+yVGVvWh5FoM/5V
         0bFlkLE2wzJVd7tRVD7K4P1D21rjXvd5pqoAhGD5xRWJBJ14MGU6EfGiGgrAgX8C6Wg0
         Y4vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeDXRfP (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 24 Apr 2018 13:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46597 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbeDXRfO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Apr 2018 13:35:14 -0400
Date: Tue, 24 Apr 2018 19:35:11 +0200
From: Libor Pechacek <lpechacek@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        live-patching@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
Message-ID: <20180424173511.frrpg45bndwffvkh@fmn.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <20180420125605.e4eye7ncukyivleh@fm.suse.cz>
 <20180423144317.too6ucui37m7oj7y@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423144317.too6ucui37m7oj7y@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1598649864260065338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 23-04-18 10:43:17, Joe Lawrence wrote:
> On Fri, Apr 20, 2018 at 02:56:05PM +0200, Libor Pechacek wrote:
[...]
> > > +
> > > +	# Wait for livepatch transition  ...
> > > +	local i=0
> > > +	while [[ $(cat /sys/kernel/livepatch/"$mod"/transition) != "0" ]]; do
> > > +		i=$((i+1))
> > > +		if [[ $i -eq $MAX_RETRIES ]]; then
> > > +			die "failed to complete transition for module $mod"
> > 
> > FWIW, qa_test_klp tests dump blocking processes' stacks at this place for more
> > efficient information exchange between tester and developer.
> > (klp_dump_blocking_processes() in https://github.com/lpechacek/qa_test_klp,
> > file klp_tc_functions.sh)
> > 
> 
> ... If I read the klp_dump_blocking_processes() code correctly and
> understand your comment, you are suggesting that reading (any)
> /sys/kernel/livepatch/*/transition would be simpler?  No module
> parameter needed as only one should ever be transitioning at a given
> time?

Exactly.

[...]
> > > +#	modname - module name to unload
> > > +function disable_lp() {
> > > +	local mod="$1"
> > 
> >    ^^^VVVV - mixed indentation with tabs and spaces. Intentional?
> > 	     (same in set_pre_patch_ret and several other places)
> > 
> 
> Ahh, thanks for spotting that.  checkpatch doesn't seem to complain
> about shell script indentation.  Funny that shellcheck didn't either.
> 
> > > +
> > > +        echo "% echo 0 > /sys/kernel/livepatch/$mod/enabled" > /dev/kmsg
> > > +        echo 0 > /sys/kernel/livepatch/"$mod"/enabled
> > 
> > How about folding disable_lp functionality into module unload function? That
> > would save extra invocation of disable_lp in test scripts.
> > 
> 
> Maybe this is just a stylistic thing, but I preferred the test scripts
> to be rather explicit about what they are doing.  Instead of a do-it-all
> test_it() call, I liked how part_a(), part_b(), part_c() spelled things
> out.
> 
> In some instances, these functions were once combined, but I ran
> into a scenario where I needed only a part of that function because I
> was injecting an error.  That experience lead me to keep the test "api"
> more RISC than CISC :) 

Understood. Thanks for explanation.

[...]
> > > diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> > > new file mode 100755
> > > index 000000000000..739d09bb3cff
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> > > @@ -0,0 +1,607 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> > > +
> > > +. functions.sh
> > 
> > This assumes functions.sh is in $CWD.
> > 
> 
> Good point.  In the past, I've used something like:
> 
>   SCRIPTDIR="$(readlink -f $(dirname $(type -p $0)))"
> 
> but I notice that not many selftests do anything special at all:
> 
>   % grep '^\. ' $(find . tools/testing/selftests/ -name '*.sh')
>   ...
> 
> only the perf tests do, and they use ". $(dirname $0)/..." so I'll use
> that convention for these tests.

Indeed! I'm for following the crowd.

Thanks for putting the scripts together. Good job done!

Libor
-- 
Libor Pechacek
SUSE Labs
