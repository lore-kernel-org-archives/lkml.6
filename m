Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeCLVE7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:04:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932372AbeCLVE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:04:58 -0400
Subject: Re: [PATCH v4 3/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-4-git-send-email-longman@redhat.com>
 <20180312140027.97db31d5dfc5c5f52a7c19a3@linux-foundation.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ddfd63f8-f061-72ab-744e-1e6cf9c764b7@redhat.com>
Date: Mon, 12 Mar 2018 17:04:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180312140027.97db31d5dfc5c5f52a7c19a3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 05:00 PM, Andrew Morton wrote:
> On Mon, 12 Mar 2018 16:15:41 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed into the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>>
>> The pr_warn_ratelimited() macro is used to limit the number of warning
>> messages that can be printed within a given period of time.
>>
>> ...
>>
>> +#ifdef pr_fmt
>> +#undef pr_fmt
>> +#endif
>> +#define pr_fmt(fmt)	"sysctl: " fmt
> Why is it necessary to undefine pr_fmt?  That's a somewhat unusual
> thing to do.
>
>
Because it is defined in the printk.h. I should have put the pr_fmt
definition before the iinclude file to eliminate the need to undefine it.

-Longman
