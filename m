Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/A6zm9U5ORo92cmgFu71K7qGDRQ4lFnWewYXwSFHfIM+e4AMidl26voEYtmj9SNlw3AlIR
ARC-Seal: i=1; a=rsa-sha256; t=1524343268; cv=none;
        d=google.com; s=arc-20160816;
        b=Z+OKDYVtfzSANtrFyBaGQbhvKj9r4qx6VptAzVfJySUbHOiE+b5vjvCU4izqMTqoLh
         SP88PBIWkqAkP45lAH6ZbUGfWhmOP3rArcRl+4/yBXrvo7kqXzCHrL2m66gzyc8uQAJh
         Ay91cRvWORTR4e0yXVuESVaZZJ+yQILwSp43gwW5xZ5J8JgSqdnfrQVJt1jmrtaxEvHA
         efHJHRsJwOYudRGMcnvM2AtMXtE+BCaoHoNF3wQHvcstJWVHN8M9Uaj4hqhjOpWy+wuR
         spK8tFkTuAVvB5tD5y+n6oAMQy7HNcgIrfA6dXM8aWseEFhzaDf3X6zEppXR+mL5/L19
         yE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mST2aiBk0WSHGAQpc5NF7NtYs/mJs04CdGZV5pU/7fw=;
        b=NrOg0eseJrdrQQnbg7JBEQT6I4bgm9Vw6zGJXetPHihisXcs4YlEOsJ8ESLDYvvQAY
         0dXEVunauSGuclkpDuJJbn+mznn+ZFOt632krqh4M+dY710RTCPhXY0p9Xm7fUuBqKe6
         yClfzp9wQMR1+cIOeDpKNqhyKQ4MxSbuwPuJu3hT99lDLA1XHEy1kR4/xo8umfohMSIp
         G2hRtBl0vNDUKxCwYCtPCPiZKM+RRh7sCSOcsUVjijSdlttppqA2UmP5JKV7gs9Qk/48
         hr4noWr6tNxQYNgeEhyOaN6PQ3yYqYR3Nym0ehsdL4UeVnksvpyRu2DAIN4ACT1R2VDP
         IrmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=mcCODtcN;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=mcCODtcN;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeDUUlH (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 21 Apr 2018 16:41:07 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36521 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDUUlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Apr 2018 16:41:06 -0400
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 22 Apr 2018 02:11:05 +0530
Message-ID: <CAG=yYwnsP5w6hKqsp0Q3_DZO3JZmtStGwnXNZN9zjPuFe8fOeA@mail.gmail.com>
Subject: Re: possible BUG: selftests: proc-loadavg-001 failed during kernel testing
To: shuah@kernel.org, Kees Cook <keescook@chromium.org>,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598389767027919605?=
X-GMAIL-MSGID: =?utf-8?q?1598389767027919605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This problem is fixed now.

$sudo make -C tools/testing/selftests/proc run_tests
[sudo] password for jeffrin:
make: Entering directory
'/home/jeffrin/upstream-kernel/linux/tools/testing/selftests/proc'
TAP version 13
selftests: proc-loadavg-001
========================================
ok 1..1 selftests: proc-loadavg-001 [PASS]

Please add me in changelog if i was useful.



On Sat, Apr 21, 2018 at 8:41 PM, Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
> hello,
>
> selftests: proc-loadavg-001
> ========================================
> not ok 1..1 selftests:  proc-loadavg-001 [FAIL]
>
> To reproduce :
> make -C tools/testing/selftests/proc run_tests
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
>
>
> --
> software engineer
> rajagiri school of engineering and technology



-- 
software engineer
rajagiri school of engineering and technology
