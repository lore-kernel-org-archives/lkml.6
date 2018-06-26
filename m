Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8374C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1693B26CEE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiEV0db0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1693B26CEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeFZTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:09:35 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33339 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeFZTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:09:34 -0400
Received: by mail-ua0-f193.google.com with SMTP id u21-v6so2326243uao.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+z+MnntGYev9PwMYnXinO4dZq7CrIa1ZELfbU6xOWLA=;
        b=CiEV0db0jxVdXt4Wb3yW39uepFM3fVImG48WD0xRQvtl6T39sDYg4/hZ1QQLrvGvrN
         /WtOn5NVXInrHZ+gzclwwwwrzCEefQZ29C7mePj4iNDLy+B2VdhYxtJA6e3WQP3mRhZa
         Ywght5RPC9i76CPte+Balmdn60VbU9TXI3zMZXNxeFyb4etlTuIj5m1FQGWs34e0xSto
         RCOfp396IbnWMYBLal1RHAih7lm4BUjlHuMHGGle6IP7tAmnaGvE8U2VURLu4XnHlUgf
         VSrUk2IkuztzPxu4muuIF0n2vvwtpVZTLlRkubaa9hVBj27fNc82BOiic44a3MTCNY98
         GbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+z+MnntGYev9PwMYnXinO4dZq7CrIa1ZELfbU6xOWLA=;
        b=OaFD/i2lEM+Z9EO03ZHCCPVqlNKttmJWAOKiDv2wczodXHDD0zvjPXa4eaUVcNKhAx
         Oc8SChe+oBbIvsA7mS5R3zKPao7un146OhDnvVH8mlezk6x+mU/5aDIZP7rpwUBUz700
         /Gki1Lgr3+o3ULeGED3ii7WSGJRvs2BKUTZmoMB3ViYrti/0/8yYoGzGdLLybR0u4Y0B
         NG+IJJWCRUn7E7BTSULomysGJFoHk53aydVNHYOU/0ez0zi5cbVUNhtbUy2dbPGGIhpW
         DjY0gHpWqFf5mAnzHgpLBzrf84skOi8t4+OwGZtz0MvylLw+Yf0wg67lFmvSsZLkQsVE
         1QPA==
X-Gm-Message-State: APt69E1gyqCY1/YByMQ8DTiF53J2XpqWeB8Y9HMWE1+jPk/djmIfN/iN
        nSPyaL/Pf5JrMNFbacvsOhy/EWFIVEqEcbnUAnDVmx6x
X-Google-Smtp-Source: AAOMgpev4SVifaBQcrTyjARqRzZFoc3KGl36gvBE3LxUVFImOAsT2aZ12YzIc6jgmUNqxpmQ1Ao7Qm0ruv0TiFrkvfk=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr1166930ual.28.1530040173376;
 Tue, 26 Jun 2018 12:09:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:09:32
 -0700 (PDT)
In-Reply-To: <20180625122453.souir6wzzyhbkj4m@mwanda>
References: <20180621182155.27769-1-michael.straube@posteo.de>
 <20180622102800.4p6wabmte4yf4rtp@mwanda> <CAHp75VeASBAsBrrq65qhkAGXHoSE8Hg-9dSGcgjT2bNND-1MBw@mail.gmail.com>
 <20180625122453.souir6wzzyhbkj4m@mwanda>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 22:09:32 +0300
Message-ID: <CAHp75VeO3dDRYwVFY+jeCngwOY-rZVr7XLxvwYNxkfR_cHZaFg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <michael.straube@posteo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:24 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jun 25, 2018 at 12:47:44PM +0300, Andy Shevchenko wrote:
>> On Fri, Jun 22, 2018 at 1:28 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> > On Thu, Jun 21, 2018 at 08:21:55PM +0200, Michael Straube wrote:
>> >> Remove braces from single line if statements.
>> >> Also fix a comparsion to NULL in one of the conditions.
>> >> Issues found by checkpatch.

>> >> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
>> >> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
>> >> @@ -618,9 +618,8 @@ ssize_t proc_set_wait_hiq_empty(struct file *file, const char __user *buffer, si
>> >>       if (count < 1)
>> >>               return -EFAULT;
>> >>
>> >> -     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>> >> +     if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
>> >>               sscanf(tmp, "%u", &g_wait_hiq_empty);
>> >> -     }
>> >
>> >
>> > The original code is kind of bad.  The NULL check isn't required.
>> > The sscanf call should have error checking.  The error code is wrong if
>> > the copy from user fails.  The tmp buffer isn't NUL terminated.
>> >
>> >         if (copy_from_user(tmp, buffer, sizeof(tmp)))
>> >                 return -EFAULT;
>> >         tmp[sizeof(tmp) - 1] = '\0';
>> >
>> >         if (sscanf(tmp, "%u", &g_wait_hiq_empty) != 1)
>> >                 return -EINVAL;
>> >
>> >         return count;
>>
>> Shouldn't this be
>>
>> kstrtouint_from_user()
>>
>> instead of all those lines?
>
> I wasn't sure kstrtoint() was the exact same as sscanf()...  If so then
> sure.

In this case it's very close to what sscanf() is doing here including
all user buffer handing.

-- 
With Best Regards,
Andy Shevchenko
