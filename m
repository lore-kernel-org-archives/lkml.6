Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29534C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D065F2515D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="CQrDol5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D065F2515D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeGBXnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:43:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34709 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGBXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:43:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so69644plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Whq/EohKBwtXw06TbXWGz4D80xdSyAY9mDQANq6Abo=;
        b=CQrDol5TUtv7WtSxxSgKpeDjPzmf73AyqlwiCOCzBmolA0BduARJNPPJ4yfU3pfqes
         gSGqb00Pyky6/O89PBDcEg12ujg5ZBOkU3eDQTATsEHmE4LybZS09YFleV6qDIleLKBz
         DwhzmlQNLVidu+vw/jPXL3wVbuKpabKXGwPw9zGlelJzplv+IA308oDgcEIt8z4TLJWZ
         cF7SsX3fagNaiMTqMLpVL4m0JdG3MWF1oOZTvp+UXB/5y+mpb+CxqDs9ruCl2vce3qkw
         JY3nOjp1nH6S6gmQAptRbV5Z2fBMF0ZrUjRdoEOhfWrtJkWKx+geovhxhlQUXLGfKYBy
         HGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Whq/EohKBwtXw06TbXWGz4D80xdSyAY9mDQANq6Abo=;
        b=s6wKcHNct5UtUmPa7yZv+57w2O/E81QVxL9SEp9CPd+KM9XDoMImJ0QXBgPE1YRTu1
         iPQzAHL2tsW45X79SLxIk9tK8BSRD1FYrtFnqv62swPqO6poT1jCDwoweDgHPgh4X8Bm
         usbt44tzfmd7ZJhtPL8iKPHky0ygLEr0o7a76ny/KWGQ1uuB1HEAPKRaCCiDGFZvFUMr
         wXZJ+zuuaMKYnoXZwRLvLtaXFDKRrlH7gWr1ZwYt9WfNty14E2nCaJoyCcow24OQTfeI
         KymbRRHhNU9B0p7Bk6jHmtxQFUDWVGaOWRCqDBrCjeTYpkwtPBIiWRAOqoGNN1OHC9Q/
         HwHw==
X-Gm-Message-State: APt69E3joS7y307y4V5u+Z2DzDt8QN0lIakzLmrJfgOrHAdUMG7VPSTz
        u3PsBxIos6n3UG6DXTJZPKZqog==
X-Google-Smtp-Source: ADUXVKJ+MI9PFrlgM34YmBg/qaZVXqD/EB0SlIZnaPKOrBflmdsi3OxVTTm6JUpkbf8g59i748wV1A==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr27472961plb.274.1530574988968;
        Mon, 02 Jul 2018 16:43:08 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::7:a7e4])
        by smtp.gmail.com with ESMTPSA id c5-v6sm21874062pfe.169.2018.07.02.16.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 16:43:08 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:43:07 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Hurst <shurst@google.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
Message-ID: <20180702234307.GA27810@vader>
References: <20180702230346.72350-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702230346.72350-1-evgreen@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:03:46PM -0700, Evan Green wrote:
> This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
> in lo_compat_ioctl. It only takes an unsigned long argument, and
> in practice a 32-bit value works fine.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d6b6f434fd4b..4cb1d1be3cfb 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1613,6 +1613,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  		arg = (unsigned long) compat_ptr(arg);
>  	case LOOP_SET_FD:
>  	case LOOP_CHANGE_FD:
> +	case LOOP_SET_BLOCK_SIZE:
>  		err = lo_ioctl(bdev, mode, cmd, arg);
>  		break;
>  	default:
> -- 
> 2.16.4
> 
