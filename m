Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-147225-1526668144-2-3603917088374922724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526668143; b=PlncMzjKbYZClYIpB2SSo3FP73Th+jfzMuHJD0GJe59JCqu4/9
    2h+gZLxSOPdMvmlXL6ru0Ee84Xo1bl0GnFRyKsdUp/0RraGMPSEjZd3GUSF6tZPu
    j5R5rSAJV37S1XkXyeL/cN0QY35rQFqc8E6DsIZBzkFpCHDvb+zb7wvjAIqj/1y2
    908GQL5Z3lbz6G+VuQKLOovwy8qzvahT/71cNdB6uJ1b2QvCqhOIKVijzc82rCnw
    JbaydUU5PIAGPhs1Worfl9Sme0a2aD/+2T9ljiHPV29QKyD5Moz6eFqeOLsk8hgG
    0hsWglbdplv71jvQ/YtzCKVZoy0BSjZXY+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526668143; bh=BJ/YYsuNIbnrU+VciY8vRtjSRRmZS0
    2NlaSW8WmZSe4=; b=CNq5lRx7Dya9YMPoZlUfNaeQ7SQ9Uc6OCP15SR0BtgMYI1
    Y1qmghOMIiCY4RAyietz87MoAnb+SlatkrhOs/XhIIkLBQR8DxhZb1GeeY5BX0w+
    KuI3OejJl3HZGfHszU9O1OigvJKhZ0gACKlWKTc5HIfDCfc7LaRJNoMV5ZfKAnuS
    LweDkiMFhPN7NrueG7ds8IY0AWLnJoym3UuPEIDFsKoj7Yy5pICUagWL/aNiFunu
    O9WrWc+z6Cglu4Kv+Nz11Ix3c5xpUGww/FF+ep7YgjDtwgCJILrIHaWM6cZQDhVH
    X35VyR3iYY5fKPFFXhCH+dfaz/FYqYySSKtkDnEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=o1uaTRdk x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=bT55TyN0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=o1uaTRdk x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=bT55TyN0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNMfwRqE2ykDoybd7F0JqSu9xotEfgTy0r5oM0vBfgUPp56kTcypldJWKpuk4DoR3p3Nz8wrI6uvQspk34O0w7XJTT18gCuz1QVJDI2FzdgHh6IqpB0y
    nM/WkIsv3iuqEBYx2U1nufHYRbjeKqxe9AFa/xoxmV4aJ5NqLWMeSeOiNFRib42GUkJkvyT12dDON/tmQqbwZ7CDYESaQjwo8iwUSTYg8LlvKs7BvNrcMRmq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=4ao_m9BdAAAA:8 a=NajTpMQcntb8chXKuvcA:9
    a=CjuIK1q_8ugA:10 a=MsgbvsnFcLE8lbaOJhbn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeERS25 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 14:28:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42814 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeERS2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 14:28:54 -0400
X-Google-Smtp-Source: AB8JxZo89+bS02WFVy4zTJdJjy1mxrpauAx9GkKlrMX/+M5r0C44StxAq11gEGj2iFgAsG81gXZmQw==
Date: Fri, 18 May 2018 14:28:49 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        peterz@infradead.org
Subject: Re: [PATCH 00/10] RFC: assorted bcachefs patches
Message-ID: <20180518182849.GF31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518174536.ai26bg3bhlvzq4pi@destiny>
 <20180518174912.GE31737@kmo-pixel>
 <20180518180324.ymwbajfw5wsfrlth@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518180324.ymwbajfw5wsfrlth@destiny>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 02:03:25PM -0400, Josef Bacik wrote:
> There's nothing stopping us from doing that, it just uses a kprobe to override
> the function with our helper, so we could conceivably put it anywhere in the
> function.  The reason I limited it to individual functions was because it was
> easier than trying to figure out the side-effects of stopping mid-function.  If
> I needed to fail mid-function I just added a helper where I needed it and failed
> that instead.  I imagine safety is going to be of larger concern if we allow bpf
> scripts to randomly return anywhere inside a function, even if the function is
> marked as allowing error injection.  Thanks,

Ahh no, that's not what I want... here's an example:

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/btree_cache.c#n674

Here we've got to do this thing which can race - which is fine, we just need to
check for and handle the race, on line 709 - but actually exercising that with a
test is difficult since it requires a heavily multithreaded workload with btree
nodes getting evicted to see it happen, so - it pretends the race happened if
race_fault() returns true. The race_fault() invocation shows up in debugfs,
where userspace can tell it to fire.

the way it works is dynamic_fault() is a macro that expands to a static struct
dfault_descriptor, stuck in a particular linker section so the dynamic fault
code can find them and stick them in debugfs (which is also the way dynamic
debug works).

#define dynamic_fault(_class)						\
({									\
	static struct _dfault descriptor				\
	__used __aligned(8) __attribute__((section("__faults"))) = {	\
		.modname	= KBUILD_MODNAME,			\
		.function	= __func__,				\
		.filename	= __FILE__,				\
		.line		= __LINE__,				\
		.class		= _class,				\
	};								\
									\
	static_key_false(&descriptor.enabled) &&			\
		__dynamic_fault_enabled(&descriptor);			\
})

Honestly it still seems like the cleanest and safest way of doing it to me...
