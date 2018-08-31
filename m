Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB989C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltto8TEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeHaTQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:16:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32821 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeHaTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:16:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so1238138edv.0;
        Fri, 31 Aug 2018 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OakFLENuwgbFbDjfQEAX9HmDNCHYIGzIDhRitMT5zYY=;
        b=Ltto8TEt5omeD5A8gFwZfNQfRqduET/fclaEV7VurgbvUWUGDz62jx4Q4OYMph6b35
         5HQFybqd+66NOlJsOmJpKb5sNP/C5e0E271mZesCSQLHxtsavkd3SC7t5SZvzwrCWVg0
         hFxA5Zrz+mCdKyqsPczTpR+MJQtnDo7pBXruE4XvsMy5U2rJoXY4rU6fP/WaZ+w5+4qG
         m9HPdENUNH3E1YcWw8QvHlPuA80MhLiN+JFPW4OQPnhDD3jGK61EwgJejKuF8eqPMXkS
         io4yIy+2FGP81NLMuDN+H/rGe+Z72DQbcseRntNTBI1wiVvbwWuDU0XraU2B/r3+VpoA
         xLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OakFLENuwgbFbDjfQEAX9HmDNCHYIGzIDhRitMT5zYY=;
        b=NgM/jD3KoUCDcFA5xWHTxhJrG5oWYJ/N2KFqbBpnml1u1qlkBSA40iXaLoRiPEb8B9
         v+9w/cJPqulpYDVzMoEGT0OOAmd1dARd6T3ET1s/VlZI8SZ8BSvQ+OukHdOZmg4Jgfgs
         CT/y7c41i7NJcYn6O52xKlaaoGbUdRbvNjQwrt7TPPYlPHjjY5WxGtzUWwpIjskXFdy8
         lNIctL/xCIrGLAooV92Yfpt4J/Mehq3TPYGHb1sNySPWO9faUgXG1qnEl94IPXDb0V4Z
         JMpSKb0NEZO3LqWS9Tsr0pIMiQia1Vd+Zm4VgpW1/YWDMUwERwxZ5FdSxqoEArNCifGK
         fYug==
X-Gm-Message-State: APzg51Ay6nd4CGaIlrVEx/vIuf7FJLwRA9Br329kfMy0QKSbji+s9VJo
        XojJyxBTkf8P1wjUd924+aagezRGqLcIL1dLs09fNQ==
X-Google-Smtp-Source: ANB0Vda7tSXnYS2FL8daSoWT+JEmDh0UglQTUOSoNZIvpPevQmG2DzcFqX/CLo3aHbXIfSR2qXIPznRC4yq3dkp/zHc=
X-Received: by 2002:a50:fc03:: with SMTP id i3-v6mr18802924edr.85.1535728125829;
 Fri, 31 Aug 2018 08:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de> <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
 <CAK8P3a2XTUZJUqGu6v=SZqcoJTqM3fgtDAWBnBopX3=4NJYcRA@mail.gmail.com>
 <CAF=yD-+9yc838Y_DO1S4HsBpLrBk8iNt0oAj1ceO1S6sE+tCdg@mail.gmail.com> <CAK8P3a00DLR9JyfKwbYXnKCpRf+YWuUyMbC+UfXZTfdnAJxRtg@mail.gmail.com>
In-Reply-To: <CAK8P3a00DLR9JyfKwbYXnKCpRf+YWuUyMbC+UfXZTfdnAJxRtg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 31 Aug 2018 11:08:09 -0400
Message-ID: <CAF=yD-+tiVeP0FA1CUrT4Jyn28tnT+bett+Dq2frvU5eS1ANPw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Looking at it again, it seems that sock_gettstamp() should
> > > actually deal with this gracefully: it will return a -EINVAL
> > > error condition if the timestamp remains at the
> > > SK_DEFAULT_STAMP initial value, which is probably
> > > just as appropriate (or better) as the current -ENOTTY
> > > default, and if we are actually recording timestamps, we
> > > might just as well report them.
> >
> > Yes, that's a nice solution. There is always some risk in changing
> > error codes. But ioctl callers should be able to support newly
> > implemented functionality. Even if partially implemented and
> > returning ENOENT instead of ENOIOCTLCMD.
>
> Ok, so do you think we should stay with the current version
> for now, and change the two points later, or should I rework
> it to integrate the locking and removing the callback?
>
> I suppose the series actually gets nicer without the
> callback, since I can simply add the generic timestamping
> implementation first, and then remove the dead ioctl
> handlers.

Agreed. I would add the locks in a separate patch, if only on the
off-chance that lockdep discovers something and it will be easier
to bisect and revise independently. I can also follow up with that
patch outside this set, of course.
