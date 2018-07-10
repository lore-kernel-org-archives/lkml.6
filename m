Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D966EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6PRvZZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9210E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGJXYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:24:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39018 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbeGJXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:24:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so622399wmb.4;
        Tue, 10 Jul 2018 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LJ2e2wvx4ZWrvmGIqC2g8qcfq+ffiY4DZ10hg02y3XA=;
        b=d6PRvZZ4bKMwF9Gup4YZIbDw7Y9cJkafZ9olcOgK5KA4cxqGYIrGgoKqFAC1vnFwIn
         N7X/Qx+/Mhnk17OZ67oW1o0bwGYM+hTVrN0q5KzwodTwtgzFU5tFXCBOBX+eKD7efjdc
         LPt47cB+m2x7Dk+QnjgD/r39yZ2qnZATFwSUMgAqaZu2n6sEGpvVP39v/5WOzpuSim4/
         3fDEdvQXerNeyC22jdk4X1KDZ5pMFYfDlbMi/1idALPl1iwNUGC3Go4RAFAZj5zH0Z87
         LpYGKCa6Am/7KOjEOJVoZek9pZESCf58CSa66wWK3GRLn1n700OPW8+dCTtF7aixCeFf
         jPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LJ2e2wvx4ZWrvmGIqC2g8qcfq+ffiY4DZ10hg02y3XA=;
        b=CONNpsmdoxqfMYWsoz7s2CymH6ioCYVSCewFIjKFtS6Ljziy2Qkr6bPN9iM92YuXRt
         Ss+AhiUBOQHZeGk5lvL4VrgCI6r1083vm83vchq7LXaKX4PacHsPi32EivFYkOfiDyPO
         S2Fl5oX4yizaOk2lbH6jO1Ck7KfC0Gp970T3AKXkkxJAvOnoZpkZ+/mJLlYo0shYOg4G
         zP3GU4lj9STZveUoveic+uOhuiQ2Iw1bcgE/aNPi05XqSKotm6PxghYj1WJeaIYQJp10
         tcM6mI5i94q50TSD8R7YliizWufzZDWyvYztAt5QaSrbmDBOKBqVi4BKV0TaftNdyLkN
         TV8Q==
X-Gm-Message-State: APt69E0jRNnI9ifvjHHYanO2ZRQAe3PZ+xMt8HlSQRBhsHxbhIITu4dA
        oWAr7TwkJRMVUjO0OQ9NFiM=
X-Google-Smtp-Source: AAOMgpfEVxS0GT0aDGJa8CowWNZAI9vh0g0yYknoB1fpR78PCPfOGHYmmwG4XQlL5SOHpYqy+Ao1wA==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr12981311wmc.90.1531264991130;
        Tue, 10 Jul 2018 16:23:11 -0700 (PDT)
Received: from [10.10.40.181] ([38.97.127.241])
        by smtp.gmail.com with ESMTPSA id g125-v6sm405858wmf.16.2018.07.10.16.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:23:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC PATCH v2 11/27] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <fbf45667-5388-44a6-1f22-07bcc03e1804@linux.intel.com>
Date:   Tue, 10 Jul 2018 19:23:04 -0400
Cc:     X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <DDFF4AF4-51D2-44F5-8B63-E8454F712EC6@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-12-yu-cheng.yu@intel.com>
 <fbf45667-5388-44a6-1f22-07bcc03e1804@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:44 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
>> +	/*
>> +	 * On platforms before CET, other threads could race to
>> +	 * create a RO and _PAGE_DIRTY_HW PMD again.  However,
>> +	 * on CET platforms, this is safe without a TLB flush.
>> +	 */
> 
> If I didn't work for Intel, I'd wonder what the heck CET is and what the
> heck it has to do with _PAGE_DIRTY_HW.  I think we need a better comment
> than this.  How about:
> 
> 	Some processors can _start_ a write, but end up seeing
> 	a read-only PTE by the time they get to getting the
> 	Dirty bit.  In this case, they will set the Dirty bit,
> 	leaving a read-only, Dirty PTE which looks like a Shadow
> 	Stack PTE.
> 
> 	However, this behavior has been improved and will *not* occur on
> 	processors supporting Shadow Stacks.  Without this guarantee, a
> 	transition to a non-present PTE and flush the TLB would be
> 	needed.

Interesting. Does that regard the knights landing bug or something more
general?

Will the write succeed or trigger a page-fault in this case?

[ I know it is not related to the patch, but I would appreciate if you share
your knowledge ]

Regards,
Nadav
