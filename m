Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCDC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78CB2242B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvAzRK5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78CB2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeHJT2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:28:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51876 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeHJT2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:28:23 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so3508435itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQukal0s2aQDRrtnS0HE6Et9Ie/z38k0Gj8GQXK1agw=;
        b=VvAzRK5Udg56y1lhB9s1Qh9c7J5HNy6dwz23jIt1sNi35EuXlkCLFIWsZz/lw1kodh
         pKvV7JAY2sZR7w1RhMsASDkNnVVjTGtB0C+MrkzGxMhZDMc/i+hMaCPLOaEMlKvjRWtO
         055QUrgN98EduuF2C3HXBR+u244V2tHq0HhD2ho3yNrzzn9qUmv0aAXq6LLSqN+gaTBP
         rkBF6PaxiFg0qbvLRy/U7aOi7rC1KwuWw0615ibVa99AEOQb/yGeMQpSixUvbWVBhzGr
         XSeiAa2+DylW36A83Mhx26n5MWkqzQaZRNUDyBpPTmITaazAFgkr/xm7UYGF/hGOidVj
         fIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQukal0s2aQDRrtnS0HE6Et9Ie/z38k0Gj8GQXK1agw=;
        b=HhIvGtPZEkrywQeaqVKHwe0KFkA5tgI5oRl/GfO65xnCvnVLfB38wewN5OXsVB5q26
         Z0hmCnpnU3erbdXgHG2KkpGLaB557xWLr9hECXTbD0eYLi2SwYhhnphrr/jR66D6visE
         tAgNVj4E4y1gTD1CRAyoAtRPFTOm5Ke71G1ZKO6iuskWjixyuPL92p3ucjrSGCHUhmkN
         FC24U3vkS0wtsDX/szU87tTritB+jiYo9Xv1xrOVxr0TsUSwAL5T+BD8LZhEsq3oCNAu
         tQDl9gR7YYXLk9F7SARuIt7b8SLdrsZA1Q4V5Bp8VTkSWQJcUDHtG8+ALy3Iiw9MdO8U
         i8Xg==
X-Gm-Message-State: AOUpUlFeJsIN5xHaqiFV5s1I6ZqQlIsVU2ohOpqunXOD88NhHx8cTk6C
        q2+U4IWdc3iCs5jLI70r0+ncFSYL+tpvcthNxoyZtA==
X-Google-Smtp-Source: AA+uWPw5X8QOaN67WAKZ4sXQ8NrkFYgCVDeP2Bux7zoawhwSOI4pOtk58LSLyOlSCHOa+EW3nOT4QEc8qGjzA4NAb5A=
X-Received: by 2002:a24:fdc8:: with SMTP id m191-v6mr3098662ith.10.1533920261696;
 Fri, 10 Aug 2018 09:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180810032111.197743-1-toddpoynor@gmail.com> <20180810032111.197743-3-toddpoynor@gmail.com>
 <CALTjKEM2q=pGh+nz6O7mQerkcnZ+=B6t+viu7dwfMHjZMQRXGg@mail.gmail.com>
In-Reply-To: <CALTjKEM2q=pGh+nz6O7mQerkcnZ+=B6t+viu7dwfMHjZMQRXGg@mail.gmail.com>
From:   Rob Springer <rspringer@google.com>
Date:   Fri, 10 Aug 2018 09:57:30 -0700
Message-ID: <CALTjKEN=jwaasgdb_GMd7i1mPowS16MKxUoBbpHV++RSCu0dfw@mail.gmail.com>
Subject: Re: [PATCH 02/16] staging: gasket: core: remove debug log that could crash
To:     toddpoynor@gmail.com
Cc:     John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Rob Springer <rspringer@google.com>

On Fri, Aug 10, 2018 at 9:56 AM Rob Springer <rspringer@google.com> wrote:
>
> Revewed-by: Rob Springer <rspringer@google.com>
>
> On Thu, Aug 9, 2018 at 8:21 PM Todd Poynor <toddpoynor@gmail.com> wrote:
>>
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> A debug log in gasket_alloc_dev() is issued regardless of whether the
>> device pointer used returned success or error.  The log isn't that
>> useful anyway, remove it.
>>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> ---
>>  drivers/staging/gasket/gasket_core.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> index d12ab560411f7..37d14e30ffa21 100644
>> --- a/drivers/staging/gasket/gasket_core.c
>> +++ b/drivers/staging/gasket/gasket_core.c
>> @@ -234,8 +234,6 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
>>         dev_info->device = device_create(internal_desc->class, parent,
>>                 dev_info->devt, gasket_dev, dev_info->name);
>>
>> -       dev_dbg(dev_info->device, "Gasket device allocated.\n");
>> -
>>         /* cdev has not yet been added; cdev_added is 0 */
>>         dev_info->gasket_dev_ptr = gasket_dev;
>>         /* ownership is all 0, indicating no owner or opens. */
>> --
>> 2.18.0.597.ga71716f1ad-goog
>>
