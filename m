Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C445C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B903B20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQbjDnwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B903B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIKTAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:00:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38223 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeIKTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:00:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so1112488wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OyH98qt2uwrISq7HZ2FsLx6ueFs7I86Trpl3rfvjkJ8=;
        b=VQbjDnwRQwlyttIhgtrtTHFlRZY5I25klHc2MD9I+AWtxlI+TsjVbxAq/HQpstIXlO
         6B5sDX4txb0r/SWzZcIEPMQsugZq4qXZoCk6A2h3jeTl+8IvZVkif5m/FE3+N1Q9HyOp
         ubo37D5IuP8qQPw1O9Es8ML8zHoO5XsG5V+Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OyH98qt2uwrISq7HZ2FsLx6ueFs7I86Trpl3rfvjkJ8=;
        b=axqLJqZr2OcUYxPd7zmnAS+pRDh4LUYazr2HwMLjyOxgLMWN+x8nCtS/I5vFGkgeZz
         HO5bDnvgX/w0l6FKqYPC//3pDPINJty8ktPzqzrc042wY7SUZNVtl0TbTGImbMutC73t
         QD8dfTuBaq3sO6XTywaM1LTaONez+DzClKPogCkFJnH+UAlCTH/ZxgMNfwX/dMsJ53Ko
         Ykq0HDtFpROYF/B8c6kg4pWj5/muC1wbo/aJEh7hsWOY+vk4ZuNqVn+9JBcaoPLiFmWi
         eGkPR2prlvpXmVFDy+LmEJPimDcC7dLV0CjiUcgeInpz577feTuGSQznTmFL8XF6RXtT
         Ua9Q==
X-Gm-Message-State: APzg51B0M8PV8g7ltD+iR6bKtGwwKsQPY1dniusRhn1Jd+4Nc93mfN7x
        pq0gr63nr/AlE+6bQ+886pGjzA==
X-Google-Smtp-Source: ANB0VdY3PmWAmGMpTu5nIe2L8HvaDezgg/vkNqonNM375ibZFVDWMRlJI7xRWGqoDJuPPQ6DyGOqOA==
X-Received: by 2002:a1c:65c5:: with SMTP id z188-v6mr1412795wmb.57.1536674433951;
        Tue, 11 Sep 2018 07:00:33 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id j2-v6sm1787523wmj.5.2018.09.11.07.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 07:00:32 -0700 (PDT)
Date:   Tue, 11 Sep 2018 15:00:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona: make array mclk_name static, shrinks
 object size
Message-ID: <20180911140031.GT4185@dell>
References: <20180904141553.28000-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904141553.28000-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Sep 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array mclk_name on the stack but instead make it
> static. Makes the object code smaller by 23 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   38050	  11604	     64	  49718	   c236	linux/drivers/mfd/arizona-core.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   38027	  11604	     64	  49695	   c21f	linux/drivers/mfd/arizona-core.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mfd/arizona-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
