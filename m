Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0229AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="plhzHWyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B891D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeKSHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:47:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33067 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeKSHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:47:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so19513967otl.0;
        Sun, 18 Nov 2018 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vx7e8wFqHXMMu3XuxsbHP7t5DgFf8qS7/fcrT/0+sCU=;
        b=plhzHWyFv/k2tweFZ8/rD4J33HSvXug4VUX7IdAxdQu/YUbavFBPA+/Rd0sBrIpnlo
         jCimM+TD+KCZhWgI8rBbCDzk9RCjC9VT1pgLbRIF8U5sbOkDcYLAa3BZsdbAyfogrvWm
         8mvC1SjNtyLF6am3WuVjXOVP77cl3QpdwnhuyjGDWuQbkUlMTS/0Sl5GxY1F3v8uDy3Y
         TI/8WKrTosRV5zlsAFR+Hwq/tg1atjadJatM2MXdRprEDp3UzSiq4WNlNRy9wNdc+4Ij
         FLP/yrqfobAQEubymG5juDaxJvyeq7t7CKOCmb9w2fiP12GbNBlJZUpYeBv9g0d/eekx
         KvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vx7e8wFqHXMMu3XuxsbHP7t5DgFf8qS7/fcrT/0+sCU=;
        b=SqZUJ2etOuPQmw0Y4Fpvdwft6x0QPZLecG96gE8OjiNfWw73y+zU2fUkxdZ+J/Wbce
         GSeF8YeyHsxiFfy+YYp1bR7NcPdILRb4ir1rxFfr7oo/YLj0zMWvQcKYVElOqCZDZ4le
         p9rYqoNdXPUcrs3xcdLQxyG9lcYURkst2O1oZC6B7NNneNyI9LcXEkEB6aoCOEttEbGg
         hCOyTAgYboKdbleX1C/iT6bvNtSgKSCSU5f7lxMcYfzgFzFVl/FsxSjyyfgNaDMAXyLv
         GbcvZ69P2ySY3nige/awzj0BTUeogt4pW9LtngDwNQpiAD8GOEweLG25H396ylSg9y4B
         PXYg==
X-Gm-Message-State: AGRZ1gKGMqcHjAF2PpkrYb1l3gLCxX4KoNlgN5njHtJN9/Tl+4EnjRwB
        2P7tGEsyugI627noDIOTbRM1tOuvVZuHwA81xBTTELMG
X-Google-Smtp-Source: AJdET5dxgndeuA0MguYVvgPPF1G/6TZ3HZPd867qB3zW7onWyVHoBO6fj9oysCij5uGr/N52Ol5XBMy0npsAn9CKTfE=
X-Received: by 2002:a9d:3408:: with SMTP id v8mr12294151otb.237.1542576347652;
 Sun, 18 Nov 2018 13:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-8-martin.blumenstingl@googlemail.com>
 <20181118171340.GG5591@lunn.ch> <CAFBinCBkH3OrtxROpcbqF-1BtRY=6QqS2zkhZTo=W==1FKqZsw@mail.gmail.com>
 <20181118174531.GA7446@lunn.ch>
In-Reply-To: <20181118174531.GA7446@lunn.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 22:25:36 +0100
Message-ID: <CAFBinCCOp2Q0Uf5-pxr66QzD9STFpTtJXXGC+_o2GiXtMF8u2A@mail.gmail.com>
Subject: Re: [PATCH 7/7] net: phy: icplus: allow configuring the interrupt
 function on IP101GR
To:     andrew@lunn.ch
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 6:45 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I'll wait a few days for more feedback and re-send this series with
> > that issue fixed
>
> Hi Martin
>
> In networking world, you should expect feedback within 3 days. So i
> was actually a bit slow. If i'd of waited much longer, David would of
> merged the patches very soon.
good to know, thanks
for me as "someone who sends patches" (and as someone who is impatient
sometimes... ;)) this is great because I don't have to wait ages for
feedback!

> So feel free to respin the patchset now if you want.
I just sent v2


Regards
Martin
