Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C6DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247B2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="2HoriVv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3247B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHaFyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:54:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46127 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeHaFyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:54:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id j7-v6so486734qkd.13;
        Thu, 30 Aug 2018 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUgCKjozPJN3EB5eVQST3Bg8RrG5gtE+SD2gAS6kVok=;
        b=2HoriVv3bOHgIYQQfVJJSHUol1XRmBc9FGR7Qt3Qaf7DmVZmzdtuKN1mxiUunsj4jk
         ZhMQfAX+N4p+lI+l9OtIiBi7bh+OtGdpSw05ODcmlOcdUiQvAaOPtoMFIgRYr6uBPxFr
         ZrAOvd7xYenRu6J7/Q8EGQny5y0AXnTuuqy6T7yFS+70a7w1Hq0PGUvwzwdCH6CdNhgP
         68HGQOf76OO0cPD+3VRDhzSbEIHQYvfzqq0WyjRMIydUkqGbTFWtLaALUkYfi1RP6n9c
         Y3EI/qelOnDSqaYZWAIyhedVPk1W5aA4NMtfhm6hQmU2oRVRVKcXrkkRGYK2Arq8Tbpl
         g73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUgCKjozPJN3EB5eVQST3Bg8RrG5gtE+SD2gAS6kVok=;
        b=mi0Ga3e6I4AZXs4IUydw5365L5E53KIIcp5Bisc0GCiCWoMly+z9DY885w9fRfHnIb
         jzMPYw3yd7T/p4Yr2ZYpD6gaes8cl2NCd8gsrm1DJaBFb+Pk8rHGqF7W+zpGvqt9tRWX
         q9P5cwyDc9HbeBHRnnHvF4RV/jsxd0kSfeZeX9wYuA02/MYd7Q2WKSBue9z2TzJzN/cq
         JIYre7jcfSlxCyLwrm19PANOZD/ePZ2s6pQZ02gNUzZVy3qwQ70pvi3xkueNC3QO2gYQ
         BeA4/VZhU5FUUDCa82xNH9/UIDH4LS2wxOs0weaEiQ6P4OQ7NGTfttg5zkuxt7uN8FRG
         +pwQ==
X-Gm-Message-State: APzg51BTpWKTyzrHQXNOio17ifMJXKEjy8BrW1qE8egNOdpLp6Ln2RJg
        jXaqOGk9+2A7tmx4gZumkMhxr0Sa7avGiUbKC5g=
X-Google-Smtp-Source: ANB0VdZ3aSVtDzqyLiaVP4hFEN2epzg3v7FPxOKU9+BxhO3lZK9kE6RDl3oU2MRIZvllTpy2zNDuRhYtc1gW846nqNU=
X-Received: by 2002:a37:54d:: with SMTP id 74-v6mr13386911qkf.30.1535680140913;
 Thu, 30 Aug 2018 18:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180830214517.29372-1-tony.luck@intel.com> <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
In-Reply-To: <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
From:   Tony Luck <tony.luck@intel.com>
Date:   Thu, 30 Aug 2018 18:48:50 -0700
Message-ID: <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86-ML <x86@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        dave.jiang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 30, 2018 at 2:45 PM Tony Luck <tony.luck@intel.com> wrote:
> >
> > Fix is to move one step at a time. First mark the page not present
> > (using the decoy address). Then it is safe to use the actual address
> > of the 1:1 mapping to mark it "uc", and finally as present.
>
> Can't we do it in one step, but make sure that he clflush gets the real address?
>

I'd like to, but I'd need to have a way to mark the address as needing fixing as
it gets passed from set_memory_uc() to _set_memory_uc() to
change_page_attr_set()
to change_page_attr_set_clear()

Just checking "do we have a non-canonical address" at the bottom of that
call stack and flipping bit 63 back on again seems like a bad idea. But adding
extra flag arguments is majorly ugly too.

-Tony
