Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0026C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B18E208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyytkrFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B18E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeFLJxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:53:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42927 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:53:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id k190-v6so20527164oib.9;
        Tue, 12 Jun 2018 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pa7pzSFLrUqF/vyckkBeEXxwhzU7rsV7SBQBwV99bHc=;
        b=tyytkrFv6Rm5bHzh0DC56UBn7VjFkm5AnbuFA4dBa4E9kqwqB6tJEnZ08ZkhTb4ATL
         cGiaJDzvb1x9/fMbOn44FMp36yNP7hg0jNtepTMDViBs/7eBOs1Hl/PBIhfiHKOFX23b
         6Hf9aKxGU9+GiU91frz7lGcRHTd23SPLyPktRn9er0K9X5CRJU17j40AIHC1nYFHi59c
         e77wVhj3SLLMUNzm7Js+ddvNjtqsCYzyxnyUenhSvNvosb/aeol3dg4saTENsrS3Ouzu
         VHp/m+HmQbr9lAThvTLbiydl53+0bFqXhMYKPvfT2FkkFynt9TJc4Ku36BYWR1u1H9Dv
         YF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pa7pzSFLrUqF/vyckkBeEXxwhzU7rsV7SBQBwV99bHc=;
        b=UfXjsBf4YZ4pmrThEPUND/Cf5Mbeu3oGReQp39mxPHedFyiYCfERv5iXzKP8b/uuJ+
         JmPWzG77SHvkJPN2hKmLv1FMDJnQY2lALAldK6JFZ1aXhqoNLdDP9Olf0OdtPb1OsyLN
         33cB73Us0d3sTW3pjXmDKNQ8uGzlvI0omgsS4eezsMNKTFC3XSuWVkAO913aa2XKDw3R
         pHiVVF0oUlRT7LJtYPc4jeHBL/mkB47TMXHjyLeofuE+o8YFeqN/IwKS9s9wiN5dqM9l
         CiYNwHc4b7NShz0Oiu/rddFO2vOo8ugaE30wBNCox2S42xMYcXKMhNp8VS0PHMIJScfG
         kO/g==
X-Gm-Message-State: APt69E3prEB+N2685+zfnKmRMHBTADyLwVVKH0vWSmhX2JzMth/9h+Dk
        PGNwtmJiSa73zfGndWYa+W8UEyeIp7J1p+hTs14=
X-Google-Smtp-Source: ADUXVKLM3xOFF53UfAuyrtoJfvwC7tw0/3RRuLC/eYJ242GNw4GYoHFriFpILu3k2PpQ6OWPtDSNxMmDVoo1jPNcG9w=
X-Received: by 2002:aca:4f0d:: with SMTP id d13-v6mr1448718oib.138.1528797193001;
 Tue, 12 Jun 2018 02:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5187:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 02:53:12
 -0700 (PDT)
In-Reply-To: <5381809C-13EE-42BC-883B-F8E5A90FD1C5@gmx.com>
References: <1528777362-40212-1-git-send-email-jiazhouyang09@gmail.com> <5381809C-13EE-42BC-883B-F8E5A90FD1C5@gmx.com>
From:   Kassey <kassey1216@gmail.com>
Date:   Tue, 12 Jun 2018 17:53:12 +0800
Message-ID: <CAKwPUoz5uz+nxvjBo9nw2fNYcCJRk2-aCzPNcrCzg9-383D7AA@mail.gmail.com>
Subject: Re: [PATCH] inotify: add error handling for kmem_cache_create
To:     "cgxu519@gmx.com" <cgxu519@gmx.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in __kmem_cache_create->kmem_cache_open

with SLAB_PANIC, kernel will panic if it fail

On Tue, Jun 12, 2018 at 3:41 PM, cgxu519@gmx.com <cgxu519@gmx.com> wrote:
>
>> =E5=9C=A8 2018=E5=B9=B46=E6=9C=8812=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=881=
2:22=EF=BC=8CZhouyang Jia <jiazhouyang09@gmail.com> =E5=86=99=E9=81=93=EF=
=BC=9A
>>
>> When kmem_cache_create fails, the lack of error-handling code may
>> cause unexpected results.
>>
>> This patch adds error-handling code after calling kmem_cache_create.
>
> I think SLAB_PANIC can handle this case.
>
> Thanks,
> Chengguang.
>
>>
>> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>> ---
>> fs/notify/inotify/inotify_user.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotif=
y_user.c
>> index ef32f36..0704bab 100644
>> --- a/fs/notify/inotify/inotify_user.c
>> +++ b/fs/notify/inotify/inotify_user.c
>> @@ -805,6 +805,8 @@ static int __init inotify_user_setup(void)
>>       BUG_ON(hweight32(ALL_INOTIFY_BITS) !=3D 21);
>>
>>       inotify_inode_mark_cachep =3D KMEM_CACHE(inotify_inode_mark, SLAB_=
PANIC);
>> +     if (!inotify_inode_mark_cachep)
>> +             return -ENOMEM;
>>
>>       inotify_max_queued_events =3D 16384;
>>       init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] =3D 128;
>> --
>> 2.7.4
>>
>



--=20
Best regards
Kassey
