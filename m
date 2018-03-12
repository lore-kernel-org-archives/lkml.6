Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCLUsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932171AbeCLUsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:48:08 -0400
Subject: Re: [PATCH v4 1/6] sysctl: Add flags to support min/max range
 clamping
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-2-git-send-email-longman@redhat.com>
 <20180312204413.GY4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <53093737-776f-d455-5651-3a57d5ac7be9@redhat.com>
Date: Mon, 12 Mar 2018 16:48:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312204413.GY4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 04:44 PM, Luis R. Rodriguez wrote:
> On Mon, Mar 12, 2018 at 04:15:39PM -0400, Waiman Long wrote:
>> When minimum/maximum values are specified for a sysctl parameter in
>> the ctl_table structure with proc_dointvec_minmax() handler, update
>> to that parameter will fail with error if the given value is outside
>> of the required range.
>>
>> There are use cases where it may be better to clamp the value of
>> the sysctl parameter to the given range without failing the update,
>> especially if the users are not aware of the actual range limits.
>> Reading the value back after the update will now be a good practice
>> to see if the provided value exceeds the range limits.
>>
>> To provide this less restrictive form of range checking, a new flags
>> field is added to the ctl_table structure.
>>
>> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
>> entry, any update from the userspace will be clamped to the given
>> range without error if either the proc_dointvec_minmax() or the
>> proc_douintvec_minmax() handlers is used.
> You keep missing to document both on commit log and kdoc which
> end on the range is selected if you happen to go over. To be clear
> it is unclear from reading the commit log if a default is set if
> you go over if you pick another value. In this case it is conditional
> if you go over we pick the high range max, and if you go below the
> lower range minimum set allowed.
>
> What happens if no low range is set and that is what the issue in
> terms of range triggers?

Sorry for missing that.

If a minimum value is not specified, no minimum checking and clamping
will be done. Similarly for maximum. I will clarify that.

Cheers,
Longman
