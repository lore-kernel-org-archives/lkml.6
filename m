Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C7FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD03320827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD03320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeJ2TB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:01:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbeJ2TB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:01:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id n12so4497638qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9bp8gkMS9C+dO42+zhGleEzu1QlarVWXb90brUPyjo=;
        b=ufF6lkKaRxEUGJA5eiE4zJ6uKz82oYWRIU0Pov469HMhYti8f7yF+MBO1ZydBDHCrt
         OwsnG0k+RSqFgjypmCpsOzjdlgBBWlg+vATOGpgnzmW0SpSqG2L7tIPfEn2Gx21YZ/tY
         3pkTQWwlAWo5IJaeiPglPnUmaY7ca7sHc2dTWcn9rOMMYcOlaDbnFulw97cUXbT59DRl
         u+M0jb7NsKxNniD/dh4fcXKYKE1zl/aArIl4+f9crVQB4NyPkQ9r0o2Q8b70Ki6mq4xr
         FQzg2qJoxjuczhkoSZnhY2ftXSAeKpFuu6TLSX2oZR2milIUlbn+DCQtW07ysZiIhO2j
         tC2Q==
X-Gm-Message-State: AGRZ1gKZfPrkrXAAst6nGVt9e/3IieXpFyNUUCSZNYR2PmFW540qPkQp
        tOccl89Rqu7TTYzzLJ2eQi5lTHPDgtqGscgBXDxUOg==
X-Google-Smtp-Source: AJdET5cty7g5fl2oeBO9wnismPuAyu/JA0NJwOchzULszZmKWNqTYuLHkFpeYmpeu7ZflBLrD3l6ukhsEt5e99zUQ1I=
X-Received: by 2002:a37:4792:: with SMTP id u140mr5757010qka.301.1540808006277;
 Mon, 29 Oct 2018 03:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com> <20181028223041.GI1882@kunai>
In-Reply-To: <20181028223041.GI1882@kunai>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Oct 2018 11:13:14 +0100
Message-ID: <CAO-hwJLZc1R0LoL1+xAL4-n9Htu_z=pntKU0AsJCKvFZxOauwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     ckeepax@opensource.cirrus.com,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:30 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> > irq_create_mapping calls irq_find_mapping internally and will use the
> > found mapping if one exists, so there is no need to manually call this
> > from i2c_smbus_host_notify_to_irq.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Adding Benjamin to recipients. He wrote that code.

Yep, definitely looking good. For completeness, I just tested it on
the t450s, and it works fine.

This one is
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> > ---
> >  drivers/i2c/i2c-core-base.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index dc78aa7369def..656f0a6fe3adf 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
> >       if (client->flags & I2C_CLIENT_TEN)
> >               return -EINVAL;
> >
> > -     irq = irq_find_mapping(adap->host_notify_domain, client->addr);
> > -     if (!irq)
> > -             irq = irq_create_mapping(adap->host_notify_domain,
> > -                                      client->addr);
> > +     irq = irq_create_mapping(adap->host_notify_domain, client->addr);
> >
> >       return irq > 0 ? irq : -ENXIO;
> >  }
> > --
> > 2.11.0
> >
