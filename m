Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeBLMAY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:00:24 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:46927 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeBLMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:00:22 -0500
X-Google-Smtp-Source: AH8x225JzuZtJgK6WjL8M7mMvDaP3G8CbyDOMNszweT+QoST+2dAJJ6NpGc2LXYoEMs4Oa6wXrujwNhw5+nUXdBsyLM=
MIME-Version: 1.0
In-Reply-To: <20180129065053.GC20230@1wt.eu>
References: <1516979955-7466-1-git-send-email-baijiaju1990@gmail.com> <20180129065053.GC20230@1wt.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2018 13:00:21 +0100
Message-ID: <CANiq72=QsiiUgaQAh2Jp9Mh2Fmrkn=oNwNcQPT3mHX0THcqyiw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: delete mdelay in long_sleep
To: Willy Tarreau <w@1wt.eu>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 7:50 AM, Willy Tarreau <w@1wt.eu> wrote:
> Hi,
>
> On Fri, Jan 26, 2018 at 11:19:15PM +0800, Jia-Ju Bai wrote:
>> The function long_sleep() calls mdelay() when in an interrupt handler.
>> But only charlcd_clear_display() and charlcd_init_display calls
>> long_sleep(), and my tool finds that the two functions
>> are never called in an interrupt handler.
>> Thus mdelay() and in_interrupt() are not necessary.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>
> Looks good. This code is extremely old (started in 2.2) so I'm not
> surprised at all that after many changes such parts are not used
> anymore.
>
> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks for the patch and the ack, putting it in the queue.

Miguel

>
> Willy
