Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA7C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354C42087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asJ90udZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354C42087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJHQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:27:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44522 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeJHQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:27:03 -0400
Received: by mail-io1-f67.google.com with SMTP id x26-v6so15289861iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mbli7CMmIfNi0JObzelbupTxAGlZUk3IRM+vMOHrQHk=;
        b=asJ90udZ2VHW+r/A3ESWzsXPn1cEukla8aTu9cQ7k6MZp/ofoyTmka9OU6ZcotegMe
         /zWfCbghZ50V7y/V6x6htEAksvSqwgN/5TtacoNKOfv+2gZ6gZImDVRQJeE/Abf+OUIO
         5b1LnsOKTDscf2JFlbL2Dom6qQkIF+qzgAMr74CZ5JkE2+OllhuWaiUoUpL2l+gOMwji
         Pz58cLdBlz0cUE5TAC6znI68/GD3tClXkUboKmpzLfBjLYmg8uiglofpChB9pMtqMYZm
         Evq2NvTIsvCFGU+UU17/mbWCMKjZHA3sz5+8xo+yAMokg7wtYilfmgfzB/iv5/Pse37c
         ur8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mbli7CMmIfNi0JObzelbupTxAGlZUk3IRM+vMOHrQHk=;
        b=lqe9IAAD4SuPPgOjvgYU/avJijUJaOFkIzBj9FYITCyNQSxpFLHH1c8jAKfP76ZRqo
         R9D++p9IXhcRNrEnWQERAV+LgEkIOyRM2zW9+BjaptdsnUbmYEL/yyLZNKbWhI9M6jG4
         WvoCjx6JFJvVsU2KrrV0BBxCqZVfBrD8XM3HAfNXXusGm8tUPkLd3J5debslO8hCxQDI
         pN7Jpy0425ubUA4KBquDM2luTxVhzdi7bfeIyktTznapsfLQvGC93pRW8M0PhIwe+/Ma
         Sw7Cr1Y2jC5Xivrs5nU7Z0ik2+JASbfjCfnjyV/ltT+sZV/J9xSDy3XG4IhXHvKuW2bJ
         M2tw==
X-Gm-Message-State: ABuFfogPJEJOJetqyRdrreEtv4Ecp1tom80lS3fk5g7z0rzlB/Xfj0Os
        EoLnuxT+crTkZaGjkCFR0fTTxztcTNrjTQ/Kj1bN2A==
X-Google-Smtp-Source: ACcGV62K5Dmr0izWHrIpG+722GMUFoVav3DxBY4MP8do16F/e98UHFAeFm/sb8b5BZPSvzNQYtkMNrBRn2tPTLOkJ9E=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr5392254iog.11.1538990178370;
 Mon, 08 Oct 2018 02:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 02:15:57 -0700 (PDT)
In-Reply-To: <20181005163320.zkacovxvlih6blpp@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Oct 2018 11:15:57 +0200
Message-ID: <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 6:33 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-10-05 18:30:18 [+0200], To Clark Williams wrote:
>> This is the minimum to get this working on RT splat free. There is one
>> memory deallocation with irqs off which should work on RT in its current
>> way.
>> Once this and the on_each_cpu() invocation, I was wondering if=E2=80=A6
>
> the patch at the bottom wouldn't work just fine for everyone.
> It would have the beaty of annotating the locking scope a little and
> avoiding the on_each_cpu() invocation. No local_irq_save() but actually
> the proper locking primitives.
> I haven't fully decoded the srcu part in the code.
>
> Wouldn't that work for you?

Hi Sebastian,

This seems to beak quarantine_remove_cache( ) in the sense that some
object from the cache may still be in quarantine when
quarantine_remove_cache() returns. When quarantine_remove_cache()
returns all objects from the cache must be purged from quarantine.
That srcu and irq trickery is there for a reason.
This code is also on hot path of kmallock/kfree, an additional
lock/unlock per operation is expensive. Adding 2 locked RMW per
kmalloc is not something that should be done only out of refactoring
reasons.

The original message from Clark mentions that the problem can be fixed
by just changing type of spinlock. This looks like a better and
simpler way to resolve the problem to me.


> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/kasan/quarantine.c | 45 +++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 3a8ddf8baf7dc..8ed595960e3c1 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -39,12 +39,13 @@
>   * objects inside of it.
>   */
>  struct qlist_head {
> +       spinlock_t      lock;
>         struct qlist_node *head;
>         struct qlist_node *tail;
>         size_t bytes;
>  };
>
> -#define QLIST_INIT { NULL, NULL, 0 }
> +#define QLIST_INIT {.head =3D NULL, .tail =3D NULL, .bytes =3D 0 }
>
>  static bool qlist_empty(struct qlist_head *q)
>  {
> @@ -95,7 +96,9 @@ static void qlist_move_all(struct qlist_head *from, str=
uct qlist_head *to)
>   * The object quarantine consists of per-cpu queues and a global queue,
>   * guarded by quarantine_lock.
>   */
> -static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine);
> +static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine) =3D {
> +       .lock =3D __SPIN_LOCK_UNLOCKED(cpu_quarantine.lock),
> +};
>
>  /* Round-robin FIFO array of batches. */
>  static struct qlist_head global_quarantine[QUARANTINE_BATCHES];
> @@ -183,12 +186,13 @@ void quarantine_put(struct kasan_free_meta *info, s=
truct kmem_cache *cache)
>          * beginning which ensures that it either sees the objects in per=
-cpu
>          * lists or in the global quarantine.
>          */
> -       local_irq_save(flags);
> +       q =3D raw_cpu_ptr(&cpu_quarantine);
> +       spin_lock_irqsave(&q->lock, flags);
>
> -       q =3D this_cpu_ptr(&cpu_quarantine);
>         qlist_put(q, &info->quarantine_link, cache->size);
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>                 qlist_move_all(q, &temp);
> +               spin_unlock(&q->lock);
>
>                 spin_lock(&quarantine_lock);
>                 WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes)=
;
> @@ -203,10 +207,10 @@ void quarantine_put(struct kasan_free_meta *info, s=
truct kmem_cache *cache)
>                         if (new_tail !=3D quarantine_head)
>                                 quarantine_tail =3D new_tail;
>                 }
> -               spin_unlock(&quarantine_lock);
> +               spin_unlock_irqrestore(&quarantine_lock, flags);
> +       } else {
> +               spin_unlock_irqrestore(&q->lock, flags);
>         }
> -
> -       local_irq_restore(flags);
>  }
>
>  void quarantine_reduce(void)
> @@ -284,21 +288,11 @@ static void qlist_move_cache(struct qlist_head *fro=
m,
>         }
>  }
>
> -static void per_cpu_remove_cache(void *arg)
> -{
> -       struct kmem_cache *cache =3D arg;
> -       struct qlist_head to_free =3D QLIST_INIT;
> -       struct qlist_head *q;
> -
> -       q =3D this_cpu_ptr(&cpu_quarantine);
> -       qlist_move_cache(q, &to_free, cache);
> -       qlist_free_all(&to_free, cache);
> -}
> -
>  /* Free all quarantined objects belonging to cache. */
>  void quarantine_remove_cache(struct kmem_cache *cache)
>  {
>         unsigned long flags, i;
> +       unsigned int cpu;
>         struct qlist_head to_free =3D QLIST_INIT;
>
>         /*
> @@ -308,7 +302,20 @@ void quarantine_remove_cache(struct kmem_cache *cach=
e)
>          * achieves the first goal, while synchronize_srcu() achieves the
>          * second.
>          */
> -       on_each_cpu(per_cpu_remove_cache, cache, 1);
> +       /* get_online_cpus() invoked by caller */
> +       for_each_online_cpu(cpu) {
> +               struct qlist_head *q;
> +               unsigned long flags;
> +               struct qlist_head to_free =3D QLIST_INIT;
> +
> +               q =3D per_cpu_ptr(&cpu_quarantine, cpu);
> +               spin_lock_irqsave(&q->lock, flags);
> +               qlist_move_cache(q, &to_free, cache);
> +               spin_unlock_irqrestore(&q->lock, flags);
> +
> +               qlist_free_all(&to_free, cache);
> +
> +       }
>
>         spin_lock_irqsave(&quarantine_lock, flags);
>         for (i =3D 0; i < QUARANTINE_BATCHES; i++) {
> --
> 2.19.0
>
