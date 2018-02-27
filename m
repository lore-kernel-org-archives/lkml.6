Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeB0I0D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:26:03 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:58378 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeB0I0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:26:02 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@lge.com, LKML <linux-kernel@vger.kernel.org>
From: Byungchul Park <byungchul.park@lge.com>
Subject: [QUESTION] Bringing cross-release back to be alive
Message-ID: <8c535191-e24d-6465-e809-81ae9e9b23e0@lge.com>
Date: Tue, 27 Feb 2018 17:26:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Cross-release introduced a false positive in some fs configs,
which was too hard to solve fundamentally - which requires to
distinguish between all dynamic instances.

I also think it better be removed than making fs developers
disable whole lockdep. But I believe that it's still helpful
in the rest of the configs.

Therefore, I want to bring it back after preventing bothering
them. I think we can achieve it by invalidating problematic
waiters at the moment producing a false positive and letting
them worked out finely later.

For example, in the case where we got trouble in, we can
initialize the completion in submit_bio_wait() with no-map
version. That way, we can achieve our goal easily for all
problems caused by cross-release in the future.

Of course, it would be the best if we solve the problems in a
right way later, but just leaving them invalidated would be
also fine because the cases are exactly same as before
applying cross-release.

I'm curious about what you think about that. If you say yes,
then I will re-summit after adding the work I mentioned above.

-- 
Thanks,
Byungchul
