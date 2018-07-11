Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76499C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFF220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbeGKRdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbeGKRdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:33:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A2ECADC6;
        Wed, 11 Jul 2018 17:28:33 +0000 (UTC)
Date:   Wed, 11 Jul 2018 19:28:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?ISO-8859-15?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 00/39 v7] PTI support for x86-32
In-Reply-To: <CA+55aFzrG+GV5ySVUiiod8Va5P0_vmUuh25Pner1r7c_aQgH9g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1807111923420.997@cbobk.fhfr.pm>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <CA+55aFzrG+GV5ySVUiiod8Va5P0_vmUuh25Pner1r7c_aQgH9g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Linus Torvalds wrote:

> It's the testing that worries me most. Pretty much no developers run 
> 32-bit any more, and I'd be most worried about the odd interactions that 
> might be hw-specific. Some crazy EFI mapping setup or the similar odd 
> case that simply requires a particular configuration or setup.
> 
> But I guess those issues will never be found until we just spring this
> all on the unsuspecting public.

FWIW we shipped Joerg's 32bit KAISER kernel out to our 32bit users (on old 
product where we still support it) on Apr 25th already (and some issues 
have been identified since then because of that). So it (or its port to 
3.0, to be more precise :p) already did receive some crowd-testing.

-- 
Jiri Kosina
SUSE Labs

