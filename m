Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AFD26491
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD7H9K36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AFD26491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965352AbeFZDaD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:30:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37512 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965262AbeFZDaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:30:01 -0400
Received: by mail-io0-f196.google.com with SMTP id s26-v6so14572653ioj.4;
        Mon, 25 Jun 2018 20:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJscD5jYd8wrwKJyW2Mo2AGrvTO+wOt/GAXtKoL0XIo=;
        b=KD7H9K36nEaXlgCW7QVZebu0irmyy3nGjBGOq92qSpcAT+ZNtHOpvyQKwuAwmYPAGI
         zYKfYYNh4poChPo5+GCZQ0EDUX9+8cgaa2m5CclXCah67U9ZoC3eg3b+pXxldayAx7qm
         jT0ZJC5NHRz4aX9f3+a+at6gtmGe69knau4UB/qnjf1g9XdeDB9NezqUxKi2gLVEuVPB
         l4yqXUq0mWgVd7L5pdCMT14IrE7rKqI5CmD/QZYdVCEdPuFjUpwWAnda5hd+eUTA7nkK
         P+O09Gj0NkrfeJdyyjsv/qfPMM3I2O7PhybLBbz31DkUYIx89gPAqu6On1EE/RhrdROK
         X46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJscD5jYd8wrwKJyW2Mo2AGrvTO+wOt/GAXtKoL0XIo=;
        b=sHFcglWOA3o5uSJ1Vg9y8YoZ3lsddU+vqHtZodTaX5Sx/3C2/9t8KBC4FC/LsMHjpu
         Zw3+63+jtniw2W2H4KmdleE3ka/UX2VcN76ZATxFJ1aGPyyCX8k9RVqoDKatDB2iTrMF
         DcyiWaC5oJ8uE1AlRAVI3pV1aBVhbt7pbs3h6G46oEC5CiuHPL8qXz+aCv/kn43Y0XYI
         oVuf/6s4iA5vj6ny/6+9Y+UwvkyIJXNBtnAYt6TmswdUDidrFjYIN4c2aVPvHXYzNupU
         EAlGcGhX6pS30NtG3x9G392Jz4oWU0lkpQmErulbwP2Laz1xO0UsYrNJken8D7xy6RZN
         gR0g==
X-Gm-Message-State: APt69E17uoVT5ZeD9ZSy8oBXD6SFlgy0GI9pZfFL0imqKaqrO68cdPy4
        YDjWaagqq+ZaHE4nCVADBIDxaLIJ7W2f7CfdKQ==
X-Google-Smtp-Source: AAOMgpeFeyju4eEtLYoJkXy3d+S75FnT6peKcc3z9lhR0fjuy5EJ5er53IYydOLgG/ZnbVLRvPqo/7rwbsQ2LyufYDo=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr13098327iov.203.1529983800699;
 Mon, 25 Jun 2018 20:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
 <1529912859-10475-3-git-send-email-kernelfans@gmail.com> <20180625104505.GA3058@kroah.com>
In-Reply-To: <20180625104505.GA3058@kroah.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 26 Jun 2018 11:29:48 +0800
Message-ID: <CAFgQCTt6MTwXbbcQCcJroM3wGdx+5c7A+eVy+dXJscu1JtfA-w@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] drivers/base: reorder consumer and its children
 behind suppliers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 25, 2018 at 03:47:39PM +0800, Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > introduces supplier<-consumer order in devices_kset. The commit tries
> > to cleverly maintain both parent<-child and supplier<-consumer order by
> > reordering a device when probing. This method makes things simple and
> > clean, but unfortunately, breaks parent<-child order in some case,
> > which is described in next patch in this series.
>
> There is no "next patch in this series" :(
>
Oh, re-arrange the patches, and forget the comment in log

> > Here this patch tries to resolve supplier<-consumer by only reordering a
> > device when it has suppliers, and takes care of the following scenario:
> >     [consumer, children] [ ... potential ... ] supplier
> >                          ^                   ^
> > After moving the consumer and its children after the supplier, the
> > potentail section may contain consumers whose supplier is inside
> > children, and this poses the requirement to dry out all consumpers in
> > the section recursively.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> > note: there is lock issue in this patch, should be fixed in next version
>
> Please send patches that you know are correct, why would I want to
> review this if you know it is not correct?
>
> And if the original commit is causing problems for you, why not just
> revert that instead of adding this much-increased complexity?
>
Revert the original commit, then it will expose the error  order
"consumer <- supplier" again.
This patch tries to resolve the error and fix the following scenario:
step0:  before the consumer device's probing,  (note child_a is a
supplier of consumer_a, etc)
[ consumer-X,  child_a, ...., child_z]     [.... consumer_a, ...,
consumer_z, ....]    supplier-X
                                                             ^^^
affected range during moving^^^
step1: When probing, moving consumer-X after supplier-X
[ child_a, ...., child_z]     [.... consumer_a, ...,     consumer_z,
....]   supplier-X, consumer-X
But it breaks "parent <-child" seq now, and should be fixed like:
step2:
[.... consumer_a, ...,     consumer_z, ....]  supplier-X  [
consumer-X,  child_a, ...., child_z]    <---
descendants_reorder_after_pos() does it.
Again, the seq "consumer_a <- child_a" breaks the "supplier<-consumer"
 order, should be fixed like:
step3:
[....  consumer_z, .....]  supplier-X  [ consumer-X,  child_a,
consumer_a ...., child_z]   <--- __device_reorder_consumer() does it.
^^ affected range^^
The moving of consumer_a brings us to face the same scenario of step1,
hence we need an external recursion.

Each round of step3,  __device_reorder_consumer() resolves its "local
affected range", which is a fraction of the "whole affected range".
Hence finally, we have all potential consumers in affected range resolved.
(Maybe I can split patch at step2 and step3 to ease the review for the
next version)

Since __device_reorder_consumer() has already hold devices_kset's spin
lock, and need to get srcu lock on devices->links.consumers.
This needs a breakage of spin lock, and will incur much effort. If the
above algorithm is fine, I can do it.
>
>
> >
> > ---
> >  drivers/base/core.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 129 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 66f06ff..db30e86 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -123,12 +123,138 @@ static int device_is_dependent(struct device *dev, void *target)
> >       return ret;
> >  }
> >
> > -/* a temporary place holder to mark out the root cause of the bug.
> > - * The proposal algorithm will come in next patch
> > +struct pos_info {
> > +     struct device *pos;
> > +     struct device *tail;
> > +};
> > +
> > +/* caller takes the devices_kset->list_lock */
> > +static int descendants_reorder_after_pos(struct device *dev,
> > +     void *data)
>
> Why are you wrapping lines that do not need to be wrapped?
>
OK, will fix.

> What does this function do?
>
As the name implies, reordering dev and its children after a position.
When moving a consumer after a supplier, we break down the order
of  "parent <-child" order of consumer and its children in devices_kset.
Hence we should move the children too.
The param "data"  contains the position info, and its name is not
illuminated :(,
since the func proto is required by device_for_each_child(), may be better to
name it as postion_info

> > +{
> > +     struct device *pos;
> > +     struct pos_info *p = data;
> > +
> > +     pos = p->pos;
> > +     pr_debug("devices_kset: Moving %s after %s\n",
> > +              dev_name(dev), dev_name(pos));
>
> You have a device, use it for debugging, i.e. dev_dbg().
>
But here we have two devices.

> > +     device_for_each_child(dev, p, descendants_reorder_after_pos);
>
> Recursive?
>
Yes, in order to move all children of the consumer.

> > +     /* children at the tail */
> > +     list_move(&dev->kobj.entry, &pos->kobj.entry);
> > +     /* record the right boundary of the section */
> > +     if (p->tail == NULL)
> > +             p->tail = dev;
> > +     return 0;
> > +}
>
> I really do not understand what the above code is supposed to be doing :(
>
The moved consumer's children may be  suppliers of devices,
[.... consumer_a, ...,     consumer_z, ....]    supplier-X      [
consumer-X,  child_a, ............, child_z]
^^^    potential consumers  ^^^^^^

                                           ^^potential suppliers^^
Now,  consumer_a and its supplier child_a  violate the order
"supplier<-consumer".
To pick out such violation, we need to check the potential suppliers
against potential
consumers. And p->tail helps to record the new moved position of child_z.

> > +
> > +/* iterate over an open section */
> > +#define list_opensect_for_each_reverse(cur, left, right)     \
> > +     for (cur = right->prev; cur == left; cur = cur->prev)
> > +
> > +static bool is_consumer(struct device *query, struct device *supplier)
> > +{
> > +     struct device_link *link;
> > +     /* todo, lock protection */
>
> Always run checkpatch.pl on patches so you do not get grumpy maintainers
> telling you to run checkpatch.pl :(
>
Yes, I had run it, and only got a warning:
WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
rather than BUG() or BUG_ON()
#167: FILE: drivers/base/core.c:245:
+ BUG_ON(!ret);

total: 0 errors, 1 warnings, 141 lines checked

> > +     list_for_each_entry(link, &supplier->links.consumers, s_node)
> > +             if (link->consumer == query)
> > +                     return true;
> > +     return false;
> > +}
> > +
> > +/* recursively move the potential consumers in open section (left, right)
> > + * after the barrier
>
> What barrier?
>
A position that moved devices can not cross before.

> I'm stopping here as I have no idea what is going on, and this needs a
> lot more work at the basic level of "it handles locking correctly"...
>
> If you are working on this for power9, I'm guessing you work for IBM?

No. I just hit this bug.

> If so, please run this through your internal patch review process before
> sending it out again...
>
I will try my best to find some guys to review. But is the assumption
of step0 and
the following algorithm worth to try?

Thanks and regards,
Pingfan
