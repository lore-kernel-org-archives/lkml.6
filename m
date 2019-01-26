Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D76C282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EE3218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USCegoDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfAZTLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:11:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46591 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:11:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so9918889edt.13;
        Sat, 26 Jan 2019 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nS3yE+ii4ytpJqTzOSSB4Cw3IAU9FV204b1kJx9Ux5g=;
        b=USCegoDV0fxohtY6SnuGV1OSKQVy8X4+7ZsXcJeNILtPaJ+vCj4VFivButbxDCT+rx
         gsDKRQojxZpCSij9Anhpad3MaCOV3xLZ4gUZinCZvbKSrCxkgTrcmeP3NamGFZXmaAXx
         w0h41u0iaBWcm0K66qM2o2Bav/ZVL5uEfta85tiEpZd7dCohrAGbpOzButFqrIjVHmIO
         r3gSlCGQGxNoE3dzWvpZ+zMbJVK0WxRAxAXs8VVtiiv6lrRULjAxp0HxqZbDldJ6N5A6
         AZn42E09SVwzOb3SYtXcm55KD2jkQzAQFpTZQE2zzA2Yjn/9mlnWDiqphaIlsu63OcQY
         qDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nS3yE+ii4ytpJqTzOSSB4Cw3IAU9FV204b1kJx9Ux5g=;
        b=gXrafQFTQYeqWgTiA8T+0c0VPnFBzr7HV8yP1KS4RZKXPgFDognq2gsCpesTeBN+vZ
         2VvpyGCubpowuzxXJgmuV/L2AgtKuu2IsiHO/JeAw2xbv+kkYwm7g3oHRvYoZiQD1MOY
         1we6EKPvNsssEJLFIg7LShzk4fqTvv1NWsU8wXIyil3Ee1HfhOvUQ36iAlM4AwPPLJQU
         Ph/M8DK9M68g5xWmf+oJEDMk4yRLs95Z6h2LnMyYB54ZHeRP9ttoyrZkdN2a4JbvB6KQ
         cowEZ7Qp2vpUFRCbjokkg5zqwB/DBoOxSuFAAgoB5VDEHyiz//no2OvbWQwwVlm5xqPg
         HA0A==
X-Gm-Message-State: AJcUukdtjdi8kRhw7XofDGPX7DOrO5Y/Qag9biQEdOJLJyhUo1hxPdev
        Y03OOlqDXyff1hvCmqDCsyY=
X-Google-Smtp-Source: ALg8bN5Ld3dhf6JAFSZCicGBRgiJKvx1cd8gTJ/kTiVYFT3WWOEXpOedmHRdOkrAjQ+AtJSeaysKKg==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr15722739edb.238.1548529906113;
        Sat, 26 Jan 2019 11:11:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f31sm13048478eda.16.2019.01.26.11.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 11:11:45 -0800 (PST)
Date:   Sat, 26 Jan 2019 12:11:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp32: Remove unnecessary self assignment in
 nsp32_set_sync_entry
Message-ID: <20190126191143.GB25003@archlinux-ryzen>
References: <20181210235156.6237-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210235156.6237-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:51:56PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/scsi/nsp32.c:2444:14: warning: explicitly assigning value of
> variable of type 'unsigned char' to itself [-Wself-assign]
>         offset      = offset;
>         ~~~~~~      ^
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/nsp32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
> index 5aac3e801903..7ce6e7acf2f3 100644
> --- a/drivers/scsi/nsp32.c
> +++ b/drivers/scsi/nsp32.c
> @@ -2441,7 +2441,6 @@ static void nsp32_set_sync_entry(nsp32_hw_data *data,
>  
>  	period      = data->synct[entry].period_num;
>  	ackwidth    = data->synct[entry].ackwidth;
> -	offset      = offset;
>  	sample_rate = data->synct[entry].sample_rate;
>  
>  	target->syncreg    = TO_SYNCREG(period, offset);
> -- 
> 2.20.0
> 

Ping?
