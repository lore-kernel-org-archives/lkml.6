Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeBTHhS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:37:18 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:50525 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeBTHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:37:16 -0500
X-Google-Smtp-Source: AH8x226RMt7rnrnE82gSRmNXv7AASqNnK5PQ/j6PlJb6mkM5XooPxYMOuoj7mCejlCTYy48XDgwsjg==
Date: Tue, 20 Feb 2018 08:37:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org, brgerst@gmail.com,
        luto@kernel.org, torvalds@linux-foundation.org, ak@linux.intel.com,
        tglx@linutronix.de, dan.j.williams@intel.com
Subject: Re: [RFC PATCH v2 5/5] x86/entry/64: open-code switch_to_thread_stack
Message-ID: <20180220073712.6kfoxc4pet4o2cgx@gmail.com>
References: <20180218123116.21334-1-linux@dominikbrodowski.net>
 <20180218123116.21334-6-linux@dominikbrodowski.net>
 <20180219143417.jsry72fehkbvz6gs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219143417.jsry72fehkbvz6gs@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > -.macro DO_SWITCH_TO_THREAD_STACK
> > +/* 8(%rsp): ~(interrupt number) */
> > +ENTRY(interrupt_helper)
> 
> "interrupt_helper" is a bit vague, how about "interrupt_entry"?  That
> better describes its purpose and also makes it more analagous to
> paranoid_entry() and error_entry().

Yeah, interrupt_entry() sounds better - and the renaming should be propagated to 
the other patches as well.

Thanks,

	Ingo
