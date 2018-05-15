Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeEOHEX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:04:23 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44181 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeEOHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:04:21 -0400
X-Google-Smtp-Source: AB8JxZp9TTVJPg/J3S1YNq85AFKKjezt06KusJyhGUZ7MWOYgOcuaZAl3j79kj+Y+PLTfs5YiQD1kYPw/reaxKdqqqo=
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiL+x0Q8jgUZFOmrM5yndE0sDRRTSci2B-y5Y-r+QMCxA@mail.gmail.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com> <CAOQ4uxiL+x0Q8jgUZFOmrM5yndE0sDRRTSci2B-y5Y-r+QMCxA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 10:04:20 +0300
Message-ID: <CAOQ4uxgDFb1jgKBx9p=DVXqBpx_Jiw_zDggf5PPN+=qhv-xTsw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 8:42 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, May 14, 2018 at 10:31 PM, Waiman Long <longman@redhat.com> wrote:
>> The percpu_rwsem_release() is called when the ownership of the embedded
>> rwsem is to be transferred to another task. The new owner, however, may
>> take a while to get the ownership of the lock via percpu_rwsem_acquire().
>> During that period, the rwsem is now marked as writer-owned with no
>> optimistic spinning.
>>
>
> Waiman,
>
> Thanks for the fix. I will test it soon.
>
> For this commit message I suggest that you add parts of the reproducer
> found here:
> https://marc.info/?l=linux-fsdevel&m=152622016219975&w=2
>

fsfreeze is happy with these changes.

You may add:
Tested-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
