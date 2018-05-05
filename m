Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeEEIg4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:36:56 -0400
Received: from mout.web.de ([212.227.17.12]:50687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:36:40 -0400
Subject: Re: [PATCH v2] KVM: X86: Limit timer frequency to 200ms
To: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <1525131328-27086-1-git-send-email-wanpengli@tencent.com>
 <CANRm+CwcjUqNzWK3qVzGbuzgVLTYTyVtwSGgnVd2Ui4sxE+VkQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <96fca559-9759-0c2f-6e3b-98877c7340d3@web.de>
Date: Sat, 5 May 2018 10:36:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CANRm+CwcjUqNzWK3qVzGbuzgVLTYTyVtwSGgnVd2Ui4sxE+VkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:joWdx8OweVHXlcqJg+lZJxlAmjjcsHtlc3+Uh0cUA02V8fn+1EN
 Z28hlhjj8ox1eJnmMxBGB18y9XPAFxFSYIp/w4X/LEMcGFzYjHv2bn1f1QkXbbfhrRDhILp
 9EaFvpeSNW7P5tHz9ehoTiix39k8VScUPrHQH3hmDJXVvHiNinTxpmHUicjRXKhFmzLBgZD
 yEfKwya0blKw8Xv08twUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DwwnOmW4694=:vdf9Ef1hj8PXkPU+ypPMNt
 jvQY/zqAAJIzXyZ8PjBMyq4l4Qh3Rm8eUMa0PVAw4W2Gf39QfFxdEUwVW99nXZCQ+fuZy19zR
 hnRJ63MKjtNSdX3XuFRLCZ40xj/xy4dxfKP2wCH2HfsdqBSo95MP5oIqR0pfRkN6ZFMDGt1ah
 kobWdcGP5dslCVVVUrixBQf91PF2VowrO9ZGY/P425GEe3gMLe0YY3Z7l/iGaeOTYbT6AluOm
 jz6o0E07JA+sAh/z8AqWNA+tJ0Qnqr6ECBwFn94WVX4BAGozidYcFSoNQFrnn+rRTEG5dWtwI
 GK1KUJO9DkMN1A3g9i4qf2LVKLcqjR+IQPHzwLhRRVFca16Y6ik2uryL43WZUPB3k/AJqaQ7I
 IONzrDw+eoZQ7cO8Czg6zzpEaOIKt5feS6WrFHnG+xczjgp528VMrK83ntS9oSzf+67taJhan
 LMUXKZTojJfBGkR7snEKxHZtAGA28QgKZ06TJ2JilpTAcHvdlxBodIRXyRCjD/Wkd8fIrUWGF
 pnmitrjakaj58M0hNpgiKqnzOHF+3tz8JAqByPcMhN6Ya8Y8WsDB2XGc8nokv3o3iWyRzAro6
 DSSta9RonkSHWrrarjfHFk/W7VJDaQfz6BdM8+4RLEaZ92+6SPTZnB8qY6yGrR8oL/KlGxlbR
 7TplA8sgN/NyQvTHwBYR7+vEN9esHOBXCYrToMJqDd2UmikfQw+aluOSVGzmjbRL6SKkdU4/3
 9Cs8IL4UdUPVzWl1g6fRYd845tO5UdFZ1A+MyWCNIM6MH7r4SbLGKKDYE0LmWlAdRqgnNgsYp
 6nLZE1J
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-05 01:44, Wanpeng Li wrote:
> ping,
> 2018-05-01 7:35 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Anthoine reported:
>>  The period used by Windows change over time but it can be 1 milliseconds
>>  or less. I saw the limit_periodic_timer_frequency print so 500
>>  microseconds is sometimes reached.
>>
>> As suggested by Paolo, lower the timer frequency limit to a
>> smaller interval of 200 ms (5000 Hz) to leave some headroom. This
>> is required due to Windows 10 changing the scheduler tick limit
>> from 1024 Hz to 2048 Hz.

"... lower the *default* timer frequency limit to a smaller interval of
200 *us* ..." - same for the subject.

(Amazing that even Windows 10 still uses periodic ticks.)

Jan

>>
>> Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
>> Cc: Darren Kenny <darren.kenny@oracle.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> v1 -> v2:
>>  * update patch subject and description
>>
>>  arch/x86/kvm/x86.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 51ecd38..dc47073 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -114,7 +114,7 @@ module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
>>  static bool __read_mostly report_ignored_msrs = true;
>>  module_param(report_ignored_msrs, bool, S_IRUGO | S_IWUSR);
>>
>> -unsigned int min_timer_period_us = 500;
>> +unsigned int min_timer_period_us = 200;
>>  module_param(min_timer_period_us, uint, S_IRUGO | S_IWUSR);
>>
>>  static bool __read_mostly kvmclock_periodic_sync = true;
>> --
>> 2.7.4
>>
> 
