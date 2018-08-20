Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E9AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E62174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O2QqAI3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02E62174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeHUC4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:56:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36128 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUC4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:56:23 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so1813158itp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjEsfVyuJd5rTmCZtHxvtZNrn1SA283X6hI5rQe2lQo=;
        b=O2QqAI3a+2jjZqZ4G4h7BPBiicivLZk9zK/jp9w214sxJFIh8D0gI+l97txYufz399
         F1rxIcBH6j1Sl6fUc5Nuhr5Hp0PiNSK+JDRh71yCeGmd2ecaeAT+uaWYcs9eO5dcVX59
         Kg4FOTCP+zusP2MPu4EyLchE90sM/bPP2hNFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjEsfVyuJd5rTmCZtHxvtZNrn1SA283X6hI5rQe2lQo=;
        b=WClezOi6P/+LD7PqlGC60j+pw6z84Widfib+FBYxqd+7oUs0QKZfsq2gPmQ9EwNHx3
         xPj61JT4AjfIebiTMWcmfjvqLpjPfCwfcUbp06OX+8pOXbuXg/VgNWkcuWwYSW0aftd+
         MDaxNu5i5S5kZWL73yIlLH94ho+S1SlQTEavtTB4zn5TqJOXen1A/qATMfx10qBaQiu4
         WdrmeWqXCEM7UEAnIdeAmdt832rZKj+kFJXEYyEbiPWOYCRioogpKvi1rcs9rQx+cLmd
         kXtD+d7Eq/y/lqdD6DPbTKL3z9fdIEsqAjhItu4o0dX4Ss4UDRk+lq0tUqCQwn2U/RQH
         ya7A==
X-Gm-Message-State: APzg51CO5CzddKhiTVIlKTNG0SJ8syMKBI5BjYmlEH+KOk0er9yzs419
        30fj6x0LMhP2bXhOYoIa/IbfADfwUvZomu/WXJI=
X-Google-Smtp-Source: ANB0Vda0RhuexnaRrPsEC3+ngqXGYRoQSZFX6IrZZhvPKo5KIp6F0SlDeH75QGg0s2ZvKGhs3q5JzBogIu+Ftoa2PAQ=
X-Received: by 2002:a24:1d0c:: with SMTP id 12-v6mr1231580itj.9.1534808322488;
 Mon, 20 Aug 2018 16:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180820212556.GC2230@char.us.oracle.com> <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk> <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <20180820223557.GC16961@cisco.cisco.com> <bd148fb6-e139-a065-1bf5-8054f932d30a@intel.com>
 <1534806880.10027.29.camel@infradead.org> <dd9657d2-f1c1-630d-4cce-7f1c67a968d6@intel.com>
In-Reply-To: <dd9657d2-f1c1-630d-4cce-7f1c67a968d6@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 16:38:31 -0700
Message-ID: <CA+55aFxGpX_W_B8aiV7dWFj5=wckTSiQ4nzVx-moonO5t3e6Lw@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>, jsteckli@os.inf.tu-dresden.de,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 4:27 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> You're right that we could have a full physmap that we switch to for
> kmap()-like access to user pages.  But, the real problem is
> transitioning pages from kernel to user usage since it requires shooting
> down the old kernel mappings for those pages in some way.

You might decide that you simply don't care enough, and are willing to
leave possible stale TLB entries rather than shoot things down.

Then you'd still possibly see user pages in the kernel map, but only
for a fairly limited time, and only until the TLB entry gets re-used
for other reasons.

Even with kernel page table entries being marked global, their
lifetime in the TLB is likely not very long, and definitely not long
enough for some user that tries to scan for pages.

             Linus
