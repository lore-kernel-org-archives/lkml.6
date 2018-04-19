Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48jJynRSYKGoZBGp2d8+fs1rz34mK+hTLRAVQCJq+jhRYQVbCg5hlIgdzwx4VdOvztz5/aw
ARC-Seal: i=1; a=rsa-sha256; t=1524126124; cv=none;
        d=google.com; s=arc-20160816;
        b=JSXkB4apRYxYXoJ58xUketjkmuDx0+KlGU4y4eg7PVAgcxsZFgEkAwRx1YekZobGr6
         s4sNrAgR2TL3ZyAlmDO0x8J/fDMSAl88HZO56qGvtTUYxK6A2Y2dVY4LLpQ6SXkXRC11
         7dYKSJmmyq6oRMJgXWTrGqa8rVBW6STzlvnkBJw4lcLClfuMGr8GnPURPg5nr3PWcJAT
         AVlARONGrquKCjw6r5jQyofmtYC+uWZQsprQxHNPwOWjH5jD8N6JwFSnDdLqDeoBubq+
         OzhAwJsPt9yJTNkb2kQs6tMQUQNWQcEf0D4sU7cHC4yznuiFHs6xy0Rfey+wE9HwZN0N
         Utlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=GKQtROPyb5U30rjviPqeMYnJmqP+q/fyOIX5bFpNnlc=;
        b=lbkeOqLi6GNJDlAWbB04Ur/VZHqRiEnakRUwy3TbVG82JZMVSsXr0wTAZRHWJuaKt3
         OL8oawJeEGxuAg/tqtxHvmu1ETOmkMuSNog0beFMYMDrZ6n6arUdFMbzE6rq7WLIurkt
         v97+LXhxUyTZhk2AWHp6DODW5UewKxxvXEr9sHqi0JbytGYnNb9PJE4qcwVbQP/GE9Dv
         wPYgbj64ER2eY+Duu7x3YGGyOjSyoFbgRaq728saznPLeKgSpkRFUV+X5+9FpDf2OO7M
         fPwiggK20v2PN1y0spOXt4mbjwRpfpzmxyJXt5iMz21gVWHDC0JrXUD+Da6hyo5xJ/Nu
         3ceQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=TtPMwg9P;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=TtPMwg9P;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeDSIWE (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 19 Apr 2018 04:22:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45695 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeDSIWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Apr 2018 04:22:02 -0400
MIME-Version: 1.0
In-Reply-To: <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
References: <20180418075256.300-1-anders.roxell@linaro.org>
 <20180418075256.300-2-anders.roxell@linaro.org> <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 19 Apr 2018 10:22:01 +0200
Message-ID: <CADYN=9Lw0S8yhnRn3u+0A8Cc3R91V=3PBytU1c+Ns3TNPdB1xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/filesystems: remove Makefile warning
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuahkh@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598069678446839048?=
X-GMAIL-MSGID: =?utf-8?q?1598162075431774254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18 April 2018 at 16:54, Shuah Khan <shuah@kernel.org> wrote:
> On 04/18/2018 01:52 AM, Anders Roxell wrote:
>> When overriding the 'clean' target make throws up warnings:
>> Makefile:9: warning: overriding recipe for target 'clean'
>> ../lib.mk:98: warning: ignoring old recipe for target 'clean'
>>
>> In current code we change from TEST_PROGS to TEST_GEN_PROGS and that
>> does that we can remove the target 'clean' and 'all'.
>>
>> Fixes: 10924bc64487 ("selftests: move dnotify_test from Documentation/filesystems")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  tools/testing/selftests/filesystems/Makefile | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
>> index 427a401aae5c..a55ac3ac09ad 100644
>> --- a/tools/testing/selftests/filesystems/Makefile
>> +++ b/tools/testing/selftests/filesystems/Makefile
>> @@ -1,9 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -TEST_PROGS := dnotify_test devpts_pts
>> +TEST_GEN_PROGS := dnotify_test devpts_pts
>>  CFLAGS += -I../../../../usr/include/
>> -all: $(TEST_PROGS)
>>
>>  include ../lib.mk
>> -
>> -clean:
>> -     rm -fr $(TEST_PROGS)
>>
>
> Hi Anders,
>
> Michael sent in a patch to fix the problem already. It is in linux-kselftest fixes
> branch for 4.17-rc2
>
> Classifying dnotify_test to TEST_GEN_PROGS_EXTENDED as Michael is the correct way
> to handle this problem. It allows the test to be built and installed and it won't
> be run in the main kselftest run.

Why don't we want to run them in the main kselftest run?
Is the rationale documented somewhere/somehow?
If they are long running tests or intrusive tests, can we document
with a printout like:
=== Test ${foo} - SKIPPED (${short_rationale}) ===
=== Test dnotify_test - SKIPPED (long run) ===
=== Test devpts_pts - SKIPPED (intrusive run) ===

Should there be a variable to turn them on from the main kselftest run?

Cheers,
Anders

>
> thanks,
> -- Shuah
