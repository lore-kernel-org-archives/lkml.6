Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033509AbeCARkH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:40:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033270AbeCARkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:40:05 -0500
Subject: Re: [PATCH v2 2/5] sysctl: Add flags to support min/max range
 clamping
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-3-git-send-email-longman@redhat.com>
 <20180228004753.GY14069@wotan.suse.de>
 <23264b8f-e84d-48cf-0da0-eb328916b2aa@redhat.com>
 <20180228184325.GJ14069@wotan.suse.de>
 <e5ac80d5-2919-8944-293d-ee9b70f6ad02@redhat.com>
Organization: Red Hat
Message-ID: <5d13fde9-2b9e-69e8-c263-9fd9d093e293@redhat.com>
Date: Thu, 1 Mar 2018 12:40:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e5ac80d5-2919-8944-293d-ee9b70f6ad02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 01:58 PM, Waiman Long wrote:
> On 02/28/2018 01:43 PM, Luis R. Rodriguez wrote:
>> On Wed, Feb 28, 2018 at 12:53:40PM -0500, Waiman Long wrote:
>>> On 02/27/2018 07:47 PM, Luis R. Rodriguez wrote:
>>>> On Tue, Feb 27, 2018 at 03:49:48PM -0500, Waiman Long wrote:
>>>>> When minimum/maximum values are specified for a sysctl parameter in
>>>>> the ctl_table structure with proc_dointvec_minmax() handler,
>>>> an
>>>>
>>>>> update
>>>>> to that parameter will fail with error if the given value is outside
>>>>> of the required range.
>>>>>
>>>>> There are use cases where it may be better to clamp the value of
>>>>> the sysctl parameter to the given range without failing the update,
>>>>> especially if the users are not aware of the actual range limits.
>>>> Makes me wonder if we should add something which does let one query
>>>> for the ranges. Then scripts can fetch that as well.
>>> That will actually be better than printing out the range in the dmesg
>>> log. However, I haven't figured out an easy way of doing that. If you
>>> have any suggestion, please let me know about it.
>> I think a macro that also adds yet another proc read-only entry with a postfix
>> "_range" with an internal handler which prints the range may suffice.
>>
>>   Luis
> I think that is a possible solution. Instead of adding a macro, I will
> add one more flag which does the magic when the ctl_table entry is being
> processed. I think that will be simpler from the user point of view.
>
> Cheers,
> Longman
>
This patch will take a bit more time to work on. So I am going to do it
as a separate patch on top of the current one later. I don't want to
delay the review of the current patch set.

Cheers,
Longman
