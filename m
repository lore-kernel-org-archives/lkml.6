Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+Pqu2+jPkOymEsg/rWtYDIlUYSloKMTx2MPiEHxLCnfGUZtRBlIHWdjZ5TBtlpZKg1gDIN
ARC-Seal: i=1; a=rsa-sha256; t=1524778395; cv=none;
        d=google.com; s=arc-20160816;
        b=SoQVy8MUqtu0CVvacaVWWd7dOj7WRfEpe1jmbuA7BfwWAV7yxkloZA9xpWY0ifeBth
         P4dgV8GBXX2i22XFfC4mE8ZlsRkYYFS7SRz1z5mo1qnnuTmMcB3FBKtr2nbwoM1bHeLY
         G3a8DjAX2rbU+UnNlqRmGwu3syWor5E3ESqwezyGj+ARrihIKvBg8wG/wMBWi8bocr+3
         /Z8zJS2jgGsZxA69KmQJ+RzrwjVaTDF4T6VdRbDtvwrbrXvPmjA9oOC/5adHkyhRFJLz
         hiSQJf6t/SqgfXLcAmHajbdsCfF1fanFOSaQtBWqpIGzVOQ0W0FerwJCfJegL6cNPZsX
         vrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=pt/iVsv9CYmpHt61xM3QBCRAmTnosFTaYLFgA9WpNDA=;
        b=eulbIBUQwVGTDRsaXZKc0vRhmRMKkvxTnbOOpEXTC2fMNJ63z2mBsjvvLeSt0XkcEW
         7HNxvVuHaXb2OLBKktmLxH524IEfx4tIna5akyZVYLHBSxXTIwYMex2J9PZ8qcpTItnb
         GNoeQhILnwxOw02iz4t58V0qWse6pBSMz8pjCn+I3cYnxrJwObSWmxtYy9t+9wUhlfun
         Woq/SI4ecHU3Unp+HoPI5kt3W+hYMkmn+sy/UVk8GbnF5VkKcfFvk7lAA2UpWCqpioKn
         z0tZ+r65Bi3EuMnQZEtg0lF3/2AyH4X6Vt1lwdCQt+H8eFl6vW7TiANZgiYYokaJf1hJ
         U09A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ZpeB/znf;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=ZpeB/znf;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbeDZVdO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 26 Apr 2018 17:33:14 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54501 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeDZVdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Apr 2018 17:33:13 -0400
MIME-Version: 1.0
In-Reply-To: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
References: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 26 Apr 2018 14:33:11 -0700
Message-ID: <CALAqxLWphJvPe=v2T2ksjHnQP1Vu7+gZernEgFVXcx5kB+efsQ@mail.gmail.com>
Subject: Re: possible BUG: selftest about raw_skew failed
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598846030370820268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 7:47 AM, Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
> hello,
>
> failure of a test in selftest:timers
>
> selftests: raw_skew
> ========================================
> WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
> Estimating clock drift: 17.910(est) 16.820(act) [FAILED]

So you're ignoring the warning above. If an ADJ_OFFSET operation is
going on, ntpd (or something similar) is changing the clock, which
will kill the estimated drift calculation.

-john
