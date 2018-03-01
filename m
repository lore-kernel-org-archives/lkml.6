Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966636AbeCAJAK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:00:10 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:41274 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965361AbeCAJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:00:08 -0500
X-Google-Smtp-Source: AG47ELuqq269sggVa8OvUF6HmwAHuhQTE+JOQ+bmUhu1vCkH3fDnZ2bscSJID0S+9/EWndPLIKL6kQ==
Date: Thu, 1 Mar 2018 09:33:16 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: richard_c_haines@btinternet.com, paul@paul-moore.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Subject: Regression found when running LTP connect01 on next-20180301
Message-ID: <20180301083316.GA6779@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was running LTP's testcase connect01 [1] and found a regression in linux-next
(next-20180301).  Bisect gave me this patch as the problematic patch (sha
d452930fd3b9 "selinux: Add SCTP support") on a x86 target.

Output from the test(LTP release 20180118):
$ cd /opt/ltp/
$ cat runtest/syscalls |grep connect01>runtest/connect-syscall
$ ./runltp -pq -f connect-syscall
"
Running tests.......
connect01    1  TPASS  :  bad file descriptor successful
connect01    2  TPASS  :  invalid socket buffer successful
connect01    3  TPASS  :  invalid salen successful
connect01    4  TPASS  :  invalid socket successful
connect01    5  TPASS  :  already connected successful
connect01    6  TPASS  :  connection refused successful
connect01    7  TFAIL  :  connect01.c:146: invalid address family ; returned -1 (expected -1), errno 22 (expected 97)
INFO: ltp-pan reported some tests FAIL
LTP Version: 20180118
"

The output from the test expected 97 and we received 22, can you please
elaborate on what have been changed?


Cheers,
Anders
[1] https://github.com/linux-test-project/ltp/blob/20180118/testcases/kernel/syscalls/connect/connect01.c#L146
