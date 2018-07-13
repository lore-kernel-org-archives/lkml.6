Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676ECECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E16B205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDpaaxDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E16B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeGMOec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:34:32 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44998 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeGMOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:34:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id 125-v6so18288618vke.11;
        Fri, 13 Jul 2018 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vmqORs+Or60qNY4r0K68CwyqYNSseRhZqw/bL41C/Yk=;
        b=QDpaaxDC9a9dWPHcchjRDk5E1wTYa4fifUXc91GtzBDmPJw0RbTqW53uJcOPOEmSGZ
         otYdxJGd2Lt2XyNwnjEc0ETmkqfUPnxBxHPPT4affTLH+hGFxClKi1mMurzlAh3DqOni
         edczirlJ5BmOvUSvYw9ycM6iV7Oo3rgCBSEwvhsR8YF6iHER4Cvtg0q6AhgVjGfFshso
         d8G4K+DD/WIiy/kO1Tu0JLHaT1Tm0ZVfV3lL29pJ+zlhL5ODhB0Orh+x0SS6tIprVz/9
         764++lR6HdvlkGdg3LhSrmu4yI7GnP//eScY/CFIgRaGdMbpW3a3WcqvrVAh6b86DzYT
         h7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vmqORs+Or60qNY4r0K68CwyqYNSseRhZqw/bL41C/Yk=;
        b=n4UwhEO246lsc1i8hBdbi/zDxwR9iAJhmrJLlV/kceW78qS4yjtWbgSjD/cBtNy8xS
         0gj7JCpumK4Zmfe1OjKk4lUPi1sVdfkNgCn0eDP14JrwHgmWfzuvDdle/wegu27geSiT
         Qnqf6+sh2KxnISXR62oY8nqcMftZNYVLk/0Zk4BsipELDiIy+9kBM7BQ2H83DlKDMpZz
         /OQtnvBL1iFd7MKKqvUvLRYgNuCpRrpzw2VlgNWL2jQJavshBcBpVgB5o879UAfA7ayX
         vqUaZL4jI7eukYY3B19h3f1citYkzNqtdiu68OSeYaKEC4CKTqBQEk/p9kxD7nsYmrqF
         SJdQ==
X-Gm-Message-State: AOUpUlGp0ZIxA0oNRB4FCHIheg/Po6MmW5b6OZ5nMPAIzchk/NQHe+2+
        wvH0hsNHqy1t9GpgWkTM1QZb9NmF0Eoz7XFVnDM=
X-Google-Smtp-Source: AAOMgpf90lvM3wWQ5qVKwVud623+PAWOurwpar1vOhmex24WH464VGNGT+aox9qt6Uz9wkPLWvtrxAK7sIPHi1ncuik=
X-Received: by 2002:a1f:8e4d:: with SMTP id q74-v6mr4055234vkd.161.1531491580909;
 Fri, 13 Jul 2018 07:19:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:19:39
 -0700 (PDT)
In-Reply-To: <HE1PR0502MB3753318D0C380DFEBCD6E452A2410@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <20180704172908.GA33650@beast> <HE1PR0502MB3753318D0C380DFEBCD6E452A2410@HE1PR0502MB3753.eurprd05.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jul 2018 17:19:39 +0300
Message-ID: <CAHp75Vd2pX_AjMwEHQUOL7WfokgoY+bsakCJxbojBBxuuF_H+Q@mail.gmail.com>
Subject: Re: [PATCH] platform/mellanox: Use 2-factor allocator calls
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 10:39 PM, Vadim Pasternak <vadimp@mellanox.com> wrote:
>
>
>> -----Original Message-----
>> From: Kees Cook [mailto:keescook@chromium.org]
>> Sent: Wednesday, July 04, 2018 8:29 PM
>> To: Darren Hart <dvhart@infradead.org>
>> Cc: Vadim Pasternak <vadimp@mellanox.com>; Andy Shevchenko
>> <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH] platform/mellanox: Use 2-factor allocator calls
>>
>> As already done treewide, switch from open-coded multiplication to using 2-
>> factor allocation helpers.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>

Pushed to my review and testing queue, thanks!

> Acked-by: Vadim Pasternak <vadimp@mellanox.com>
>
>> ---
>>  drivers/platform/mellanox/mlxreg-io.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/mellanox/mlxreg-io.c
>> b/drivers/platform/mellanox/mlxreg-io.c
>> index c192dfe6bd65..acfaf64ffde6 100644
>> --- a/drivers/platform/mellanox/mlxreg-io.c
>> +++ b/drivers/platform/mellanox/mlxreg-io.c
>> @@ -152,8 +152,8 @@ static int mlxreg_io_attr_init(struct mlxreg_io_priv_data
>> *priv)  {
>>       int i;
>>
>> -     priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
>> -                                      priv->pdata->counter *
>> +     priv->group.attrs = devm_kcalloc(&priv->pdev->dev,
>> +                                      priv->pdata->counter,
>>                                        sizeof(struct attribute *),
>>                                        GFP_KERNEL);
>>       if (!priv->group.attrs)
>> --
>> 2.17.1
>>
>>
>> --
>> Kees Cook
>> Pixel Security



-- 
With Best Regards,
Andy Shevchenko
