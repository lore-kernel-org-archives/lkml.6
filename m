Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA05ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F70320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCnH8Now"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F70320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeGQT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:57:48 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38326 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:57:48 -0400
Received: by mail-yb0-f196.google.com with SMTP id i9-v6so875171ybo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HG2oRehlFdsqyKpdamp8CzUmeyowAhmUlDH6NKCgm5M=;
        b=iCnH8NowZt2ydSjMaH8+VJ4OQ9GvWbSKZtdpvMa007mUoSxWe7U38mYmAzgY50ARAc
         PXxb7L6GMmb1Uc4L1Y/+SEQCrO2WNiMnyS6mbMnzvPTOLZjDewJUxLxg4pt6qilCwLGj
         ZALLsVCu61iTaSEJ3aVAx5n5mlAUujotujrNVOz8AZ1Z6FAZyaempsl8NRZ5EcmPZB9/
         5+4KggUMADl7kceBKn/aWqlKvEBBgHSW6sFio2ldmuL//TEydJcsgJhZBl/0L0HSDPuI
         HUMxO+Za5v6VJ3cV+aXvEFGgp1gbN1PFPMoveejlyOBU837A56Alwb45p0LwcHW/GR8z
         iMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HG2oRehlFdsqyKpdamp8CzUmeyowAhmUlDH6NKCgm5M=;
        b=g6LRU7blYv2SxIXm1jZHETaXjNGqeQBqHFpOVhNV9UNvX/Xt1IA/0/i0TShf09jhOc
         PXTAC7i4Neg9sMiO78SHhTbThI3BnUMz73s65C9A4pOpD45PsWjBKeJnts9qVfr97Ydb
         wO0VCGinwEuXf6Qf0kYR2IhsFXRDYNmuUeG52K4/DKhnDHbOzSYjUas0yEKQxpLMWBUh
         MSZi1z/mUcL8LTsNn4ORldrqS+Fp8pMFH3D1k0ZIV4KHGDuZ1X1PLB1Q4OPpNT790KOg
         I5TY/JK3vcYBOcQ3SE3IgLURxADxiPeXILCicz+exstPfaeGaeo+xG1dqyEmg02WCO9c
         5DJg==
X-Gm-Message-State: AOUpUlGQ6n4gEOXxy7DeWM/nreugGv2nRzkoGXxpNUXhTpsssczgN+8Q
        +8Oa5Kjj7g0KEAeuBMNowv4pScfQeE4OCYHkQKI=
X-Google-Smtp-Source: AAOMgpfOUZvRy3eYAuEJgVX892Ab77FcVRIYyiYqJiFuwOYpiTNMrL+S6nPKT9pcaQlOmpEX4JvjB71R5laxURNxxbo=
X-Received: by 2002:a25:69c2:: with SMTP id e185-v6mr1635188ybc.366.1531855424583;
 Tue, 17 Jul 2018 12:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:23:44
 -0700 (PDT)
In-Reply-To: <20180717103715.k3cu7jiv4333aq4k@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717020926.176408-28-toddpoynor@gmail.com>
 <20180717103715.k3cu7jiv4333aq4k@mwanda>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Tue, 17 Jul 2018 12:23:44 -0700
Message-ID: <CAO3upoaEbcSxsmtaBK7gZ1i-SA78vOR0KKxCj4Q0XF1zZHH6vA@mail.gmail.com>
Subject: Re: [PATCH 27/32] staging: gasket: remove else clause after return in
 if clause
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 3:37 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jul 16, 2018 at 07:09:21PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Else after return is unnecessary and may cause static code checkers to
>> complain.
>>
>> Reported-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Simon Que <sque@chromium.org>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> ---
>>  drivers/staging/gasket/gasket_page_table.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
>> index 2a27db658a4e4..080bf78c22c3b 100644
>> --- a/drivers/staging/gasket/gasket_page_table.c
>> +++ b/drivers/staging/gasket/gasket_page_table.c
>> @@ -598,9 +598,8 @@ bool gasket_page_table_is_dev_addr_bad(
>>       if (gasket_addr_is_simple(pg_tbl, dev_addr))
>>               return gasket_is_simple_dev_addr_bad(
>>                       pg_tbl, dev_addr, num_pages);
>> -     else
>> -             return gasket_is_extended_dev_addr_bad(
>> -                     pg_tbl, dev_addr, num_pages);
>> +     return gasket_is_extended_dev_addr_bad(
>> +             pg_tbl, dev_addr, num_pages);
>
> This isn't the normal way to break up a line.  It might even cause
> problems if you run with checkpatch.pl --strict.  And anyway this fits
> on one line:
>
>         return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages);
>
> But normally we would do:
>
>         return gasket_is_extended_dev_addr_bad(pg_tbl, dev_addr, num_pages,
>                                                wha'ever, blah, blah, blah);
>
> There are times when that looks a bit ugly if the variable names are
> long so we could do:
>
>         return gasket_is_extended_dev_addr_bad(
>                                 long_variable_name_asdfasdfaasdf,
>                                 pg_tbl, dev_addr);
>
> But generally try to get a couple tabs in from the start of the function
> name.

Got it, fixed in v3, thanks -- Todd

>
> regards,
> dan carpenter
>
