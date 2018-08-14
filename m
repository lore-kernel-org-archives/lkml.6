Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5263C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890ED20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpJ4uBey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890ED20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeHNFN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:13:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeHNFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:13:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so8551292pfh.5;
        Mon, 13 Aug 2018 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T0sAzYYEiGAbSU9nPCHq4iLqLijsTNolaiMPj330aaQ=;
        b=SpJ4uBeyz8EMFFC27+t0T7+aCSrUppLWiL9aqfYpwwaNPmAuL1ppy2MULCOifS70c7
         0FTK/vaqlvz7V96JjD/JG0CnORvmus5yXy7tJRUbLl6nfv8oGMES8nKTEdSSQBd9RBtf
         hCRtghonSf+yUCBampgx1Gs7oIyZ1xftgY1QnwKpYCaKIOmliM4JBJ0V6FXnoRSXEHuG
         dWF9BnshA8yQYhbYh6Bm+JtEStpIcLgTBBqojrr6uJqtrcATFcbK86niU3Iv22qCOnrp
         2HbNK9xhpN69ZQwul2qsFDdfuJHQUHeBOyhXK7PnvFmA2ZNw31eWMjUmVcDFK7ZVZZhk
         8HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T0sAzYYEiGAbSU9nPCHq4iLqLijsTNolaiMPj330aaQ=;
        b=AmJ9ah3OlcZYX1VT2HLGDS6rFTnBfB5L2UlG72Ab6YW1yKe+iJAPnWaZFMnHse/gGd
         TF8lF4DdP7g0O0oBLmjxqDI525rcFqvCGxuTXU7zcrnAMVWSGaAaeF42hcKny3lx0Kgv
         VYal3h3rgIkIXduJPjETS1izNbYWIjA0KdYCQsI602HjxTYEmLxJAuIlmq2SJEWNfhH0
         O/SU5JOiTj+9ksy3lVG8z73bq/0fIV/wFvpVzRnueXkI17cB1UzmG0ztZ3O7CFZ4OcRk
         igxXycCrzt5+1JDsxt1iiSGnDMevVdcC+aHtC3f/0zrtr1d0Q87dIaKSWKy7mM3zfbzV
         b0hQ==
X-Gm-Message-State: AOUpUlEuhvUv9z5oDY2JE+BJMZzYw/UCsOVV9DWnb75fnI6EEurMO/q3
        sLVokpguCZdCxd3sJFWs82c=
X-Google-Smtp-Source: AA+uWPxHzBYVG7MEJacrMxZ/6lUAe8oSo+dy6GlWnqnxUDrBg5xDPRxaTZtHEkwAmZnobZHOkKJCwA==
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr19344362pgw.426.1534213709982;
        Mon, 13 Aug 2018 19:28:29 -0700 (PDT)
Received: from linux-zmni.apac.novell.com ([45.122.156.254])
        by smtp.gmail.com with ESMTPSA id g5-v6sm18915575pgn.73.2018.08.13.19.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 19:28:29 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:24 +0800
From:   Sean Fu <fxinrong@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/bcache: Remove NULL check.
Message-ID: <20180814022824.GA19644@linux-zmni.apac.novell.com>
Mail-Followup-To: Coly Li <colyli@suse.de>, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534153129-24869-1-git-send-email-fxinrong@gmail.com>
 <d02ab12b-3087-020e-cf51-cbd7940f8efc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02ab12b-3087-020e-cf51-cbd7940f8efc@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 06:00:11PM +0800, Coly Li wrote:
> On 2018/8/13 5:38 PM, Sean Fu wrote:
> > Remove unnessesary NULL check before kmem_cache_destroy() in
> > drivers/md/bcache/request.c
> > 
> > Signed-off-by: Sean Fu <fxinrong@gmail.com>
> 
> Hi Sean,
> 
> A same change is posted in my previous checkpatch fixes series. You may
> find it from,
> https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/?h=for-next
> 
> The identical patch is,
> https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?h=for-next&id=26b39d0732955ecb839d0afe8d6211d70f213384
>
Thank you for your reply.

Sean Fu
> Thanks.
> 
> Coly Li
> 
> > ---
> >  drivers/md/bcache/request.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> > index ae67f5f..0ddee35 100644
> > --- a/drivers/md/bcache/request.c
> > +++ b/drivers/md/bcache/request.c
> > @@ -1306,8 +1306,7 @@ void bch_flash_dev_request_init(struct bcache_device *d)
> >  
> >  void bch_request_exit(void)
> >  {
> > -	if (bch_search_cache)
> > -		kmem_cache_destroy(bch_search_cache);
> > +	kmem_cache_destroy(bch_search_cache);
> >  }
> >  
> >  int __init bch_request_init(void)
> > 
> 
