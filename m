Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeEGTOc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:14:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbeEGTOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:14:30 -0400
Subject: Re: [PATCH v6 0/8] ipc: Clamp *mni to the real IPCMNI limit &
 increase that limit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
 <87po2ex0k6.fsf@xmission.com>
 <5aac35f0-77e3-5693-ddf0-a03695ff1192@redhat.com>
 <87tvrqf66r.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a767b365-0646-55fe-6c23-f05c212c9104@redhat.com>
Date: Mon, 7 May 2018 15:14:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87tvrqf66r.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 11:06 AM, Eric W. Biederman wrote:
>
>>> and or users that may or may not exist.  If you can find something that
>>> will care sure.  We need to avoid breaking userspace and causing
>>> regressions.  However as this stands it looks you are making maintenance
>>> of the kernel more difficult to avoid having to look to see if there are
>>> monsters under the bed.
>> I shall admit that it can be hard to find applications that will
>> explicitly need that as we usually don't have access to the applications
>> that the customers have. It is more a correctness issue where the
>> existing code is kind of lying about what can actually be supported. I
>> just want to make the users more aware of what the right limits are.
> You presume the kernel is lying to applications.  I admit the kernel
> can lie to applications.  I don't see any evidence that the kernel is
> actually doing so.  So far (to me) it looks like a large number of sysv
> shared memory segments is not particulalry common.
>
> So I would not be at all surprised if no regressions would be generated
> if you simply deny setting the value past the maximum.

Maybe you are right. I will update the patchset to fail the update if
the range is exceeded since I had added option of extending the limit if
the users choose to do so.

Cheers,
Longman
