Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJU8qXOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDA720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389978AbeGKRFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:05:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeGKRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:05:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so3500790edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oqa3Ko9BSSpGbRP/XJrZt83+m62oWGDNyw+OmogRUKc=;
        b=dJU8qXOR4hFNLdX1KhhpUGZ4XeJwV7V8/nBjFjR/XjpUEfUzTUTn0qOnQ+E0l1T/WW
         uhvyrM8ykX0IeeIm+2YZMXgWhuQ8WkW1z38f/Ip7CuDGx5sQbaVOp8QcCK0Offq8kefx
         aoKUJnaMx80ZQ80Mb1k49424GTlS62Vq66/v8eUlIg4Z3WHp9bB8ZaNLM4xtypwz0am7
         GEWjom+hwNvn1vYPFZK5pIMHJ7s84r15X6RYbSXsOfUrfCmn3ZMgw/J2aeL1uHfGblG+
         5C9Smqi+QYkfeZGevoLGjN4fP8v5+N9IC6K84RDc5lwONrHwPqmhLXUSvTNyKZYwgWxA
         OEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oqa3Ko9BSSpGbRP/XJrZt83+m62oWGDNyw+OmogRUKc=;
        b=DS49c1QN8nvvA4GA0ylsXVZefUbGQV99DfNR24TP8ChngayrbLvY3+YyRIqFLswnyY
         5UHdFJbCZVqBGCR5N2aH9/lP8wpjaWFuW3rq++9v8MCGHdALWY/pXk0fEjDs42ge41TH
         1oVkBu8YHdqN97IccXTjSSj3bXPsYV7awlZ6rd1vdQpDebHZZUwwpbr0Kr7goW/WyoGi
         jXKjPeU0udTvlw1uA2MCr86+l+7xC38iQbIu4KjYeR5oFZrmhI85kLlnxSNkqEqyli0j
         KQ5zfNIN6I03EohUY5P/m8zGiQZHRZ2Xg7QWVCpFS2chOq8oeLV6DKoHjYMQJ2DD29HM
         k5Pg==
X-Gm-Message-State: APt69E0QH8av72d54Mhl7i5J1bHyJJiC3h/ci50lVWPCUY62lVZY89nt
        fjeXIeCYA+spXvuFj5FC/DuPLVlCrYKL9tgY23firTOO
X-Google-Smtp-Source: AAOMgpcLPEvj+BXUpkWNbcSaKQNMsaJHEIZoOB4gwOAqOiiSlBsWF88PWa57oNgwC2yOhWWLiXSGm2LHg6g51lSOx6g=
X-Received: by 2002:a50:96c4:: with SMTP id z4-v6mr23538854eda.14.1531328432812;
 Wed, 11 Jul 2018 10:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:9f67:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:00:32
 -0700 (PDT)
In-Reply-To: <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com> <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de> <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
 <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com> <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 11 Jul 2018 22:30:32 +0530
Message-ID: <CABb+yY0XQwXjVUMiXcqFVVCTR2jRWA343d220LqBYmTp+s6J1Q@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:11 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> Hi Jassi,
>
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> Sent: Thursday, July 12, 2018 12:32 AM
>> To: A.s. Dong <aisheng.dong@nxp.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
>> kernel@lists.infradead.org; dongas86@gmail.com; linux-
>> kernel@vger.kernel.org; Oleksij Rempel <o.rempel@pengutronix.de>; dl-
>> linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>; shawnguo@kernel.org
>> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>>
>> On Wed, Jul 11, 2018 at 6:28 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> > Hi Jassi,
>> >
>> >> -----Original Message-----
>> >> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> >> Sent: Wednesday, July 11, 2018 6:44 PM
>> >> To: A.s. Dong <aisheng.dong@nxp.com>
>> >> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
>> >> kernel@lists.infradead.org; dongas86@gmail.com; linux-
>> >> kernel@vger.kernel.org; Oleksij Rempel <o.rempel@pengutronix.de>; dl-
>> >> linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
>> >> <fabio.estevam@nxp.com>; shawnguo@kernel.org
>> >> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>> >>
>> >> On Wed, Jul 11, 2018 at 4:07 PM, A.s. Dong <aisheng.dong@nxp.com>
>> wrote:
>> >> >
>> >> > > -----Original Message-----
>> >> > > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>> >> > > Sent: Wednesday, July 11, 2018 3:55 PM
>> >> > > To: A.s. Dong <aisheng.dong@nxp.com>
>> >> > > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com;
>> >> > > Jassi Brar <jassisinghbrar@gmail.com>;
>> >> > > linux-kernel@vger.kernel.org; Oleksij Rempel
>> >> > > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
>> >> > > kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
>> >> > > shawnguo@kernel.org
>> >> > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>> >> > >
>> >> > > On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
>> >> > > > Hi Sascha,
>> >> > > >
>> >> > > > > -----Original Message-----
>> >> > > > > From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>> >> > > > > Sent: Tuesday, July 10, 2018 10:20 PM
>> >> > > > > To: A.s. Dong <aisheng.dong@nxp.com>
>> >> > > > > Cc: linux-arm-kernel@lists.infradead.org; dongas86@gmail.com;
>> >> > > > > Jassi Brar <jassisinghbrar@gmail.com>;
>> >> > > > > linux-kernel@vger.kernel.org; Oleksij Rempel
>> >> > > > > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
>> >> > > > > kernel@pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>;
>> >> > > > > shawnguo@kernel.org
>> >> > > > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
>> >> > > > >
>> >> > > > > Hi,
>> >> > > > >
>> >> > > > > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
>> >> > > > > > This is used for i.MX multi core communication.
>> >> > > > > > e.g. A core to SCU firmware(M core) on MX8.
>> >> > > > > >
>> >> > > > > > Tx is using polling mode while Rx is interrupt driven and
>> >> > > > > > schedule a hrtimer to receive remain words if have more
>> >> > > > > > than
>> >> > > > > > 4 words.
>> >> > > > >
>> >> > > > > You told us that using interrupts is not possible due to
>> >> > > > > miserable performance, we then provided you a way with which
>> >> > > > > you
>> >> could poll.
>> >> > > > > Why are you using interrupts now?
>> >> > > > >
>> >> > > >
>> >> > > > Because mailbox framework does not support sync rx now, I think
>> >> > > > we do not need to wait for that feature done first as it's
>> >> > > > independent and separate features of framework.
>> >> > >
>> >> > > You can wait forever for this feature, nobody will add it for you.
>> >> > > It's up to you to add support for that feature. Who else should
>> >> > > add this
>> >> feature if not you?
>> >> > > And when will you add that feature if not now when you actually need
>> it?
>> >> > > It is common practice that you adjust the frameworks to your
>> >> > > needs rather than working around them.
>> >> > >
>> >> >
>> >> > I'm willing to add it. Just because you said Jassi already had the
>> >> > idea on how to Implement it and does not add much complexity. So I
>> >> > just
>> >> want to see his patches.
>> >> > But if he did not work on it, I can also help on it.
>> >> >
>> >> I am not much aware of the history of this conversation... but it
>> >> seems you need to make use of mbox_chan_ops.peek_data().
>> >>
>> >> If not that, please let me know the requirement.
>> >>
>> >
>> > Thanks for the suggestion.
>> > It looks to me may work.
>> >
>> > From the definition, it seems it's used to pull data from remote side.
>> > /**
>> >  * mbox_client_peek_data - A way for client driver to pull data
>> >  *                      received from remote by the controller.
>> >  * @chan: Mailbox channel assigned to this client.
>> >  *
>> >  * A poke to controller driver for any received data.
>> >  * The data is actually passed onto client via the
>> >  * mbox_chan_received_data()
>> >  * The call can be made from atomic context, so the controller's
>> >  * implementation of peek_data() must not sleep.
>> >  *
>> >  * Return: True, if controller has, and is going to push after this,
>> >  *          some data.
>> >  *         False, if controller doesn't have any data to be read.
>> >  */
>> > bool mbox_client_peek_data(struct mbox_chan *chan) {
>> >         if (chan->mbox->ops->peek_data)
>> >                 return chan->mbox->ops->peek_data(chan);
>> >
>> >         return false;
>> > }
>> > EXPORT_SYMBOL_GPL(mbox_client_peek_data);
>> > But it seems most users in kernel simply implement it as a data
>> > available Checking rather than receiving it.
>> > See:
>> > drivers/mailbox/ti-msgmgr.c
>> > drivers/mailbox/mailbox-altera.c
>> >
>> > Only bcm uses it to receive data.
>> > drivers/mailbox/bcm-flexrm-mailbox.c
>> >
>> > For our requirement, we want to implement sync receiving protocol like:
>> > Sc_call_rpc()
>> > {
>> >         mbox_send_message(chan, msg)
>> >         If (!no_resp)
>> >                 // rx also stored in msg
>> >                 mbox_receive_msg_in_polling(chan, msg);
>> >         mbox_client_txdone();
>> > }
>> >
>> > If using peek_data, it can be:
>> > Sc_call_rpc()
>> > {
>> >         mbox_send_message(chan, msg)
>> >         If (!no_resp)
>> >                 // rx also stored in msg
>> >                 Mbox_client_peek_data(chan);
>> >
>> Yes, and you may want to loop for a certain amount of time if peek keeps
>> returning false.
>>
>> >         mbox_client_txdone();
>> > }
>> >
>> > And for mu controller driver .peek_data():
>> > imx_mu_peek_data(chan)
>> > {
>> >         // get first word and parse data size
>> >         imx_mu_receive_msg(&mu->chans, 0, mu->msg);
>> >
>> >         raw_data = (u8 *)mu->msg;
>> >         size = raw_data[1];
>> >
>> >         // receive rest of them
>> >         for (i = 1; i < size; i++) {
>> >                 ret = imx_mu_receive_msg(&mu->chans, i % 4, mu->msg + i);
>> >                 if (ret)
>> >                         return false;
>> >         }
>> >
>> >         mbox_chan_received_data(&mu->chans, (void *)mu->msg);
>> >
>> Not sure how your controller works. But the peek() callback only _checks_ if
>> there is some data available to be read. Please note that
>> peek() can not sleep.
>> So if the data fetching doesn't sleep you can do that here, otherwise peek
>> has to schedule the actual fetching of data from remote and providing to the
>> client via mbox_chan_received_data.
>>
>
> bcm seems is using peek to receive data, not only checking the data availability,
> right?
> drivers/mailbox/bcm-flexrm-mailbox.c
>
As I said, if fetching data from remote don't need to sleep, you can
call mbox_chan_received_data() from peek(). Otherwise not.
