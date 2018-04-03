Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeDCSco (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:32:44 -0400
Received: from mail.monom.org ([188.138.9.77]:45236 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbeDCScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:32:43 -0400
Subject: Re: [PATCH RT 1/3] alarmtimer: Prevent live lock in alarm_cancel()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
References: <20180328100746.18668-1-bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <c248f69e-1016-e7ec-64c2-1b8756524a49@monom.org>
Date: Tue, 3 Apr 2018 20:32:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328100746.18668-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 03/28/2018 12:07 PM, Sebastian Andrzej Siewior wrote:
> If alarm_try_to_cancel() requires a retry, then depending on the
> priority setting the retry loop might prevent timer callback completion
> on RT. Prevent that by waiting for completion on RT, no change for a
> non RT kernel.
> 
> Cc: stable-rt@vger.kernel.org

How relevant is this serie for trees before eae1c4ae275f ("posix-timers: 
Make use of cancel/arm callbacks")? Patch #2 seems to depend on that 
change which was added in v4.12.

Thanks,
Daniel
