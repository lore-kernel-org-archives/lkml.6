Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447271-1520560717-3-5797974849474787550
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520560717; b=L3Lv9Nr9Ig7PrkcCXcXRZj6syb0UOD61S3EfG5MVpHgE7Yq
    ZuYq1WPUEkULr/cEFLNacS/LUEtT09ifzJh2zhqzVUSguSw7UAgaeReLLabaz8bN
    ZEdF5vko21CLMnS2AmURk3G9KttpjzvGLAFw8+TFdjEQiVsbGIcFmv2y1kmtZf6m
    nKjrHGoK5tiBgqQ9nKnTQuZt+PFEB7qZhpSOSKVPEcdA73j/bZw9MKaSO9xOLWYv
    F/IBwYIVyDIKGg2sRnyWpzMfWWLoRrotDYKYqknyB9jBR8kzEXaFy7r2khnAj5wB
    rAaVdZcRWuCGYejIKefd7eEZnxhTPirQSNHWhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520560717; bh=1vywC9fxzj6NoBHd/cNmdvKwKU
    6zSW7jOGZisQYZo1M=; b=PzoT9LLi+D9hjJpoWmwbsUwFw0YkrXRJGd6PiLja1C
    H1KilqC1bmjT1Muxu4G1P+k/gS3KjWP4d7955uMDg6vtLidpRDYSBvsVu8ZFjWbY
    1aCxOjd8/mf6+OlZ8Uc7EP6NojXpC7IFCc3XPRilBm8WW3qOsyB7mh1sCMPaWfJH
    RB4L4BSCnMyQUxpWFh6x/I7vDBaExSXA7DZlJlXT4TxRppQ2XHpyueJEyKci6BM2
    inyltSYgu94jt6B7M92KqR6C0WpWffzJs/pjoh565qgXxttsCdIwaaJPEesB0hTb
    4SuXRFPtQDYrkq3LfVjsZG2GhfFtcCzWJ4Ly7G4S51Qg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIB6d (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:45053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeCIB6d (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 8 Mar 2018 20:58:33 -0500
Date: Fri, 9 Mar 2018 01:58:30 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Alexei Starovoitov <ast@fb.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180309015830.GO4449@wotan.suse.de>
References: <20180306013457.1955486-1-ast@kernel.org>
 <20180308012353.GO14069@wotan.suse.de>
 <d83869b4-260e-179d-d469-83b8d8068399@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83869b4-260e-179d-d469-83b8d8068399@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 03:07:01PM -0800, Alexei Starovoitov wrote:
> On 3/7/18 5:23 PM, Luis R. Rodriguez wrote:
> > 
> > request_module() has its own world though too. How often in your proof of
> > concept is request_module() called? How many times do you envision it being
> > called?
> 
> once.

What about other users later in the kernel?

> > > +static int run_umh(struct file *file)
> > > +{
> > > +	struct subprocess_info *sub_info = call_usermodehelper_setup_file(file);
> > > +
> > > +	if (!sub_info)
> > > +		return -ENOMEM;
> > > +	return call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
> > > +}
> > 
> > run_umh() calls the program and waits. Note that while we are running a UMH we
> > can't suspend. What if they take forever, who is hosing them down with an
> > equivalent:
> > 
> > 	schedule();
> > 	try_to_freeze();
> > 
> > Say they are buggy and never return, will they stall suspend, have you tried?
> > 
> > call_usermodehelper_exec() uses helper_lock() which in turn is used for
> > umh's accounting for number of running umh's. One of the sad obscure uses
> > for this is to deal with suspend/resume. Refer to __usermodehelper* calls
> > on kernel/power/process.c
> > 
> > Note how you use UMH_WAIT_EXEC too, so this is all synchronous.
> 
> looks like you misread this code
>
> #define UMH_NO_WAIT     0       /* don't wait at all */
> #define UMH_WAIT_EXEC   1       /* wait for the exec, but not the process */
> #define UMH_WAIT_PROC   2       /* wait for the process to complete */
> #define UMH_KILLABLE    4       /* wait for EXEC/PROC killable */

I certainly did get the incorrect impression this was a sync op, sorry
about that. In that case its odd to see a request_module() call, when
what is really meant is more of a request_module_nowait(), its also
UMH_NO_WAIT on the modprobe call itself as well.

In fact I think I'd much prefer at the very least to see a different wrapper
for this, even if its using the same bolts and nuts underneath for userspace
processes compiled on the kernel. The sanity checks in place for
request_module() may change later and this use case seems rather simple and
limited. Keeping tabs on this type of users seems desirable. At the *very
least*

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 40c89ad4bea6..7530e00da03b 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -37,11 +37,13 @@ extern __printf(2, 3)
 int __request_module(bool wait, const char *name, ...);
 #define request_module(mod...) __request_module(true, mod)
 #define request_module_nowait(mod...) __request_module(false, mod)
+#define request_umh_proc(mod...) __request_module(false, mod)
 #define try_then_request_module(x, mod...) \
 	((x) ?: (__request_module(true, mod), (x)))
 #else
 static inline int request_module(const char *name, ...) { return -ENOSYS; }
 static inline int request_module_nowait(const char *name, ...) { return -ENOSYS; }
+static inline int request_umh_proc(const char *name, ...) { return -ENOSYS; }
 #define try_then_request_module(x, mod...) (x)
 #endif

Modulo, kernel/umh.c is already its own thing, so pick a name that helps
identify these things clearly.

> and the rest of your concerns with suspend/resume are not applicable any
> more.

Agreed, except it does still mean these userspace processes are limited to
execution only the kernel is up, and not going to suspend, but I think that's
a proper sanity check by the umh API.

> bpftiler.ko is started once and runs non-stop from there on.
> Unless it crashes, but it's a different discussion.

Sure.

  Luis
