Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx485cagKjwDNYNBNbVSb+BCCuG4ma4Dfbtqur2GnnxV3MCOWri9i3YSqOlla092cc/RFMT4P
ARC-Seal: i=1; a=rsa-sha256; t=1524778135; cv=none;
        d=google.com; s=arc-20160816;
        b=V65PGr09XN4v7mCG0k5XS5P+nL2RN7qHujqap8XNPT7STbRpSPjzbbkVP7PDpJF3L0
         laP+yF7MOhHfH9E0qc52qJd6XAGf/RLmMnek8B7VfP95/ZyQ6yIoV3bJx398mWE6AiO/
         v7M+CxcCyWbFz85CiphpNyg5tsCCbd5HSejuDTKUWpCoi6cwtJRkoIMb3Xxs6C2u0/MU
         3NiMQdZBxgGGzhtq6FyF2w5ag0rAYDBIjLKfc2bAf8gg1tSswSNjMQvga99K7Vs27huF
         NQRlpklRGnnZMROP/R04Q20UqYPNTSyxtk6PKigiSsxxiqfdeFwMfvJQhjGKMUP1uVBJ
         wV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=AFA4+yo18HhXLiG5kwh/EOxOFr8pAfLQAZpKWJafTBo=;
        b=HwaonamQJHhuwFxlfuYwcEAYKSG6JEEKXXd8Cj04ODu4RrASIGdJFRmXwLABcVf63v
         uLenrnKn7dvXhuj9vMvt2yw2bH9TwUy7JAbJK84O8c/ybSW3Wh0/0kQtd7a4z4wZAGhX
         iKj/nd1tA4qiMmWV8VTZCIoAeVQQRSuSNbUgn4QIIv/Alpv0ziH0fOor4XfeHDGJjKPA
         czraTGe+QiNK/pt/Amv84gJO5UZYcmQH7JMX/cy9as2pV921BFKTiA2bf1E8zfuocQeM
         yqZq2wZCrHsW1PWZ8K97Q+A2hlLGw79Opk4V4+0eZw1oV/5I8oti8qcUqanT6YmZhSxo
         w0xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeDZV2o (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 26 Apr 2018 17:28:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbeDZV2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Apr 2018 17:28:42 -0400
Date: Thu, 26 Apr 2018 23:28:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
cc: shuah@kernel.org, Kees Cook <keescook@chromium.org>,
        anton@enomsg.org, ccross@android.com,
        Tony Luck <tony.luck@intel.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: possible BUG: selftest about raw_skew failed
In-Reply-To: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804262327480.1596@nanos.tec.linutronix.de>
References: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598845758740105843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 21 Apr 2018, Jeffrin Thalakkottoor wrote:

Cc'ing John and Miroslav

> hello,
> 
> failure of a test in selftest:timers
> 
> selftests: raw_skew
> ========================================
> WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
> Estimating clock drift: 17.910(est) 16.820(act) [FAILED]
> Bail out!
> Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
> 1..0
> not ok 1..7 selftests:  raw_skew [FAIL]
> 
> 
> To reproduce :
> 
> make -C tools/testing/selftests/timers/ run_tests
> 
> 
> 
> 
> Linux debian 4.17.0-rc1+ #3 SMP Sat Apr 21 03:41:44 IST 2018 x86_64 GNU/Linux
> 
> GNU Make            4.2.1
> Binutils            2.30
> Util-linux          2.31.1
> Mount                2.31.1
> Linux C Library      2.27
> Dynamic linker (ldd) 2.27
> readlink: missing operand
> Try 'readlink --help' for more information.
> Procps              3.3.14
> Kbd                  2.0.4
> Console-tools        2.0.4
> Sh-utils            8.28
> Udev                238
> 
> -- 
> software engineer
> rajagiri school of engineering and technology
> 
