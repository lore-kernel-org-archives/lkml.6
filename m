Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A0320875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9r7y1kH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A0320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeGMNso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:48:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43201 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeGMNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:48:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so25188784wrv.10;
        Fri, 13 Jul 2018 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0hm7Lbjf7JCwsRCsIm1qeBxf1xRhgj3Q2/MVZ6NA+bg=;
        b=S9r7y1kHZAYUfd3KQO0h3goUvSQLC+t4RufftkII57uvp443jaoMx7jCombJqnPcpM
         o9qyK8zBjLRXbmNBN4oxZvJ6bCrOlVvqYxnI6uZ/+rM/RucC8pTyJFb2byKdQFhfPyuE
         nYcWlfFvLlPosY9nM6/Nndslk7UbaBrQEaoGqa20IMZ3lOZv8Fpm6YMqZAWWBMVthaa+
         cVsp8mXHKeAQOHf1IGZK7O0hLhd7cZjlkKT8gEXy2DScfOfbXJs45HpUbrvEnhOPzjN4
         HedlxSQDEvu3f6VrffV7Cp5vMXa6cr6caGZ0SvuD5wdgbHIditQXHLHmRndxZ459OYK+
         0kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hm7Lbjf7JCwsRCsIm1qeBxf1xRhgj3Q2/MVZ6NA+bg=;
        b=fJTBpSm9C27QXHSNnNks2VzKkAsBFXB8fxEYN9EF9kCwrxJshRZcakjnic8N1EPyZz
         wFdqhCGUzeyFY0ppd6mYrHwSLqh67VPPNjDYVpZX2TwUAxDYvgxq80eI3OSi9YDard2c
         tU1WS+WXWLxLHJOC2UwKQ1dITyQgZwR6nJHBav/IWD5aPo/PONCzp+t4dLEAvV9TuAIP
         JFZz4K/cULo6hl5Y6Li/poKKcOQGtNDSteQDBAQ++q4GL5j5npm4Prp7NRe3vI+GuHSA
         INfEl8ISeXOyv59BL1BE8cq0nfnRdBrvhJZ6rWHlhq2HSKGCM6L7CqnAm/iXaWp/+T/B
         fXzg==
X-Gm-Message-State: AOUpUlEOerfN4zxtX5/GnqrQZ72fn9Lx38yP6PM4vVW8tfTyLLFokiex
        Ht4w+GI9urWHXV7eU/qPmm4=
X-Google-Smtp-Source: AAOMgpeCgJ9lm6L40GU/6oZ0tjViqkZw1XrylgdhWxFXqzLhvNqzicO052bJtjuo8br45dhfBG1GPQ==
X-Received: by 2002:a5d:4701:: with SMTP id y1-v6mr4915096wrq.107.1531488841433;
        Fri, 13 Jul 2018 06:34:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b1-v6sm9229199wma.23.2018.07.13.06.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 06:34:00 -0700 (PDT)
Date:   Fri, 13 Jul 2018 15:33:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
Message-ID: <20180713133357.GB13602@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-26-yu-cheng.yu@intel.com>
 <20180711102035.GB8574@gmail.com>
 <1531323638.13297.24.camel@intel.com>
 <20180712140327.GA7810@gmail.com>
 <20180713062804.GA6905@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713062804.GA6905@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> 
> > > > to "CET" (which is a well-known acronym for "Central European Time"),
> > > > not to CFE?
> > > > 
> > > 
> > > I don't know if I can change that, will find out.
> > 
> > So what I'd suggest is something pretty simple: to use CFT/cft in kernel internal 
> > names, except for the Intel feature bit and any MSR enumeration which can be CET 
> > if Intel named it that way, and a short comment explaining the acronym difference.
> > 
> > Or something like that.
> 
> Actually, I don't think CFT is much better -- there's limited number
> of TLAs (*). "ENFORCE_FLOW"? "FLOWE"? "EFLOW"?

Erm, I wanted to say 'CFE', i.e. the abbreviation of 'Control Flow Enforcement'.

But I guess I can live with CET as well ...

Thanks,

	Ingo
