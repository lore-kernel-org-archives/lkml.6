Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D727E21709
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K71Otv/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D727E21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbeHGMQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:16:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeHGMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:16:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so15158294wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LG3L7ONXJU/+yBC1ImjBjMAawDLs9B+fSM+nsoC/jaM=;
        b=K71Otv/GdEnVdiB//Lsv8mDGA0ll3647nPi2Qle7+9u2VjnOQb9bJJ93Q3R2JKmmOV
         YXB7e2OnafN9b2Ed7IFbxzmK493iCFYT1W1zCfbN0B+bvJ55enlUYbv2YkVj2wIS8PcQ
         ERSa4ALOLfkTQENJSGxPdvNfNDhYv4X06xgq1IJWQHOx8DvcHvFaocNC6QhwxAdzEN31
         lvUMGpI1MS1LKrFEEpod19GFsTqpA5JHOFMOrrOgUUd0KCTauf8CkJh5viknxUhi+Vrf
         0sVD7/0lp9DMh1XhVWtYfZq0cISf07pX4tCypydEMlmgnbEEux+kl5k13zyIpuYvS2R/
         cXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LG3L7ONXJU/+yBC1ImjBjMAawDLs9B+fSM+nsoC/jaM=;
        b=kaqAEFg8MryfSdVUo7d7MIe2s0KLpKxr2gMyMT+x6f6zNg6tesTNvM9rf7UvyUeBtL
         p+BSzyjeoL+V5W1fPer0UXyHbnI3P/pssAFhBzVboJf3G7WBYhvVuWleMguv4qaWkAC5
         xZ1dU9Kox14er+9D2DVTjWnevRcBygTRBo3+dbfaBrRCFndBU8K39RmLrPUl/h8HVFpc
         fo+2ScwU/PsWV295yJM5Imc/Lq9x6ObTg5T3MOWvKlIkiSqUORfYla/uelI2Yvuh3/Wk
         MtdF2f6vAaHPng+7jSZFYKa50iI42obHh4fP4jmXWqqKb9wp2xpYPRGcBKcF+1y4U0a/
         V3qA==
X-Gm-Message-State: AOUpUlF+MWAH++G27TZxV0HQULk79WuJBFrLExnjrGuADfA+teQjlaez
        XaQUsVxTEUmi7LrERJ6sIuXFXWgX
X-Google-Smtp-Source: AAOMgpeNUryGtKEeQlKIBOnVLj091ufi9SbGIYaHopN9G8NX+Lm+9eboMnFegcyzyWWPlu2u3Am9OA==
X-Received: by 2002:adf:fb81:: with SMTP id a1-v6mr11726420wrr.219.1533636192245;
        Tue, 07 Aug 2018 03:03:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f8-v6sm1363545wrj.9.2018.08.07.03.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 03:03:11 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:03:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, dvyukov@google.com
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel
 addresses
Message-ID: <20180807100309.GB12200@gmail.com>
References: <20180807012257.20157-1-jannh@google.com>
 <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
> > 
> > There have been multiple kernel vulnerabilities that permitted userspace to
> > pass completely unchecked pointers through to userspace accessors:
> > 
> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
> >  access_ok() checks")
> > - the sg/bsg read/write APIs
> > - the infiniband read/write APIs
> > 
> > These don't happen all that often, but when they do happen, it is hard to
> > test for them properly; and it is probably also hard to discover them with
> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
> > code, it just returns -EFAULT instead of doing a proper BUG() or at least
> > WARN().
> > 
> > This patch attempts to make such misbehaving code a bit more visible by
> > WARN()ing in the pagefault handler code when a userspace accessor causes
> > #PF on a kernel address and the current context isn't whitelisted.
> 
> I like this a lot, and, in fact, I once wrote a patch to do something similar. It was before 
> the fancy extable code, though, so it was a mess.  Here are some thoughts:

Agreed - please move this series beyond the RFC phase.

> - It should be three patches. One patch to add the _UA annotations, one to improve the info 
>   passes to the handlers, and one to change behavior.
>
> - You should pass the vector, the error code, and the address to the handler.
> 
> - The uaccess handler should IMO WARN if the vector is anything other than #PF (which mainly 
> means warning if it’s #GP). I think it should pr_emerg() and return false if the vector is 
> #PF and the address is too high.
> 
> - Arguably most non-uaccess fixups should at least warn for anything other than #GP and #UD.

Ack.

Thanks,

	Ingo
