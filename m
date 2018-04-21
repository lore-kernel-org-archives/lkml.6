Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+yL9SXyWWccCD+14tOmILRBkTvN1Xt/ErnmCOS/6fKf7YXpvvkMNnDQQhqvWbCQH6T4J8g
ARC-Seal: i=1; a=rsa-sha256; t=1524322078; cv=none;
        d=google.com; s=arc-20160816;
        b=eNeRTWzPsO36cvR3N/QVtV3kXF92luxypmvvmn+CwU3X829MPvZg0UEliDqlBPE0xi
         1h3uh5rJN8fB7qbYhTjGYLXnzjhY/OmMZLlQwYSF/t7fAcBpNwxdifZvEvZVPuRgBSwZ
         V8HWROAWBNOmQDuadBMYLr0fqqjIKb20awmAagnApOzWIowIUpmtnV3ygdu6rHTykWTp
         XSPcBmf64yOmnOCUySgpTNRsLxXlUreWXHpSOR4JtpF+H6pPWVcGmncGCmdcZOHHYeUB
         xWicEFZv890OXBjpkcLU+jUMqDf93tncfaPJONKbG+ZjXQjSytCu6Z4TJsqmG7nsIgT5
         NN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hLSsNOLmQ0+l0PMRhAo8IPKxviI98wovDO1wg8vb6bw=;
        b=KhkBu5/Fu37o+0p5BLzBdACO2GoeMwKEfw23p5tyz1acF1+kPwyVhmV+6G97MjSD+G
         YqBNzpW1YRK0Fx81TTMlhCbtHP0mW99OieKC5LWlGvsGw8KpmX9in7U1yMYCfjR5zQTu
         I1L8422zUwPo5UAxh5bFAgvqPipsGtzeuqWz/YYjJORE2Seo9PyYHOSeLBP80vdl83x0
         fnzYlzQp10yQ4lVxlKqS3aLQMybDahkTkF/K8SojTUUf85a/kAqHeGK/9PrrT7yQ9Y2H
         9QViZjjPPJQl0ndanpYTXnWQ5YXfpzPSliMOsZNs+nc/nab3XRVPn2jfUOMu9Ni9+or9
         g8kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=iKKmZfsI;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=iKKmZfsI;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDUOr5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 21 Apr 2018 10:47:57 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34898 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeDUOr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Apr 2018 10:47:56 -0400
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 21 Apr 2018 20:17:55 +0530
Message-ID: <CAG=yYwmQb-zuq3V9muu=xXsRGa3s1A=fFgz-XJchCiFd+GYUYQ@mail.gmail.com>
Subject: possible BUG: selftest about raw_skew failed
To: shuah@kernel.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598367547498408284?=
X-GMAIL-MSGID: =?utf-8?q?1598367547498408284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hello,

failure of a test in selftest:timers

selftests: raw_skew
========================================
WARNING: ADJ_OFFSET in progress, this will cause inaccurate results
Estimating clock drift: 17.910(est) 16.820(act) [FAILED]
Bail out!
Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
1..0
not ok 1..7 selftests:  raw_skew [FAIL]


To reproduce :

make -C tools/testing/selftests/timers/ run_tests




Linux debian 4.17.0-rc1+ #3 SMP Sat Apr 21 03:41:44 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238

-- 
software engineer
rajagiri school of engineering and technology
