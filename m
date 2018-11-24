Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56893C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC4120673
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 06:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BXLRKoR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC4120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeKXQ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 11:56:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42782 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbeKXQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 11:56:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so11459611pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 22:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DSA4IAm+rIodBxZ81PMxgZIzP8Ol1DiJilFhUmPwNNg=;
        b=BXLRKoR0xt74II+cGjSNMI2Jnxqhkgay4yvx8tZEqnZ+CoC7MXJdTnVGdVsUXwQ9Ko
         +zQngDv9pyzi0GH3CI4KrnX+aNJdGMLUjvPeRL5dbFcLoGSI2KWorH0VfKWaB4g2F9Xq
         Syz7F2/sXeDwF4O5tkte2n2EsnJL040yefiZyo/kcdWf9n7AkXlo6of0FBKdFIwFW8kV
         wPq/0GMQvGmeKJf+nq8DYVxExy/JaqVZnK4uzEcY9iq9l2mdfrr3zPvMe4e6ucr0eujX
         WGISPCKKIqma0fT5S9cUTJh4tfhIPeXACze2oWPWifQqossWca9JqAgVyR56rQj9H+47
         3ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DSA4IAm+rIodBxZ81PMxgZIzP8Ol1DiJilFhUmPwNNg=;
        b=tjJ9HYVyf6btdRNCC+aftemsjc4stK+qGp9/wpFT3NcOqnZt1bg5Bd09XijIgNN6oO
         XmjXOn8iT11b2Zo0aoMwK58gHh3J+lUaSUEJ6bUR5gTaYLsrPqmElMKREyl+dKmNGzzY
         yWy3g42AG/T3+ax0pGej7dWNXjq+9RRyXYijjDaa467VAgbPKUdCeVbesA+tLQER19Xs
         1F/HsWIDbdoZyry/wmGAcbhZP+iZTBa6jSz5VHdYnf2UqQBqHBs3Xh/XmwfKi0FQklo3
         tR3bmqMmaQ3XMoScdmL6SuUktuOoMPUn5N+oWKxLc/Rjyo1RyxksmocE5xZYxi0Nvz1l
         1psQ==
X-Gm-Message-State: AA+aEWbFlLl1OhPcgqTN8v7t1PKbr9g2gQgA5fRIz1AA05QMhgq/OiR1
        cMTEnFmCoxFiRWVqP7hbX6T99c0TUDQ=
X-Google-Smtp-Source: AFSGD/WDW7Uea+thZdnNUkW2MYLJjgBDSswW8DxyMdCaCES1IGyJ7yV0aEh8oHGNL+C+RCq0QK6c5A==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13mr19336837plm.49.1543039770016;
        Fri, 23 Nov 2018 22:09:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y12sm8710141pfk.70.2018.11.23.22.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 22:09:28 -0800 (PST)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Linus Torvalds <torvalds@linux-foundation.org>, pabeni@redhat.com
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
 <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
 <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f739385-5bc5-6061-cf49-00c92ded3166@kernel.dk>
Date:   Fri, 23 Nov 2018 23:09:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjweUiVewcnk39mUccEN-SjxHeTZdB3VOXZrvvW4Cs3dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:16 AM, Linus Torvalds wrote:
> On Wed, Nov 21, 2018 at 9:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> It would be interesting to know exactly which copy it is that matters
>> so much...  *inlining* the erms case might show that nicely in
>> profiles.
> 
> Side note: the fact that Jens' patch (which I don't like in that form)
> allegedly shrunk the resulting kernel binary would seem to indicate
> that there's a *lot* of compile-time constant-sized memcpy calls that
> we are missing, and that fall back to copy_user_generic().

Other kind of side note... This also affects memset(), which does
rep stosb if we have ERMS if any size memset. I noticed this from
sg_init_table(), which does a memset of the table. For my kind of
testing, the entry size is small. The below, too, reduces memset()
overhead by 50% here for me.

diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9bc861c71e75..bad0fdb9ddcd 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -60,6 +60,8 @@ EXPORT_SYMBOL(__memset)
  * rax   original destination
  */
 ENTRY(memset_erms)
+	cmpl $128,%edx
+	jb memset_orig
 	movq %rdi,%r9
 	movb %sil,%al
 	movq %rdx,%rcx

-- 
Jens Axboe

