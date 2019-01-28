Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62575C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6020881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxYrYAks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA1I3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:29:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34285 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1I3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:29:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so13472380lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Cr0Xvw30nlRoRenB6A+Xtlvq8eKjofNGXUNco6MaAUQ=;
        b=BxYrYAksWrbzcMFPdGNfy68pu99ouzCMCV0mjEgC5c4C03ALt3H8/Ose+ibTbxdY+s
         nMA2UkQKk3EAsPLj7Ir7IhC8stI0TZEiWD2GQ/AmX2H7qmmMf7ZQeAEfGyCKVQup5lSy
         hR+2Mt/JepEs7isaGqI9rQiyquG11lfhdgSGcrPgMyUxQ7Zs0frSVCJtDZZdVOeZPzS2
         3CGCnW+n2AJQv5tKXYsSmbpvSYSQa+BOGN2jcur9r/m3LbEhWTUbTNf37zzaLjyOFW6E
         2OAGr+v02zDznpt1OinBcEiIwlDA1ZR3GvLpxiTHqPGfj5V/Rp6UgyONXo9dFRqFwkhV
         qw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cr0Xvw30nlRoRenB6A+Xtlvq8eKjofNGXUNco6MaAUQ=;
        b=GUno8yNBYEuUzTcAKfj0I/sR1ta6QeiysMpfMV6Z8qnV3jxh8nYIJbAMpchWLxefTV
         wYejjOPdM7zLaBqfSzjvcVot0oHRK6KN9O5xMtIlPFolS8M9yBus1nBKQGnVDodLHQME
         yzWuoIqYwtUWzYXcRCeM7IiI4EHU9Jh0UPrCdP411CO8AqsgH82pjIZ7ulfO3n79yJHc
         UPbMOFbvCfog9fz8a1mvOr+LYK2kVILOgb3bUVGOc2oYQPJabldJ0QpoZO56sS5WHepv
         hXzbArdTgRWKzvUvHE73Ze9XbY7diASgEhqL5V2J5G4OkhdSjdI7G8fRJQfuNKLfVdkp
         LOSA==
X-Gm-Message-State: AJcUukfICPiFHgQ4IZvDXmJkt1GrHSnut0b/1lj18gFTPpGU4l66gN/h
        n7aD6iKk5exBFDYzFrdxlWQ=
X-Google-Smtp-Source: ALg8bN5LLVZWXUpWBs8gJJvQE2wwTSFPDzPRuPjWs3XoZ0dqt1PTVV+EZAXWx23OwmybcJvxoa8Xsg==
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr8987847lji.57.1548664142550;
        Mon, 28 Jan 2019 00:29:02 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id m1sm2788894lfb.56.2019.01.28.00.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:29:01 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     sstabellini@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
 <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
 <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <cd855c41-dca0-14dc-6703-886feccd34ea@gmail.com>
Date:   Mon, 28 Jan 2019 10:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Boris and Juergen who can also help getting it in

On 1/28/19 8:34 AM, Souptick Joarder wrote:
> On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> On 1/7/19 7:37 PM, Souptick Joarder wrote:
>>> Remove duplicate header which is included twice.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Can we get this patch in queue for 5.1 ?
>>> ---
>>>    arch/arm/xen/mm.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>>> index cb44aa2..e1d44b9 100644
>>> --- a/arch/arm/xen/mm.c
>>> +++ b/arch/arm/xen/mm.c
>>> @@ -7,7 +7,6 @@
>>>    #include <linux/of_address.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/types.h>
>>> -#include <linux/dma-mapping.h>
>>>    #include <linux/vmalloc.h>
>>>    #include <linux/swiotlb.h>
>>>

