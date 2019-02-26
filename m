Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C91C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD66D2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfBZTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:03:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43822 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:03:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so12041796ota.10;
        Tue, 26 Feb 2019 11:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2oWuFmMhgbRxx6Pa24BAIy0mjZbQhiIrJStCKrdqX8=;
        b=Br2zYntol0dDAWxZzSEq3+AuoPoF9t2naWsuS+6pW0bMZDAGC7lgKBVmODd2qSLrqd
         ceaDcPYTS68goNlcB7SpaJjBvQftjWonzo139paQnjk7QiidpXCLGhvmy4Zl25DZNhu0
         Kl51MHSSTfh/1C7V0Ghgu19vL4QrejwBinv87PdFi9MYA3o3W/AeFdnLFSizYeA+29eb
         U9NwiPfNIiQFZHhCGrAYiJnklQuUsEJfbYAfl6OjdZKQ+pkJUKVyedVY4uRfqcbMKJ9l
         hssdUbAtzUqQR0QRsprriThzPC6GzubkWvG+C7s4x1WfjAkO2iHce6Iw+nPWsHMVExPL
         zldQ==
X-Gm-Message-State: AHQUAuYkMTsB9G1fbahm8+nT18onr+7d+1UDVEqhxO9vYBFRafykV3AC
        yrFf5hLwLGPb1YQRaulNULxlqXPt/xo=
X-Google-Smtp-Source: AHgI3IaEFmoV8cSx7TGMy0xzojXfjrNByoHfZGqlOFb1z7n+vj4R7X2Tl2YDSWssvxjxJ3Ri07tZvA==
X-Received: by 2002:a9d:75cc:: with SMTP id c12mr7982460otl.279.1551207810218;
        Tue, 26 Feb 2019 11:03:30 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id h30sm6145927oth.19.2019.02.26.11.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:03:29 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id t206so11266454oib.3;
        Tue, 26 Feb 2019 11:03:29 -0800 (PST)
X-Received: by 2002:aca:c2c4:: with SMTP id s187mr3117123oif.175.1551207809182;
 Tue, 26 Feb 2019 11:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20190223084816.28985-1-ioana.ciornei@nxp.com> <20190224.220653.256212672271785631.davem@davemloft.net>
 <VI1PR0402MB280056BBF62A86E1703C549BE07A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB280056BBF62A86E1703C549BE07A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 26 Feb 2019 13:03:17 -0600
X-Gmail-Original-Message-ID: <CADRPPNSRpbD_dUZYJC4-SwudNk2JTPCug3T6g4dTYMBDQeeu7w@mail.gmail.com>
Message-ID: <CADRPPNSRpbD_dUZYJC4-SwudNk2JTPCug3T6g4dTYMBDQeeu7w@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     David Miller <davem@davemloft.net>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 1:01 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> > Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
> >
> > From: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Date: Sat, 23 Feb 2019 08:48:42 +0000
> >
> > > The first two patches enable cache stashing and configure the core
> > > cluster destination per software portal while the third patch is the
> > > one configuring the amount of stashing on a queue.
> >
> > Should I merge this series in via my networking tree?
>
> Even though it would be really good to have this on the networking tree as soon as possible, I am afraid that patch 2/3 is not going to apply cleanly because it touches the same areas of code that some other patches on Leo's tree are.

Hi David,

What shall we do if we want to get this in the 5.1?  Since the change
on the ethernet driver is pretty small, can I get your ACK on that
patch and merge the series through my tree?  Otherwise I can also try
to get the dpio patches in next merge window, and you can apply the
Ethernet patch after that.

Regards,
Leo
