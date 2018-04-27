Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524812674-2-9054794037510822335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812673; b=URb5xivOewjK5zhmcKRvpw2uSBCkKMAo7tpdV74uRjV6CH5IKX
    pjWwCtEGfaygSk1Q/Is1Th5JyajeC1/jx9K7q4Wai4mlBe50zHNKatnpEFfdMADl
    nwlBLNmF55GceJF5m+kKHz09JjI69SIOMohSjaPBhF2nwtXYTcTY9hiaVvD4X61P
    BfajTb7uwwGhLVDNpS7+2XPD9JckUOtVt59KwFHy/EAA6U6yMHTDhXfI1fHcGHbk
    ajQHiVM0K7TqnUdoxeeve7EJtSc29plhWOHDy8+ER32/eZvBNNjb5USUXRNgqAxl
    8jLnMH14CEaoKOarHMdeAfh5PQ+RgXx3DRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812673; bh=wX8b3l75BgrZY39T/sIqw9vAlX5hN2
    Rztl73PW1DlsM=; b=H+ZWl1JZT7Z0lxmYiIRgYJGxASk6pgUSrgnIM0g1qIB/fw
    luzREuEb8xykCsA7l9MDXrWWeTBObvzvRSixGn6BFHxLUgu7G1tYPYGG0oQnil8P
    OxFoCi2eA0TenSfTU7bZQCGLKj9U0755G7zZR2P79WRtyxP1HrSJ4R3ljk5vGKfq
    wsjixhhm+MkaAvNCXIk+1h4wvJNYi3XW0I8aVz2AGB5UoknKzR0SQreLoC3tZPFi
    kbSPTqen9AwmuISjXn9stFLg71iPf1IyHGcQ9zcZwnzcGOJhA5GYhS/xOl/b6BRk
    LCBeAzkqKQMMsOptaOP/OyX2OBjwF82EXPTByJgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JaLNpypT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZN3pCYr0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JaLNpypT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZN3pCYr0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI4PGO6L68WJkqGfA1kG1vYiqb+iqfPGiKckBes1pT+/1JBcUmsu9Iql3t92IbLb4yjvY+SxDMlU4d/8jEnxPL8SiMMFtIa6E8pE/hlXaBOMERLkDb+V
    DYwp3kyBQYS9gQF9uVCMKEe7H+GnfsYAv7MrW2EhU+WPHlbhiRqlhQdhEP+bTN1r0iubsulPcc6wMko+H2AUW9Sz6t+wnYT70GilBTzatfMBR7NL0uZSpxQo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lpJF-rWiaW36qJbeeckA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757457AbeD0HER (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 03:04:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38012 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757367AbeD0HEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 03:04:16 -0400
X-Google-Smtp-Source: AB8JxZpf5PnN20gSYQvWTGHt5BdO8sGLKQ1dqogMeoP6lDfoYkeBG7CkO0RoepQXJJU8l9FE0kPIuw==
Date: Fri, 27 Apr 2018 09:04:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20180427070412.utb5e53zbnajcfv2@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481120919.22588.16126591608892708741.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152481120919.22588.16126591608892708741.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the blacklist file indicates a sensitive address
> information to reader, it should be restricted to the
> root user.
> 
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ea619021d901..51096eece801 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
>  	if (!file)
>  		goto error;
>  
> -	file = debugfs_create_file("blacklist", 0444, dir, NULL,
> +	file = debugfs_create_file("blacklist", 0400, dir, NULL,
>  				&debugfs_kprobe_blacklist_ops);
>  	if (!file)
>  		goto error;

Note that in a typical Linux distro debugfs is already root-only:

  fomalhaut:~> ls -ld /sys/kernel/debug
  drwx------ 28 root root 0 Apr 23 08:55 /sys/kernel/debug

but this change might make sense if debugfs is mounted in some other fashion.

But the patch looks incomplete, 'blacklist' is not the only word-readable file in 
the kprobes hierarchy. The kprobes directory itself, and the 'list' file is 
readable as well:

  [root@fomalhaut ~]# ls -ld /sys/kernel/debug/kprobes
  drwxr-xr-x 2 root root 0 Apr 23 08:55 /sys/kernel/debug/kprobes

  [root@fomalhaut ~]# ls -l /sys/kernel/debug/kprobes/

  -r--r--r-- 1 root root 0 Apr 23 08:55 blacklist
  -rw------- 1 root root 0 Apr 23 08:55 enabled
  -r--r--r-- 1 root root 0 Apr 23 08:55 list

So not just the blacklist should be 400 but 'list' as well, and the main kprobes 
directory as well.

Thanks,

	Ingo
