Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeA3J6l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:58:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeA3J6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:58:39 -0500
Date: Tue, 30 Jan 2018 10:58:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] objtool: Don't print '.tmp_' prefix for .o files
Message-ID: <20180130095831.GJ2228@hirez.programming.kicks-ass.net>
References: <cover.1517284349.git.jpoimboe@redhat.com>
 <3788b5aec1c279184b78cdbd8b520903c0fb8a80.1517284349.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3788b5aec1c279184b78cdbd8b520903c0fb8a80.1517284349.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 10:00:42PM -0600, Josh Poimboeuf wrote:
> With the following commit:
> 
>   2a0098d70640 ("objtool: Fix seg fault with gold linker")
> 
> ... objtool warnings started showing the modversions '.tmp_' prefix in
> the .o file name, like:
> 
>   arch/x86/mm/.tmp_mem_encrypt_boot.o: warning: objtool: sme_encrypt_execute()+0x48: indirect call found in RETPOLINE build
> 
> The prefix is confusing.  Remove it from the printed 'objname' variable.

This patch actually tripped me up today. Turns out I have both:

 build/kernel/sched/core.o
 build/kernel/sched/.tmp_core.o

and ended up staring at the wrong file and going WTF because the offsets
didn't match.

I much prefer the actual real filename printed. Yes the .tmp_ crud is
weird, but at least its the real file.
