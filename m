Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F7ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F9B215E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F9B215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392166AbeIVGKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:54 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41294 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392140AbeIVGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:53 -0400
Received: by mail-io1-f69.google.com with SMTP id q24-v6so26101716iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=4tA88TLPwMdDTqdkaaoMo4ME+HYOUnR76EVicgKx82s=;
        b=SXWCayAGwk1lSy/eUhBfUoHncEhLi+VQSmbyOctTxkuzxbhLSHG8NHEuSWRA9wMvZG
         OgKnapThfEFOwJrWEeMdHJGMm7S6jal0XlNbGBSwSHyFZxe3pLaO7j8xDwWhdvLcQ2uj
         oZFx/aYCUW0mf4U4xm578u1jsmldeHQs++tp5lw4cLkxYFS/Awy+CWEZszOhTZ8qo8QF
         tBpYWF2VtT9I/c+VzKev4qImvvXwshCoxG3kb1M5UB5owBrdVHR3tw62DdQgywE/rc+X
         fVo3UxQRpekclX9EIGztThXapnK3wv2kkjlfdn2gqeu7adkrdjfx7pty4h1I3H4qhcOq
         oxmw==
X-Gm-Message-State: ABuFfohpOAbxDqkafB5byAVVMCRTzt8SE3sHXa+2UV0wRp8zDangLp7+
        X6LoIdV/Icd26aoK9vW6SGvctYlZOETxg+4aykAXugihHqlm
X-Google-Smtp-Source: ACcGV60e00p8udnSLh4QX29CICaWGF+Ki+94KbKu132FcYgZbtv/ag5rkmKQyOPpsE36y0D70kn3rdFR4Xt/ZqOpcXOJ6FseDBHZ
MIME-Version: 1.0
X-Received: by 2002:a5e:c104:: with SMTP id v4-v6mr114038iol.9.1537575575770;
 Fri, 21 Sep 2018 17:19:35 -0700 (PDT)
Date:   Fri, 21 Sep 2018 17:19:35 -0700
In-Reply-To: <lsq.1537575342.495565532@decadent.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000025c4a05766ab6be@google.com>
Subject: Re: [PATCH 3.16 20/63] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
From:   syzbot <syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     akpm@linux-foundation.org, ben@decadent.org.uk,
        dgilbert@interlog.com, glider@google.com, jthumshirn@suse.de,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3.16.58-rc1 review patch.  If anyone has any objections, please let me  
> know.

> ------------------

> From: Alexander Potapenko <glider@google.com>

> commit a45b599ad808c3c982fdcdc12b0b8611c2f92824 upstream.

> This shall help avoid copying uninitialized memory to the userspace when
> calling ioctl(fd, SG_IO) with an empty command.

> Reported-by: syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Acked-by: Douglas Gilbert <dgilbert@interlog.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>   drivers/scsi/sg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1825,7 +1825,7 @@ retry:
>   		num = (rem_sz > scatter_elem_sz_prev) ?
>   			scatter_elem_sz_prev : rem_sz;

> -		schp->pages[k] = alloc_pages(gfp_mask, order);
> +		schp->pages[k] = alloc_pages(gfp_mask | __GFP_ZERO, order);
>   		if (!schp->pages[k])
>   			goto out;



Can't find the corresponding bug.

