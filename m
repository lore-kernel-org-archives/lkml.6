Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeBKFqp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 00:46:45 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44156 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeBKFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 00:46:43 -0500
X-Google-Smtp-Source: AH8x226kMR7lsx0t/BTgOzgPcucOXwxDXyhH0we6C37xtihYUX9CLZt3uv+3NlMMA57tlajovGncJkI5oofU3TIqfEQ=
MIME-Version: 1.0
In-Reply-To: <20180211010201.GA14719@bombadil.infradead.org>
References: <CAErzpmu5o+tLJyY9GqkFEOn=KSs0q9pevCBWcvzpxDyV9RiC_Q@mail.gmail.com>
 <1518285863.16865.17.camel@perches.com> <20180211010201.GA14719@bombadil.infradead.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 11 Feb 2018 13:46:22 +0800
Message-ID: <CAErzpmtU+HOasX1PEpFyV6-aJgjn4KsH8mOa6ekySCEXCc_1ug@mail.gmail.com>
Subject: Re: [PATCH] seq_file: remove redundant assignment of index to m->index
To: Matthew Wilcox <willy@infradead.org>
Cc: Joe Perches <joe@perches.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 9:02 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Sat, Feb 10, 2018 at 10:04:23AM -0800, Joe Perches wrote:
>> > @@ -120,14 +120,12 @@ static int traverse(struct seq_file *m, loff_t offset)
>> >          if (pos + m->count > offset) {
>> >              m->from = offset - pos;
>> >              m->count -= m->from;
>> > -            m->index = index;
>> >              break;
>> >          }
>> >          pos += m->count;
>> >          m->count = 0;
>> >          if (pos == offset) {
>> >              index++;
>> > -            m->index = index;
>> >              break;
>> >          }
>> >          p = m->op->next(m, p, &index);
>>
>> Of course this looks correct, but how
>> are you _absolutely sure_ about this?
>>
>> Perhaps the m->op->stop(m, p) call below
>> the break, which takes m as an argument,
>> needs an updated m->index.
>
> Not only that, but ->next might also look at m->index.
I think there is no chance to call op->next, because the loop will
break immediately
after the assignment.
