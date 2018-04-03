Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-86314-1522715840-2-16352731555964303632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522715839; b=RadVgH3SUhgMhuWJZ5nWNx8A11/dvSBeuIbnxC0G2hsmI0lioW
    6kPBGF/4l0MsPYU5bvNM10wWvLABTHWI8FAtU/9aA2+GLaTZnKHPhwSzT4b9Ms5+
    Y6C8QtAmOPMKnFlZlPYiaraGXtAs546k2sPjhXJcpuf17zMyTWSZ2Px2HRz+Xyqt
    Nk+JBf6bB1/TRE7xspVUa3hbDPz1oYZ7N5ZVmK4AIWHUMCJKj2kBbMq4gr+lnDQH
    Tot05phNh4mm947+FwQVekyCwCBZ2EZiP/YW8ge8F7OKHbSVbuiAxBRHg7WXKHgY
    aLWsnSfux6BHM8EJnT4uFe+Q6YR4Oge+/SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522715839;
    bh=3Y/syECd6jPsKqQ4sDekcb4Poc7li1StKyKBu5RNDuo=; b=F85PL0VEe5TV
    DX8Zs2WqrwWp8TzTzNtvBY6J4mprom5WcdE0ObZANnaqMCu+g73DHlzoUqS1P2ad
    uJov0DXXYiE358SYQVekS0J/cl65h9+gUpOdxnRpOFUe0YTbs6XW7f9YI5e190fu
    BS4fjEgZAds7kbaeyHy8WuZW+cXKZ/BPyxsemozrU6Kz/1AANYzxDZj/caiVaTkw
    X1He3rCzWOKEAXO4Nh4nE+WEeXE8Zd04SpLlEzXc6bK4olI7Jotx1MouJEZ0JICE
    PweSjaWCohEJriBQ7+/nuC8LoieILtSszrYH4KngurSdSgQ8JX4xJIfCwWITxr9I
    s+thQ5aCDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMB7E6OErh7b2Vt4jpgK9c+uRQEnwgVIPqmj7bs5cAXa9PImqrlRaCCpJ0xTSgOPuyU5cZBtnLW3SAEoAz6DJi/1WJbxd+OA6FXwbN0EOOXxacCsIjpS
    KKzWEaoCdO/BNiuQkxGImcu/e1qwnoWY821HIqH7nGIca3AxhW5Ho/BAYLhxh4Uw6QLxbP3Hu7hgnjqaVhWv0WDtv+oLEcoB0/mPCukVJTM3eEz9uNeu/0EP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=EhmgoRYYKgDKCxrPtzoA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbeDCAhR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 20:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754662AbeDCAhQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Apr 2018 20:37:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277A42178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>
Cc: gnomes@lxorguk.ukuu.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mjg59@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jforbes@redhat.com,
        linux-man@vger.kernel.org, jlee@suse.com,
        linux-security-module@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <4136.1522452584@warthog.procyon.org.uk>
 <alpine.LRH.2.21.1803311145180.7769@namei.org>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
Date: Mon, 2 Apr 2018 17:37:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1803311145180.7769@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/30/2018 05:46 PM, James Morris wrote:
> On Sat, 31 Mar 2018, David Howells wrote:
> 
>> Date: Thu, 26 Oct 2017 17:37:38 +0100
>>
>> Hi James,
>>
>> Can you pull this patchset into security/next please?  It has been in
>> linux-next since the beginning of March.
>>
>> It adds kernel lockdown support for EFI secure boot.
> 
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> next-lockdown and next-testing
> 
> Are there any known coverage gaps now?
> 
> 
> 

This is an attempt at a review.  I'm replying here because I can't find 
the actual relevant patch emails.

Cover letter:

 > Here's a set of patches to institute a "locked-down mode" in the
 > kernel and to trigger that mode if the kernel is booted in 
secure-boot > mode or through the command line.

I think this is seriously problematic in that it's not well defined.  It 
sounds like "locked-down mode" means "make me feel good about 
something".  For the rest of this review, I'm going to pretend that you 
actually want two features: 
"try-prevent-root-from-corrupting-the-kernel" and 
"try-to-prevent-root-from-reading-kernel-memory".

Also, there should be a justification that allows normal people (i.e. 
those who are not involved in the UEFI signing process) to understand 
*why* this should have anything to do with UEFI.  I can very easily see 
why it would make sense for a UEFI authenticated variable to tell the 
kernel to enable one or both of these modes or for there to be an 
authenticated mechanism for the bootloader to tell the kernel to enable 
it.  I do *not* see why the mere act of using Secure Boot should have 
this effect.

In particular, UEFI Secure Boot should *not* enable 
"try-to-prevent-root-from-reading-kernel-memory", which means that, 
unless you actually implement the split, you should drop a bunch of the 
patches.

In fact, I think the kernel should try to get away from the idea that 
UEFI Secure Boot should imply annoying restrictions.  It's really 
annoying and it's never been clear to me that it has a benefit.

"Restrict /dev/{mem,kmem,port} when the kernel is locked down": this 
should probably split into one restriction for read and one for write.

"Lock down /proc/kcore": should only apply to 
"try-to-prevent-root-from-reading-kernel-memory"

"Lock down kprobes": ditto

"bpf: Restrict kernel image access functions when the kernel is locked 
down": This patch just sucks in general.  At the very least, it should 
only apply to "bpf: Restrict kernel image access functions when the 
kernel is locked down".  But you should probably just force all eBPF 
users through the unprivileged path when locked down instead, since eBPF 
is really quite useful even with the stricter verification mode.

"Lock down perf": how about preventing using perf on the kernel when 
"try-to-prevent-root-from-reading-kernel-memory" is set and not 
restricting it otherwise?

"debugfs: Restrict debugfs when the kernel is locked down": The logic is 
IMO nutty.  Why the 0444 restriction?  I see no reason that reading a 
0644 file should be treated any differently from reading a 0444 file. 
Regardless, I think you should prevent writing or reading depending on 
lockdown mode and add an API so that individual debugfs files can 
override this.

"efi: Lock down the kernel if booted in secure boot mode": you have a 
stray change in fs/debugfs/inode.c in here.  Also, as above, I really 
dislike this patch.

"lockdown: Print current->comm in restriction messages": Shouldn't this 
be folded in with whatever patch added that code in the first place?
