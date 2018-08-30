Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C478C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D622082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="OQ8fju0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D622082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeHaBNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:13:19 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46097 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeHaBNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:13:18 -0400
Received: by mail-yb1-f193.google.com with SMTP id y20-v6so121382ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eXZe4FOmg6+Ww8JjSSEA9cmxusZTNS+aUYRveHKvAT8=;
        b=OQ8fju0SZraMnY0W8Kb+wZn7uep+Xmhx+bIfyhAeQXt/Y2nwZhm3vt/2cnomfyGVmr
         bDHM5qlCdRwkRVKLOCbJQX4ye0ngzYzW+kAmgymyuqWLqOc5CQNwfA3/1QXG4stoYOQ9
         QFP+FYj3pIztV8hS4yyH3wko1VT9011dUhEnWer1a4N3hWjQWREy5GYL/E17D7Y1ERpk
         0gJIkDMjY/4YdH3XIbs8f7cdPlxgAsK+JI/1TYtd18ZYgBAIfgl7vPO/ZpSCyzgIGnRA
         LtRmsjgUpCEFZlR7BBhb+N44goMq70xN2FdTawMJA/q9zBGzZrVA5zDUbrjWh+aoaaBT
         5afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eXZe4FOmg6+Ww8JjSSEA9cmxusZTNS+aUYRveHKvAT8=;
        b=gcmrU17cNCUW0pXrNW+WpP1l0cfwnOu20AGZpR3x9nt7vbNwXcnj6KQupu6iuwLs5h
         yqp69/ht4/yo48g3OPHQ7CklOTEIpcSAECMHpY1OGVsqjMDWpGfjNqXOpiWHJkxESji9
         ngy1UKLbdgUUuGWiG1niTExdHQ8iJvL1u0Ib/MZCLWPNc313mxIl9tZGch96t9T1qbAf
         PDsOQ6CraUrunfssyISvN+JIEcjDePqmk7NxGHbcjA3ZbsYcFt+wyv/eXieS7ACykyu1
         fcJprgQ2km9JNi/AVOAA3kHgANK4H4M6jD9BkLJm4ni1eATtW2uZ9+a2nwGDdyEGaXv/
         FSqg==
X-Gm-Message-State: APzg51CGZpFh3aa6IMsLkgDQmxR8K7iQuOvVuj9c0KOVDz8mUz3o+L9+
        bDz92i+ZIVoPvaUuR20Q4QH8cHChwecZ5I0BF3EUjw==
X-Google-Smtp-Source: ANB0VdaEzHur0EhCzwr3ZpCq/XcpPzYraqD3bIl1sbvtSxoahULkeweqLk1eGrG8AOv+mORwE1SxeQTptFhOu6BHefo=
X-Received: by 2002:a25:684c:: with SMTP id d73-v6mr2513700ybc.276.1535663353754;
 Thu, 30 Aug 2018 14:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3c0a:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 14:09:13
 -0700 (PDT)
In-Reply-To: <20180830175419.GD31581@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org> <20180830004046.9417-2-mdf@kernel.org>
 <20180830030420.GB16896@lunn.ch> <CAAtXAHe_fX9_XExvFj20a0L-=b0Z1gX410=wnR=P2DjO-hEByA@mail.gmail.com>
 <20180830175419.GD31581@lunn.ch>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Thu, 30 Aug 2018 14:09:13 -0700
Message-ID: <CAAtXAHcfKBDMg7FkFFfX9WViZPJoSq=zUnoj+BkwqjasyM5WUg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: nixge: Add support for fixed-link subnodes
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Thu, Aug 30, 2018 at 10:54 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > The hardware has MDIO, but you don't have a PHY connected on it, and
>> > use fixed link.
>>
>> Since it's an FPGA design in that case we'd probably build the hardware without
>> MDIO to save resources.
>
> You can save resources, but is it worth the complexity else where,
> like in the software?

Depends. For now I definitely have build versions that don't have MDIO regs
there. I might be able to chat with HW folks ...

>
>> > It is important you have the mdio subnode, with PHYs and switches as
>> > children. The driver currently gets this wrong, it uses
>> > pdev->dev.of_node.
>>
>> Oh, whoops.
>
> Yes, and i also missed it. I generally review all new network drivers
> and look at their MDIO and PHY code.

I had looked at macb as an example and there were a bunch of other cases
where there was no 'mdio' subnode.

>
>> Any good examples of drivers doing it right? Is the one going with
>> the DT snippet above a good example?
>
> That comes from the Freescale fec_main.c. It only supports DT, and
> always uses of_mdiobus_register. You need to be a bit more flexible
> for when you don't have DT. I'm not sure there are good example of
> this, since they either don't need this flexibility, or they get it
> wrong :-(

Alright, no problem. I'll take a stab at it. And come back with a v2 ;-)
Need to look at your response in the other patch.

Cheers,

Moritz
