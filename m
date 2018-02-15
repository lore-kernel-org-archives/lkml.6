Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755201AbeBOJOb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:14:31 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:44104 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeBOJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:14:29 -0500
X-Google-Smtp-Source: AH8x226cVSb9OULd5kJJZ5NOQBrhz1zZzgTb5t6YDDWA0Msr15BHd2C6LiFzJJ2Fsqr9sDz4e30jmqFCnKpxj9ALcOc=
MIME-Version: 1.0
In-Reply-To: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
References: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 15 Feb 2018 10:14:27 +0100
Message-ID: <CAFLxGvz2t8rnEQh4VBJ8v3b66GKA5DY3iMk33jnMP664+RMubw@mail.gmail.com>
Subject: Re: fs_struct refcounting: spinlock vs atomic
To: Enrico Weigelt <lkml@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:13 PM, Enrico Weigelt <lkml@metux.net> wrote:
> Hi folks,
>
>
> in fork.c, a spinlock is held for fs_struct refcounting, while other
> places - eg. switch_task_namespaces uses atomic_dec_and_test() on
> the nsproxy.
>
> What's the exact difference here ? Could the atomic counting also used
> for fs_struct ?

Well, the spinlock protects more than just the counter. So atomic won't do it.

-- 
Thanks,
//richard
