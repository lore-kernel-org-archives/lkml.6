Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2916EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36AC205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXjcPMfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAQPWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:22:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40491 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfAQPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:22:21 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so1582226ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnLAybpdoQnr3UI674Pd3aAhNK3gQ91jeRbiR4dTUzo=;
        b=LXjcPMfRXIMWwPJyrnMqKTICp5a1OZY48w+6G2JBs8vl4QdDnuyke2az+Dtx3TKa50
         7cu5HMsSCjnWTcdjf0hMKU6WUM1jdboXfI5IBmn39UmDoOW/r4IY2uMcqvJlGTzmWX/P
         r4KwfWUZK18GUWSzpIaZzNPS/b50y5L7h5AHrP4ZayuOpikN6LIitL7b6+hyBkXJeyF8
         DmYo/JkGL1orbYpF7ecKCk8fKY7GYKF1Foz42ZN4onqL7jfICuCQLmzqdiDBCNVXFTnR
         n74fqkd9CrqapVSUUZuk0WDRg7mKC7JzscM1F7UYpmNw97WERaUttPjZbPilFnqHQS81
         opHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnLAybpdoQnr3UI674Pd3aAhNK3gQ91jeRbiR4dTUzo=;
        b=iug7dOETu2wxpOJVlLXKuZf3nE6YKFv6uL8ECJwkKbAH8NlZ1QRbL6oTTSYmDeoLru
         mdMyThB1qyr9J0ZbnNIlPM51TnRx9RCMHdbgRMN62quVJ6L6LGeYijfFZRm+eJeFXM8P
         NBicblM4/XZFvBHQR36wA98WipdjylBmFQx/cnDlW6/OayI0X0iS+XvZkIgN/hJySAKG
         qjUTHOfEd4RLF1SvLmEBKWvWa4QJ3UO1GsdhANFsxF9RU/7vzeZX/y8ffKn1Lf52OSwn
         bt1Gm6nTAbNYkMtLwm/nQf/XOh4CtGdYESvmL/i5mC5eA65t818BcTe3Firwi10wzC6w
         MA4w==
X-Gm-Message-State: AJcUukcKCVmY9ZCl6Nwf0wfOAw0sf+vMWKLMS8eJYSDkp1hhbCFYwOCy
        cQZqr1fbiB6+FKdCspwIROKrfWHcoZK6Hm9wwMs=
X-Google-Smtp-Source: ALg8bN74wJXGW9IEeBLX1QxSlVn90pBMU9FqRQb0GkEfbZEjdlEV7DYozD61L4nAnmvnYse2QpcxZ8VmUj2kRQbrMX8=
X-Received: by 2002:a02:5184:: with SMTP id s126mr7945358jaa.12.1547738540125;
 Thu, 17 Jan 2019 07:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20190116050435.11624-1-ck.hu@mediatek.com> <20190116050435.11624-2-ck.hu@mediatek.com>
 <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com> <1547712032.5318.17.camel@mtksdaap41>
In-Reply-To: <1547712032.5318.17.camel@mtksdaap41>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 17 Jan 2019 09:22:09 -0600
Message-ID: <CABb+yY3Lk7up2+mrwQGBowm0j6SEyitQkj0=q9Z+C7aHad56Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in channel
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 2:00 AM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Jassi:
>
> On Wed, 2019-01-16 at 10:22 -0600, Jassi Brar wrote:
> > On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
> > >
> > > This patch supplies a new framework API, mbox_abort_channel(), and
> > > a new controller interface, abort_data().
> > >
> > > For some client's application, it need to clean up the data in channel
> > > but keep the channel so it could send data to channel later.
> > >
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > ---
> > >  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
> > >  include/linux/mailbox_client.h     |  1 +
> > >  include/linux/mailbox_controller.h |  4 ++++
> > >  3 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > index c6a7d4582dc6..281647162c76 100644
> > > --- a/drivers/mailbox/mailbox.c
> > > +++ b/drivers/mailbox/mailbox.c
> > > @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> > >  }
> > >  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
> > >
> > > +/**
> > > + * mbox_abort_channel - The client abort all data in a mailbox
> > > + *                     channel by this call.
> > > + * @chan: The mailbox channel to be aborted.
> > > + */
> > > +void mbox_abort_channel(struct mbox_chan *chan)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       if (!chan || !chan->cl)
> > > +               return;
> > > +
> > > +       if (chan->mbox->ops->abort_data)
> > > +               chan->mbox->ops->abort_data(chan);
> > > +
> > > +       /* The queued TX requests are simply aborted, no callbacks are made */
> > > +       spin_lock_irqsave(&chan->lock, flags);
> > > +       chan->cl = NULL;
> > > +       chan->active_req = NULL;
> > > +       spin_unlock_irqrestore(&chan->lock, flags);
> > > +}
> > >
> > Why not just release and then request channel again ?
> > mbox_abort_channel() is just a copy of mbox_free_channel() and if the
> > abort can sleep, that is more reason to just do that.
>
> The cursor may change position 300 times in one second, so I still
> concern the processing time. Request and free channel looks too heavy to
> do 300 times per second.
You send data 300Hz, not abort ... which is supposed to be a rare event.
And then your shutdown/startup is currently empty, while abort isn't
quite lightweight.

> Conceptually, I just want to clean up the
> channel rather than free and request it, so they are somewhat different.
> I say it may sleep because mbox_abort_channel() is a copy of
> mbox_free_channel(). I could change it to 'must not sleep' because
> Mediatek controller does not sleep in abort callback.
>
No please. Just use the shutdown/startup.

Thanks.
