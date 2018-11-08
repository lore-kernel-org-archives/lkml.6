Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293CEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8F820817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fqc/2lru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8F820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKIC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:56:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39032 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKIC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:56:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id 192-v6so16808525oii.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJB4NUn9UPTiP1FJtiTjQxBiUAPHBytuBDNQAPJxmXU=;
        b=fqc/2lru6ZtKk5WtbtIueLqSG87WSn3uCirBxUG3Vl6ylcMo4yeO+S9kDcdz03WccK
         ox1l4kv0T0vQ1uOo2MT6uZMUG2UXaGYC0IMTza086Y8SRTktsxsr5RPdI5goUvW2MUt5
         USZkveLhupkBqCTMxN1O+13i/AUZCVqvadFJev9688Pz32H+6KDZ/ao32lEeCj+RlJJo
         l39zsYzVAn/tvs0b7TMKvzl9AiI/cQLZqtN8uQE3+6UipDklAzh8DlSPSu7TDO+5QgY6
         SG3pzdo/yWMVell+tqt4gDgS5Fn3r8qPWLejvQe2jJfzwz0VO2WLQ8AOgvwq1FD729Mx
         ygTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJB4NUn9UPTiP1FJtiTjQxBiUAPHBytuBDNQAPJxmXU=;
        b=CZfT+Kbv/AVjPwwxuWr1Ov/Nf8k6gi/tkoyfKLLfvNzTnpyTFvsVjeacTIGwcMBCsi
         PfFvUqw/cCxuOlVf5bESjgp/ocgiGuSE/Dh7bbY5W4jA5XcdCQpcmcN4TEUp/Z97QtTH
         nQ3PNbnMwYWrelCiqGTWbXhscuYILzUBdDg2pqMvTVdBRLjAOgaFLGRAowh+AWGS0Cfd
         NSJPFscfrXx3ZMiG0LDIx4uXUooI00inc2jh1JUL85RuvcuBNVyYEdsCDFDlWYsWq3m0
         c9SAQGclpRu96/wMH/qQrLMjvB/+0mEbxnor4eAjQKIrCSQIboivSDP2ARZKJzzPh6uc
         ZSNg==
X-Gm-Message-State: AGRZ1gIAkGRz2HzJqIwsHyMythY0Qpu4dn7Fv4KgWhg9xnVRlv0Eeiu/
        W1GVMFJ+uQDHYb76Mdcxg3hU9OswhCNzurZLnEFFEA==
X-Google-Smtp-Source: AJdET5dVHYX16lgGcxgWnfQyyWWV6Yt7kGyGxdMcBqxE4vdkw6/PXfNP0Lh+LO8DMF/wWWDKGH80Bi6f9nC3Y7Pyaw4=
X-Received: by 2002:a54:4188:: with SMTP id 8-v6mr3275458oiy.105.1541697584617;
 Thu, 08 Nov 2018 09:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20181107171010.421878737@linutronix.de> <20181107171149.165693799@linutronix.de>
 <20181108074012.GD20032@gmail.com> <20181108091251.GL9761@hirez.programming.kicks-ass.net>
In-Reply-To: <20181108091251.GL9761@hirez.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Nov 2018 09:19:33 -0800
Message-ID: <CAPcyv4iCc32VpHA2c8QMRTFy1wGRAmhFQV1xVUiAo2zYKOfJrQ@mail.gmail.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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

On Thu, Nov 8, 2018 at 1:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 08, 2018 at 08:40:12AM +0100, Ingo Molnar wrote:
> > > + - Cc: ``cc-ed-person <person@mail>``
> > > +
> > > +   If the patch should be backported to stable, then please add a '``Cc:
> > > +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> > > +   mail.
> >
> > Can I suggest a more canonical form:
> >
> >       Cc: <stable@vger.kernel.org> # v4.18 and later kernels
> >
> > It would be nice if people adding Cc: stable lines would actually try to
> > figure out which exact kernel versions are affected.

I know at least StGit mail does not grok that "#"notation. I've
stopped using it in favor of a "Fixes:" tag. I would think "Fixes:" is
preferred over "# <KVER>" if only because it can be used to track
fixes to commits that have been backported to stable. Is there any
reason for "# <KVER>" to continue in a world where we have "Fixes:"?
