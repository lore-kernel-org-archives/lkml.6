Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeENTgo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:36:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751422AbeENTgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:36:42 -0400
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
 <20180409112013.GA23240@redhat.com>
 <38c89c59-5ff0-20df-2628-880db397006e@redhat.com>
 <20180409142208.GA25893@redhat.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <63c13bd6-7f42-7d3f-3cda-f989f6982ae4@redhat.com>
Date: Mon, 14 May 2018 15:36:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180409142208.GA25893@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 10:22 AM, Oleg Nesterov wrote:
> On 04/09, Waiman Long wrote:
>> On 04/09/2018 07:20 AM, Oleg Nesterov wrote:
>>> Hmm. Can you look at lockdep_sb_freeze_release() and lockdep_sb_freeze_acquire()?
>> These 2 functions are there to deal with the lockdep code.
> Plus they clearly document why sem->owner check is not right when it comes
> to super_block->s_writers[]. Not only freeze and thaw can be called by
> different processes, we need to return to user-space with rwsem held for
> writing.

Sorry for the late reply as I was busy on other work.

I have just sent out a v2 patch to hopefully address your concern.
Please let me know your thought on that.

Thanks,
Longman
