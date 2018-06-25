Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9092025500
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcN1b1QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9092025500
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeFYHIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:08:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43749 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeFYHIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:08:52 -0400
Received: by mail-io0-f196.google.com with SMTP id i23-v6so8600125iog.10;
        Mon, 25 Jun 2018 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkmUga3+Yh2UhoJyPcxXWgWGL1B7mNDwop7EU/jFa3c=;
        b=tcN1b1QYCqDyUS9ciBhh44wikX1sbj+8VKoJ6Fie1HSJblNsGSTlZA5u6azP+jqDZv
         FMMBJcQKalVdzMicExZTOGamTuLp/pK29KyqiuX4cYyB56tbB8qoLpwDaxZBKhc9sr98
         gikhwWqGMaFx5k9lYVPUPXfuslI67sJHJD8PJvFWy0g6kAJW67givXKjgUFJL8uujyCC
         J4J+RKwX1lQJR7uKudhPMM7qYkXzvAkuZWZcUSjpg4raQRBAJGKcVZYQieSVHDFgaCzf
         PVAblbfRLfvQyCRriUPLqC8SKulU+MpFR84XNFVZGi6cb+j1EcbnhfiXRLrcwlZuNU1L
         QpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkmUga3+Yh2UhoJyPcxXWgWGL1B7mNDwop7EU/jFa3c=;
        b=jiL9zn/kXewjWtbaLBhIBiczQeMozC44DWwM/nPRIpl/ka2u2xfO6x/j/nmqXLOb+h
         UIX+ruo4D931m2Yz2og8h2PxNE3OFwuIK88yrzigZfUjDTOctjkK+teLZmfMEoEjGz9F
         hlu7OW2e9UGeX2lObZBg6sxMFdxqGf1gf7rAckAvCjFQVMc9XfH6l7RT8zyin6ETdr8o
         r7uVLjMXE/npNdGrgqjAjPycG7V/DyET8vgCYc6VUWOhWz16BA8Lv/7ZRO4NEHbKOG+0
         bULK2wLkZQIoFxanA/1SELg07/YTOCCU6ogvbcvGX2/czhlLZ4AFsHrrmpVlWOjpyXn0
         xUcA==
X-Gm-Message-State: APt69E1pV7C75ElDwbDBVYJ4m/Ku85dsFViQ316DflV1KHbPiwoJnD4n
        RJmsTObj26T+NEQBFRK7WiX2+xsGcBIH0BMiJw==
X-Google-Smtp-Source: AAOMgpctPcNImuZTzuCxT/HyhMdlbSwF2HuBJCda1oRtjsr5tyFoR5FCPQ9XRCXsf6hYoDxt0/DGm+bgBY78vhn6T9c=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr9667574iog.238.1529910531812;
 Mon, 25 Jun 2018 00:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
 <1529904187-18673-2-git-send-email-kernelfans@gmail.com> <20180625064110.GA4233@kroah.com>
In-Reply-To: <20180625064110.GA4233@kroah.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 25 Jun 2018 15:08:39 +0800
Message-ID: <CAFgQCTvKBDVPdDyBmxmCu1nJC+bD+g14h=6EQscSR4qyfiWx6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers/base: introduce some help routines for
 reordering a group of dev
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        Christoph Hellwig <hch@infradead.org>, helgaas@kernel.org,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 25, 2018 at 01:23:05PM +0800, Pingfan Liu wrote:
> > This patch introduce some help routines used by next patch. It aims to
> > ease reviewing, while the next patch will concentrate on algorithm.
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
> >  drivers/base/core.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 36622b5..8113d2c 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -123,6 +123,44 @@ static int device_is_dependent(struct device *dev, void *target)
> >       return ret;
> >  }
> >
> > +struct pos_info {
> > +     struct device *pos;
> > +     struct device *tail;
> > +};
> > +
> > +/* caller takes the devices_kset->list_lock */
> > +static int descendants_reorder_after_pos(struct device *dev,
> > +     void *data)
> > +{
> > +     struct device *pos;
> > +     struct pos_info *p = data;
> > +
> > +     pos = p->pos;
> > +     pr_debug("devices_kset: Moving %s after %s\n",
> > +              dev_name(dev), dev_name(pos));
> > +     device_for_each_child(dev, p, descendants_reorder_after_pos);
> > +     /* children at the tail */
> > +     list_move(&dev->kobj.entry, &pos->kobj.entry);
> > +     /* record the right boundary of the section */
> > +     if (p->tail == NULL)
> > +             p->tail = dev;
> > +     return 0;
> > +}
> > +
> > +/* iterate over an open section */
> > +#define list_opensect_for_each_reverse(cur, left, right)     \
> > +     for (cur = right->prev; cur == left; cur = cur->prev)
> > +
> > +static bool is_consumer(struct device *query, struct device *supplier)
> > +{
> > +     struct device_link *link;
> > +     /* todo, lock protection */
> > +     list_for_each_entry(link, &supplier->links.consumers, s_node)
> > +             if (link->consumer == query)
> > +                     return true;
> > +     return false;
> > +}
>
> You are adding code that no one uses yet, making this impossible to
> review as I don't know what to expect.  I shouldn't have to read the
> second patch and have to flip back and forth to try to figure it out :(
>
OK, I had thought the less code in [2/3] will ease the reviewing

> sorry, please break this series up in a better way to make it simpler to
> review.
>
OK.

Regards,
Pingfan
