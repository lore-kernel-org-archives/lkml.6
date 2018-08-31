Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94136C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A98820661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJuevRr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A98820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHaMdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:33:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50983 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHaMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:33:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so4380706wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f39v9NvL0dna5Wxvti4XgLL2bwfWPTeGuj+93NLRq2g=;
        b=TJuevRr0s0G8sPZ8pqCfwr69T9ty8m1sPHVhP2cYVzxR7f/pPNpsj1u+IvNyOM9Y38
         B4SSfgktnyF9D98re/rekALXnPbZe8ryN7JudthO5qarpbDsMIUwdbxrjVIcpmUJP2S3
         UQbfKSICZ/T0nQOkTKKa+FdzXGLIYb+Tj1VshHvF8GlLd3BWLcj1axSqa0q1J+J5ALoZ
         AAJlkoaWP3obRN4xFEs1ryiuwpkjdjROymsBg055ELV/Ga29V+1vSjQlY4aTqYFlX+4x
         VKZlVDvrWKU5maqJ0eGaGRmRzl/0QktykF7zg7UVd7PM4v2N/buZnskxSjmQgiQdZ6Y/
         xnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f39v9NvL0dna5Wxvti4XgLL2bwfWPTeGuj+93NLRq2g=;
        b=DF5jwOeeb20Q6K3orOevg1vmVaeIb31ORBmtFxoru4JZOHCJcNxvNMONJAKL4URFqy
         o5otu3oa94aQrzHQ6jOmzOpaGcRrlcIuPG6wTVeNJH3wHzU74tYYox3VbFcGGiaarAW1
         Z7fNoUxJasTX5Xsb8u34N7PLyyKc4CWfiBSNUIWktF46NYR/LtIT6x1VlEaFrYM9/wWK
         mcuMKSPovuP4O9GVB+lbgPWAl404QAXDyiwrn1k6mgGRppXnMVHYx/fD8NTS25LEHZJ3
         ihSmkErrZa5zEukPatOlmIlXLAFPoUclpIoF/Hlqtna0P/7Rgv6QS5a/NJ0XjKyhgaBt
         +Ccw==
X-Gm-Message-State: APzg51CMHmV5PRjDscVW7hMbKeOV3OuVKV+ViN8kXTsfXrwan0MFvHJS
        KiI9+r33Tz1LL36SOX06dCxog5GO
X-Google-Smtp-Source: ANB0VdbWA4HEdeqxBzccavbVPxLDbBz5u5PP7rD0JCNaRd6uaPTXgYpRjVZtDzSxhDvW4O1YhtgHRw==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr3997573wmr.138.1535704035743;
        Fri, 31 Aug 2018 01:27:15 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:41c4:f3ec:dcc3:6a2f])
        by smtp.gmail.com with ESMTPSA id k35-v6sm14523080wrc.14.2018.08.31.01.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:27:15 -0700 (PDT)
Date:   Fri, 31 Aug 2018 10:27:14 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/dumpstack: fix address space casting in
 show_opcodes()
Message-ID: <20180831082712.cbfvv655amizvkfq@ltop.local>
References: <20180830194736.210039-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830194736.210039-1-jannh@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:47:36PM +0200, Jann Horn wrote:
> I sloppily passed a kernel-typed pointer to __range_not_ok(), and sparse
> doesn't like that.
> Make `prologue` a __user pointer (to protect against accidental
> dereferences) and force-cast it to a kernel pointer when calling
> probe_kernel_read(), which will then immediately force-cast it back to a
> user pointer.

It's a bit sad to have to do this.
__range_not_ok() explicitly requires a __user pointer (I don't know
if there is a good reason for it) but  the real job is done by
__chk_range_not_ok(). Can't you use this later instead?


-- Luc Van Oostenryck
