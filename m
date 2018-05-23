Return-Path: <SRS0=+d69=IK=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZpKZ8RLPI8C+tRJCO35/def2Z+rQt7bYC+g5vaPbOwq/4zPkXuEHh+T2wNesBTpmr0orXWF
ARC-Seal: i=1; a=rsa-sha256; t=1527037167; cv=none;
        d=google.com; s=arc-20160816;
        b=L5plyol6YX/XuGRanNWo8AcOq6i9PHCf5rL2yjjtTWog5qWIuKCkdFkdHiACll8Lo6
         OH8a2mtu+GofX0/LrtJ0CrlnIPfhhQVXmTT4HLomndd/cr8EPnzeUjB1wmvZ33ya3lQs
         LaTIf73GuVkvsBcAJbbYWpbehpSkHRQgV0oPsEgFgSJR8PjCl4BRi3wgsHptRrZA5IHd
         60b1+6w4WpfYEBGWBg6IZotcQfsZsQaGb5tIgNEKiCnWzLdPhlL7y4zcQsWc9PHi+72L
         43GFzpZDmQi2qtkqKXtoXLj9vuG2eq7qSDcAYZBgDQOf/T3uEq+jYbGthVceyZqhUcs3
         h49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=3BpgI8wcNaSRRSTa69l586ttR7ePvuSaQP8w7f3K3t8=;
        b=zY/wzTYN/fjOsEuRU/bm8HqeZRIZEFOEnxfrIPoZMkV2M23HTdifhlmBjlLHs6iX4Q
         TIcwuQsy8FAwBafTNgoVEtMeOKhr0TRtgHq28cXV8iUDWFaXapoiTt/8MN0wongC3IJf
         ZXuDtpW6HTEilH1e++wmsJIUypDj8X/1en4y44pPAfnH0xesPXztM8cOts7uNlRN99S8
         mbUDc1s0MAvx9mSphZFRDTpQacPokjbn0JwL77CGa+ZbK1aCw+5bGhuCQ3IxiegWGYKp
         lR8C33ndNxYEaEav2j74th9MJMtrkimj9tkOa+2VL4NudcExgQTZhE2WsT4j7agtHV4D
         6VpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Date: Tue, 22 May 2018 20:59:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Philippe
 Ombredanne <pombredanne@nexb.com>, Al Viro <viro@zeniv.linux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Levin, Alexander (Sasha
 Levin)" <alexander.levin@verizon.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Fix typo in comment
Message-ID: <20180522205924.0f4781eb@gandalf.local.home>
In-Reply-To: <20180522205557.4cfa3c3f@gandalf.local.home>
References: <20180518203130.2011-1-gomonovych@gmail.com>
	<20180522205557.4cfa3c3f@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600835335190642114?=
X-GMAIL-MSGID: =?utf-8?q?1601214524561654458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 22 May 2018 20:55:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 May 2018 22:31:28 +0200
> Vasyl Gomonovych <gomonovych@gmail.com> wrote:
> 
> > Fix typo in the words 'reserved', 'been'  
> 
> Thanks, but someone sent me a bunch of spelling fixes for that file
> which included these. I'll be pushing that to linux-next soon.

I stand corrected. ring_buffer.c was fixed, but the "been" typo in
ring_buffer.h was not. I'll add that part of this patch.

-- Steve
> 
> > 
> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> > ---
> >  include/linux/ring_buffer.h | 2 +-
> >  kernel/trace/ring_buffer.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index 7d9eb39fa76a..aa500da87f2a 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -63,7 +63,7 @@ void *ring_buffer_event_data(struct ring_buffer_event *event);
> >  
> >  /*
> >   * ring_buffer_discard_commit will remove an event that has not
> > - *   ben committed yet. If this is used, then ring_buffer_unlock_commit
> > + *   been committed yet. If this is used, then ring_buffer_unlock_commit
> >   *   must not be called on the discarded event. This function
> >   *   will try to remove the event from the ring buffer completely
> >   *   if another event has not been written after it.
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index dcf1c4dd3efe..a8a8eb23c489 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2776,7 +2776,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
> >   * @buffer: the ring buffer to reserve from
> >   * @length: the length of the data to reserve (excluding event header)
> >   *
> > - * Returns a reseverd event on the ring buffer to copy directly to.
> > + * Returns a reserved event on the ring buffer to copy directly to.
> >   * The user of this interface will need to get the body to write into
> >   * and can use the ring_buffer_event_data() interface.
> >   *  
> 
