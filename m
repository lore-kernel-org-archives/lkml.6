Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B17C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBCB20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="1/IE7Mqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBTQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:19:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34894 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBTQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:19:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so27836499qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAs7V9lXIE9K2qInJaJNOkns2i39lzC9uSxJQ8sa40g=;
        b=1/IE7MqbL7uwTpF2M11GSjbRitE5Lrmn5gWs89HYyKafME/A7vFFSAu81/7VV9kLNl
         BpxqD26rh0XMF4gYg3JgfSuC637+xzF10QF+LG0YgHhX76aaAdEYZYrg2Iq1JWrLFfmH
         6P1YWqHjL8AJwk6jdE3kTaxc4hNTtEDYe8XAxZHMowRid6V7X5OSeSVej7pzcfl5Xf0F
         Y3ldzkNML0mlx0N5yW2dytm88H5PqOunIZKaopwZVtmdxH3INCQumKNjMVoaeTaLd9re
         9HDObIK+ga+hauJ/dB3p1O4Dg+ezStuwkWbi+OLciD60nm5SndVoiSRhdi7O6n1YgaI2
         enNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAs7V9lXIE9K2qInJaJNOkns2i39lzC9uSxJQ8sa40g=;
        b=gzxZIPaEVCKQRDzIcmqziqQ82RAKRk/QwbfR8fr74WuiLIaY+kY9PREqLRsIkjOZPw
         aRrP9dw4UK6vjU6FTCuhcP7U68FgQPePWALiwqKBu7o4N0nWkZg99bsQ5GcvC+6/FXok
         axRrCF2tCK09JHOtst7SO1WSjO8lpdJCKEkWaUZR6MA7og+uNcGdCE3SJ7If1Hz69RUX
         8k0CMu7/xWgTyRXs9lWroKNuVhb0z1KhG8UjgMD/oaEWn9zIip+4zpgx5i4zIuEZQzLg
         pRGhy1L86LpMT2h4YzEOQQvTV3SRevteoim3dS106COx4Wfw3zVlIdiCXwCogYRv+GfP
         Nitw==
X-Gm-Message-State: AHQUAua0x9XIXFn6N1sM1k2xtVaw5/2joXWl2OaIqrJ6OHX1wDdrq/9k
        WT9YGQ8O+qogAbsQbKyMfM6NQOIqS6JM5ZFQCOR7nA==
X-Google-Smtp-Source: AHgI3IYdbXAAqySGfywIJjCYFCaSRh5AhQGd93FtpA4Z3zouaE+Q7znDpbYtaWW20Z8ZgmlcqNTLGsl2vRWSjpb1Xss=
X-Received: by 2002:ac8:1bf7:: with SMTP id m52mr28436100qtk.200.1550679542750;
 Wed, 20 Feb 2019 08:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica> <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica> <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica> <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica> <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica> <20190220041151.GA13520@nautica>
In-Reply-To: <20190220041151.GA13520@nautica>
From:   Tom Herbert <tom@herbertland.com>
Date:   Wed, 20 Feb 2019 08:18:51 -0800
Message-ID: <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:12 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Dominique Martinet wrote on Fri, Feb 15, 2019:
> > With all that said I guess my patch should work correctly then, I'll try
> > to find some time to check the error does come back up the tcp socket in
> > my reproducer but I have no reason to believe it doesn't.
>
> Ok, so I can confirm this part - the 'csock' does come back up with
> POLLERR if the parse function returns ENOMEM in the current code.
>
Good.

> It also comes back up with POLLERR when the remote side closes the
> connection, which is expected, but I'm having a very hard time
> understanding how an application is supposed to deal with these
> POLLERR after having read the documentation and a bit of
> experimentation.
> I'm not sure how much it would matter for real life (if the other end
> closes the connection most servers would not care about what they said
> just before closing, but I can imagine some clients doing that in real
> life e.g. a POST request they don't care if it succeeds or not)...
> My test program works like this:
>  - client connects, sends 10k messages and close()s the socket
>  - server loops recving and close()s after 10k messages; it used to be
> recvmsg() directly but it's now using poll then recvmsg.
>
>
> When the client closes the socket, some messages are obviously still "in
> flight", and the server will recv a POLLERR notification on the csock at
> some point with many messages left.
> The documentation says to unattach the csock when you get POLLER. If I
> do that, the kcm socket will no longer give me any message, so all the
> messages still in flight at the time are lost.

So basically it sounds like you're interested in supporting TCP
connections that are half closed. I believe that the error in half
closed is EPIPE, so if the TCP socket returns that it can be ignored
and the socket can continue being attached and used to send data.

Another possibility is to add some linger semantics to an attached
socket. For instance, a large message might be sent so that part of
the messge is queued in TCP and part is queued in the KCM socket.
Unattach would probably break that message. We probably want to linger
option similar to SO_LINGER (or maybe just use the option on the TCP
socket) that means don't complete the detach until any message being
transmitted on the lower socket has been queued.
>
> If I just ignore the csock like I used to, all the messages do come just
> fine, but as said previously on a real error this will just make recvmsg
> or the polling hang forever and I see no way to distinguish a "real"
> error vs. a connection shut down from the remote side with data left in
> the pipe.
> I thought of checking POLLERR on csock and POLLIN not set on kcmsock,
> but even that seems to happen fairly regularily - the kcm sock hasn't
> been filled up, it's still reading from the csock.
>
>
> On the other hand, checking POLLIN on the csock does say there is still
> data left, so I know there is data left on the csock, but this is also
> the case on a real error (e.g. if parser returns -ENOMEM)
> ... And this made me try to read from the csock after detaching it and I
> can resume manual tcp parsing for a few messages until read() fails with
> EPROTO ?! and I cannot seem to be able to get anything out of attaching
> it back to kcm (for e.g. an ENOMEM error that was transient)...
>
>
>
> I'm honestly not sure how the POLLERR notification mechanism works but I
> think it would be much easier to use KCM if we could somehow delay that
> error until KCM is done feeding from the csock (when netparser really
> stops reading from it like on real error, e.g. abort callback maybe?)
> I think it's fine if the csock is closed before the kcm sock message is
> read, but we should not lose messages like this.

Sounds like linger semantics is needed then.

>
>
>
> > I'd like to see some retry on ENOMEM before this is merged though, so
> > while I'm there I'll resend this with a second patch doing that
> > retry,.. I think just not setting strp->interrupted and not reporting
> > the error up might be enough? Will have to try either way.
>
> I also tried playing with that without much success.
> I had assumed just not calling strp_parser_err() (which calls the
> abort_parser cb) would be enough, eventually calling strp_start_timer()
> like the !len case, but no can do.

I think you need to ignore the ENOMEM and have a timer or other
callback to retry the operation in the future.

> With that said, returning 0 from the parse function also raises POLLERR
> on the csock and hangs netparser, so things aren't that simple...

Can you point to where this is happening. If the parse_msg callback
returns 0 that is suppose to indicate that more bytes are needed.

>

>
> I could use a bit of help again.
>
> Thanks,
> --
> Dominique
