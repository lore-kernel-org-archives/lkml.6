Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02553C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C52086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9Wp1yFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbeLQRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:42:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53264 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbeLQRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:42:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so77499wmb.3;
        Mon, 17 Dec 2018 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3TKUIyB+V+gKRErjhJ7SH490nX9JYjHPpmBbnVCXxJ8=;
        b=F9Wp1yFwffE297wsKdm7IAMFaB+KPil4bWIUJdaDcu/po6imVTaIY9EBxjnOtqNrou
         HXgUKx2cvDsm+rx3c5YoQA39pKfP2glg8e4K8FJqZZjzkoc+wOlstdzsr3s78W8qBkUF
         FvUsnk5XZQXB2VcSqobIAecdlDFsWwWiUrjxBIKJX7mB887AYRbsK3P5foXu6JeU12wQ
         XoGClD5sZkdN5S6YqpovxRYB0PLKH+1LMHZwg7rXNXx6P1cTlbbRlo9WyRUVHzbc71sy
         4KiY/RT/kNBPlJ8lebse2Njx6z3gUjgTUc8e+bVAYxcBMkgy6i2TU6008K148T8dylpS
         2NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TKUIyB+V+gKRErjhJ7SH490nX9JYjHPpmBbnVCXxJ8=;
        b=bewO+2xKODflExbyYhMv4R5+Z0kxKgLUpVX0693fUPxJbAApvylJoUigOwO1TIX0Gf
         OhT33kV73ZgVQQjZgYELoF5Pcp95ceCb/0mgLWFdBM7hxtSir/66l2QWWZ5szIJ0oAq0
         Kdh9vVi6zAw1JSeRwGPgWwd3hMVWBjjkzHeDdtuD6A4h3eWbcx3mGtZR5ADGezBo9VTF
         rR+H3t6HaKMxryyVR997fVZK+bBP1HISItin0QV0nPmyM4FbilB5TBLTjIOqEc9/caxK
         OoJtQVAmqa05lUDwjlnw/LK4nbrB9gNp8uAFxjbu0Ow7spZrV4jGmzlaoKeqpXOuUX6r
         2enA==
X-Gm-Message-State: AA+aEWbNcDDxas4QSRvkkS5fnRThQfuuy+PAC4GC45eL908Xr0CzzBYd
        0ugWjq8H8GhiU33wIhg89H1fwOCLQCXYLQ==
X-Google-Smtp-Source: AFSGD/VHpfKJIjEgazD4wRNSeMZIqVrZwRqUpbtJ/cjDO8igDDqgmQ20ApCA1UZRkPyuGxCGz+T21Q==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr99496wmm.22.1545068551537;
        Mon, 17 Dec 2018 09:42:31 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c14sm9058457wme.13.2018.12.17.09.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:42:30 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:42:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev/samples: Use u8 instead of char for handle
 functions
Message-ID: <20181217174229.GB857@flashbox>
References: <20181019180427.1386-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019180427.1386-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:04:27AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> samples/vfio-mdev/mtty.c:592:39: warning: implicit conversion from 'int'
> to 'char' changes value from 162 to -94 [-Wconstant-conversion]
>                 *buf = UART_MSR_DSR | UART_MSR_DDSR | UART_MSR_DCD;
>                      ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> 1 warning generated.
> 
> Turns out that all uses of buf in this function ultimately end up stored
> or cast to an unsigned type. Just use u8, which has the same number of
> bits but can store this larger number so Clang no longer warns.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  samples/vfio-mdev/mtty.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 7abb79d8313d..f6732aa16bb1 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -171,7 +171,7 @@ static struct mdev_state *find_mdev_state_by_uuid(uuid_le uuid)
>  	return NULL;
>  }
>  
> -void dump_buffer(char *buf, uint32_t count)
> +void dump_buffer(u8 *buf, uint32_t count)
>  {
>  #if defined(DEBUG)
>  	int i;
> @@ -250,7 +250,7 @@ static void mtty_create_config_space(struct mdev_state *mdev_state)
>  }
>  
>  static void handle_pci_cfg_write(struct mdev_state *mdev_state, u16 offset,
> -				 char *buf, u32 count)
> +				 u8 *buf, u32 count)
>  {
>  	u32 cfg_addr, bar_mask, bar_index = 0;
>  
> @@ -304,7 +304,7 @@ static void handle_pci_cfg_write(struct mdev_state *mdev_state, u16 offset,
>  }
>  
>  static void handle_bar_write(unsigned int index, struct mdev_state *mdev_state,
> -				u16 offset, char *buf, u32 count)
> +				u16 offset, u8 *buf, u32 count)
>  {
>  	u8 data = *buf;
>  
> @@ -475,7 +475,7 @@ static void handle_bar_write(unsigned int index, struct mdev_state *mdev_state,
>  }
>  
>  static void handle_bar_read(unsigned int index, struct mdev_state *mdev_state,
> -			    u16 offset, char *buf, u32 count)
> +			    u16 offset, u8 *buf, u32 count)
>  {
>  	/* Handle read requests by guest */
>  	switch (offset) {
> @@ -650,7 +650,7 @@ static void mdev_read_base(struct mdev_state *mdev_state)
>  	}
>  }
>  
> -static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
> +static ssize_t mdev_access(struct mdev_device *mdev, u8 *buf, size_t count,
>  			   loff_t pos, bool is_write)
>  {
>  	struct mdev_state *mdev_state;
> @@ -698,7 +698,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  #if defined(DEBUG_REGS)
>  			pr_info("%s: BAR%d  WR @0x%llx %s val:0x%02x dlab:%d\n",
>  				__func__, index, offset, wr_reg[offset],
> -				(u8)*buf, mdev_state->s[index].dlab);
> +				*buf, mdev_state->s[index].dlab);
>  #endif
>  			handle_bar_write(index, mdev_state, offset, buf, count);
>  		} else {
> @@ -708,7 +708,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  #if defined(DEBUG_REGS)
>  			pr_info("%s: BAR%d  RD @0x%llx %s val:0x%02x dlab:%d\n",
>  				__func__, index, offset, rd_reg[offset],
> -				(u8)*buf, mdev_state->s[index].dlab);
> +				*buf, mdev_state->s[index].dlab);
>  #endif
>  		}
>  		break;
> @@ -827,7 +827,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		if (count >= 4 && !(*ppos % 4)) {
>  			u32 val;
>  
> -			ret =  mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret =  mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					   *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -839,7 +839,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		} else if (count >= 2 && !(*ppos % 2)) {
>  			u16 val;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -851,7 +851,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		} else {
>  			u8 val;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, false);
>  			if (ret <= 0)
>  				goto read_err;
> @@ -889,7 +889,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;
> @@ -901,7 +901,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;
> @@ -913,7 +913,7 @@ ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  			if (copy_from_user(&val, buf, sizeof(val)))
>  				goto write_err;
>  
> -			ret = mdev_access(mdev, (char *)&val, sizeof(val),
> +			ret = mdev_access(mdev, (u8 *)&val, sizeof(val),
>  					  *ppos, true);
>  			if (ret <= 0)
>  				goto write_err;
> -- 
> 2.19.1
> 

Gentle ping for review.

Thank you,
Nathan
