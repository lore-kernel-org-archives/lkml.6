Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA79B2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A10KIFpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA79B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeHaIar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:30:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34047 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeHaIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:30:47 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so9451372iob.1;
        Thu, 30 Aug 2018 21:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AokSjKPbdSmG3ItrzteFsFxkiINe4RGQvUjh2ZGgnw=;
        b=A10KIFpmOo7Op6PrvGJLQ132AGWIndOWITrIukBs24YRpHxspBAOa+R+jty9ctwUy0
         iuXacOfO0Pn0uMG5zYMP3K2vp1bJEmBus0erIkkku4jFwfGR8gEo9sWoaWG/PhPe0Mac
         iynAMKVY1LfItBDFtVZ4qCXCXc1EltSriZQ+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AokSjKPbdSmG3ItrzteFsFxkiINe4RGQvUjh2ZGgnw=;
        b=napINGzpvtWxavL9Gy00tNgVmFUZ5ocrmdONUqR+6mJeVRG/jOt6yOQdsBMgaCwc90
         Aewl1znu9Uf8wc6GjClSbaWEAfgMxTQTKcQ95Y09vpgzW2wRESRM//4drDg6LAlVwDVO
         TVlY/gkMEWRxOpKaDpPoxjt8TWKsvQ9bNjaR9S4rM1Bl5i6dhrn2AO681nQ32Xgi+fT4
         IxKXXiQjiMiLl7Wsrx47vFt/0lvT6yayevZHFVVZI/2HqDpGiSWCQSDV5mBLX9/SAMRt
         aSivZCZtKWd+RGIBWZnvcb8A9/UjTTEHCJaM1Ko1rFmbYXlxZs8cCLhfJZVqjEpuf+Dd
         xPKQ==
X-Gm-Message-State: APzg51BY1YewwOAzB0p0/gJYYwjJjxxVHd9HjqL5zRjraY5baOTIhg7F
        NuTE5m5H6AmSAkl0naXJgLajqT5x60Xxm6hb5JQ=
X-Google-Smtp-Source: ANB0VdaPuqVtEI1ScJ1IWfFODfRirMtRluA247Ye3/So7uYSyWQ9Qzt/Ejon2ukpJEPmtbmhRuaIqG7t2+koJuAyWwA=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr11522384iop.238.1535689514236;
 Thu, 30 Aug 2018 21:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180830214517.29372-1-tony.luck@intel.com> <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
 <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
In-Reply-To: <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 21:25:03 -0700
Message-ID: <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:49 PM Tony Luck <tony.luck@intel.com> wrote:
>
> Just checking "do we have a non-canonical address" at the bottom of that
> call stack and flipping bit 63 back on again seems like a bad idea.

You could literally do something like

    /* Make it canonical in case we flipped the high bit */
    addr = (long)(addr<<1)>>1;

in the call to clflush and it magically does the right thing.

Pretty? No. But with a big comment about what is going on and why it's
done, I think it's prettier than your much bigger patch.

I dunno. It does strike me as a bit hacky, but I'd rather have a
*small*  one-liner hack that generates two instructions, than add a
complex hack that modifies the page tables three times and has a
serializing instruction in it.

Both are subtle fixes for a subtle issue, but one seems pretty
harmless in comparison.

Hmm?

But I'll bow to the x86 maintainers.

             Linus
