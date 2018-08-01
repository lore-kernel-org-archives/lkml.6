Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F90CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F103020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fjwwW5CH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KB8Dd7bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F103020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbeHAGGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:06:00 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38021 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbeHAGF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:05:59 -0400
Received: by mail-yb0-f196.google.com with SMTP id i9-v6so7049766ybo.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a0SNCNQqhg47KieOA7FkNEfuxdldR7ZbNPA2FLWcqYI=;
        b=fjwwW5CHnMzQZSVe6MyZJCp5vyrgiAzB5uNt+JcR1LeHtmuqXSI8IfoWbeQSUhY5WY
         31QRSPlu+myISKLjf5WzjdQ9fgkXoua/pP1S//REndfxhV9S53rvJ7YNTDoewQbc1QFv
         1wE8opHpPa+IixtvsGKPPEK+5r+j9DjFLah2CzzoUfAZXQpv0gEuGsd+Odbad3cza5k0
         1zVUm+qeuXtoFUMOpwmbfaZjXmOwUtVKf6WQWumNoE8VwkPpnlrPGDyiQ5vHNYtzXBK0
         YA5Cgj8rpZTuHHGLrnLvVaRsbdIfemLtdj+Xx2jdCyTx6a8OJbtQma9S0X/HSlSgpQF8
         qtaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a0SNCNQqhg47KieOA7FkNEfuxdldR7ZbNPA2FLWcqYI=;
        b=KB8Dd7bUTs0TVJxVAfBOel++d/mMeUYKtrssSsqYxCc4JDYya31rU+QhXMaYh+U5z0
         Jz8iS9QrnlYXfxT9tWnX+Du2sBaPTiC6dbYsOFuA4V/yue7NrSuAq+JKbGk5GYWuJLjz
         6a10RfZ4SJv1boo8D8aS6Omm95sbGddwdlEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=a0SNCNQqhg47KieOA7FkNEfuxdldR7ZbNPA2FLWcqYI=;
        b=aybfxrpVC771akWuK19xQq//YxsNHI0QEaIKQMMmRNzq380qGnYCpRuJ4Zf8SyF03b
         lDdW8bTOZts3tSWorde51IrA7VVaWpQH9uMJ4aV2mbzQ8X7V1i3mOPl1h85Ef0YR6Uje
         cZk7c4zkZteA8Nfin5sGUXmmroy7mUjX/Vp9JOCJ6dcO+vgqNf2Ixu7uqMBCB/Tk0Sg4
         xMx80ILUoSLbrlGqgd0IRgifyYZ636LX/rbz8UL1K0WYDV40yA6uJviarFJvO+v2ld1A
         VmLA6wx4QcWDVhBS6IIWDpRuMUs/2/OFE6njW4nqAggN3K+RABprFukZTiQForWQNS6b
         pxWw==
X-Gm-Message-State: AOUpUlEUQm8uffCXM/ilt1vOeikui0SI4QeRfPGayrqsUqcw2DbOV6Vk
        fxUMwyMGBSMpd9j0kwc8FEwjxsYxOJ3B2LsDjTDYGQ==
X-Google-Smtp-Source: AAOMgpemEhHmSrLpqdwIbmEgidisN4KZJ4fJuw3bwrOKxyr3OOg1RC+r0/7lmnSnSGCMZnAd2Hofz42ylo+yX3eiYVE=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr13474766ybr.463.1533097344798;
 Tue, 31 Jul 2018 21:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 21:22:23
 -0700 (PDT)
In-Reply-To: <20180801021508.GB31192@ziepe.ca>
References: <20180801000039.44314-1-keescook@chromium.org> <20180801000039.44314-2-keescook@chromium.org>
 <20180801021508.GB31192@ziepe.ca>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 21:22:23 -0700
X-Google-Sender-Auth: j1SQTn8OUdryzgJH_LOh54oB68g
Message-ID: <CAGXu5j++7uQC3XWH7EDhOMDCfcTm+cJ4_9dwN-HsffNRRHyi6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:15 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Jul 31, 2018 at 05:00:37PM -0700, Kees Cook wrote:
>> From: Jason Gunthorpe <jgg@mellanox.com>
>>
>> Add shift_overflow() helper to assist driver authors in ensuring that
>> shift operations don't cause overflows or other odd conditions.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>> [kees: tweaked comments and commit log, dropped unneeded assignment]
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/overflow.h | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index 8712ff70995f..69fc366ce865 100644
>> --- a/include/linux/overflow.h
>> +++ b/include/linux/overflow.h
>> @@ -202,6 +202,37 @@
>>
>>  #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>>
>> +/** check_shift_overflow() - Calculate a left-shifted value and check overflow
>> + *
>> + * @a: Value to be shifted
>> + * @b: How many bits left to shift
>
> The above @b should be @s

Ooops, copy-paste-o. :)

>
>> +#define check_shift_overflow(a, s, d) ({                             \
>
> Should I run this series through the rdma tree?

I'd like to get Rasmus's Ack, but otherwise, yes, that'd be fine.

-Kees

-- 
Kees Cook
Pixel Security
