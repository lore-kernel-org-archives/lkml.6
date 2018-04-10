Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/dXHayw89bgWyD8kz5WXIHxUIn9+61jAZ1Xi4gLFEAtC82uuCzrAjU+7bUegzBt/ejUDI+
ARC-Seal: i=1; a=rsa-sha256; t=1523396037; cv=none;
        d=google.com; s=arc-20160816;
        b=n3KwxsA9TDk6jg1e4ziyPzmjT9BnK96gWWp85b9GODpR591JaJNQNWG9iyMH/VEgtU
         IUbXGklPtT/SVWLk6QTumghnSdPqgvtFSQ1lNTAeLG1KZm6RGpxcHPBvghLJL7DOOIcQ
         wGHEpyP4GOdYWiE5LWoO7l6HJ2867JFnUfFPjl1qB3++3x0Nr/YNp4CidW7zf0VE6oVH
         BSWRZCOlH5q3Xcl5rXFyNRC2UA1Y3fA/Aj9Q3fWjYFglxeBbDc1LXqumFNdvgt4U2PzV
         9M0IbB546vUQI8AQfACLc3+RblVU4O0sy08qnKhqjMCFOldj2bwCSCpOGyZmF1q37SBr
         vPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=f8B2Uk5hrM+xJaWzkFzJ7k8HQ4QhXhvPqnopxQyx6w8=;
        b=olvCFkY/7aIM5GShuUGWX9cqWoYCsVEYYGlCpGBcPXvOp9pTxbj+wRJk371qo/H7Fq
         LEYOjriOqKwMxKnftlBnp7asVkzyiPrPNRzZmDX0YKqYaBTQCMktH5rCgufErNRlDGJX
         GLuxSvI0mGW/BkmnIWoOzidwdD00x5omD8d2nvsuelBs0VFYraoTYFBjNqrFJDZ7s7X1
         i1w2RYTsa7yVat1uO+epMWpKMvvI4KCKiKaInRuJSBvMPiSxyjEeq5xOKDLYfuV64PON
         y3ViBRnsk/EBVy1rc6+enoUN3BB1/KSOJAagm+BP/+7kvKSZIEzPySA6Dr2vLCyINpWl
         RshQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDJVd4 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 17:33:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751770AbeDJVdz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 17:33:55 -0400
Date: Tue, 10 Apr 2018 16:33:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] selftests/livepatch: introduce tests
Message-ID: <20180410213354.ma5wfe3jc23pzmw4@treble>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
 <1523373354-10801-2-git-send-email-joe.lawrence@redhat.com>
 <20180410200059.loy3hw6tcwdi4m5z@treble>
 <daac17e1-6e32-fce9-51b0-24ec25bda69f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daac17e1-6e32-fce9-51b0-24ec25bda69f@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372767626625774?=
X-GMAIL-MSGID: =?utf-8?q?1597396523988505912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 04:50:51PM -0400, Joe Lawrence wrote:
> On 04/10/2018 04:00 PM, Josh Poimboeuf wrote:
> > On Tue, Apr 10, 2018 at 11:15:54AM -0400, Joe Lawrence wrote:
> >> +static void test_klp_shadow_vars_exit(void)
> >> +{
> >> +}
> >> +
> >> +module_init(test_klp_shadow_vars_init);
> >> +module_init(test_klp_shadow_vars_exit);
> > 
> > For this last line, s/module_init/module_exit/, though I think the exit
> > function can just be removed altogether?
> 
> D'oh workspace / git user error, I posted an older version :(
> 
> But the exit function seems to be required if an init function is
> provided.  Here I omitted the exit function:
> 
>   % modprobe test_klp_shadow_vars
>   % lsmod | grep test_klp_shadow_vars
>   test_klp_shadow_vars    16384  0
>   % rmmod test_klp_shadow_vars
>   rmmod: ERROR: could not remove 'test_klp_shadow_vars': Device or
>     resource busy
>   rmmod: ERROR: could not remove module test_klp_shadow_vars: Device or
>     resource busy
> 
> and from kernel/module.c
> 
> SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>                 unsigned int, flags)
> ...
>         /* If it has an init func, it must have an exit func to unload*/
>         if (mod->init && !mod->exit) {
>                 forced = try_force_unload(flags);
>                 if (!forced) {
>                         /* This module can't be removed */
>                         ret = -EBUSY;
>                         goto out;
>                 }
>         }
> ...

Hm, ok, though that seems like a weird limitation...

> I missed Petr's commit msg note "that the constructor is called under
> klp_shadow_lock."  I'll convert the test to use GFP_ATOMIC for this
> allocation.
> 
> I'll also add CONFIG_PM_SLEEP_DEBUG=y to my test VM kernel .config.  Any
> other debug option suggestions?

I think CONFIG_LOCKDEP is always a good idea.  Otherwise, I dunno...
Here's my .config:

  https://paste.fedoraproject.org/paste/cnM-J18uVWJrxz2DAdSchg

-- 
Josh
