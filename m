Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F2214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549889513;
	bh=NQ4Rj+/2pq8bLUoOpWjXlCMrhIqE4IbLC/EzGLfcE58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lL/gpKCWdJgu42swQ9g2azz2QUmoRCWQe/fHr0zj7p/ijabvNpFvtL62yIINiIW4I
	 rXzTnQCVDXN0uTF8tc+FrrnOwLtXAqODbQ5jC8KZGRtzK4cPVzHJV5AB6kenKVJibg
	 PLb5BW5x0j2NW/IzXANn1O862oNfVrER8loLS920=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBKMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:51:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfBKMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:51:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so222541wrg.1;
        Mon, 11 Feb 2019 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VJjpDyw113yc9X+E7TLCvV6Hjo1NS8QIcrGVdAgZSFU=;
        b=SJuHKgCPaV8m0rvf9J6ojZ6wh+/eWw43hB1oNWB8DgAMDSVLYM/x8TIdWWjIilbuna
         8qRRwGn0mbUnbcDkdWisnG/YnfXqcIQ7pat7vhg/aVYcHyjaVIX75LGyZRpVP0VgsXB7
         m9smo0dGL/+1qhNpeGajs+3emSp85qaDrTqXcMLKztVJ6czU6IdqWDp7g3q3wUQ/ggEG
         iMtEE9hZtioGJC9w5IQiIY2DbfUckzkgwHQblXPG4A/WD1brhaTK5GYrYI3TgE5svFiH
         noRwEc9ZWgea2yF+eNji9BTVQVeykEwKPx+TB6QgqkGqcTuk70u3QRhPAHEK4bIewCZ8
         M6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VJjpDyw113yc9X+E7TLCvV6Hjo1NS8QIcrGVdAgZSFU=;
        b=SOJKzFweRH9j+p87TH3G4+w31t1Xde88Pp1UUVs3wc5S7j3e+jVY1yGm9bobqy/ktK
         N3i3Ju4L/JGQreup9Bl5slc/6hnAXt5rxmrWyiVrIx4Jies7G5t1MgwuAuWvwDhVUsYE
         CXKAcaywBlZjfXB1H6qa1P39mvOJIHZasHhMSFPEdOfjHdRT4MERiTLPAnJ5SigJo7ca
         cNhXr5aCKt2vODDsU5h6A6mTnLikNVeR40hV77956KbveACAPDCVY6S+Gcm5Er6gO49B
         WjaUy1OIBEOObXKhPUMjDqanPiN3jlLGeShOC0jzw24mqn4N4FN4f5YgsYfKJ9EbYBEr
         GCFg==
X-Gm-Message-State: AHQUAuaGDBrXVbeO0gJ1PJq0oBHWrbhgJPN6w+82YMpGQwIDhX8OQiFr
        8JQqcmAEeUNMZ8OAUZ1/beHvllO2
X-Google-Smtp-Source: AHgI3IZc+kIKFrbqxeYJFS3TazW2L12bMNhe1wsiNYNBXBEY2ixnasgQNM0H6XkuoOMLS+F8QsSeug==
X-Received: by 2002:adf:b648:: with SMTP id i8mr10320427wre.319.1549889509365;
        Mon, 11 Feb 2019 04:51:49 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t5sm9130743wmg.43.2019.02.11.04.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:51:48 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:51:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Dan Rue <dan.rue@linaro.org>
Subject: Re: [PATCH 2/2] selftests/x86/fsgsbase: Default to trying to run the
 test repeatedly
Message-ID: <20190211125146.GA66987@gmail.com>
References: <20190203134017.9375-1-broonie@kernel.org>
 <20190203134017.9375-3-broonie@kernel.org>
 <20190211084916.GB62722@gmail.com>
 <20190211124738.GA22391@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211124738.GA22391@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Brown <broonie@kernel.org> wrote:

> On Mon, Feb 11, 2019 at 09:49:16AM +0100, Ingo Molnar wrote:
> 
> > So this isn't very user-friendly either, previously it would run a 
> > testcase and immediately provide output.
> 
> > Now it's just starting and 'hanging':
> 
> >   galatea:~/linux/linux/tools/testing/selftests/x86> ./fsgsbase_64 
> 
> > I got bored and Ctrl-C-ed it after ~30 seconds.
> 
> > How long is this supposed to run, and why isn't the user informed?
> 
> On Intel systems I've got access to it's tended to only run for less
> than 10 seconds for me with excursions up to ~30s at most, I'd have
> projected it to be about a minute if the tests pass.  However retesting
> with Debian's v4.19 kernel it seems to be running a lot more stably so
> we're now seeing it run to completion reliably when just one copy of the
> test is running.
> 
> AFAICT it's not terribly idiomatic to provide much output, and anything
> that was per iteration would be *way* too spammy.

Certainly - but a "please wait" and updating the current count via \r 
once every second isn't spammy.

> > Also, testcases should really be short, so I think a better approach 
> > would be to thread the test-case and start an instance on every CPU. That 
> > should also excercise SMP bugs, if any.
> 
> Well, a *better* approach would be for the underlying issue that the
> test is finding to be fixed.
> 
> I didn't look at adding more threads as the test case is already
> threaded, it does seem that running multiple copies simultaneously makes
> things reproduce more quickly so it's definitely useful though it's
> still taking multiple iterations.

multiple iterations are fine - waiting a minute with zero output on the 
console isn't.

Thanks,

	Ingo
