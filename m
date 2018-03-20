Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCTQ5d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:57:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59443 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCTQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:57:31 -0400
X-Google-Smtp-Source: AG47ELv4kYk/2KWyHjhUf8TSwwQ8T3mT5krMwbxejEkqW7M9lyYzZlxe3WZhS358sxcBXpvWfj6DEg==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: tg3 crashes under high load, when using 100Mbits
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CA+oDAx908Dpn93-c4ogS5F1XZJri9GC_WaFR8wuDKO47kygB5w@mail.gmail.com>
Date: Wed, 21 Mar 2018 00:57:23 +0800
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
Content-Transfer-Encoding: 8bit
Message-Id: <48279E27-4FCB-4A3F-8F4A-E26581020D2A@canonical.com>
References: <CA+oDAx908Dpn93-c4ogS5F1XZJri9GC_WaFR8wuDKO47kygB5w@mail.gmail.com>
To: Satish Baddipadige <satish.baddipadige@broadcom.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satish Baddipadige <satish.baddipadige@broadcom.com> wrote:

> On Thu, Feb 15, 2018 at 7:37 PM, Siva Reddy Kallam
> <siva.kallam@broadcom.com> wrote:
>> On Mon, Feb 12, 2018 at 10:59 AM, Siva Reddy Kallam
>> <siva.kallam@broadcom.com> wrote:
>>> On Fri, Feb 9, 2018 at 10:41 AM, Kai Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> Hi Broadcom folks,
>>>>
>>>> We are now enabling a new platform with tg3 nic, unfortunately we  
>>>> observed
>>>> the bug [1] that dated back to 2015.
>>>> I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762  
>>>> MRRS to
>>>> 2048”) but it does’t work.
>>>>
>>>> Do you have any idea how to solve the issue?
>>>>
>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664
>>>>
>>>> Kai-Heng
>>> Thank you for reporting. We will check and update you.
>> With link aware mode, the clock speed could be slow and boot code does not
>> complete within the expected time with lower link speeds. Need to override
>> and the clock in driver. We are checking the feasibility of adding
>> this in driver or firmware.
>
> Hi Kai-Heng,
>
> Can you please test the attached patch?

I built a kernel and asked affected users to try.

Thanks for your work.

Kai-Heng

>
> Thanks,
> Satish
> <tg3_5762_clock_override.patch>
