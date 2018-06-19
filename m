Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11499C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978DD20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmylMBrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978DD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030343AbeFSSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:33:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34016 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030239AbeFSSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:33:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so288976pfl.1;
        Tue, 19 Jun 2018 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YuZhsbmOaIeEDIFiTL+XLVbsx++X3DMkSo6Fcg2liHo=;
        b=SmylMBrmN3t0Rl+/MGGEXXB8ehG54qVCTmcWH27oUphzFaFWHHLkPnBVW4lMCSWbmb
         eWxr4V+aGvvCus8lvh8KnmHijnnTTMUngZrREKgB5+lHLOpqZPEoXDUo81kJJq54oME6
         l7zL2nq7KAUqWSrmXoPE2aLliRf5maigxzy3/24t2Wq+ep5h25bRNccW1UmYQXZQ5pRl
         ViU9y5AKBfCeii/YTYHyXU0S8dkboYIcow7cldMo9AN6e3MCLU9Ys96kupjxwCSbm0aW
         wsfnen6sTJCTSjmmtnUn6YYLOO/VP2izAzm8zO93XRC6lkwJD2GJG+KvSoDFoxeYZ0UZ
         vyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuZhsbmOaIeEDIFiTL+XLVbsx++X3DMkSo6Fcg2liHo=;
        b=YYVH4Y5CGaGrjMlPufNMby5sNxWV5ziplzSN4rKtgjuBUvkZnPVgAaykEfUIWcIIhU
         61MXvrRB9Ix7HEHUr2nA2qw/OkeR1ZI52TGmhOCb+aoDD7W3t3AKDBO8jNM5RjiHIq4u
         2gKURZMlqDcLmBk73gt356x8pFc3rxyGdWH3R02VzcFWmCXPR9UUvNDP9JjlGSyJJClG
         nQ5mY6NBmyGtUG12efOV+ZN+r+5bg8ckF41nM9jo5SdRr8uNEUnwADp0WwKJYKRMraas
         weLU6r5qHjm+3md30kES54f7Xcf6P4sxjxMx/K2WMft2HHy9+neOml0b3ARAyyNbbRpe
         1J8Q==
X-Gm-Message-State: APt69E21NI9TG7URTU9DosVaMmvj98WLWuGQw0NOKHnfZHXVzTej2cwb
        TkxIWJ2XBuW6XUWTY4bir1o=
X-Google-Smtp-Source: ADUXVKKa/jeeGVEbpda/Br9jJ/Kkwjm8IMqKlD3OC8C/lGFTqYZMzxhu0+i/ft0nVKEHM+LgTX74EA==
X-Received: by 2002:a65:4a42:: with SMTP id a2-v6mr16052634pgu.367.1529433200052;
        Tue, 19 Jun 2018 11:33:20 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id q11-v6sm389103pgs.2.2018.06.19.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:33:18 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:33:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 5/5] Input: evdev - Switch to bitmap_zalloc()
Message-ID: <20180619183316.GI71788@dtor-ws>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-6-andriy.shevchenko@linux.intel.com>
 <20180615214231.GA371@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615214231.GA371@yury-thinkpad>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 12:42:31AM +0300, Yury Norov wrote:
> Hi Andy,
> 
> On Fri, Jun 15, 2018 at 04:20:17PM +0300, Andy Shevchenko wrote:
> > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > Besides that it returns pointer of bitmap type instead of opaque void *.
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/input/evdev.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > index c81c79d01d93..370206f987f9 100644
> > --- a/drivers/input/evdev.c
> > +++ b/drivers/input/evdev.c
> > @@ -481,7 +481,7 @@ static int evdev_release(struct inode *inode, struct file *file)
> >         evdev_detach_client(evdev, client);
> > 
> >         for (i = 0; i < EV_CNT; ++i)
> > -               kfree(client->evmasks[i]);
> > +               bitmap_free(client->evmasks[i]);
> > 
> >         kvfree(client);
> > 
> > @@ -925,17 +925,15 @@ static int evdev_handle_get_val(struct evdev_client *client,
> >  {
> >         int ret;
> >         unsigned long *mem;
> > -       size_t len;
> > 
> > -       len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
> > -       mem = kmalloc(len, GFP_KERNEL);
> > +       mem = bitmap_alloc(maxbit, GFP_KERNEL);
> >         if (!mem)
> >                 return -ENOMEM;
> 
> But in commit message you say you switch to bitmap_zalloc(). IIUC
> bitmap_alloc() is OK here. But could you please update comment to
> avoid confusing.
> 
> > 
> >         spin_lock_irq(&dev->event_lock);
> >         spin_lock(&client->buffer_lock);
> > 
> > -       memcpy(mem, bits, len);
> > +       bitmap_copy(mem, bits, maxbit);
> > 
> >         spin_unlock(&dev->event_lock);
> > 
> > @@ -947,7 +945,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
> >         if (ret < 0)
> >                 evdev_queue_syn_dropped(client);
> > 
> > -       kfree(mem);
> > +       bitmap_free(mem);
> > 
> >         return ret;
> >  }
> > @@ -1003,13 +1001,13 @@ static int evdev_set_mask(struct evdev_client *client,
> >         if (!cnt)
> >                 return 0;
> > 
> > -       mask = kcalloc(sizeof(unsigned long), BITS_TO_LONGS(cnt), GFP_KERNEL);
> > +       mask = bitmap_zalloc(cnt, GFP_KERNEL);
> >         if (!mask)
> >                 return -ENOMEM;
> > 
> >         error = bits_from_user(mask, cnt - 1, codes_size, codes, compat);
> 
> If my understanding of bits_from_user() correct, here you can also use
> bitmap_alloc(), true?

bits_from_user() copies as much as user supplied, we want to zero out
the tail to make sure there is no garbage, so we want to use
kcalloc/kzalloc/bitmap_zalloc here.

Thanks.

-- 
Dmitry
