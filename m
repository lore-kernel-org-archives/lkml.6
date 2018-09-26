Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D35208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA4HgWPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D35208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeIZPlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:41:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43361 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeIZPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:41:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id v18-v6so5667979qka.10;
        Wed, 26 Sep 2018 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkXIFnF1AF4DxkvSF2KDNilhPlVCgDvJ3KBBKyLgIDo=;
        b=nA4HgWPAXYH7kvvr9o6qtmJyVrVvTfPAM9AoUqUfHEZf06mzVu+M83XnwYEK2qpO16
         xKEUzNAe92QkOEYVwDRYJQc21rvnKvy9FGEP+S3AUj9rGRQQEf+x7JXN32HfwZZOigml
         pHF4Q283cj+BC/AXL4Be6ntQT3AUZwdeSe8jwnYyfkQvhXTkPIdWsrTkOEVYCfyPLLmW
         jv/83K+cB8vX2qXn8oonwiI+ewYsvGDPN/FoSfPPKJukJdEaYFils7Po6QuFKGjh+UNC
         kJJ7xB9d89/qb4/obYWMANMi5I0+Uo+q+pR1DrSzlzkPiv+/OM0Qp+rN0Q6G5MezhrnA
         YCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkXIFnF1AF4DxkvSF2KDNilhPlVCgDvJ3KBBKyLgIDo=;
        b=gDFO4Qn7VU3Apu4USbWhH63SlKW5SAV4nE3poDOMqI+hAeejznJHQejhOnfL8v5ofm
         UZRayw6zb5weo6OQFhsM85q7MWWgNm1P4OVT5XXcizf+t0Yk4Zg9Pf0HSYkj9+Flq4Ch
         lru9gE0kvRsomWFGnpyJL2Z+XzBQVIcJ12fK+EIq9TeOh6Fwgn23qHl2AZuqUgl3tOuQ
         L+wYZUB0yg50j8C1WyikV7l6j5vs5vA/1vL1KfWEXfBleC1wDcD1jKxDmTu1NoYxoj05
         GL656lwMJhMZgcbPd8deQcb1JHBJdo1URnq5xjkKCRPJU0DMjupXSsdSu/GoqFpO9Jko
         QFSA==
X-Gm-Message-State: ABuFfohFC/xU0qUxcLI37keXkSY1siN50BKK1LTXyZgC/+rf2B6t6ikd
        4ZEvSQnKJciJhbOXsVsuCqTsfjIB0l8JCjGEnwM=
X-Google-Smtp-Source: ACcGV60A0lMGAk2uGFATH7/RXhZB5AO5iWvD+lIlaN8h2u/3fZ1RVlXc1UMfbb6ilUG12TNC6bTVt3thklpmWQGpHbI=
X-Received: by 2002:a37:4712:: with SMTP id u18-v6mr3537832qka.301.1537954147740;
 Wed, 26 Sep 2018 02:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <1536044899-10452-1-git-send-email-zhang.xianwei8@zte.com.cn> <9fce93c1-ad6f-8d02-0cf7-42680b78a924@canonical.com>
In-Reply-To: <9fce93c1-ad6f-8d02-0cf7-42680b78a924@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 12:28:56 +0300
Message-ID: <CAHp75Vf2YE4M9gkN6TYmJa5smAVWDD35+h9PwHkv4PYTEwb=4g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Use __func__ instead of
 read_ec_cmd in pr_err
To:     Ike Panhc <ike.pan@canonical.com>
Cc:     zhang.xianwei8@zte.com.cn, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 11:49 AM Ike Panhc <ike.pan@canonical.com> wrote:
>
> On 09/04/2018 03:08 PM, Zhang Xianwei wrote:
> > Refer to the commit f1395edbcec8 ("platform/x86: ideapad-laptop: Use
> > __func__ instead of write_ec_cmd in pr_err"), prefer using '"%s...",
> > __func__' to using 'read_ec_cmd' in read_ec_data.
> >

Pushed to my review and testing queue, thanks!

> > Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> > ---
> >  drivers/platform/x86/ideapad-laptop.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> > index d4f1259..f856d59 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -212,7 +212,7 @@ static int read_ec_data(acpi_handle handle, int cmd, unsigned long *data)
> >                       return 0;
> >               }
> >       }
> > -     pr_err("timeout in read_ec_cmd\n");
> > +     pr_err("timeout in %s\n", __func__);
> >       return -1;
> >  }
> >
> >
>
> Good catch. Thanks.
>
> Acked-by: Ike Panhc <ike.pan@canonical.com>
>


-- 
With Best Regards,
Andy Shevchenko
