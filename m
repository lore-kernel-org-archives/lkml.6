Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422737-1524844756-2-1595844797298867264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524844755; b=Djigp0ieOWVMPXBIeV5YOnpsWkFhkaq5M5AMotV2XP0ZQJKDxz
    Uhis/KpoXPNMJR/Ey2NhPHa9VlQGcNEdu+6ZzwswXwaMfCOsLMrq59SwdAdjEeCF
    UK4kgu1n2Vr03mQhYry0WoaiZD9n2nFVX3VfPM/+kRAgRastdKTuhnPcbdNv+7yU
    8uND1xGYISv5aN9ODglWxIgVUEX5bDi06RDPYzLxsyndZHYFDmF8DAtR9IN73HJt
    LV9px+X2hnwgUlyIYrhhOaIGZ/jFyOQjs8peDYMmQWLGcQBlgkl7XrOcbUzfntHe
    hX42hiJXItmJssoykv+zo7JAtt/jkkKLfXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524844755;
    bh=bemEEnTAiuTRYuE+1ItFENhzR7tNscVzdkZpNKhD9S8=; b=JOa9DV9ZBwZ/
    FhKn2Qs1/YXeG0s8eAPHZOta4HpbxuIOx6PGdQ57Mf5zgw24dPkup9XPGad7eh5F
    h1tFKbhvrHAoYyjjp72EaBRVRg3kRzY6u0dipZLXtUubQVUhC2O8Ds9GBUHpvpgW
    ZZh6NNobUwej3V0SZ2ZuV5LI6W99rNbi9hpHRZYonHUBQzQFLV2G/ssmod/r2iex
    jiXB95mlnzeROTu7QYn8PhoxowG4pI/ec1SenwN8YQ7y3KDXAYSJ4CrYWv1IOmvU
    8jKsapE3vKc7jhL8m5vdY90ilbdQQHW+ickjXWbqyVJG3dVyhMzi8lHhnBZHfW9z
    rZz/jHrh4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBcsW3nb8EONQfWq8Mxds+XfYEb7Hc5zAa+Nwd5nlyglg+NSzTOcmCzWTkMSDEd0nFIPyY9o4biK+UyPkxEOne96bHI6+YI1ClP3283zZIuAE8LcF/oc
    3wOoAAaeqvkD7GdaOq2POl2klGj1o4JI3bYY8E3bRR6ykNdlo6x8+6MZmUnVErWHGHaRH2tID1AEG3UwzxDI/5v0uoKQx8NordsOLHVnrr95z4GRbfPlS1VD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1AuVUZ6l6WutYQIIjb4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbeD0P6n (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932851AbeD0P6h (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 11:58:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F94521894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 28 Apr 2018 00:58:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/7] kprobes: Make blacklist root user read only
Message-Id: <20180428005831.d80829f93397984cd6899a6a@kernel.org>
In-Reply-To: <20180427070412.utb5e53zbnajcfv2@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481120919.22588.16126591608892708741.stgit@devbox>
        <20180427070412.utb5e53zbnajcfv2@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 09:04:12 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since the blacklist file indicates a sensitive address
> > information to reader, it should be restricted to the
> > root user.
> > 
> > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index ea619021d901..51096eece801 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
> >  	if (!file)
> >  		goto error;
> >  
> > -	file = debugfs_create_file("blacklist", 0444, dir, NULL,
> > +	file = debugfs_create_file("blacklist", 0400, dir, NULL,
> >  				&debugfs_kprobe_blacklist_ops);
> >  	if (!file)
> >  		goto error;
> 
> Note that in a typical Linux distro debugfs is already root-only:
> 
>   fomalhaut:~> ls -ld /sys/kernel/debug
>   drwx------ 28 root root 0 Apr 23 08:55 /sys/kernel/debug
> 
> but this change might make sense if debugfs is mounted in some other fashion.
> 
> But the patch looks incomplete, 'blacklist' is not the only word-readable file in 
> the kprobes hierarchy. The kprobes directory itself, and the 'list' file is 
> readable as well:
> 
>   [root@fomalhaut ~]# ls -ld /sys/kernel/debug/kprobes
>   drwxr-xr-x 2 root root 0 Apr 23 08:55 /sys/kernel/debug/kprobes
> 
>   [root@fomalhaut ~]# ls -l /sys/kernel/debug/kprobes/
> 
>   -r--r--r-- 1 root root 0 Apr 23 08:55 blacklist
>   -rw------- 1 root root 0 Apr 23 08:55 enabled
>   -r--r--r-- 1 root root 0 Apr 23 08:55 list
> 
> So not just the blacklist should be 400 but 'list' as well, and the main kprobes 
> directory as well.

OK, I'll mark it 0400 too.
For the kprobes directory, as Thomas pointed in the original thread,
that is currently debugfs API's limitation.

https://patchwork.kernel.org/patch/10364817/

We only have debugfs_create_dir() but it doesn't have "mode" flag.

struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);

And doesn't care the parent mode bits.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
