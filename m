Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeCSGrt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:47:49 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35072 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755122AbeCSGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:47:47 -0400
X-Google-Smtp-Source: AG47ELsldQ15QIgq5+AkKL4VMXRmzYITcR5jzxn4LqwZL2WCGlb9pyOB/06jUdfjNdV5Sb1f22pTovQeNc6g3hUtwxo=
MIME-Version: 1.0
In-Reply-To: <20180319063708.GB20345@oracle.com>
References: <001a114aacf82781120565c9f4fe@google.com> <CACT4Y+Y_K_GQq0ZgwMNEWuHx6k3BWQZKCoNT8BOWsB-mxL2Szw@mail.gmail.com>
 <20180319063708.GB20345@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 Mar 2018 09:47:26 +0300
Message-ID: <CACT4Y+ZMbLyxvOAz-rXfxkZOdqDAnLWNbg-K8n93k2JYUtdOYQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in rds_cong_queue_updates
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: syzbot <syzbot+80c06fb3aabfa386bc06@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 9:37 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (03/19/18 09:29), Dmitry Vyukov wrote:
>>
>> This looks the same as:
>>
>> #syz dup: KASAN: use-after-free Read in rds_cong_queue_updates
>
> correct, seems like the rds_destroy_pending() fixes did not seal
> this race condition. I need to look at this more carefully to see
> what race I missed.. no easy answer here, I am afraid.


Hi Sowmini,

What fix do you mean? syzbot does not know about any fixes for any of
the bugs as far as I see. So maybe your fix actually fixed it, but
it's not in upstream yes, and syzbot still finds this in upstream.
We tell syzbot about fixes (with Reported-by tags or "#syz fix" email
commands) to be able to later make sense of the state of the bugs.
