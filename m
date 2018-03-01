Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161541AbeCAURx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:17:53 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:40731 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161487AbeCAURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:17:51 -0500
X-Google-Smtp-Source: AG47ELvvp3P7Nn/oAVKhCxREn6TXAQOMOAnGtuHZLNSLdEPjIc6Z8eOJKe4TE6hyePDyDgbTZ/yPtyu1RGvxrgZuR5c=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CADYN=9Lbu608OGPnm4pdbFS24yuk+Pruhn5Wv5ArGitm6UOQpw@mail.gmail.com>
References: <20180301083316.GA6779@localhost.localdomain> <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
 <CADYN=9Lbu608OGPnm4pdbFS24yuk+Pruhn5Wv5ArGitm6UOQpw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Mar 2018 15:17:48 -0500
Message-ID: <CAHC9VhQ3h0U8QzSktGbEKHK1pfmuvLGPLsGEZbEhBQQjQdr+-Q@mail.gmail.com>
Subject: Re: Regression found when running LTP connect01 on next-20180301
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 3:01 PM, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 1 March 2018 at 14:42, Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Mar 1, 2018 at 3:33 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
>>> Hi,
>>>
>>> I was running LTP's testcase connect01 [1] and found a regression in linux-next
>>> (next-20180301).  Bisect gave me this patch as the problematic patch (sha
>>> d452930fd3b9 "selinux: Add SCTP support") on a x86 target.
>>>
>>> Output from the test(LTP release 20180118):
>>> $ cd /opt/ltp/
>>> $ cat runtest/syscalls |grep connect01>runtest/connect-syscall
>>> $ ./runltp -pq -f connect-syscall
>>> "
>>> Running tests.......
>>> connect01    1  TPASS  :  bad file descriptor successful
>>> connect01    2  TPASS  :  invalid socket buffer successful
>>> connect01    3  TPASS  :  invalid salen successful
>>> connect01    4  TPASS  :  invalid socket successful
>>> connect01    5  TPASS  :  already connected successful
>>> connect01    6  TPASS  :  connection refused successful
>>> connect01    7  TFAIL  :  connect01.c:146: invalid address family ; returned -1 (expected -1), errno 22 (expected 97)
>>> INFO: ltp-pan reported some tests FAIL
>>> LTP Version: 20180118
>>> "
>>>
>>> The output from the test expected 97 and we received 22, can you please
>>> elaborate on what have been changed?
>>>
>>> Cheers,
>>> Anders
>>> [1] https://github.com/linux-test-project/ltp/blob/20180118/testcases/kernel/syscalls/connect/connect01.c#L146
>>
>> Hi Anders,
>>
>> Thanks for the report.  Out of curiosity, we're you running the full
>> LTP test suite and this was the only failure, or did you just run the
>> connect01 test?
>
> Normally we run all syscalls, but when we saw this regression I did the
> bisect and only ran test connect01.
> On every new push we ran 19 different sets of LTP tests, where
> connect01 is part of the syscalls test set.

So this means that only the connect01 test experienced failures?

>>  Either answer is fine, I'm just trying to understand
>> the scope of the regression.
>>
>> Richard, are you able to look into this?  If not, let me know and I'll
>> dig a bit deeper (I'll likely take a quick look today, but if the
>> failure is subtle it might require some digging).
>>
>> --
>> paul moore
>> www.paul-moore.com

-- 
paul moore
www.paul-moore.com
