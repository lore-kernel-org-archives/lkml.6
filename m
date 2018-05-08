Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeEHS5k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:57:40 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:41943 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeEHS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:57:38 -0400
X-Google-Smtp-Source: AB8JxZodKAQ7D6amY/EOGFrmlSsx3HB7+/L9TpKgkYHfGI/JmvRcVVtroudIuSXMFnrGudLMhdS3sQ==
Date: Tue, 8 May 2018 15:57:32 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: syzbot <syzbot+141d898c5f24489db4aa@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, syzkaller-bugs@googlegroups.com,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_do_sm
Message-ID: <20180508185732.GP5105@localhost.localdomain>
References: <000000000000c10690056bb22ccd@google.com>
 <CADvbK_d8O7b9OCfCKGhaaQuBafi6rgkKEQh9Bk7pvZKX3KDKCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_d8O7b9OCfCKGhaaQuBafi6rgkKEQh9Bk7pvZKX3KDKCg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 01:41:03AM +0800, Xin Long wrote:
...
> >  sctp_chunk_destroy net/sctp/sm_make_chunk.c:1481 [inline]
> >  sctp_chunk_put+0x321/0x440 net/sctp/sm_make_chunk.c:1504
> >  sctp_ulpevent_make_rcvmsg+0x955/0xd40 net/sctp/ulpevent.c:718
> There's no reason to put the chunk in sctp_ulpevent_make_rcvmsg's
> fail_mark err path before holding this chunk later there.
>
> We should just remove it.

Oups. Agreed.

  Marcelo
