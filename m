Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B935ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE992080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE992080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKAAsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:48:50 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42693 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeKAAsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:48:50 -0400
Received: by mail-ot1-f50.google.com with SMTP id j3so9170378otl.9;
        Wed, 31 Oct 2018 08:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dxz1lbR1Nea5clUweTgFxB7Gw9YuMJlZY66RSFZYpqE=;
        b=bgZqjHpeTozA0QpRSUqwJp4Z5/aGMK/z0f/5NT4WNmjnsaHODoPTRl7UWxI/rfb5dh
         5xlULURTqO3vZ2ssu3byUMHn4OFZoEnnWr8BwMQOVf0ZUrLgoy7oFnfug7YCvebkJqHP
         msT9bnUbocbcLHfc8DSNZqs2YespxOpnKhsQguzibvUJO7aGtj2JAEkaERP1Tyl1/YO8
         ph845365Bno16vG5fWQKYee8Atluy4aN+D0Qp0BqjTSqfdtUdgSoGCNksS+O/trjsRfu
         fpNXNZGhOzQDF524R4xo9/9iCr5UpjrlHN4J8F1LUaBFLAPDkRooaKR6o0C1ld+OwXEf
         knYA==
X-Gm-Message-State: AGRZ1gL8sXF9p/HCopYof9hdpeJGc1HKrj+Zmszy9QlLXGn9/55elsxD
        QZvA+PHNHTKpN54cCQssTMT+rdjPg1fMpVnBPoo=
X-Google-Smtp-Source: AJdET5cZ4/gJdNeXslf23qlXStZwHpSj0wYwCmyaPvMy4A6z9hffaiQlzXUWm4DcKxNrSoCDz6RlWlv/IE1z8WIu06A=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr2288092otk.55.1541001015510;
 Wed, 31 Oct 2018 08:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-4-git-send-email-harini.katakam@xilinx.com>
 <20181031145400.GH20889@lunn.ch> <CAFcVECKg4u5t9=TOJ1omVJ=8ves_yvzcDZZA_-bE4OAv96cymg@mail.gmail.com>
 <20181031154733.GC25521@lunn.ch>
In-Reply-To: <20181031154733.GC25521@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 31 Oct 2018 21:20:04 +0530
Message-ID: <CAFcVECKVa+zBh-YS19jgsPkhYXLsN7jEOxK96dxeWi8p38wWEA@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: macb: Add pm runtime support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
On Wed, Oct 31, 2018 at 9:18 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Yes, I understand. But I thought I'd handle it when we have a separate
> > MDIO bus driver. As of now, with macb, I do not see a way, for ex.,
> > for MAC1 to access MDIO0 when MAC0 is suspended.
> > However, I will work a bit more on this solution.
>
> You could look at the FEC driver. Its runtime suspend works well for
> me, and i've some complex setups, with two FEC interfaces, PHY and
> switches hanging off various MDIO busses etc.

OK sure, thanks.

Regards,
Harini
