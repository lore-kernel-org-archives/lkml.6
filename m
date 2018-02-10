Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-490242-1518290064-2-5977706644691146772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518290063; b=tbXkNEVegBghN4e/M+rQhmZjXYhx/HGe25VlczX43/m15m6
    FCcocVJ/DQiv8fA7Z0cyviQbp17UtBnl10isJmg0gPQdH9ESa8pCH0w02wJ2+5qH
    90Gf2m4a5PCZsNWzd81EGczqgJaQYh5PUX9E2Odfi9MZsMKMjLCcv8TOqp1JKuMd
    /eetXVoKvD5kUaej0awktZNalKFAWy8rhhAYRZsM6uPbuiIMFisaNglnzAlnRtGG
    1tGhiCZ20VbTnHpLZEoL8+e/PG+gwgo2HueOlu+57q8rBCorrlPK5Rjpg1y0/WQt
    zVPlrdGL2ReM3gZ1nlJSvUSCzCOkeVRvNhXlXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518290063; bh=oHsvJ1O9zTjMhbZWuzqCN8kPjMsBy3od1C77YB
    7DioA=; b=lgyQsZ+f3H6UfTiT0pM2DON+pjdqliWG8im3l6HIVZZBSHZmP0jgAi
    QednN6p5w86wbjj1fDq+f5N/lx7q+f+Z/kggfPAiUATu9ukbDEe0NptjZGnhasCU
    1ygZ39ilqwKpGUlRo/vdCu7TjE1fFaAJUy+P1vyzrCOdCQPY8e8T+E28ivIWHbkv
    ADPG8AOWFzNlv1jKKtl6ndmC+8iVSSr8LYsw4Fd8ovNriEXMwUoI+20CNMvZvOiX
    fBVKA5OzxaMvFySRcit8tD6Zr0N65TyX2gBODmThGFsmzh3Rd0uByB2vkGJ9qylW
    S86eY9W/7Gp/OGNFqV5VrBVn4OwPfFkw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=R4LbO5EG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=miNwPIIg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=R4LbO5EG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=miNwPIIg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBJTOU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 14:14:20 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37721 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBJTOU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 14:14:20 -0500
X-Google-Smtp-Source: AH8x227088+Q+7r9y6g8LpygANh+KVU2vxdmlqtflFdJ9/PSoOLFAWlaayo/Ry2ealyD1H9Bt/4Zeoihl2wAQV3a5bs=
MIME-Version: 1.0
In-Reply-To: <20180210072340.GC8814@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.472824776@linuxfoundation.org>
 <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com> <20180210072340.GC8814@kroah.com>
From: Kees Cook <keescook@google.com>
Date: Sat, 10 Feb 2018 11:14:18 -0800
Message-ID: <CAGXu5jK=46Oz63Q5rPbDuGzGxDPFpx5asE3-RLunuvQkEsF4cA@mail.gmail.com>
Subject: Re: [PATCH 4.9 46/92] x86/alternative: Print unadorned pointers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:23 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 09, 2018 at 02:01:32PM -0800, Kees Cook wrote:
>> On Fri, Feb 9, 2018 at 5:39 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > 4.9-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Borislav Petkov <bp@suse.de>
>> >
>> > (cherry picked from commit 0e6c16c652cadaffd25a6bb326ec10da5bcec6b4)
>> >
>> > After commit ad67b74d2469 ("printk: hash addresses printed with %p")
>> > pointers are being hashed when printed. However, this makes the alternative
>> > debug output completely useless. Switch to %px in order to see the
>> > unadorned kernel pointers.
>>
>> This missed a "Fixes:" tag so probably missed automated checking on
>> how far back to port this. It shouldn't go back beyond 4.15 (where
>> ad67b74d2469 first appeared).
>
> Good point.  Should we instead be using %pK for this change instead?  Or
> should we just backport commit ad67b74d2469 to 4.14?  :)

ad67b74d2469 is pretty disruptive, I can't recommend putting it in
4.14. I mean, I think it'd be great, but I suspect other people would
find it very surprising. :)

I would just revert this commit from kernels earlier than 4.15; this
%p usage is in debugging, so %pK doesn't make much sense here.

-Kees

-- 
Kees Cook
Pixel Security
