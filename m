Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/Qy0ARuIvF5zesVK5jRF/6gjHyAlKHNPG+7f88wLgfriV1kQb5rvHGvmmC/QvRoPqV/659
ARC-Seal: i=1; a=rsa-sha256; t=1524083535; cv=none;
        d=google.com; s=arc-20160816;
        b=v44GSxsUEvOlpBrm+xrowOXP0UUYo7J9walZSfhVrRL5Z4nGjNL9dwHuxBCUhDW55m
         rb0gXRQUs+bGmZwlyC14Ak7e9Y50yBMqqzZUUkm3LWvZ579FI1dfO0dd0sala09eZvVl
         XwKhx+of3PYMvvQYzEn2obmkmMRX6m6Btp0pQ0RdrWNbpqNvvNVPwK1ulKfeBNrwbTb/
         ZG6ADnctiy+E3CQNT4Rsl9cTYeZOvIAR1YpbCIpyGC38nDQedQX/oeSd/MX7e9jz/OdX
         vMYylRCSEe+GDsCuD69seqzCfIPJ40cO/Dx5XWSTNSEefM72MD14RWynXAjKcL+OXrIx
         8TTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=27X3AnJcnfIIdzf7xTOQjlvelrIG0DEFt5FEi1cAHMk=;
        b=CDLKQT1s9jRv2DthssErseq5nxydz/CHZYTCc50tlyj4P39142g78JSBXadES250sX
         HessRxvGmj/vEacG9/7oOQJa59rspS2nYGeCw0yG3mgpaMfEjVlZbWAjA9KHWe3T6Hpx
         AXtVBEqHBtgsCAktaMHvp6e+vncN72j6M7kWHLSSiiWnntSepw6tFIAzvHeN/7Ipmyjp
         91k3++KwtY10/satcIHwW/RkbPLr5Zor75BEdwEa984DPA8r/JerIOY8H6u7vNwqdc9q
         hukqnDCX7PLK0/NiuWK5el7Qu3NkVoYlEWSz67qAXJ+0xuziFd7y8ib5L/pCuEao1G6a
         o+iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MuArCzNn;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MuArCzNn;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRUcO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 18 Apr 2018 16:32:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35239 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeDRUcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Apr 2018 16:32:12 -0400
MIME-Version: 1.0
In-Reply-To: <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
References: <20180418075256.300-1-anders.roxell@linaro.org>
 <20180418075256.300-2-anders.roxell@linaro.org> <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 18 Apr 2018 22:32:10 +0200
Message-ID: <CADYN=9JPshmJA4zREWRQgNet7jLJbXuJUTyFTo0nB9i2bA1WyQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1598117416919588419?=
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
> Michael sent in a patch to fix the problem already.

I'm sorry I should have seen that.

> It is in linux-kselftest fixes
> branch for 4.17-rc2
>
> Classifying dnotify_test to TEST_GEN_PROGS_EXTENDED as Michael is the correct way
> to handle this problem. It allows the test to be built and installed and it won't
> be run in the main kselftest run.

Great, thank you for the explanation.

Cheers,
Anders

>
> thanks,
> -- Shuah
