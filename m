Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226bLw2a5iHWaL+ODZ2TFqoJSYf0URAm183AHnmv/j//evJuvP99L2KkfQfT8vuYjqjSp9qM
ARC-Seal: i=1; a=rsa-sha256; t=1519369544; cv=none;
        d=google.com; s=arc-20160816;
        b=aNKowxaRiHHyKoMoFThUwuSNZkv3KbqWneGk5qppAw291GPNf8wmHqjQpldf32FQAs
         6SuDmmUD9iH7Bzv8aSRCzgyCbsv8OGTT8/YdNLpro+0EgaOHx3/0jpXumWWlh5Txm6M+
         S20pvMGqF3+jtAqL4+5iWE4TjEO+oScBG5Vo5AhIxL7hVsbgY6o6yEBkx7J/PxOI0i5H
         VILpvAA+P7R1NdQGHfc26Hp0sN9R7622Lcm7S3AXW47d4d3zLW7OM3kiS7XrIHfxqTBB
         xFZWuOcGGWje0ba10QtNTqG0XyIPJRSQTcJHK0vf906p4SXL3SFJtS85KAaFj5zEa4B1
         BW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=TWDbOhElEdNdMAbau9wHyumn4Sp/Xvgh+KNu22A21EQ=;
        b=ImKAUCCEIU38Z54QBu5swsxHXgkGkjjqoaiYEGHHwXKlSinDfLEVIClQtvUlKmhwLd
         uZxSHVumlAfqCUxidd0AZgR5a7Fmr9mPl6s9KrGCLQvJ9WfRW6PmbUSBJahe+6MqRwiH
         gDFzveTAUtnjkqNRGDva3BZXIhjwdTN62wX21lyXIFGskJZE2fgrYgEA/XjM7zWGjeoh
         Q74imL8eYA0wnl0USFE3oZbRDfkthwcKlZFiaK6NKBIUGjBJb9f47r6SQaYZIEQtO/oc
         ultnG9ASW/GbG6CDmnlMYfd7+znJb+lEetjrNNmO8TfbNGlUheBiO97E6mMMWxlEXbWs
         xDnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=BYneIz/Z;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=BYneIz/Z;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBWHF3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 02:05:29 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41539 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBWHF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 02:05:27 -0500
MIME-Version: 1.0
In-Reply-To: <CADYN=9KgBp0+iGDL8x774UUadyo54Za4ESLPk2GUfqFz+7W02Q@mail.gmail.com>
References: <20180222115307.15063-1-zongbox@gmail.com> <CADYN=9KgBp0+iGDL8x774UUadyo54Za4ESLPk2GUfqFz+7W02Q@mail.gmail.com>
From: Zong Li <zongbox@gmail.com>
Date: Fri, 23 Feb 2018 15:05:25 +0800
Message-ID: <CA+ZOyajDWFr9dG70uOMoreA=FALoKJCYsFRiUAkZC-a3BuojZg@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593174439701441853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-23 3:57 GMT+08:00 Anders Roxell <anders.roxell@linaro.org>:
> On 22 February 2018 at 12:53, Zong Li <zongbox@gmail.com> wrote:
>> Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
>> to ease disabling it all")', the make kselftest-merge cannot merge the
>> config dependencies of kselftest to the existing .config file.
>>
>> These config dependencies of kselftest need to enable the
>> 'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.
>
> Is this patch needed when patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
> RUNTIME_TESTING_MENU")' find its way into the kernel ?
> I think it's in linux-next now.

Thanks. The patch sha 'f29c79906064 ("lib/Kconfig.debug: enable
RUNTIME_TESTING_MENU")' can resolve the make kselftest-merge
on default situation, but I think the kselftest-merge should resolve
the dependencies
without the prerequisite, it should enable the 'RUNTIME_TESTING_MENU'
when merging
the config of some selftests if RUNTIME_TESTING_MENU is not set.

Best Regards,
Zong Li
