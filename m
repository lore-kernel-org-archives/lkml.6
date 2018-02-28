Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225Y+yXnkpdpkzr9j0mprZlDatrQAfSr6G60ySXMXkOEueQO/ZVgnJcGTvD9KgRxDL+/9dYA
ARC-Seal: i=1; a=rsa-sha256; t=1519809184; cv=none;
        d=google.com; s=arc-20160816;
        b=Bv2adg2rh3S7nzndRxACfjGttLoIuEpFSenfXREthaporxEox+nWLgu3cclbhDj0P/
         VKdhu+uMMuEiesnA9dQLIosqtJgNeQwSf8LlEwfwJi0FL81jZVbL974YTqQhsizMTWDb
         KhtePgCZK91RcobfRaGI0+fGKjwI03mZgmsDFfeuL1+QbqAPaYDWH+1pjGCaLFiHILeZ
         T6L/DzFhOZ2aibApqzqWjPZ31BMZMbM1DOp9mbqeOkshZHMN7DhR+FxNMwJ9YYfOP8WF
         sveTMzs/0zPCWGpZ0/gTrMbcc8CEu4yL4E61tBmxfMAIaWlJhyjUbjUn7TxaPPXUkoKv
         2WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=rONrybrJRJL3HcGIcrgcwdMcex4xZm7T55EYDhRKrUw=;
        b=S7mjZlLeyGX5jLJTQ7H67FP9fc60k6LP9T5XbY/jqrSQfLhyaxBJl+6LGyHid86ROX
         eoTAsXCf6m48HrXcG3LRURrjbLPZEb6H4O+Iz7crDi7NN5CPn8J4qTZB5AM9+Z098rWt
         OGkd//vheMHmu3aRAkTSjzPAuYLNx0pA5U38s7PzI4m3JnMM1soOeOpl9gTvBphg4w41
         OfaZVjxniEEvK6ROc/uof9FpFGPVgySPY89ETgeXLUo6MPsKbLUTEQYwyfX+123VRdk9
         IpsxbPcw4/YIUzmdOGQJdvCkQwANFuA4Uog6gjdRV4DDc+Sx7LEeV/kIbd9utwrFu/Ku
         AEKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=AwRPWAsx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=AwRPWAsx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeB1JNE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Feb 2018 04:13:04 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42593 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeB1JNC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Feb 2018 04:13:02 -0500
MIME-Version: 1.0
In-Reply-To: <CADYN=9JgNRqs5ghv9_UU0MEEKX_kg+L2KXs3c-tXpw1m0dnxDw@mail.gmail.com>
References: <20180222115307.15063-1-zongbox@gmail.com> <CADYN=9KgBp0+iGDL8x774UUadyo54Za4ESLPk2GUfqFz+7W02Q@mail.gmail.com>
 <CA+ZOyajDWFr9dG70uOMoreA=FALoKJCYsFRiUAkZC-a3BuojZg@mail.gmail.com> <CADYN=9JgNRqs5ghv9_UU0MEEKX_kg+L2KXs3c-tXpw1m0dnxDw@mail.gmail.com>
From: Zong Li <zongbox@gmail.com>
Date: Wed, 28 Feb 2018 17:13:01 +0800
Message-ID: <CA+ZOyagCaxyrgTJ4uTqKC3zQgCG97qX+XmfQaXLUhk=MFOJyDA@mail.gmail.com>
Subject: Re: [PATCH] selftest: fix kselftest-merge depend on 'RUNTIME_TESTING_MENU'
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, Vincent Legoll <vincent.legoll@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, mcgrof@kernel.org,
        davem@davemloft.net, Kees Cook <keescook@chromium.org>,
        Fathi Boudra <fathi.boudra@linaro.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zong@andestech.com, greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593102038295942155?=
X-GMAIL-MSGID: =?utf-8?q?1593635436066281137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-28 6:32 GMT+08:00 Anders Roxell <anders.roxell@linaro.org>:
>
> On 23 February 2018 at 08:05, Zong Li <zongbox@gmail.com> wrote:
> > 2018-02-23 3:57 GMT+08:00 Anders Roxell <anders.roxell@linaro.org>:
> >> On 22 February 2018 at 12:53, Zong Li <zongbox@gmail.com> wrote:
> >>> Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
> >>> to ease disabling it all")', the make kselftest-merge cannot merge the
> >>> config dependencies of kselftest to the existing .config file.
> >>>
> >>> These config dependencies of kselftest need to enable the
> >>> 'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.
> >>
> >> Is this patch needed when patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
> >> RUNTIME_TESTING_MENU")' find its way into the kernel ?
> >> I think it's in linux-next now.
> >
> > Thanks. The patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
> > RUNTIME_TESTING_MENU")' can resolve the make kselftest-merge
> > on default situation, but I think the kselftest-merge should resolve
> > the dependencies
> > without the prerequisite, it should enable the 'RUNTIME_TESTING_MENU'
> > when merging
> > the config of some selftests if RUNTIME_TESTING_MENU is not set.
>
> I see your point, but should the be enabled in a common place that
> gets included per
> default if running kselftest-merge and not in all config fragments?
>
> Cheers,
> Anders

I agree with you. It is better that the config fragments of each
selftests is responsible for
enabling the specific configs they needed only.
Thanks for your reply.

Best Regard,
Zong Li
