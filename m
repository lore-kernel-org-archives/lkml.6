Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965574AbeEXIsG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:48:06 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34609 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965114AbeEXIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:47:57 -0400
X-Google-Smtp-Source: AB8JxZrcyzGQnnnUX8/NUaTxyWyJ3v8O6EkUqJzEVYHKtsSFKsvfyfW7mM9ZlebNdwRU4uWGQH4GuQ==
Subject: Re: [RFD] Add debugfs for cpuidle ?
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org>
 <2682482.uFPN0cxrGI@aspire.rjw.lan>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
Date: Thu, 24 May 2018 10:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2682482.uFPN0cxrGI@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2018 10:28, Rafael J. Wysocki wrote:
> On Thursday, May 24, 2018 10:14:31 AM CEST Daniel Lezcano wrote:
>> 
>> Hi all,
> 
> Hi,
> 
>> would it be interesting to add debugfs metrics for cpuidle in order
>> to read some statistics from there and investigate the behavior ?
> 
> What exactly would you like to see in there?

It could be interesting to have statistics on a per cpu and global basis
for:

- prediction accuracy:

/sys/kernel/debug/cpuidle/prediction/[good|over|under]
/sys/kernel/debug/cpuidle/cpu*/state*/prediction/[good|over|under]

 - exit latency

In addition, it is often the case the idle states values are dropped
randomly, it is interesting to see the average exit latency for the
states. That could give also an indication the cluster idle state success.

/sys/kernel/debug/cpuidle/state*/latency/[min|max|avg|stddev]
/sys/kernel/debug/cpuidle/cpu*/state*/prediction/[min|max|avg|stddev]

And perhaps more information like the tick stopped stat ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
