Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1551978-1522892937-2-1713733939247319822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892937; b=jcX6r388m8s3x8drOno11FeKYL6ROFFlF5BblMYskRoEoHcFbP
    gDcQ9B32+rULmBm3K8SAjyk8eNVmQogplkQVmdhKYXCIgZJADT40B124lmXeB8tE
    rhKIeN6mSguow+D3Le6WDGuNyzA2vW3r1iqikV4604ZNVWwUDsir2fXJlA1qy3/h
    VERjgldYHeVbaeTAQOZ1fs/wOHWBfh9r19M7lJ3m6iMb+59P0JLJjUPhT8SOOgtG
    3n/2R5Avx+a7dG766AVKUdms93TCb3B/n65W5EqdShpe/5P98snzDU0BENGHx4T8
    CwY5e/4k9JKZ6RswfCyNn8lEaWQy1V0io+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522892937; bh=+LSQRjZYggpV2bjdMjAY7tZ5TXw5KQ
    Oaxi4ruBdaf3A=; b=T6Ttb8lKV2zSa0KcSqqEz4tvi2yhCuQ5Ft/AVzypqlMKkk
    r4QxcZxMTTjzn0W/E13rFGTr+F8cdjY5BT2lSMBxmg5FIbNPaRp0Hhi20BVkaA9G
    syWM/AtiaxKnsQCeFF2aczcOF1NncKYbu+KF4vpSD+QtaWJeNXnHZYQKcGSJW06Z
    emZ7Pt+ojMBzo3ehgCzHGsrx7XYcDc/CfWCSS8jXrkXge0C3KhTwZYlIYyM2NL3Y
    HgM82V/jfwjqC6W6PbfceHDrlV6YCHe3w8dD353LA5jt4Y5h2lorlV5BzauwH6x7
    laNmGUnXW6V3A5x2b9H2maaOu3v1kYDbNwB33aIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMFzGlJ+E9r01rPvvobBdokGGq/a5Cjlo/ZVaejYdXUpmI/5l5mQwgZGsAJ0bp/qU06AKMDblGBkslK/lKuvwuCl7FlgvR6aErmw/7MedqnOLxEsZKHg
    l/F8H+k8i8c8A2jSrtGVndDvuumwzcbN1Xjkm6uy8X4jQGYN70Ldf78XVSR8qRsV2ICKvvfb604bz4u2/10sF5bi7OQpyYIPKwbUHNeuc9lHfSb8EkOe3JYc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=hcKa7B41ueMZnoVtdnkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeDEBsy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:48:54 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:44983 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeDEBsy (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Wed, 4 Apr 2018 21:48:54 -0400
Date: Thu, 5 Apr 2018 09:48:20 +0800
From: joeyli <jlee@suse.com>
To: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
Message-ID: <20180405014820.GB7362@linux-l9pv.suse>
References: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com>
 <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk>
 <15406.1522880367@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15406.1522880367@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 11:19:27PM +0100, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
> 
> > > Uh, no.  bpf, for example, can be used to modify kernel memory.
> > 
> > I'm pretty sure bpf isn't supposed to be able to modify arbitrary
> > kernel memory. AFAIU if you can use BPF to write to arbitrary kernel
> > memory, that's a bug; with CAP_SYS_ADMIN, you can read from userspace,
> > write to userspace, and read from kernelspace, but you shouldn't be
> > able to write to kernelspace.
> 
> Ah - you may be right.  I seem to have misremembered what Joey Lee wrote in
> his patch description.
>

Sorry for it's my fault to misunderstood the behavoir of bpf with
CAP_SYS_ADMIN.

Joey Lee
