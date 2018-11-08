Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC8C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF4D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sB8W9id2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF4D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeKIIeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:34:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37033 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKIIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:34:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so19558340oth.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=i4Uv/qZujwIg4and+P3q40oPDYkuaRIrVJnKREeP8Is=;
        b=sB8W9id2mKHpNNcWTW33sTPJYv9uK+1fjBO270QGAfoLAGPKZ44/8Pgc3u/NM68OR2
         +depcr3DSjCHqKYNne2a4AKpz0lNzSrSSg2nufcpeHMABkRo/WgLW+Zwh7MBDH+qD3Yb
         Ys+0ASh2xKQ5AlRa9RArHb37GYDLhgXXvONBbiYyygukpgu5zxZ+se7OBSTbyp3C+d5E
         ZMQjvcB23w8Xr6zzXN3cdjLTdiE04SZQbauWxc8ItaHkhMGJ6Sow2vxL/OAUrz66bDVV
         4c9/gqZCo1ghlJrslRUfcZVp/K/NktkMv88PsR3m/u6Ix4TdEG00P7Ty0xsGWMJMMpo7
         SnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=i4Uv/qZujwIg4and+P3q40oPDYkuaRIrVJnKREeP8Is=;
        b=DQqPcbhC1Jbg20jgdLgzDoDk5tRcZJV5WL6etkB/Sl4x/CIY9ISzgIRh6uGsLGLZWu
         mjWwatgN5SrUvV04m0TDNzhwi3UXEd1QLXdThNmrQSk0JQtjusVETnujJmsmGqGIB5qH
         CQWVmrKBcQ2waCv+eJV36HvBt9gXhVWTFI4DqbHTG99JtHsPk7fGWlEX2jyMuZVl0w0b
         GHm5LtbobFre7gBQoa07SDdHo/mRBa/l7MwOYQAQJROaMhXINvhzcQkZu70SjYcYBNXP
         ZV8XninH4hqlmp5XAVz9EAQtXr253MzNjHikYpKULF9n2uHTzF8+6shYotxhFiJG8JqF
         bQbA==
X-Gm-Message-State: AGRZ1gJCPOLedbyFxqBSrrvfGiHb0eyykD5gmwiwWMRxE7xH5LePODnK
        bjjzRCFNjh2ka0dAnO/q0hYv/1l/uKa1L6V9YkvEyg==
X-Google-Smtp-Source: AJdET5eVCPXx9VLgMUknPby5Bw41EjRbqjNwLWMsltnJN3oer4cDLPhlLPV9MHJYyYg2qOcZqs4OURjblB3nsVcTHz8=
X-Received: by 2002:a9d:40cd:: with SMTP id t13mr3797026oti.98.1541717780356;
 Thu, 08 Nov 2018 14:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com> <20181108091251.GL9761@hirez.programming.kicks-ass.net>
 <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com> <20181108201425.GF1080@thunk.org>
In-Reply-To: <20181108201425.GF1080@thunk.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Nov 2018 14:56:09 -0800
Message-ID: <CAPcyv4inHR_cBT3thN3+UN5rHGPVfGdmo-_x9wVaUiZ8upN0hg@mail.gmail.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>, acme@redhat.com,
        frederic@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 12:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Nov 08, 2018 at 09:19:33AM -0800, Dan Williams wrote:
> >
> > I know at least StGit mail does not grok that "#"notation. I've
> > stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
> > preferred over "# <KVER>" if only because it can be used to track
> > fixes to commits that have been backported to stable. Is there any
> > reason for "# <KVER>" to continue in a world where we have "Fixes:"?
>
> The main annoyance I have with Fixes is because it can be a pain to
> figure out what the "# <KVER>" would be.  Something like:
>
> % tag --contains DEADBEEF | grep ^v | head
>
> doesn't work because kernel version numbers don't sort obviously.  So
> v4.10 comes before v4.3 using a normal sort, and even sort -n doesn't
> do the right.

Unless I'm misunderstanding, I think you want:

    git describe --contains $COMMIT --match=v[345]*

...which should give you the latest tagged kernel according to that match spec.
