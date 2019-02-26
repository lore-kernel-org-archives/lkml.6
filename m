Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B870C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8EA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFUnUcAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfBZDRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:17:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38965 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfBZDRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:17:47 -0500
Received: by mail-it1-f194.google.com with SMTP id l15so1958003iti.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfpR+2g4g4OsNiZmUQ3n9q493knJgabkX/oiivPi214=;
        b=KFUnUcAHBV0YZWsuOBhyOl8JSVu2RmqvKTYGQxOB3ogLIqsopmp1js0ySMZOfdHvGU
         wzTFF5IiRS2F5aW/da15h+41qnB+yQYAEjGblUG5mghdwJoI4rBcbJ/g7GLeqNbtwnvn
         4VpUkEtXirOYUhyrQki/lcIQdBAi0stg6e/FWviUwECQ1oKvuln9hEPc86MPZ+It6Xb+
         hj++HB9cnqQEIMWYOIjgC3X2mp1lCuyCCE/7QEiXoL/Ah5eRxKYn0+Pu1lAElGx8MG7k
         CdmLlQ9V3EGnjZM7hwX++AAJbPZwRHSWMTXzfqfmkLTu6lV2eOfGfWAfJYB4G8H/2Y4l
         cZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfpR+2g4g4OsNiZmUQ3n9q493knJgabkX/oiivPi214=;
        b=Gsp+OImXj7yVsOXvQkN2TRY5xS0/zdm3OZbBXNb+zrFT/kqADx7ASOmwtchnxnGn/y
         TlYFEAiuf5UMqfN/g3nVqv9R7zxLLSICR2T1DaDOKY149iuTTByZ7gDTjwREECUyFiHM
         MvEmIoClZWI/2LEKgkDRbmrGYAo3xzUWQfxNL8QqVRjKoEdVwnEPjUxG6tc7I+8ZaRE4
         X3AtH6BndWqSM5MtrlpTAWdmScs9osVkmZ7HTv4d97QGtkUoulEqm83/68u8UFnabi0k
         XqVGOtKKHwk/RaxZpYYzIvF4JiNI0FMXjmMmvtfjQLRy6kjyMdGFwWeh6W2WQS1ZbXfJ
         8oPw==
X-Gm-Message-State: APjAAAWKZ3f7u16ubrSe2GtPKlSO/8Ty7bQZ+593dsPlzMfzjC50vzLT
        2GGfilUVbU6+K+nCvkd7Xuci7CcIZV5dhKFYFKjhgA==
X-Google-Smtp-Source: APXvYqwv4/YXxjpV3T7HZAI1sU3TQvKOf6BnpxPBjjdEyeFTflQzzaYCRvKtvjcuY5Y0LR992vWfAZqYcKFKQCi7nfA=
X-Received: by 2002:a05:660c:6c3:: with SMTP id z3mr1234109itk.83.1551151066252;
 Mon, 25 Feb 2019 19:17:46 -0800 (PST)
MIME-Version: 1.0
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org> <20190225.162300.209654917842732349.davem@davemloft.net>
In-Reply-To: <20190225.162300.209654917842732349.davem@davemloft.net>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 26 Feb 2019 08:47:35 +0530
Message-ID: <CALxhOnjdNQsLf=vfWLM2XhQYZVQjo0jKZyCLbzqbcaXGHxyfBQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc: Unify the system call scripts
To:     David Miller <davem@davemloft.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        sparclinux <sparclinux@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> > This patch depends on;
> >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
>
> Can you please merge this series in with that dependency
> then?

I was planning to push this patch series independently. But
when Arnd (he is guiding me for this task) and I discussed
some other work, then we planned to include that in this
same patch series. I was done with the implementation but
it is bit late to post. So please abandon this patch series.

Thanks
Firoz
