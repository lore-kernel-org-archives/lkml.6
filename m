Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227j+j9THfCxWhCwVktX0fCESGyYFO6JP6W0aS5nHm+1FZBkdMmz2CtbXzzbB3ul/k4Wc0qw
ARC-Seal: i=1; a=rsa-sha256; t=1519770785; cv=none;
        d=google.com; s=arc-20160816;
        b=YpDLPQGtvTurs0m3h1Tsg5SyVFw7l0t3OH5yN7Myllx5oa1J8RgkDWWcVzsU5Fs84v
         OBM8aAYWbRvVdCTUxem2crEjRJYBcEjVdsvHxcslq1EjAOXPJAWbdXjV4pmbjMd+oFjV
         eApktMalVdHE+AdFGMXQcTTTq67xnrrQvzac/XHEIDO+Q5dR22KHJVOUubiVi3cdzqJW
         mJwkG3J+7jNFE+TJh/53pl1DDxAmxB4kFrT4sgkuV3ZAMLD+fmd5SCUoO/oKFQmxVk2t
         qzJnUYy5BVCPpkoO2YTbJDo2LjwYqtAfgHLXF7WD4souymYr88X1K2WdHZdepWuyS9xr
         uoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=67hJ4B07k04Gtm+Ee/tPG0hR39Zh1EzqQIcyef5eaBk=;
        b=WYfxdE5/dWfl+SsV2FK3+OUlnOYRdunR0PBThBuAwkYKT3mB+dZBGcQReNqLiOG5pG
         zfqpE+nI3iYdDmStfyJ7E0Al7HBWT/L8x3L0/KsfDK8DHFeUo16x+Kyy00+A+9u5YS0j
         mAqzB2bjH4o6vaZ+CpbStQCn9OuJUHyEv6dAfOPq3fqfKcq9k7XtSfgQqHL92YjUdn9r
         Gqoq5o2j3zPREbQzLwDqEi4RMqPbtszyznmA3at9jC09DpEi4SpnrdimjaXV81/wtIXe
         OHu38Hqg6C5Hm7+diQXUxwlno2O+CeAMXqlcqXvgaBnomvZvCsnQ5LWIC265KIpLCnrv
         Cvzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jheVkSPZ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jheVkSPZ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeB0Wcu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 17:32:50 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40554 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeB0Wcq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 17:32:46 -0500
MIME-Version: 1.0
In-Reply-To: <CA+ZOyajDWFr9dG70uOMoreA=FALoKJCYsFRiUAkZC-a3BuojZg@mail.gmail.com>
References: <20180222115307.15063-1-zongbox@gmail.com> <CADYN=9KgBp0+iGDL8x774UUadyo54Za4ESLPk2GUfqFz+7W02Q@mail.gmail.com>
 <CA+ZOyajDWFr9dG70uOMoreA=FALoKJCYsFRiUAkZC-a3BuojZg@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 27 Feb 2018 23:32:45 +0100
Message-ID: <CADYN=9JgNRqs5ghv9_UU0MEEKX_kg+L2KXs3c-tXpw1m0dnxDw@mail.gmail.com>
Subject: Re: [PATCH] selftest: fix kselftest-merge depend on 'RUNTIME_TESTING_MENU'
To: Zong Li <zongbox@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593595170517722224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 February 2018 at 08:05, Zong Li <zongbox@gmail.com> wrote:
> 2018-02-23 3:57 GMT+08:00 Anders Roxell <anders.roxell@linaro.org>:
>> On 22 February 2018 at 12:53, Zong Li <zongbox@gmail.com> wrote:
>>> Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
>>> to ease disabling it all")', the make kselftest-merge cannot merge the
>>> config dependencies of kselftest to the existing .config file.
>>>
>>> These config dependencies of kselftest need to enable the
>>> 'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.
>>
>> Is this patch needed when patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
>> RUNTIME_TESTING_MENU")' find its way into the kernel ?
>> I think it's in linux-next now.
>
> Thanks. The patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
> RUNTIME_TESTING_MENU")' can resolve the make kselftest-merge
> on default situation, but I think the kselftest-merge should resolve
> the dependencies
> without the prerequisite, it should enable the 'RUNTIME_TESTING_MENU'
> when merging
> the config of some selftests if RUNTIME_TESTING_MENU is not set.

I see your point, but should the be enabled in a common place that
gets included per
default if running kselftest-merge and not in all config fragments?

Cheers,
Anders
