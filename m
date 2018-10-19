Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2224ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED662083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ+XYRPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED662083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJSOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:32:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42617 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeJSOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:32:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id c23so30398540otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnbaLEG+cWjwJM3pc0T0eu27jN7it+YIIDvRTUmWHhw=;
        b=AQ+XYRPUcLNLvZwhqiXCv5T6EC7oXA3QE52V26efkVi+uNfaLQ+x9bHLk76i3JmDNC
         SeDJlPCJSI9SyMT45N99q9S6+yDUsuAfGoFOlk0y9eBCtOybo9C367OLY/5bDWC2N/I/
         I0Q3Ove/u7nFWG+5xCBRo8PlqH9hOtQPih8vRSrc7H3rga73N3CLvj+NQ1tM9C9HCXSv
         aDT0sv8WOnNSDFbubmMlCjhJ44Udfwlp6j1e/9TC/LlkGMs978bpZFv0M/vyRCBqfd59
         S3q3Az/kL8KaYQvhH7LUFQBXTaO1c+a1Rh53E/1PDewC4a5igWvMOny9fvPk1EGqxmEE
         RhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnbaLEG+cWjwJM3pc0T0eu27jN7it+YIIDvRTUmWHhw=;
        b=nkLCSFJmaSqJSspci2yc1abfjfe1PuyhzGZUIhu8RSAMc2/8TJ6S71qZ2/D/zLE/Ia
         xp4TIxrdAMgVLb6Ykg8KpuxcUasL11Jjiaw5H7sb8KnEPYP9YR2oup2fDNUQJBgZlMt+
         WpvKxBYma8GDfRiGYA/dEGBTvr/uBR1YrT42O7iGrZfQxPhVJullppIewJNiYRnoVWTt
         8e4gNKwCEMx/aiFiAvQs3FH85XXaTUWuQwyoHsHsFAKhxlz2pmfd0gCO4gmjXXNqGmjZ
         6PoVxhFz0Bk2+NQfkhXtlAVuzNopqacbvUHgnFOI8RTNWa+7Froq1FciNQj+V4BcZTI5
         aNWw==
X-Gm-Message-State: ABuFfoiD3x6lG3mjbzqrG6raz/XD/SNHZGV5zkVDqJFy7+nqCFnMTA/b
        4H0RyA/YPabQ64U33DSsrwkbg2iIdtjjJmqQAVZrhg==
X-Google-Smtp-Source: ACcGV62Is/gFfhvgvVuFw8ftQsetsvWmB8pXm4AHCQYYFCdkKcuFozPN6djSbQh8OSL/wvHZN4LU2lUd/eyRRn2tTEA=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr20309471otb.230.1539930466143;
 Thu, 18 Oct 2018 23:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com> <CAA9_cmeRE3mPvxb3NciGFYjNu9aMFx4iTMeUq2fC3UtsyXky2A@mail.gmail.com>
In-Reply-To: <CAA9_cmeRE3mPvxb3NciGFYjNu9aMFx4iTMeUq2fC3UtsyXky2A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Oct 2018 23:27:34 -0700
Message-ID: <CAFd5g46P8PuGH8B5B3mT=M1a4Lg7JTOdWJ8LECo8-i2a=fUZDA@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
To:     dan.j.williams@intel.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:55 PM Dan Williams <dan.j.williams@intel.com> wrote:
<snip>
> > ## More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here:
> > https://google.github.io/kunit-docs/third_party/kernel/docs/
>
> Nice! I've been using mocking techniques in kernel code for the
> libnvdimm test infrastructure in tools/testing/nvdimm/. It's part unit
> test infrastructure, part emulation, and I've always had the feeling
> it's all a bit too adhoc. I'm going to take a look and see what can be
> converted to kunit. Please include linux-nvdimm@lists.01.org on future
> postings.

Great to hear!

Interesting, is this kind of like the nfsim stuff?
>
> I'll shamelessly plug my lwn article about unit testing
> https://lwn.net/Articles/654071/ because it's always good to find
> fellow co-travelers to compare notes and advocate for more test
> oriented kernel development.

Most definitely! I will take a look, and be in touch.

Cheers!
