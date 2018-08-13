Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B828C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670521829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbPKRsj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A670521829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeHMI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:57:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44979 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:57:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so6485078plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ja+DLBYJQok3UI169o1CD2+Zo2KuiktTZcC9VnAq4as=;
        b=vbPKRsj9J9du7tBx2XQiSGVcq1HX0mRAPMMjkUfcE8jjCLOo10F/FLebgGrw3TTC+Y
         aNTKaogVnaCFQ3eT+xz+dbrsbpS941UKjKuTHJuZiL5saT01L64/boTBXE6HMO6RHj9M
         XJff3lr4XI3KrkfHvYhprQJIH/c9mI8yBXcuIu8MWK9U/rdzIZ6FLvyF7PJ+E+XUFHeO
         +uchNmtat4gqHx4cQcXr8qtPMZ3uE8TC19KtLkBiMgnW+opVX82vEp98+6pNi80n3KsC
         SWWtX7PtJiIlbQ8750f7LbHpomD1FXkZao7zHGOGe8J1WjvRWH44gMhG9nCJv+6kQr2T
         YJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ja+DLBYJQok3UI169o1CD2+Zo2KuiktTZcC9VnAq4as=;
        b=MF4FkAS5hIa1DyTYufZgZPVS4Ng5QOst41+LEwfP12qT1Lhc3MQlk35l2lILLNjLWb
         CamwFGLLNCWG9SjupYmaqPYmPlvVP7i7uic7eKmeXO4U/W7xIlMnhSHLVxvm2lROQm/L
         0fLCco8QF/FrfjivJ01cRappaOL6RjM7pVo3icH4UAIisyTByk9KWIBaBuewJn9uDAyc
         HYksYy6nkrdJ8LsywpnZ8MAFq7kEmWjndL5uAk5cmGhVOKR3XahgOUTBzYl4089wo20J
         X3RparSaOE2F12KnA8rWbnsy//R/7wpuw+oAk+1HJnEEWupn9NCUUiGXYWvV0kPmq5+I
         NGZw==
X-Gm-Message-State: AOUpUlFXwVoS7XGQJEnKIUfm82jr0Li/OI7BrTu4XZoSR4BCP2QGPDFK
        z4eXIY/gm1qtaoooPlwWcuo=
X-Google-Smtp-Source: AA+uWPw+sNGbKUEguzF2xAQLoI8kJQ1l0v/0tGt7IlTf5nbE+PGJG+E5G23hGm0bGlr+5r9kfUJL3A==
X-Received: by 2002:a17:902:b60e:: with SMTP id b14-v6mr15273100pls.111.1534140989588;
        Sun, 12 Aug 2018 23:16:29 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id 16-v6sm28220687pfo.164.2018.08.12.23.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 23:16:27 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:16:23 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Peter Kalauskas <peskal@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-ID: <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
References: <20180808223100.225086-1-peskal@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808223100.225086-1-peskal@google.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:31:00PM -0700, Peter Kalauskas wrote:
> The call to strlcpy in backing_dev_store is incorrect. It should take
> the size of the destination buffer instead of the size of the source
> buffer.  Additionally, ignore the newline character (\n) when reading
> the new file_name buffer. This makes it possible to set the backing_dev
> as follows:
> 
>   echo /dev/sdX > /sys/block/zram0/backing_dev
> 
> Signed-off-by: Peter Kalauskas <peskal@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Cc: <stable@vger.kernel.org>    [4.14+]

> ---
>  drivers/block/zram/zram_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 7436b2d27fa3..3137faea1493 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -336,6 +336,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
>  	char *file_name;
> +	size_t sz;
>  	struct file *backing_dev = NULL;
>  	struct inode *inode;
>  	struct address_space *mapping;
> @@ -356,7 +357,11 @@ static ssize_t backing_dev_store(struct device *dev,
>  		goto out;
>  	}
>  
> -	strlcpy(file_name, buf, len);
> +	strlcpy(file_name, buf, PATH_MAX);
> +	/* ignore trailing newline */
> +	sz = strlen(file_name);
> +	if (sz > 0 && file_name[sz - 1] == '\n')
> +		file_name[sz - 1] = 0x00;
>  
>  	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE, 0);
>  	if (IS_ERR(backing_dev)) {
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 
