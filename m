Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755699AbeCHTLL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:11:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752250AbeCHTLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:11:10 -0500
Subject: Re: [PATCH 0/5] sysctl: Enable easy addition of range showing sysctl
 parameters
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520454869-13871-1-git-send-email-longman@redhat.com>
 <20180308183442.GJ4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b1c56ec2-3c26-9235-7f16-f1ebf7109304@redhat.com>
Date: Thu, 8 Mar 2018 14:11:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308183442.GJ4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:34 PM, Luis R. Rodriguez wrote:
> On Wed, Mar 07, 2018 at 03:34:24PM -0500, Waiman Long wrote:
>>   % cat msgmni_range
>>   [0, 32768]
> All that sounds promising but I think you are jumping a few
> steps ahead of what needs to get done. Let's first sort out the
> first series well.
>
>   Luis

Yes, you are right. I will focus on the getting the first series right
first, before considering that.

In fact, I have a slight change of mind on how to do it. Instead of
adding a new _range parameter to show just the range of a particular
sysctl parameter, I am thinking of a generic sysctl_ranges parameter
that iterates all the ctl_table entries and list out the ranges of all
the parameters that are flagged to have a min/max range. That will
eliminate the interface clutter due to a bunch of new *_range /proc/sys
files.

-Longman
