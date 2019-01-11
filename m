Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8819921783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfAKV0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfAKV0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:26:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2D338046C;
        Fri, 11 Jan 2019 21:26:08 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04BCE600C2;
        Fri, 11 Jan 2019 21:26:00 +0000 (UTC)
Date:   Fri, 11 Jan 2019 15:25:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190111212558.r7vfv4djkz7w5wu5@treble>
References: <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111212210.veyfn5vvjswcwacm@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Jan 2019 21:26:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:22:10PM -0600, Josh Poimboeuf wrote:
> b) Adding a gap to the #DB entry stack

And that should be #BP of course...  Not sure why my fingers keep doing
that!

-- 
Josh
