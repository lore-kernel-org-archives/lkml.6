Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269DC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772922075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBBCOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:14:32 -0500
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:49352 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBBCOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:14:32 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 21:14:32 EST
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id B3C9E16118D;
        Fri,  1 Feb 2019 18:07:10 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nS6CwHwFKwdo; Fri,  1 Feb 2019 18:07:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id CBA601611B9;
        Fri,  1 Feb 2019 18:07:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tUkKQ1vOdvnK; Fri,  1 Feb 2019 18:07:09 -0800 (PST)
Received: from Penguin.CS.UCLA.EDU (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id AA2BA16118D;
        Fri,  1 Feb 2019 18:07:09 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alex Branham <alex.branham@gmail.com>, Alan Mackenzie <acm@muc.de>,
        Eli Zaretskii <eliz@gnu.org>, linux-kernel@vger.kernel.org,
        34235@debbugs.gnu.org
From:   Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix,
 division by zero bug). Problems with glibc.
Openpgp: preference=signencrypt
Autocrypt: addr=eggert@cs.ucla.edu; prefer-encrypt=mutual; keydata=
 xsFNBEyAcmQBEADAAyH2xoTu7ppG5D3a8FMZEon74dCvc4+q1XA2J2tBy2pwaTqfhpxxdGA9
 Jj50UJ3PD4bSUEgN8tLZ0san47l5XTAFLi2456ciSl5m8sKaHlGdt9XmAAtmXqeZVIYX/UFS
 96fDzf4xhEmm/y7LbYEPQdUdxu47xA5KhTYp5bltF3WYDz1Ygd7gx07Auwp7iw7eNvnoDTAl
 KAl8KYDZzbDNCQGEbpY3efZIvPdeI+FWQN4W+kghy+P6au6PrIIhYraeua7XDdb2LS1en3Ss
 mE3QjqfRqI/A2ue8JMwsvXe/WK38Ezs6x74iTaqI3AFH6ilAhDqpMnd/msSESNFt76DiO1ZK
 QMr9amVPknjfPmJISqdhgB1DlEdw34sROf6V8mZw0xfqT6PKE46LcFefzs0kbg4GORf8vjG2
 Sf1tk5eU8MBiyN/bZ03bKNjNYMpODDQQwuP84kYLkX2wBxxMAhBxwbDVZudzxDZJ1C2VXujC
 OJVxq2kljBM9ETYuUGqd75AW2LXrLw6+MuIsHFAYAgRr7+KcwDgBAfwhPBYX34nSSiHlmLC+
 KaHLeCLF5ZI2vKm3HEeCTtlOg7xZEONgwzL+fdKo+D6SoC8RRxJKs8a3sVfI4t6CnrQzvJbB
 n6gxdgCu5i29J1QCYrCYvql2UyFPAK+do99/1jOXT4m2836j1wARAQABzSBQYXVsIEVnZ2Vy
 dCA8ZWdnZXJ0QGNzLnVjbGEuZWR1PsLBfgQTAQIAKAUCTIByZAIbAwUJEswDAAYLCQgHAwIG
 FQgCCQoLBBYCAwECHgECF4AACgkQ7ZfpDmKqfjRRGw/+Ij03dhYfYl/gXVRiuzV1gGrbHk+t
 nfrI/C7fAeoFzQ5tVgVinShaPkZo0HTPf18x6IDEdAiO8Mqo1yp0CtHmzGMCJ50o4Grgfjlr
 6g/+vtEOKbhleszN2XpJvpwM2QgGvn/laTLUu8PH9aRWTs7qJJZKKKAb4sxYc92FehPu6FOD
 0dDiyhlDAq4lOV2mdBpzQbiojoZzQLMQwjpgCTK2572eK9EOEQySUThXrSIz6ASenp4NYTFH
 s9tuJQvXk9gZDdPSl3bp+47dGxlxEWLpBIM7zIONw4ks4azgT8nvDZxA5IZHtvqBlJLBObYY
 0Le61Wp0y3TlBDh2qdK8eYL426W4scEMSuig5gb8OAtQiBW6k2sGUxxeiv8ovWu8YAZgKJfu
 oWI+uRnMEddruY8JsoM54KaKvZikkKs2bg1ndtLVzHpJ6qFZC7QVjeHUh6/BmgvdjWPZYFTt
 N+KA9CWX3GQKKgN3uu988yznD7LnB98T4EUH1HA/GnfBqMV1gpzTvPc4qVQinCmIkEFp83zl
 +G5fCjJJ3W7ivzCnYo4KhKLpFUm97okTKR2LW3xZzEW4cLSWO387MTK3CzDOx5qe6s4a91Zu
 ZM/j/TQdTLDaqNn83kA4Hq48UHXYxcIh+Nd8k/3w6lFuoK0wrOFiywjLx+0ur5jmmbecBGHc
 1xdhAFHOwU0ETIByZAEQAKaF678T9wyH4wjTrV1Pz3cDEoSnV/0ZUrOT37p1dcGyj/IXq1x6
 70HRVahAmk0sZpYc25PF9D5GPYHFWlNjuPU96rDndXB3hedmBRhLdC4bAXjI4DV+bmdVe+q/
 IMnlZRaVlm9EiMCVAR6w13sReu7qXkW9r3RwY2AzXskp/tAe4BRKr1Zmbvi2nbnQ6epEC42r
 Rbx0B1EhjbIQZ5JHGk24iPT7LdBgnNmos5wYjzwNlkMQD5T0Ydzhk7J+UxwA5m46mOhRDC2r
 FV/A0gm5TLy8DXjv/Esc4gYnYai6SQqnUEVh5LuV8YCJBnijs+Tiw71x1icmn6xGI45EugJO
 gec+rLypYgpVp4x0HI5T88qBRYCkxH3Kg8Qo+EWNA9A4LRQ9DX8njona0gf0s03tocK8kBN6
 6UoqqPtHBnc4eMgBymCflK12eKfd2YYxnyg9cZazWA5VslvTxpm76hbg5oiAEH/Vg/8MxHyA
 nPhfrgwyPrmJEcVBafdspJnYQxBYNco2LFPIhlOvWh8r4at+s+M3Lb26oUTczlgdW1Sf3SDA
 77BMRnF0FQyE+7AzV79MBN4ykiqaezQxtaF1Fy/tvkhffSo8u+dwG0EgJh+te38gTcISVr0G
 IPplLz6YhjrbHrPRF1CN5UuL9DBGjxuN35RLNVEfta6RUFlR6NctTjvrABEBAAHCwWUEGAEC
 AA8FAkyAcmQCGwwFCRLMAwAACgkQ7ZfpDmKqfjSrHA/+KzAKvTxRhA9MWNLxIyJ7S5uJ16gs
 T3oCjZrBKGEhKMOGX4O0GA6VOEryO7QRCCYah3oxSG38IAnNeiwJXgU9Bzkk85UGbPEd7HGF
 /VSeHCQwWou6jqUDTSDvn9YhNTdG0KXPM74aC+xr2Zow1O2mhXihgWKD0Dw+0LYPnUOsQ0KO
 FxHXXYHmRrS1OZPU59BLvc+TRhIhafSHKLwbXK+6ckkxBx6h8z5ccpG0Qs4bFhdFYnFrEieD
 LoGmnE2YLhdV6swJ9VNCS6pLiEohT3fm7aXm15tZOIyzMZhHRSAPblXxQ0ZSWjq8oRrcYNFx
 c4W1URpAkBCOYJoXvQfD5L3lqAl8TCqDUzYxhH/tJhbDdHrqHH767jaDaTB1+Talp/2AMKwc
 XNOdiklGxbmHVG6YGl6g8Lrbsu9NZEI4yLlHzuikthJWgz+3vZhVGyNlt+HNIoF6CjDL2omu
 5cEq4RDHM44QqPk6l7O0pUvN1mT4B+S1b08RKpqm/ff015E37HNV/piIvJlxGAYz8PSfuGCB
 1thMYqlmgdhd9/BabGFbGGYHA6U4/T5zqU+f6xHy1SsAQZ1MSKlLwekBIT+4/cLRGqCHjnV0
 q5H/T6a7t5mPkbzSrOLSo4puj+IToNjYyYIDBWzhlA19avOa+rvUjmHtD3sFN7cXWtkGoi8b
 uNcby4U=
Organization: UCLA Computer Science Department
Message-ID: <17880b13-2fde-764d-a284-11cf0caf1cec@cs.ucla.edu>
Date:   Fri, 1 Feb 2019 18:07:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------3EDE60C2A864A50FA18F8A05"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3EDE60C2A864A50FA18F8A05
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for helping to track down this bug. Since the problem occurs only 
with a few Linux kernel versions and affects Emacs only when doing CPU 
profiling, it doesn't seem worth spending time to try to patch Emacs to 
work around the bug. So I installed the attached patch into emacs-26's 
etc/PROBLEMS file to warn users about the problem, and am closing the 
Emacs bug report.


--------------3EDE60C2A864A50FA18F8A05
Content-Type: text/x-patch;
 name="0001-etc-PROBLEMS-Mention-profiler-report-bug-Bug-34235.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-etc-PROBLEMS-Mention-profiler-report-bug-Bug-34235.patc";
 filename*1="h"

From 1243188bc4f722abf16518bf73924ce5f17750cf Mon Sep 17 00:00:00 2001
From: Paul Eggert <eggert@cs.ucla.edu>
Date: Fri, 1 Feb 2019 17:58:05 -0800
Subject: [PATCH] * etc/PROBLEMS: Mention profiler-report bug (Bug#34235).

---
 etc/PROBLEMS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/etc/PROBLEMS b/etc/PROBLEMS
index cab087631c..00583f016d 100644
--- a/etc/PROBLEMS
+++ b/etc/PROBLEMS
@@ -1850,6 +1850,12 @@ term/xterm.el) for more details.
 
 ** GNU/Linux
 
+*** GNU/Linux: profiler-report outputs nothing.
+
+A few versions of the Linux kernel have timer bugs that break CPU
+profiling; see Bug#34235.  To fix the problem, upgrade to kernel
+versions 4.19.19 or 4.20.6, or later.
+
 *** GNU/Linux: Process output is corrupted.
 
 There is a bug in Linux kernel 2.6.10 PTYs that can cause emacs to
-- 
2.20.1


--------------3EDE60C2A864A50FA18F8A05--
